Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeCUVKj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:10:39 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35072 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeCUVKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:10:35 -0400
X-Google-Smtp-Source: AG47ELsA2rr8LDHF1T+ztvqOlQ/ZofrURq2jc9PMvZdqHknnZJeRftUyKBuwylArh5M4KyjdZJf8lA==
Subject: Re: detecting integer constant expressions in macros
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1521584015.31174.3.camel@med.uni-goettingen.de>
 <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6d771077-bee3-07c9-61c3-440dfed8e567@rasmusvillemoes.dk>
Date: Wed, 21 Mar 2018 22:10:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 00:08, Linus Torvalds wrote:
> On Tue, Mar 20, 2018 at 3:13 PM, Uecker, Martin
> <Martin.Uecker@med.uni-goettingen.de> wrote:
>>
>> here is an idea:
> 
> That's not "an idea".
> 
> That is either genius, or a seriously diseased mind.
> 
> I can't quite tell which.
> 
>> a test for integer constant expressions which returns an
>> integer constant expression itself which should be suitable
>> for passing to __builtin_choose_expr might be:
>>
>> #define ICE_P(x) (sizeof(int) == sizeof(*(1 ? ((void*)((x) * 0l)) : (int*)1)))

Wow. This is absolutely awesome.

>> This also does not evaluate x itself on gcc although this is
>> not guaranteed by the standard. (And I haven't tried any older
>> gcc.)
> 
> Oh, I think it's guaranteed by the standard that 'sizeof()' doesn't
> evaluate the argument value, only the type.

Even if there's some hypothetical scenario where x ends up containing
something of variably-modified type, could one just use 0? instead of 1?
. That doesn't affect the type of the whole expression.

> I'm in awe of your truly marvelously disgusting hack. That is truly a
> work of art.

I'm not really worthy of commenting or trying to improve on this, but I
think it's important that 'git blame' will forever give Martin the
credit for this, so two minor suggestions:

- Cast (x) to (long) to allow x to have type u64 on a 32-bit platform
without giving "warning: cast to pointer from integer of different
size". That also allows x to have pointer type (it's theoretically
useful to take max() of two pointers into an array), and not so
important for the kernel, floating point type.

- Maybe use (int*)4 to avoid the compiler complaining about creating a
non-aligned pointer.

> I'm sure it doesn't work or causes warnings for various reasons, but
> it's still a thing of beaty.

I tried putting the below ugly test code through various gcc versions.
In no cases could I get different optimization options to generate
different results. I also couldn't get -Wall -Wextra to produce any
warnings that wasn't just due to the silly input (i.e., yes, I know I
have a comma expression with no side effects....). Most importantly,
ICE_P was always accepted as an ICE itself. Everything from 4.6 onwards
gives the same and expected output, namely 1 in the first four lines, 0
otherwise. gcc 4.4 instead produces this:

4                       1
sizeof(long)            1
5ull - 3u               1
3.2                     1
square(2)               0
square(argc)            0
squarec(2)              1
squarec(argc)           1
1+argc-argc             1
1+argc+argc+1-argc-argc 1
bignum() - 1            0
0*bignum()              0
0*bignumc()             1
sizeof(foo)             0
p                       1
p < q                   1
p++                     0
main                    1
malloc(8)               0
v = malloc(8)           0
v                       1
x++                     0
y++                     0
(3, 2, 1)               0
({x++; 0; })            0
({square(y--); 0; })    0
(square(x), 3)          0
(squarec(x), 3)         0
({squarec(x); 3;})      0
({squarec(x);})         1

So it seems to accept/treat (x)*0l as NULL as long as x has no
side-effects - where a function call is treated as having side effects
unless the function is declared with the const attribute,
comma-expressions are hard-coded as having side-effects [and what else
would they be good for, so that's not totally unreasonable...], and
statement expressions have side effects if they have more than one
statement.

Rasmus


#include <stdio.h>
#include <stdlib.h>

static inline __attribute__((__const__)) unsigned squarec(unsigned n)
{
	return n*n;
}

static inline unsigned square(unsigned n)
{
	return n*n;
}

static inline unsigned long long bignum(void)
{
	return 1000000000000ULL;
}

static inline __attribute__((__const__)) unsigned long long bignumc(void)
{
	return 1000000000000ULL;	
}

/* #define ICE_P(x) (sizeof(int) == sizeof(*(1 ? ((void*)((long)(x) *
0l)) : (int*)1))) */
#define ICE_P(x) (__builtin_types_compatible_p(typeof(0 ?
((void*)((long)(x) * 0l)) : (int*)1), int*))

#define t(x) printf("%-20s\t%d\n", #x, __builtin_choose_expr(ICE_P(x),
1, 0))

int main(int argc, char *argv[])
{
	char foo[argc++];
	char **p, **q;
	int x = 5, y = 8;
	void *v;
	
	p = &argv[3];
	q = &argv[6];
	
	t(4);
	t(sizeof(long));
	t(5ull - 3u);
	t(3.2);
	t(square(2));
	t(square(argc));
	t(squarec(2));
	t(squarec(argc));
	t(1+argc-argc);
	t(1+argc+argc+1-argc-argc);
	t(bignum() - 1);
	t(0*bignum());
	t(0*bignumc());
	t(sizeof(foo));
	t(p);
	t(p < q);
	t(p++);
	t(main);
	t(malloc(8));
	t(v = malloc(8));
	t(v);
	t(x++);
	t(y++);
	t((3, 2, 1));
	t(({x++; 0; }));
	t(({square(y--); 0; }));
	t((square(x), 3));
	t((squarec(x), 3));
	t(({squarec(x); 3;}));
	t(({squarec(x);}));

	/* Shutup distracting warnings. */
	if (argc > 100000) {
		printf("%llu", square(argc) + squarec(argc) + bignum() + bignumc());
	}
	
	return 0;
}
