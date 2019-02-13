Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2597F20836
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbfBMOAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:00:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54690 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389284AbfBMOAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:00:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E76DE80D;
        Wed, 13 Feb 2019 06:00:31 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B7C43F557;
        Wed, 13 Feb 2019 06:00:29 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:00:26 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213140025.GB6346@brain-police>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213131720.GU32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Feb 13, 2019 at 02:17:20PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 10:50:21AM +0000, Julien Thierry wrote:
> > On 13/02/2019 10:35, Peter Zijlstra wrote:
> > > On Tue, Feb 12, 2019 at 09:15:13AM +0000, Julien Thierry wrote:
> > > 
> > >>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > >>>>> index a674c7db..b1bb7e9 100644
> > >>>>> --- a/kernel/sched/core.c
> > >>>>> +++ b/kernel/sched/core.c
> > >>>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
> > >>>>>  		__schedule_bug(prev);
> > >>>>>  		preempt_count_set(PREEMPT_DISABLED);
> > >>>>>  	}
> > >>>>> +
> > >>>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
> > >>>>> +	    unlikely(unsafe_user_region_active())) {
> > >>>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> > >>>>> +		       prev->comm, prev->pid, preempt_count());
> > >>>>> +		dump_stack();
> > >>>>> +	}
> > >>>>> +
> > >>>>>  	rcu_sleep_check();
> > >>>>>
> > >>>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> > > 
> > >> I guess I'll drop the might_resched() part of this patch if that sounds
> > >> alright.
> > > 
> > > I'm still confused by the schedule_debug() part. How is that not broken?
> > 
> > Hmmm, I am not exactly sure which part you expect to be broken, I guess
> > it's because of the nature of the uaccess unsafe accessor usage.
> > 
> > Basically, the following is a definite no:
> > 	if (user_access_begin(ptr, size)) {
> > 
> > 		[...]
> > 
> > 		//something that calls schedule
> > 
> > 		[...]
> > 
> > 		user_access_end();
> > 	}
> > 	
> > 
> > However the following is fine:
> > 
> > - user_access_begin(ptr, size)
> > - taking irq/exception
> > - get preempted
> 
> This; how is getting preempted fundamentally different from scheduling
> ourselves?

The difference is because getting preempted in the sequence above is
triggered off the back of an interrupt. On arm64, and I think also on x86,
the user access state (SMAP or PAN) is saved and restored across exceptions
but not across context switch. Consequently, taking an irq in a
user_access_{begin,end} section and then scheduling is fine, but calling
schedule directly within such a section is not.

Julien -- please yell if I've missed some crucial detail, but I think that's
the gist of what we're trying to describe here.

Will
