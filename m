Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeCERNE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:13:04 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:52157 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeCERNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:13:02 -0500
X-Google-Smtp-Source: AG47ELtBwg/+JMW/JID6LFJ1mGXGmGna/06jE3iYFAs8dxr47Sm7KsdvmYqu0QcbnlMwajwa9z/Wtw==
Subject: Re: C tricks for efficient stack zeroing
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: pageexec@freemail.hu
References: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <9c65c2ab-fc82-3d9e-491d-c4d1658d103d@redhat.com>
Date: Mon, 5 Mar 2018 09:06:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 11:50 AM, Jason A. Donenfeld wrote:
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
>      thing1(...)
>      thing2(...)
>          thinga(...)
>          thingb(...)
>             thingi(...)
>          thingc(...)
>      thing3(...)
>      thing4(...)
>          thinga(...)
>          thingc(...)
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
> 
> Regards,
> Jason
> 

Have you seen http://www.openwall.com/lists/kernel-hardening/2018/03/03/7 ?
This sounds exactly like what you have proposed.

Thanks,
Laura
