# To claculate Suum of Integers in String

require 'rspec/autorun'

def add(numbers)
  return 0 if numbers.empty?

  delimiter = /,|\n/
  if numbers.start_with?('//')
    delimiter, numbers = numbers[2..].split("\n", 2)
    delimiter = Regexp.escape(delimiter)
  end

  # nums = numbers.split(/#{delimiter}/).map(&:to_i)
  nums = numbers.split(/#{delimiter}|,|\n/).map(&:to_i)
  negatives = nums.select { |n| !n.positive? }
  raise "Negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?

  nums.sum
end

# test cases
RSpec.describe '#add' do
  it 'returns 0 for an empty string' do
    expect(add('')).to eq(0)
  end

  it 'returns the number itself for a single number' do
    expect(add('1')).to eq(1)
  end

  it 'returns the sum of two numbers' do
    expect(add('1,5')).to eq(6)
  end

  it 'returns the sum of multiple numbers' do
    expect(add('1,2,3,4')).to eq(10)
  end

  it 'returns the sum of numbers with new lines' do
    expect(add("1\n2,3")).to eq(6)
  end

  it 'supports different delimiters' do
    expect(add("//;\n1;2")).to eq(3)
  end

  it 'raises an exception for negative numbers' do
    expect { add('1,-2,3,-4') }.to raise_error('Negative numbers not allowed: -2, -4')
  end
end
