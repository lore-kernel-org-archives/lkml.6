Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D320831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3VvhCdgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413D320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeJ3TjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:39:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeJ3TjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yilsHGeLrvWkzS1/U3VUQx0exaT16U5qH+taFg0cJfw=; b=3VvhCdgM6dpEsbVSjcrGYf5AO
        STGHLdU+2Yz1WHFNDKT3QC6aautp9ONtxjz2I6aL9I/+TwfwmHdYd+PjTajRDkfZk+EwVycXy9PR+
        VfbhDVw7VgEkXoRLDfI7Bmcscb+e1PiRtSno36vUVgozWZOzsOTFIthdzu7f/2xi6+nN0Fu16UPdA
        7vnbB1WLUrBBPVubv1TnNPc3pY511oVMSlGgd65vUFxly849CRrX7RVM7F0EPzrQoU9Cg2HOhwsoz
        MvUocHhEtyvP/eqtBRJ2nYsZXfWIb6XNUWSMdj2UxWK4odk2t1z13f+eUvaX5bZUEFsIMoYQ3pWQ0
        JXrkXjMGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHRX3-00028q-6r; Tue, 30 Oct 2018 10:45:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A20042029FA14; Tue, 30 Oct 2018 11:45:54 +0100 (CET)
Date:   Tue, 30 Oct 2018 11:45:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
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
Message-ID: <20181030104554.GB8177@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024120335.GE29272@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 02:03:35PM +0200, Juri Lelli wrote:
> Pain points:
> 
>  1. Granularity of enforcement (at each tick) is huge compared with
>     the task runtime. This makes starting the replenishment timer,
>     when runtime is depleted, always to fail (because old deadline
>     is way in the past). So, the task is fully replenished and put
>     back to run.
> 
>     - Luca's proposal should help here, since the deadline is postponed
>       at throttling time, and replenishment timer set to that (and it
>       should be in the future)

ACK

>  1.1 Even if we fix 1. in a configuration like this, the task would
>      still be able to run for ~10ms (worst case) and potentially starve
>      other tasks. It doesn't seem a too big interval maybe, but there
>      might be other very short activities that might miss an occasion
>      to run "quickly".
> 
>      - Might be fixed by imposing (via sysctl) reasonable defaults for
>        minimum runtime (w.r.t. HZ, like HZ/2) and maximum for period
>        (as also a very small bandwidth task can have a big runtime if
>        period is big as well)

ACK

>  (1.2) When runtime becomes very negative (because delta_exec was big)
>        we seem to spend lot of time inside the replenishment loop.
> 
>        - Not sure it's such a big problem, might need more profiling.
>          Feeling is that once the other points will be addressed this
> 	 won't matter anymore

Right, once the sysctl limits are in place, we should not have such
excessive cases anymore.

>  2. This is related to perf_event_open syscall reproducer does before
>     becoming DEADLINE and entering the busy loop. Enabling of perf
>     swevents generates lot of hrtimers load that happens in the
>     reproducer task context. Now, DEADLINE uses rq_clock() for setting
>     deadlines, but rq_clock_task() for doing runtime enforcement.
>     In a situation like this it seems that the amount of irq pressure
>     becomes pretty big (I'm seeing this on kvm, real hw should maybe do
>     better, pain point remains I guess), so rq_clock() and
>     rq_clock_task() might become more a more skewed w.r.t. each other.
>     Since rq_clock() is only used when setting absolute deadlines for
>     the first time (or when resetting them in certain cases), after a
>     bit the replenishment code will start to see postponed deadlines
>     always in the past w.r.t. rq_clock(). And this brings us back to the
>     fact that the task is never stopped, since it can't keep up with
>     rq_clock().
> 
>     - Not sure yet how we want to address this [1]. We could use
>       rq_clock() everywhere, but tasks might be penalized by irq
>       pressure (theoretically this would mandate that irqs are
>       explicitly accounted for I guess). I tried to use the skew between
>       the two clocks to "fix" deadlines, but that puts us at risks of
>       de-synchronizing userspace and kernel views of deadlines.

Hurm.. right. We knew of this issue back when we did it.
I suppose now it hurts and we need to figure something out.

