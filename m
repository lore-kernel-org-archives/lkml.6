Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F70C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622B4222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xj2JPIQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbfBMNRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:17:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42690 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfBMNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sSbenEiJhYX0l2EY5xkUhH56SlPk5uQLJ95FY6Mjt1Y=; b=Xj2JPIQBOloxhQw3JujUmGJIq
        DFUBrKC+gfMyibtvX1xhuP6U5b6tDKKXEfK+cJojo6IjEyeLF91bsRPk+YOlJ+kpegYeb2ZFXdhAq
        OSZrldohNa09OEJgutlw0oex04SKKqk7maSCd4Nlkhiy5T8uRAB92kbhvi73QFea/81qqeWmdpHeP
        JAvOL4HNW+DTdMpbGM0k+zFFvKRACTDr22Equv682FZWcYaivmgMPXMsBPKGk0gW0ZcTqeFfZW2kg
        84BvlBxo08nJ1Ql2V06hNEjJNphxNXCTHtpn2/majCFoSv5cnqTmjDYldsye7FzBmNeBUDHKHi7rZ
        qBvBdEqHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtuPh-00084g-BQ; Wed, 13 Feb 2019 13:17:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 207E325D07E27; Wed, 13 Feb 2019 14:17:20 +0100 (CET)
Date:   Wed, 13 Feb 2019 14:17:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        hpa@zytor.com, valentin.schneider@arm.com
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213131720.GU32494@hirez.programming.kicks-ass.net>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:50:21AM +0000, Julien Thierry wrote:
> On 13/02/2019 10:35, Peter Zijlstra wrote:
> > On Tue, Feb 12, 2019 at 09:15:13AM +0000, Julien Thierry wrote:
> > 
> >>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >>>>> index a674c7db..b1bb7e9 100644
> >>>>> --- a/kernel/sched/core.c
> >>>>> +++ b/kernel/sched/core.c
> >>>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
> >>>>>  		__schedule_bug(prev);
> >>>>>  		preempt_count_set(PREEMPT_DISABLED);
> >>>>>  	}
> >>>>> +
> >>>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
> >>>>> +	    unlikely(unsafe_user_region_active())) {
> >>>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> >>>>> +		       prev->comm, prev->pid, preempt_count());
> >>>>> +		dump_stack();
> >>>>> +	}
> >>>>> +
> >>>>>  	rcu_sleep_check();
> >>>>>
> >>>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> > 
> >> I guess I'll drop the might_resched() part of this patch if that sounds
> >> alright.
> > 
> > I'm still confused by the schedule_debug() part. How is that not broken?
> 
> Hmmm, I am not exactly sure which part you expect to be broken, I guess
> it's because of the nature of the uaccess unsafe accessor usage.
> 
> Basically, the following is a definite no:
> 	if (user_access_begin(ptr, size)) {
> 
> 		[...]
> 
> 		//something that calls schedule
> 
> 		[...]
> 
> 		user_access_end();
> 	}
> 	
> 
> However the following is fine:
> 
> - user_access_begin(ptr, size)
> - taking irq/exception
> - get preempted

This; how is getting preempted fundamentally different from scheduling
ourselves?

> - get resumed at some point in time
> - restore state + eret
> - user_access_end()
> 
> That's because exceptions/irq implicitly "suspend" the user access
> region. (That's what I'm trying to clarify with the comment)
> So, unsafe_user_region_active() should return false in a irq/exception
> context.
> 
> Is this what you were concerned about? Or there still something that
> might be broken?

I really hate the asymetry introduced between preemptible and being able
to schedule. Both end up calling __schedule() and there really should
not be a difference.
