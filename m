Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5ACC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467BA20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxnurEWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfAVO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:57:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbfAVO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ubc/EeKgBxh6zaeMi0e7CVRJR36Rk40o1knBVNzRVgo=; b=uxnurEWpOwxfX07blsFss6LMX
        QIsijql4IW5MQwVhqLc1fUPwBWjpaJrIvR4EoZxJIcHicV4VIjfWgyXF7KOYNGh04kLpi5OjW7KgK
        j5cMe9L/dy1u8nafjWzsgStT8f7mH2EpJyUZmeUzFz3cHn5oPOFqjLPcp3QB7j1vorE44z68x+FrG
        II+yp3j2g+106iMVvUW/AfSX2juhT1G5JeCZbZsU7rGO0td0suZVWaKtMteAmI+oKL8uZh+UMKskw
        +Hl/hdwcuFfSUUjEMIfyUmg31A1R50ZOnghv3X5fI8N5oMmqUXRoKS+LeWuhFImUI8RRbSoyGGGu1
        EQ3SM2kAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glxUn-0000N4-Bf; Tue, 22 Jan 2019 14:57:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1C0020EF9B32; Tue, 22 Jan 2019 15:57:42 +0100 (CET)
Date:   Tue, 22 Jan 2019 15:57:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 05/16] sched/core: uclamp: Update CPU's refcount on
 clamp changes
Message-ID: <20190122145742.GQ27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-6-patrick.bellasi@arm.com>
 <20190121153308.GL27931@hirez.programming.kicks-ass.net>
 <20190121154412.fak2t2iquj3aixtu@e110439-lin>
 <20190122093704.GM27931@hirez.programming.kicks-ass.net>
 <20190122104305.6vjx37muqsxm536t@e110439-lin>
 <20190122132817.GG13777@hirez.programming.kicks-ass.net>
 <20190122140115.twtx646vewm757ca@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122140115.twtx646vewm757ca@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 02:01:15PM +0000, Patrick Bellasi wrote:
> On 22-Jan 14:28, Peter Zijlstra wrote:
> > On Tue, Jan 22, 2019 at 10:43:05AM +0000, Patrick Bellasi wrote:
> > > On 22-Jan 10:37, Peter Zijlstra wrote:
> > 
> > > > Sure, I get that. What I don't get is why you're adding that (2) here.
> > > > Like said, __sched_setscheduler() already does a dequeue/enqueue under
> > > > rq->lock, which should already take care of that.
> > > 
> > > Oh, ok... got it what you mean now.
> > > 
> > > With:
> > > 
> > >    [PATCH v6 01/16] sched/core: Allow sched_setattr() to use the current policy
> > >    <20190115101513.2822-2-patrick.bellasi@arm.com>
> > > 
> > > we can call __sched_setscheduler() with:
> > > 
> > >    attr->sched_flags & SCHED_FLAG_KEEP_POLICY
> > > 
> > > whenever we want just to change the clamp values of a task without
> > > changing its class. Thus, we can end up returning from
> > > __sched_setscheduler() without doing an actual dequeue/enqueue.
> > 
> > I don't see that happening.. when KEEP_POLICY we set attr.sched_policy =
> > SETPARAM_POLICY. That is then checked again in __setscheduler_param(),
> > which is in the middle of that dequeue/enqueue.
> 
> Yes, I think I've forgot a check before we actually dequeue the task.
> 
> The current code does:
> 
> ---8<---
>    SYSCALL_DEFINE3(sched_setattr)
> 
>         // A) request to keep the same policy
>         if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
>             attr.sched_policy = SETPARAM_POLICY;
> 
>         sched_setattr()
>             // B) actually enforce the same policy
>             if (policy < 0)
>                 policy = oldpolicy = p->policy;
> 
>             // C) tune the clamp values
>             if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>                 retval = __setscheduler_uclamp(p, attr);
> 
>             // D) tune attributes if policy is the same
>             if (unlikely(policy == p->policy))
>                 if (fair_policy(policy) && attr->sched_nice != task_nice(p))
>                     goto change;
>                 if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
>                     goto change;
>                 if (dl_policy(policy) && dl_param_changed(p, attr))
>                     goto change;

		  if (util_changed)
		      goto change;

?

>                 return 0;
>         change:
> 
>             // E) dequeue/enqueue task
> ---8<---
> 
> So, probably in D) I've missed a check on SCHED_FLAG_KEEP_POLICY to
> enforce a return in that case...
> 
> > Also, and this might be 'broken', SETPARAM_POLICY _does_ reset all the
> > other attributes, it only preserves policy, but it will (re)set nice
> > level for example (see that same function).
> 
> Mmm... right... my bad! :/
> 
> > So maybe we want to introduce another (few?) FLAG_KEEP flag(s) that
> > preserve the other bits; I'm thinking at least KEEP_PARAM and KEEP_UTIL
> > or something.
> 
> Yes, I would say we have two options:
> 
>  1) SCHED_FLAG_KEEP_POLICY enforces all the scheduling class specific
>     attributes, but cross class attributes (e.g. uclamp)
>
>  2) add SCHED_KEEP_NICE, SCHED_KEEP_PRIO, and SCED_KEEP_PARAMS
>     and use them in the if conditions in D)

So the current KEEP_POLICY basically provides sched_setparam(), and
given we have that as a syscall, that is supposedly a useful
functionality.

Also, NICE/PRIO/DL* is all the same thing and depends on the policy,
KEEP_PARAM should cover the lot

And I suppose the UTIL_CLAMP is !KEEP_UTIL; we could go either way
around with that flag.

> In both cases the goal should be to return from code block D).

I don't think so; we really do want to 'goto change' for util changes
too I think. Why duplicate part of that logic?
