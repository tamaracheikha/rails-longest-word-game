# require 'json'
# require 'open-uri'

# class GamesController < ApplicationController
#   def new
#     alphabet = ('a'..'z').to_a
#     letters = []
#     letters_size = 11
#     i = 0
#     while i < letters_size
#       letters << alphabet.sample(1)
#       i += 1
#     end
#     @letters = letters.flatten
#   end

#   def score
#     @word = params[:word]
#     url = "https://wagon-dictionary.herokuapp.com/#{@word}"
#     response = JSON.parse(open(url).read)
#     if response['found']
#       if @word.chars

#       end
#     end
#   end
# end

require "open-uri"
class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    letters_array = []
    letters_size = 11
    i = 0
    while i < letters_size
        letters_array << alphabet.sample(1)
        i += 1
    end
    @letters = letters_array.flatten
  end
  def letter_check?(attempt, grid)
    attempt_array = attempt.chars
    return attempt_array.all? { |letter| attempt_array.count(letter) <= grid.count(letter) }
  end
  def check_english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = open(url)
    word = JSON.parse(word_serialized.read)
    return word['found']
  end
  def score
    @attempt = params[:word]
    @grid = params[:grid]
    if letter_check?(@attempt, @grid) && check_english_word?(@attempt)
      @final_score = @attempt.length
    else
      @final_score = 0
    end
    return @final_score
  end
end
