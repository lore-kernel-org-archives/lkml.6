Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeCBVPn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:15:43 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41094 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933610AbeCBVPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:15:42 -0500
Date: Fri, 2 Mar 2018 22:15:30 +0100
From: Willy Tarreau <w@1wt.eu>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: LKML <linux-kernel@vger.kernel.org>, pageexec@freemail.hu
Subject: Re: C tricks for efficient stack zeroing
Message-ID: <20180302211530.GA31403@1wt.eu>
References: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Mar 02, 2018 at 08:50:17PM +0100, Jason A. Donenfeld wrote:
> Hi list,
> 
> I'm writing this email to solicit tricks for efficiently zeroing out
> the stack upon returning from a function. The reason this is often
> desirable is if the stack contains intermediate values that could
> assist in some form of cryptographic attack if compromised at a later
> point in time. It turns out many surprising things could be such an
> aid to an attacker, and so generally it's important to clean things up
> upon returning.
> 
> Often times complicated cryptographic functions -- say elliptic curve
> scalar multiplication -- use a decent amount of stack (say, 1k or 2k),
> with a variety of functions, and then copy a result into a return
> argument. Imagine a call graph like this:
> 
> do_something(u8 *output, const u8 *input)
>     thing1(...)
>     thing2(...)
>         thinga(...)
>         thingb(...)
>            thingi(...)
>         thingc(...)
>     thing3(...)
>     thing4(...)
>         thinga(...)
>         thingc(...)
> 
> Each one of these functions have a few stack variables. The current
> solution is to call memzero_explicit() on each of those stack
> variables when each function return. But let's say that thingb uses as
> much or more stack as thinga. In this case, I'm wasting cycles (and
> gcc optimizations) by clearing the stack in both thinga and thingb,
> and I could probably get away with doing this in thingb only.
> Probably. But to hand estimate those seems a bit brittle.
> 
> What would be really nice would be to somehow keep track of the
> maximum stack depth, and just before the function returns, clear from
> the maximum depth to its stack base, all in one single call. This
> would not only make the code faster and less brittle, but it would
> also clean up some algorithms quite a bit.
> 
> Ideally this would take the form of a gcc attribute on the function,
> but I was unable to find anything of that nature. I started looking
> for little C tricks for this, and came up dry too. I realize I could
> probably just take the current stack address and zero out until _the
> very end_ but that seems to overshoot and would probably be bad for
> performance. The best I've been able to do come up with are some
> x86-specific macros, but that approach seems a bit underwhelming.
> Other approaches include adding a new attribute via the gcc plugin
> system, which could make this kind of thing more complete [cc'ing
> pipacs in case he's thought about that before].
> 
> I thought maybe somebody on the list has thought about this problem in
> depth before and might have some insights to share.

No solution here but a few insights in case something helps you make
progress :
  - it is possible to keep a copy of ESP/RSP after all variables are
    declared, but this will not always cover variables declared in
    sub-blocks. Probably that a construct like this could cover part
    of what you need :

    void thingb()
    {
        void *stack_top = get_sp();
        /* other local variables */
        void *stack_bottom = get_sp();
        ...
      epilogue:
        memset(stack_bottom, 0, stack_top - stack_bottom);
        return;
    }

  - the stuff above will not cover arguments passed on the stack
  - some of these arguments could very well be modified in place and
    will actually serve as local variables :

    void thingd(int *i);
    int thingc(int a, int b, int c, int d, int e, int f, int g)
    {
        thingd(&g);
        return g;
    }

  - you cannot consider that you'll wipe the memory at once (local
    variables and arguments) as you don't want to erase the return
    pointer

  - one nice solution would in fact be for the caller to be able to
    clean the callee's stack at once (including arguments). It would
    be as "easy" as placing the stack pointer on return into one of
    the clobbered registers, deciding that this one is not clobbered
    anymore since it'd contain a copy of the callee's deepest stack,
    and would be used to clean till the current SP.

It would do this in short on x86_64 :

    void thingd(int *i);
    int thingc(int a, int b, int c, int d, int e, int f, int g)
    {
        thingd(&g);
        return g;
    }

    int thingd(int a)
    {
        int b, c, d, e, f, g;
        /* do some stuff */
        return thingc(a, b, c, d, e, f, g);
    }

In pseudo-asm :

    thingc:
       ...
       mov rdi, rsp
       ret

    thingd:
       push g
       mov r9d, f
       mov r8d, e
       mov rcx, d
       mov rdx, c
       mov rsi, b
       mov rdi, a
       call thingc
       add rsp, +8
       // rdi contains the bottom of the stack for thingc
      0:
       movq [rdi], 0
       add rdi, 8
       cmp rdi, rsp
       jb 0b

This would obviously require some gcc changes so that some attributes placed
on the called function would be enforced on the caller (this is just a new
calling convention after all). But again it would certainly miss some stack
parts which are modified after RSP is copied.

Just my two cents,
Willy
