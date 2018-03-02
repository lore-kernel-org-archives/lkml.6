Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeCBTuX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:50:23 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:36055 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932243AbeCBTuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:50:19 -0500
X-Google-Smtp-Source: AG47ELv+JTISUeITkW0f2Vovmy1oaL5RH9APhFkINUZIsKcygs3Q6KE66qKenxEKc3M9lA3waS9Vm63OuPLK1CiEWFg=
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 2 Mar 2018 20:50:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
Message-ID: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
Subject: C tricks for efficient stack zeroing
To: LKML <linux-kernel@vger.kernel.org>
Cc: pageexec@freemail.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I'm writing this email to solicit tricks for efficiently zeroing out
the stack upon returning from a function. The reason this is often
desirable is if the stack contains intermediate values that could
assist in some form of cryptographic attack if compromised at a later
point in time. It turns out many surprising things could be such an
aid to an attacker, and so generally it's important to clean things up
upon returning.

Often times complicated cryptographic functions -- say elliptic curve
scalar multiplication -- use a decent amount of stack (say, 1k or 2k),
with a variety of functions, and then copy a result into a return
argument. Imagine a call graph like this:

do_something(u8 *output, const u8 *input)
    thing1(...)
    thing2(...)
        thinga(...)
        thingb(...)
           thingi(...)
        thingc(...)
    thing3(...)
    thing4(...)
        thinga(...)
        thingc(...)

Each one of these functions have a few stack variables. The current
solution is to call memzero_explicit() on each of those stack
variables when each function return. But let's say that thingb uses as
much or more stack as thinga. In this case, I'm wasting cycles (and
gcc optimizations) by clearing the stack in both thinga and thingb,
and I could probably get away with doing this in thingb only.
Probably. But to hand estimate those seems a bit brittle.

What would be really nice would be to somehow keep track of the
maximum stack depth, and just before the function returns, clear from
the maximum depth to its stack base, all in one single call. This
would not only make the code faster and less brittle, but it would
also clean up some algorithms quite a bit.

Ideally this would take the form of a gcc attribute on the function,
but I was unable to find anything of that nature. I started looking
for little C tricks for this, and came up dry too. I realize I could
probably just take the current stack address and zero out until _the
very end_ but that seems to overshoot and would probably be bad for
performance. The best I've been able to do come up with are some
x86-specific macros, but that approach seems a bit underwhelming.
Other approaches include adding a new attribute via the gcc plugin
system, which could make this kind of thing more complete [cc'ing
pipacs in case he's thought about that before].

I thought maybe somebody on the list has thought about this problem in
depth before and might have some insights to share.

Regards,
Jason
