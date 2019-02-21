Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B896C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C02B2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfBUMGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:06:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43212 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBUMGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:06:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBAB780D;
        Thu, 21 Feb 2019 04:06:53 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C73C83F5C1;
        Thu, 21 Feb 2019 04:06:50 -0800 (PST)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
Date:   Thu, 21 Feb 2019 12:06:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2019 22:55, H. Peter Anvin wrote:
> On 2/19/19 4:48 AM, Will Deacon wrote:
>>
>> I think you'll still hate this, but could we not disable preemption during
>> the uaccess-enabled region, re-enabling it on the fault path after we've
>> toggled uaccess off and disable it again when we return back to the
>> uaccess-enabled region? Doesn't help with tracing, but it should at least
>> handle the common case.
>>
> 
> There is a worse problem with this, I still realize: this would mean blocking
> preemption across what could possibly be a *very* large copy_from_user(), for
> example.
> 

Yes, that's a good point. And I guess a userspace program could forcibly
trigger the kernel into a large copy_from/to_user(), knowingly disabling
preemption.

I don't know how bad this could get.

> Exceptions *have* to handle this; there is no way around it. Perhaps the
> scheduler isn't the right place to put these kinds of asserts, either.
> 

Maybe I'm misunderstanding what you mean with "Exceptions *have* to
handle this". Isn't the fact that the AC/PAN flags gets saved on
exception entry and set back to "user accesses disabled" already
handling it? Or are you referring to something else?

So far my understanding is that the exception/interrupt case is fine.
The worrying case is what gets called in the user access regions
(schedule(), preempt_enable(), tracing...).

Did I get lost somewhere?

> Now, __fentry__ is kind of a special beast; in some ways it is an "exception
> implemented as a function call"; on x86 one could even consider using an INT
> instruction in order to reduce the NOP footprint in the unarmed case.  Nor is
> __fentry__ a C function; it has far more of an exception-like ABI.
> *Regardless* of what else we do, I believe __fentry__ ought to
> save/disable/restore AC, just like an exception does.
> 

That does make sense to me. However it doesn't solve the issue of
calling (or preventing to call) some function that rescheds.


> The idea of using s/a gcc plugin/objtool/ for this isn't really a bad idea.
> Obviously the general problem is undecidable :) but the enforcement of some
> simple, fairly draconian rules ("as tight as possible, but no tighter")
> shouldn't be a huge problem.
> 
> An actual gcc plugin -- which would probably be quite complex -- could make
> gcc itself aware of user space accesses and be able to rearrange them to
> minimize STAC/CLAC and avoid kernel-space accesses inside those brackets.
> 

Not sure I get this. The data that is retrieved from/stored user space
is generally obtained from/saved into kernel-space address. And when you
start the user_access_begin() it means you plan on doing a bunch of user
access, so I wouldn't expect to be able to batch everything into registers.

Cheers,

-- 
Julien Thierry