By virtue of being a real-time class, we do indeed need to have deadline
on the wall-clock. But if we then don't account runtime on that same
clock, but on a potentially slower clock, we get the problem that we can
run longer than our period/deadline, which is what we're running into
here I suppose.

And yes, at some point RT workloads need to be aware of the jitter
injected by things like IRQs and such. But I believe the rationale was
that for soft real-time workloads this current semantic was 'easier'
because we get to ignore IRQ overhead for workload estimation etc.

What we could maybe do is track runtime in both rq_clock_task() and
rq_clock() and detect where the rq_clock based one exceeds the period
and then push out the deadline (and add runtime).

Maybe something along such lines; does that make sense?

---
 include/linux/sched.h   |  3 +++
 kernel/sched/deadline.c | 53 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8f8a5418b627..6aec81cb3d2e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -522,6 +522,9 @@ struct sched_dl_entity {
 	u64				deadline;	/* Absolute deadline for this instance	*/
 	unsigned int			flags;		/* Specifying the scheduler behaviour	*/
 
+	u64				wallstamp;
+	s64				walltime;
+
 	/*
 	 * Some bool flags:
 	 *
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 91e4202b0634..633c8f36c700 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -683,16 +683,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
 		dl_se->runtime = 0;
 
-	/*
-	 * We keep moving the deadline away until we get some
-	 * available runtime for the entity. This ensures correct
-	 * handling of situations where the runtime overrun is
-	 * arbitrary large.
-	 */
-	while (dl_se->runtime <= 0) {
-		dl_se->deadline += pi_se->dl_period;
-		dl_se->runtime += pi_se->dl_runtime;
-	}
+	/* XXX what do we do with pi_se */
 
 	/*
 	 * At this point, the deadline really should be "in
@@ -1148,9 +1139,9 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec, scaled_delta_exec;
+	u64 delta_exec, scaled_delta_exec, delta_wall;
 	int cpu = cpu_of(rq);
-	u64 now;
+	u64 now, wall;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1171,6 +1162,17 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
 
+	wall = rq_clock();
+	delta_wall = wall - dl_se->wallstamp;
+	if (delta_wall > 0) {
+		dl_se->walltime += delta_wall;
+		dl_se->wallstamp = wall;
+	}
+
+	/* check if rq_clock_task() has been too slow */
+	if (unlikely(dl_se->walltime > dl_se->period))
+		goto throttle;
+
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
 
@@ -1204,14 +1206,27 @@ static void update_curr_dl(struct rq *rq)
 
 	dl_se->runtime -= scaled_delta_exec;
 
-throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
+throttle:
 		dl_se->dl_throttled = 1;
 
-		/* If requested, inform the user about runtime overruns. */
-		if (dl_runtime_exceeded(dl_se) &&
-		    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
-			dl_se->dl_overrun = 1;
+		if (dl_runtime_exceeded(dl_se)) {
+			/* If requested, inform the user about runtime overruns. */
+			if (dl_se->flags & SCHED_FLAG_DL_OVERRUN)
+				dl_se->dl_overrun = 1;
+
+		}
+
+		/*
+		 * We keep moving the deadline away until we get some available
+		 * runtime for the entity. This ensures correct handling of
+		 * situations where the runtime overrun is arbitrary large.
+		 */
+		while (dl_se->runtime <= 0 || dl_se->walltime > dl_se->period) {
+			dl_se->deadline += dl_se->dl_period;
+			dl_se->runtime  += dl_se->dl_runtime;
+			dl_se->walltime -= dl_se->dl_period;
+		}
 
 		__dequeue_task_dl(rq, curr, 0);
 		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
@@ -1751,9 +1766,10 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = dl_task_of(dl_se);
 	p->se.exec_start = rq_clock_task(rq);
+	dl_se->wallstamp = rq_clock(rq);
 
 	/* Running task will never be pushed. */
-       dequeue_pushable_dl_task(rq, p);
+	dequeue_pushable_dl_task(rq, p);
 
 	if (hrtick_enabled(rq))
 		start_hrtick_dl(rq, p);
@@ -1811,6 +1827,7 @@ static void set_curr_task_dl(struct rq *rq)
 	struct task_struct *p = rq->curr;
 
 	p->se.exec_start = rq_clock_task(rq);
+	p->dl_se.wallstamp = rq_clock(rq);
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
