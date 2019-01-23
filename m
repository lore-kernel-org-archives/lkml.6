Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB8FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612C720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dGvn6phD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfAWJQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:16:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfAWJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nyFFw2tVuIIaX9gCZe5JJqss3pbgf7XHgJ577vpgrw4=; b=dGvn6phD00uBeGfvhOHwE8yUz
        fM5EaB2YTK7DfvGTmXDA+Qjz/Y7Rc9lLsev1+dCh6+a8+Wl/NqK2ypYdzI1AiRXDij0FmxsO6iCYB
        unL2wfhRhC9FGs5ToL7uq7nc5Y/gWjcRUUGzRrMurIDZ2qXncwj0feSJegbxu2yi/eRREuwdyWwBo
        r62FX//wC4oAvS0Elry5sJhwOn3qKnsr4s+8WaAdKZ5/kEjF1APKsTD/oep87hcM/6W9PcoHH/9iC
        q5rpgbzs/F1GrP57CVVS+Y6RJUM7+7oaO/52/u27HNDniETV4mKTx3vx9x6e2RmLJIvel4LjQio2c
        vLjbcWFvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmEeD-0004Ra-0f; Wed, 23 Jan 2019 09:16:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E08220D1580D; Wed, 23 Jan 2019 10:16:34 +0100 (CET)
Date:   Wed, 23 Jan 2019 10:16:34 +0100
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
Message-ID: <20190123091634.GT27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-6-patrick.bellasi@arm.com>
 <20190121153308.GL27931@hirez.programming.kicks-ass.net>
 <20190121154412.fak2t2iquj3aixtu@e110439-lin>
 <20190122093704.GM27931@hirez.programming.kicks-ass.net>
 <20190122104305.6vjx37muqsxm536t@e110439-lin>
 <20190122132817.GG13777@hirez.programming.kicks-ass.net>
 <20190122140115.twtx646vewm757ca@e110439-lin>
 <20190122145742.GQ27931@hirez.programming.kicks-ass.net>
 <20190122153315.dhjl67sgpu74hmqv@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122153315.dhjl67sgpu74hmqv@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:33:15PM +0000, Patrick Bellasi wrote:
> On 22-Jan 15:57, Peter Zijlstra wrote:
> > On Tue, Jan 22, 2019 at 02:01:15PM +0000, Patrick Bellasi wrote:

> > > Yes, I would say we have two options:
> > > 
> > >  1) SCHED_FLAG_KEEP_POLICY enforces all the scheduling class specific
> > >     attributes, but cross class attributes (e.g. uclamp)
> > >
> > >  2) add SCHED_KEEP_NICE, SCHED_KEEP_PRIO, and SCED_KEEP_PARAMS
> > >     and use them in the if conditions in D)
> > 
> > So the current KEEP_POLICY basically provides sched_setparam(), and
> 
> But it's not exposed user-space.

Correct; not until your first patch indeed.

> > given we have that as a syscall, that is supposedly a useful
> > functionality.
> 
> For uclamp is definitively useful to change clamps without the need to
> read beforehand the current policy params and use them in a following
> set syscall... which is racy pattern.

Right; but my argument was mostly that if sched_setparam() is a useful
interface, a 'pure' KEEP_POLICY would be too and your (1) looses that.

> > And I suppose the UTIL_CLAMP is !KEEP_UTIL; we could go either way
> > around with that flag.
> 
> What about getting rid of the racy case above by exposing userspace
> only the new UTIL_CLAMP and, on:
> 
>   sched_setscheduler(flags: UTIL_CLAMP)
> 
> we enforce the other two flags from the syscall:
> 
> ---8<---
>         SYSCALL_DEFINE3(sched_setattr)
>             if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY) {
>                 attr.sched_policy = SETPARAM_POLICY;
>                 attr.sched_flags |= (KEEP_POLICY|KEEP_PARAMS);
>             }
> ---8<---
> 
> This will not make possible to change class and set flags in one go,
> but honestly that's likely a very limited use-case, isn't it ?

So I must admit to not seeing much use for sched_setparam() (and its
equivalents) myself, but given it is an existing interface, I also think
it would be nice to cover that functionality in the sched_setattr()
call.

That is; I know of userspace priority-ceiling implementations using
sched_setparam(), but I don't see any reason why that wouldn't also work
with sched_setscheduler() (IOW always also set the policy).

> > > In both cases the goal should be to return from code block D).
> > 
> > I don't think so; we really do want to 'goto change' for util changes
> > too I think. Why duplicate part of that logic?
> 
> But that will force a dequeue/enqueue... isn't too much overhead just
> to change a clamp value?

These syscalls aren't what I consider fast paths anyway. However, there
are people that rely on the scheduler syscalls not to schedule
themselves, or rather be non-blocking (see for example that prio-ceiling
implementation).

And in that respect the newly introduced uclamp_mutex does appear to be
a problem.

Also; do you expect these clamp values to be changed often?

> Perhaps we can also end up with some wired

s/wired/weird/, right?

> side-effects like the task being preempted ?

Nothing worse than any other random reschedule would cause.

> Consider also that the uclamp_task_update_active() added by this patch
> not only has lower overhead but it will be use also by cgroups where
> we want to force update all the tasks on a cgroup's clamp change.

I haven't gotten that far; but I would prefer not to have two different
'change' paths in __sched_setscheduler().
