﻿def get_letters()   #возвращает загаданное слово в форме массива букв

	slovo = ARGV[0]

	if (Gem.win_platform? && ARGV[0])
		slovo = slovo.encode(ARGV[0].encoding).encode("UTF-8")
	end

	if (slovo == nil || slovo == "")
		abort "Вы не ввели слово для игры"
	end

	return slovo.split("") # .split разбивает введеное слово на массив из его букв
end

def get_user_input 
	letter = ""

	while letter == "" do
		letter = STDIN.gets.encode("UTF-8").chomp
	end

	return letter
end

def check_result(user_input, letters, good_letters, bad_letters)
	if (good_letters.include?(user_input) || bad_letters.include?(user_input)) #проверка на повторение буквы
		return 0
	end

	if (letters.include?(user_input))
		good_letters << user_input     # записываем введеную букву в массив good_letters

		if  letters.uniq.size ==  good_letters.size #условие когда отгадано все слово
			return 1
		else
			return 0
		end
	else
		bad_letters << user_input
		return -1
	end
end

def get_word_for_print(letters, good_letters)
	result = ""

	for letter in letters do
		if good_letters.include?(letter)
			result += letter + " "
		else
			result += "__ "
		end
	end

	return result
end

#1. выводить загаданное слово
#2. информацию об ошибках и уже названные буквы
#3. ошибок больше 7 - сообщить о поражении
#4. слово угадано - сообщить о победе

def print_status(letters, good_letters, bad_letters, errors)
	puts "\n Слово: " + get_word_for_print(letters, good_letters) #1

	puts "Ошибки (#{errors}: #{bad_letters.join(", ")})"

	if errors >=7
		puts "Вы проиграли :("
	else
		if letters.uniq.size ==  good_letters.size 
			puts "Поздравляем! Вы выиграли! \n\n"
		else
			puts "У вас осталось попыток: " + (7-errors).to_s
		end
	end
end

def cls
	system "clear" or system "cls"
end