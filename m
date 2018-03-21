Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753998AbeCUW16 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:27:58 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35491 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeCUW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:27:51 -0400
X-Google-Smtp-Source: AG47ELsnImSsda6SuaixILgEe4rwPr9x6IrdIZUcP5X/oikgSDpVYHPzPBJyEGskdIQdQle+AwjeGD97KfzSHTPILXA=
MIME-Version: 1.0
In-Reply-To: <6d771077-bee3-07c9-61c3-440dfed8e567@rasmusvillemoes.dk>
References: <1521584015.31174.3.camel@med.uni-goettingen.de>
 <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com> <6d771077-bee3-07c9-61c3-440dfed8e567@rasmusvillemoes.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Mar 2018 15:27:49 -0700
X-Google-Sender-Auth: QKCvH1KmNQ_0FvKlGf-czcbjQ7w
Message-ID: <CA+55aFx9v_ZuJK1-VEag5KqWxUQPBXhno1tJ1PbB7ftC2GGV0A@mail.gmail.com>
Subject: Re: detecting integer constant expressions in macros
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 2:10 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>>
>> Oh, I think it's guaranteed by the standard that 'sizeof()' doesn't
>> evaluate the argument value, only the type.
>
> Even if there's some hypothetical scenario where x ends up containing
> something of variably-modified type, could one just use 0? instead of 1?
> . That doesn't affect the type of the whole expression.

Fair enough.

> I'm not really worthy of commenting or trying to improve on this, but I
> think it's important that 'git blame' will forever give Martin the
> credit for this

You're saying "please don't ever blame me".

Gotcha ;)

> two minor suggestions:
>
> - Cast (x) to (long) to allow x to have type u64 on a 32-bit platform
> without giving "warning: cast to pointer from integer of different
> size". That also allows x to have pointer type (it's theoretically
> useful to take max() of two pointers into an array), and not so
> important for the kernel, floating point type.

Fair enough.

> - Maybe use (int*)4 to avoid the compiler complaining about creating a
> non-aligned pointer.

Yes.

> I tried putting the below ugly test code through various gcc versions.
> In no cases could I get different optimization options to generate
> different results. I also couldn't get -Wall -Wextra to produce any
> warnings that wasn't just due to the silly input (i.e., yes, I know I
> have a comma expression with no side effects....). Most importantly,
> ICE_P was always accepted as an ICE itself. Everything from 4.6 onwards
> gives the same and expected output, namely 1 in the first four lines, 0
> otherwise. gcc 4.4 instead produces this:

Ok, so since we're going to get rid of 4.4 support anyway because of
our requirement of "asm goto", and since 4.5 was apparently never
shipped in any distros, I think the minimum compiler version we care
about is gcc-4.6.

So the above sounds fine, and I won't worry about the fact that
gcc-4.4 apparently does expression simplifications early.

> So it seems to accept/treat (x)*0l as NULL as long as x has no
> side-effects - where a function call is treated as having side effects
> unless the function is declared with the const attribute,

That's actually _largely_ the main thing we care about anyway in most
places, so even the 4.4 behavior is probably acceptable in practice.

For example, for "min/max()", it's true that constants are what we're
looking at, but at the same time, the expression simplification really
only cares about "no side effects".

In some other cases, we really do want to see constants, though (the
example I mentioned earlier with build-time simplification of bswap
comes to mind).

> comma-expressions are hard-coded as having side-effects [and what else
> would they be good for, so that's not totally unreasonable...]

Actually, I think one of our more common uses of a comma expression is
not for side effects, but because of things like type warnings.

I guess that is a "side effect" too, although it's really a build-time
one, not a run-time one.

> and statement expressions have side effects if they have more than one
> statement.

Ok, that's just odd semantics.

But I guess it's actually a very natural result of "do obvious
simplifications early", ie one of those expression simplifications
that gcc-4.4 does on the early parse-tree level is to just turn a
single-statement statement expression directly into just the
expression.

So I think the gcc-4.4 behavior is "understandable", even if it
happens to be very much non-standard, and happens to break the "x*0"
trick that Martin's masterpiece uses.

If we knew exactly what gcc ends up simplifying, we might be able to
work around it. For example, is the front-end tree simplification
smart enough to realize that

   1+(unsigned long)(x)+~(unsigned long)(x)

is also 0?

For a true *constant*, that's very easy for a compiler to see (just
evaluate the damn thing). For an expression that isn't constant, it's
a bit less obvious, and depends on knowing that "~x+1" is the same as
"-x" in 2's complement.

Of course, compilers *do* have that logic, but it's often deeper down
than at parse-tree time.

Doing some simple testing on godbolt, I see that gcc-4.1 actually
accepts this program:

  unsigned long x;
  void *ptr= (void *)(x-x);

and clearly considers "(void *)(x-x)" to be NULL.

But if you write it as

  unsigned long x;
  void *ptr= (void *)(1+x+~x);

it fails with 4.1.

But then it succeeds again with 4.4 and sees that it's just an odd way
to write 0.

Damn clever compiler writers to hell, they clearly started doing that
simplification early.

There are other weird ways to calculate 0, though. We're not *just*
limited to "*0" and trivial bit tricks. I bet we could come up with
something that always evaluates to zero, but is too hard for gcc to
turn into zero symbolically.

For example, gcc-4.4 does not realize that

  #define rightmost(x) ((x)&-(x))
  #define lowmask(x) (rightmost(x)-1)
  unsigned long x;
  void *ptr= (void *)(x&lowmask(x));

is a *really* weird way to write a constant zero. But if 'x' really is
a constant, it's immediately obvious because it just evaluates the
expression and get zero.

So if you use "#define x 0x1234", it turns into NULL again.

So we *could* make this work even for gcc-4.4.

          Linus
