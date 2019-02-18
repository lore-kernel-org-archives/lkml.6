Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13151C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF61521872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfBRWbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:31:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33825 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfBRWbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:31:04 -0500
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8680:2bb1:1b64:2c6c:6ec3:aa41])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1IMURDP2770168
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 18 Feb 2019 14:30:27 -0800
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
Date:   Mon, 18 Feb 2019 14:30:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190216103044.GR32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/19 2:30 AM, Peter Zijlstra wrote:
> On Fri, Feb 15, 2019 at 08:06:56PM -0800, hpa@zytor.com wrote:
>> This implies we invoke schedule -- a restricted operation (consider
>> may_sleep) during execution of STAC-enabled code, but *not* as an
>> exception or interrupt, since those preserve the flags.
> 
> Meet preempt_enable().

I believe this falls under "doctor, it hurts when I do that." And it hurts for
very good reasons. See below.

>> I have serious concerns about this. This is more or less saying that
>> we have left an unlimited gap and have had AC escape.
> 
> Yes; by allowing normal C in between STAC and CLAC this is so.
> 
>> Does *anyone* see a need to allow this? I got a question at LPC from
>> someone about this, and what they were trying to do once all the
>> layers had been unwound was so far down the wrong track for a root
>> problem that actually has a very simple solution.
> 
> Have you read the rest of the thread?
> 
> All it takes for this to explode is a call to a C function that has
> tracing on it in between the user_access_begin() and user_access_end()
> things. That is a _very_ easy thing to do.
> 
> Heck, GCC is allowed to generate that broken code compiling
> lib/strnlen_user.c; it doesn't _have_ to inline do_strnlen_user (esp.
> with CONFIG_OPTIMIZE_INLINING), and making that a function call would
> get us fentry hooks and ftrace and *BOOM*.
> 
> (Now, of course, its a static function with a single caller, and GCC
> isn't _THAT_ stupid, but it could, if it wanted to)
> 
> Since the bar is _that_ low for mistakes, I figure we'd better fix it.
> 

The question is what "fix it" means. I'm really concerned about AC escapes,
and everyone else should be, too.

For an issue specific to tracing, it would be more appropriate to do the
appropriate things in the tracing entry/exit than in schedule. Otherwise, we
don't want to silently paper over mistakes which could mean that we run a
large portion of the kernel without protection we thought we had.

In that sense, calling schedule() with AC set is in fact a great place to have
a WARN() or even BUG(), because such an event really could imply that the
kernel has been security compromised.

Does that make more sense?

	-hpa
