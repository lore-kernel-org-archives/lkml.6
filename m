Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D18C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384C821773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfBLJPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:15:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfBLJPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:15:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF72DEBD;
        Tue, 12 Feb 2019 01:15:18 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6843F557;
        Tue, 12 Feb 2019 01:15:16 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
Date:   Tue, 12 Feb 2019 09:15:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190211135159.GC32511@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/02/2019 13:51, Peter Zijlstra wrote:
> On Mon, Feb 11, 2019 at 02:45:27PM +0100, Ingo Molnar wrote:
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index a674c7db..b1bb7e9 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
>>>  		__schedule_bug(prev);
>>>  		preempt_count_set(PREEMPT_DISABLED);
>>>  	}
>>> +
>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
>>> +	    unlikely(unsafe_user_region_active())) {
>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
>>> +		       prev->comm, prev->pid, preempt_count());
>>> +		dump_stack();
>>> +	}
>>> +
>>>  	rcu_sleep_check();
>>>
>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
>>> @@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>>>  EXPORT_SYMBOL(___might_sleep);
>>>  #endif
>>>
>>> +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
>>> +void __might_resched(const char *file, int line)
>>> +{
>>> +	if (!unsafe_user_region_active())
>>> +		return;
>>
>> Could you please more clearly explain why you want/need an exception from 
>> the __might_resched() debug warning?

So, the scenarios I'm trying to avoid are of the following flavour:

	if (user_access_begin(ptr, size)) {

		[...]

		// Calling a function that might call schedule()

		[...]
		user_access_end();
	}


The thing is, as I understand, not all function that call schedule() are
annotated with might_resched(), and on the other hand, not every time we
call a function that might_resched() will it call schedule().

Now with Peter's remark I think I might have been overzealous.

> 
> In specific; how is the addition in schedule_debug() not triggering on
> PREEMPT=y kernels?
> 
> If code is preemptible, you can (get) schedule(d). If it is not
> preemptible; you do not need these additional tests.
> 

Yes that sounds right, might_resched() only potentially reschedules if
in a suitable context, so best case I issue two warnings, worst case I
actually be warn when the caller took care to disable preemption or
interrupts before calling a might_resched().

I guess I got a bit confused with might_sleep() which is "if you call
this in the wrong context I warn" whereas might_resched() is just "if
you call this in preemptible context, lets resched".

I guess I'll drop the might_resched() part of this patch if that sounds
alright.

Thanks,

-- 
Julien Thierry
