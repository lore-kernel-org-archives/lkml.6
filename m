Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA90C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC521901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbfBMKu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:50:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51324 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731311AbfBMKu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:50:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F295A78;
        Wed, 13 Feb 2019 02:50:27 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45F683F575;
        Wed, 13 Feb 2019 02:50:24 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        hpa@zytor.com, valentin.schneider@arm.com
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
Date:   Wed, 13 Feb 2019 10:50:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213103553.GO32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/02/2019 10:35, Peter Zijlstra wrote:
> On Tue, Feb 12, 2019 at 09:15:13AM +0000, Julien Thierry wrote:
> 
>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>> index a674c7db..b1bb7e9 100644
>>>>> --- a/kernel/sched/core.c
>>>>> +++ b/kernel/sched/core.c
>>>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
>>>>>  		__schedule_bug(prev);
>>>>>  		preempt_count_set(PREEMPT_DISABLED);
>>>>>  	}
>>>>> +
>>>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
>>>>> +	    unlikely(unsafe_user_region_active())) {
>>>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
>>>>> +		       prev->comm, prev->pid, preempt_count());
>>>>> +		dump_stack();
>>>>> +	}
>>>>> +
>>>>>  	rcu_sleep_check();
>>>>>
>>>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> 
>> I guess I'll drop the might_resched() part of this patch if that sounds
>> alright.
> 
> I'm still confused by the schedule_debug() part. How is that not broken?

Hmmm, I am not exactly sure which part you expect to be broken, I guess
it's because of the nature of the uaccess unsafe accessor usage.

Basically, the following is a definite no:
	if (user_access_begin(ptr, size)) {

		[...]

		//something that calls schedule

		[...]

		user_access_end();
	}
	

However the following is fine:

- user_access_begin(ptr, size)
- taking irq/exception
- get preempted
- get resumed at some point in time
- restore state + eret
- user_access_end()

That's because exceptions/irq implicitly "suspend" the user access
region. (That's what I'm trying to clarify with the comment)
So, unsafe_user_region_active() should return false in a irq/exception
context.

Is this what you were concerned about? Or there still something that
might be broken?

Thanks,

-- 
Julien Thierry
