require 'open-uri'
###Spencer Soles 9-09-2016
###This is a solution to the Millionaire 3 contest problem from GAMES magazine in 2002
###Must have a subscription to Oxford English Dictionary to work properly
incrementingVals = Hash.new ###Millionaire 1 hash
decrementingVals = Hash.new ###Millionaire 2 hash
lowest=300000 ###Lowest score recorded
best=" "
isWord=true
incrementCount=1 
decrementCount=26
incrementTarget = 1000000
decrementTarget = 1000000

def isEnglish(word)### checks if word is found in the oxford english dictionary

    open("http://www.oed.com/search?searchType=dictionary&q=#{word}&_searchBtn=Search").each_line do |lines|
        if lines.include? "No dictionary" ### if word not found
            return false
        end
    end
return true
end

('a'..'z').each do |letters| ### initialize hashes for scoring purposes
incrementingVals[letters]=incrementCount
decrementingVals[letters]=decrementCount
incrementCount=incrementCount+1
decrementCount=decrementCount-1
end
###Change uri below to check different word set
open('http://www.math.sjsu.edu/~foster/dictionary.txt').each_line do |line|###Uses online text file of english words

    iTotal =1
    dTotal =1
    line.chomp.split("").each do |letter|
    iTotal = iTotal * incrementingVals[letter]
    dTotal= dTotal * decrementingVals[letter]
end
### scoring logic for each word
if dTotal>=decrementTarget
    dTotal = dTotal-decrementTarget
else
    dTotal = decrementTarget-dTotal
end

if iTotal>=incrementTarget
    iTotal = iTotal-incrementTarget
else
    iTotal = incrementTarget-iTotal
end

totalDistance = iTotal+ dTotal

    if(totalDistance<= 300000)
        if isEnglish(line) ###If actual word, print with score
        puts line.downcase
        puts totalDistance
            if lowest>totalDistance
                lowest = totalDistance
                best = line.chomp.downcase
            end

        puts " "
        end
    end
end
puts " "
puts "#{best} "
puts "Score: #{lowest}"

puts " "