Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEC1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A825420827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A825420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJ3UBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:01:14 -0400
Received: from mail.sssup.it ([193.205.80.98]:38396 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeJ3UBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:01:14 -0400
Received: from [151.40.16.141] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 134052431; Tue, 30 Oct 2018 12:08:09 +0100
Date:   Tue, 30 Oct 2018 12:08:04 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181030120804.2f30c2da@sweethome>
In-Reply-To: <20181030104554.GB8177@hirez.programming.kicks-ass.net>
References: <20181016144045.GF9130@localhost.localdomain>
        <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
        <20181016153608.GH9130@localhost.localdomain>
        <20181018082838.GA21611@localhost.localdomain>
        <20181018122331.50ed3212@luca64>
        <20181018104713.GC21611@localhost.localdomain>
        <20181018130811.61337932@luca64>
        <20181019113942.GH3121@hirez.programming.kicks-ass.net>
        <20181019225005.61707c64@nowhere>
        <20181024120335.GE29272@localhost.localdomain>
        <20181030104554.GB8177@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 30 Oct 2018 11:45:54 +0100
Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> >  2. This is related to perf_event_open syscall reproducer does
> > before becoming DEADLINE and entering the busy loop. Enabling of
> > perf swevents generates lot of hrtimers load that happens in the
> >     reproducer task context. Now, DEADLINE uses rq_clock() for
> > setting deadlines, but rq_clock_task() for doing runtime
> > enforcement. In a situation like this it seems that the amount of
> > irq pressure becomes pretty big (I'm seeing this on kvm, real hw
> > should maybe do better, pain point remains I guess), so rq_clock()
> > and rq_clock_task() might become more a more skewed w.r.t. each
> > other. Since rq_clock() is only used when setting absolute
> > deadlines for the first time (or when resetting them in certain
> > cases), after a bit the replenishment code will start to see
> > postponed deadlines always in the past w.r.t. rq_clock(). And this
> > brings us back to the fact that the task is never stopped, since it
> > can't keep up with rq_clock().
> > 
> >     - Not sure yet how we want to address this [1]. We could use
> >       rq_clock() everywhere, but tasks might be penalized by irq
> >       pressure (theoretically this would mandate that irqs are
> >       explicitly accounted for I guess). I tried to use the skew
> > between the two clocks to "fix" deadlines, but that puts us at
> > risks of de-synchronizing userspace and kernel views of deadlines.  
> 
> Hurm.. right. We knew of this issue back when we did it.
> I suppose now it hurts and we need to figure something out.
> 
> By virtue of being a real-time class, we do indeed need to have
> deadline on the wall-clock. But if we then don't account runtime on
> that same clock, but on a potentially slower clock, we get the
> problem that we can run longer than our period/deadline, which is
> what we're running into here I suppose.

I might be hugely misunderstanding something here, but in my impression
the issue is just that if the IRQ time is not accounted to the
-deadline task, then the non-deadline tasks might be starved.

I do not see this as a skew between two clocks, but as an accounting
thing:
- if we decide that the IRQ time is accounted to the -deadline
  task (this is what happens with CONFIG_IRQ_TIME_ACCOUNTING disabled),
  then the non-deadline tasks are not starved (but of course the
  -deadline tasks executes for less than its reserved time in the
  period); 
- if we decide that the IRQ time is not accounted to the -deadline task
  (this is what happens with CONFIG_IRQ_TIME_ACCOUNTING enabled), then
  the -deadline task executes for the expected amount of time (about
  60% of the CPU time), but an IRQ load of 40% will starve non-deadline
  tasks (this is what happens in the bug that triggered this discussion)

I think this might be seen as an adimission control issue: when
CONFIG_IRQ_TIME_ACCOUNTING is disabled, the IRQ time is accounted for
in the admission control (because it ends up in the task's runtime),
but when CONFIG_IRQ_TIME_ACCOUNTING is enabled the IRQ time is not
accounted for in the admission test (the IRQ handler becomes some sort
of entity with a higher priority than -deadline tasks, on which no
accounting or enforcement is performed).



> And yes, at some point RT workloads need to be aware of the jitter
> injected by things like IRQs and such. But I believe the rationale was
> that for soft real-time workloads this current semantic was 'easier'
> because we get to ignore IRQ overhead for workload estimation etc.
> 
> What we could maybe do is track runtime in both rq_clock_task() and
> rq_clock() and detect where the rq_clock based one exceeds the period
> and then push out the deadline (and add runtime).
> 
> Maybe something along such lines; does that make sense?

Uhm... I have to study and test your patch... I'll comment on this
later.



			Thanks,
				Luca


> 
> ---
>  include/linux/sched.h   |  3 +++
>  kernel/sched/deadline.c | 53
> ++++++++++++++++++++++++++++++++----------------- 2 files changed, 38
> insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8f8a5418b627..6aec81cb3d2e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -522,6 +522,9 @@ struct sched_dl_entity {
>  	u64				deadline;	/*
> Absolute deadline for this instance	*/ unsigned
> int			flags;		/* Specifying the
> scheduler behaviour	*/ 
> +	u64				wallstamp;
> +	s64				walltime;
> +
>  	/*
>  	 * Some bool flags:
>  	 *
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 91e4202b0634..633c8f36c700 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -683,16 +683,7 @@ static void replenish_dl_entity(struct
> sched_dl_entity *dl_se, if (dl_se->dl_yielded && dl_se->runtime > 0)
>  		dl_se->runtime = 0;
>  
> -	/*
> -	 * We keep moving the deadline away until we get some
> -	 * available runtime for the entity. This ensures correct
> -	 * handling of situations where the runtime overrun is
> -	 * arbitrary large.
> -	 */
> -	while (dl_se->runtime <= 0) {
> -		dl_se->deadline += pi_se->dl_period;
> -		dl_se->runtime += pi_se->dl_runtime;
> -	}
> +	/* XXX what do we do with pi_se */
>  
>  	/*
>  	 * At this point, the deadline really should be "in
> @@ -1148,9 +1139,9 @@ static void update_curr_dl(struct rq *rq)
>  {
>  	struct task_struct *curr = rq->curr;
>  	struct sched_dl_entity *dl_se = &curr->dl;
> -	u64 delta_exec, scaled_delta_exec;
> +	u64 delta_exec, scaled_delta_exec, delta_wall;
>  	int cpu = cpu_of(rq);
> -	u64 now;
> +	u64 now, wall;
>  
>  	if (!dl_task(curr) || !on_dl_rq(dl_se))
>  		return;
> @@ -1171,6 +1162,17 @@ static void update_curr_dl(struct rq *rq)
>  		return;
>  	}
>  
> +	wall = rq_clock();
> +	delta_wall = wall - dl_se->wallstamp;
> +	if (delta_wall > 0) {
> +		dl_se->walltime += delta_wall;
> +		dl_se->wallstamp = wall;
> +	}
> +
> +	/* check if rq_clock_task() has been too slow */
> +	if (unlikely(dl_se->walltime > dl_se->period))
> +		goto throttle;
> +
>  	schedstat_set(curr->se.statistics.exec_max,
>  		      max(curr->se.statistics.exec_max, delta_exec));
>  
> @@ -1204,14 +1206,27 @@ static void update_curr_dl(struct rq *rq)
>  
>  	dl_se->runtime -= scaled_delta_exec;
>  
> -throttle:
>  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> +throttle:
>  		dl_se->dl_throttled = 1;
>  
> -		/* If requested, inform the user about runtime
> overruns. */
> -		if (dl_runtime_exceeded(dl_se) &&
> -		    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
> -			dl_se->dl_overrun = 1;
> +		if (dl_runtime_exceeded(dl_se)) {
> +			/* If requested, inform the user about
> runtime overruns. */
> +			if (dl_se->flags & SCHED_FLAG_DL_OVERRUN)
> +				dl_se->dl_overrun = 1;
> +
> +		}
> +
> +		/*
> +		 * We keep moving the deadline away until we get
> some available
> +		 * runtime for the entity. This ensures correct
> handling of
> +		 * situations where the runtime overrun is arbitrary
> large.
> +		 */
> +		while (dl_se->runtime <= 0 || dl_se->walltime >
> dl_se->period) {
> +			dl_se->deadline += dl_se->dl_period;
> +			dl_se->runtime  += dl_se->dl_runtime;
> +			dl_se->walltime -= dl_se->dl_period;
> +		}
>  
>  		__dequeue_task_dl(rq, curr, 0);
>  		if (unlikely(dl_se->dl_boosted
> || !start_dl_timer(curr))) @@ -1751,9 +1766,10 @@
> pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct
> rq_flags *rf) p = dl_task_of(dl_se);
>  	p->se.exec_start = rq_clock_task(rq);
> +	dl_se->wallstamp = rq_clock(rq);
>  
>  	/* Running task will never be pushed. */
> -       dequeue_pushable_dl_task(rq, p);
> +	dequeue_pushable_dl_task(rq, p);
>  
>  	if (hrtick_enabled(rq))
>  		start_hrtick_dl(rq, p);
> @@ -1811,6 +1827,7 @@ static void set_curr_task_dl(struct rq *rq)
>  	struct task_struct *p = rq->curr;
>  
>  	p->se.exec_start = rq_clock_task(rq);
> +	p->dl_se.wallstamp = rq_clock(rq);
>  
>  	/* You can't push away the running task */
>  	dequeue_pushable_dl_task(rq, p);

