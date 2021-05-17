require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    @user_word = params[:word].upcase
    @letters = params[:letters].split(" ")
    @buildable = @user_word.chars.all? { |letter| @user_word.count(letter) <= @letters.count(letter) }
    @api_results = URI.open("https://wagon-dictionary.herokuapp.com/#{@user_word}")
    @json = JSON.parse(@api_results.read)
    if @buildable == false
      @response = "Sorry but #{@user_word} can't be built out of #{@letters}."
    elsif @json["found"] == true
      @response = "Congratulations! #{@user_word} is a valid English word!"
    else
      @response = "Sorry but #{@user_word} does not seem to be a valid English word..."
    end
  end

end
