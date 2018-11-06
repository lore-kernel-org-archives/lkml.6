Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4140BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA512085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA512085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbeKFVJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:09:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39030 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbeKFVJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:09:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so11422872wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 03:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2QJipU+HXUvVA+b1QDgedT6J9Y32YKRs0MEcblmHkkA=;
        b=Zwa0DHxdF8N9bd/VxXY18RNxyoawY/t2l+/nRArfCP7zddj2dwJ5HsyMfc+BnRT7xA
         U/Q5220YZ210Dz5pHgaXhwUKhITn8r5/XVKzIiSEUNoJTNbWUUbE+j57jhG5GyC064gR
         6ZG8UFbVfGSg2w5G9paZ2dja8flZM7NzbIvFdYB8Ubwcu3TJ5J5sKYFD+JqBGDf5YpvM
         AsdgwAR2VxX1qPvtyRZE7F5DvV0r2TPg5aQIFvM7de3NYJvcZDx0hN4eqWi5Hv2xsmWM
         m26UvIuBL8Y0YfpKAprmaFEFpBbLlz3ceAnpf40h2nJyJ2DlQE1InxhE8HACECVxqjMl
         FObA==
X-Gm-Message-State: AGRZ1gIy0ejcfihAyf5zLfDB4ZrwcU7cYwylACzLjU0wb9coLqEfpgbt
        2OBNW9rU137OiJBOPMkOSLcHgw==
X-Google-Smtp-Source: AJdET5eH/Kuc0T64L/Q4ZiGotG1D8T4bhPwlfn2gZAHOwRaEP6xxYXtxffYklRtIEkb8q4qo8mC9Zw==
X-Received: by 2002:a1c:5d01:: with SMTP id r1-v6mr1642360wmb.25.1541504697277;
        Tue, 06 Nov 2018 03:44:57 -0800 (PST)
Received: from localhost.localdomain ([151.34.111.247])
        by smtp.gmail.com with ESMTPSA id 191-v6sm2291681wmk.30.2018.11.06.03.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 03:44:56 -0800 (PST)
Date:   Tue, 6 Nov 2018 12:44:52 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20181106114452.GV18091@localhost.localdomain>
References: <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <20181030104554.GB8177@hirez.programming.kicks-ass.net>
 <20181030111221.GA18091@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030111221.GA18091@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/18 12:12, Juri Lelli wrote:
> On 30/10/18 11:45, Peter Zijlstra wrote:
> 
> [...]
> 
> > Hurm.. right. We knew of this issue back when we did it.
> > I suppose now it hurts and we need to figure something out.
> > 
> > By virtue of being a real-time class, we do indeed need to have deadline
> > on the wall-clock. But if we then don't account runtime on that same
> > clock, but on a potentially slower clock, we get the problem that we can
> > run longer than our period/deadline, which is what we're running into
> > here I suppose.
> > 
> > And yes, at some point RT workloads need to be aware of the jitter
> > injected by things like IRQs and such. But I believe the rationale was
> > that for soft real-time workloads this current semantic was 'easier'
> > because we get to ignore IRQ overhead for workload estimation etc.
> 
> Right. In this case the task is self injecting IRQ load, but it maybe
> doesn't make a big difference on how we need to treat it (supposing we
> can actually distinguish).
> 
> > What we could maybe do is track runtime in both rq_clock_task() and
> > rq_clock() and detect where the rq_clock based one exceeds the period
> > and then push out the deadline (and add runtime).
> > 
> > Maybe something along such lines; does that make sense?
> 
> Yeah, I think I've got the gist of the idea. I'll play with it.

So, even though I consider Luca and Daniel's points/concerns more then
valid, I spent I bit of time playing with this idea and ended up with
what follows.

I'm adding deadline adjustment when we realize that there is a
difference between delta_exec and delta_wall (IRQ load) and walltime is
bigger then configured dl_period. The adjustment to rq_clock (even
though it of course de-synchs user/kernel deadlines) seems needed, as w/o
this kind of thing task doesn't get throttled for too long, a dl_period
at max I guess, after having been running for quite a while.

Another change is that I believe we want to keep runtime always below
dl_runtime while pushing deadline away.

This doesn't seem to modify behavior for non misbehaving and non
affected by irq load tasks and should fix stalls and starvation of lower
prio activities problem.

Does it make any sense? :-)

--->8---
 include/linux/sched.h   |  3 ++
 kernel/sched/deadline.c | 78 ++++++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..e5aaf6deab7e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -521,6 +521,9 @@ struct sched_dl_entity {
 	u64				deadline;	/* Absolute deadline for this instance	*/
 	unsigned int			flags;		/* Specifying the scheduler behaviour	*/
 
+	u64				wallstamp;
+	s64				walltime;
+
 	/*
 	 * Some bool flags:
 	 *
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 93da990ba458..061562589282 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -696,16 +696,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
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
+	/* XXX have to deal with PI */
+	dl_se->walltime = 0;
 
 
 	/*
@@ -917,7 +909,7 @@ static int start_dl_timer(struct task_struct *p)
 	 * that it is actually coming from rq->clock and not from
 	 * hrtimer's time base reading.
 	 */
-	act = ns_to_ktime(dl_next_period(dl_se));
+	act = ns_to_ktime(dl_se->deadline - dl_se->dl_period);
 	now = hrtimer_cb_get_time(timer);
 	delta = ktime_to_ns(now) - rq_clock(rq);
 	trace_printk("%s: cpu:%d pid:%d dl_runtime:%llu dl_deadline:%llu dl_period:%llu runtime:%lld deadline:%llu rq_clock:%llu rq_clock_task:%llu act:%lld now:%lld delta:%lld",
@@ -1174,9 +1166,10 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec, scaled_delta_exec;
+	u64 delta_exec, scaled_delta_exec, delta_wall;
 	int cpu = cpu_of(rq);
-	u64 now;
+	u64 now, wall;
+	bool adjusted = false;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1191,12 +1184,28 @@ static void update_curr_dl(struct rq *rq)
 	 */
 	now = rq_clock_task(rq);
 	delta_exec = now - curr->se.exec_start;
+
+	wall = rq_clock(rq);
+	delta_wall = wall - dl_se->wallstamp;
+
 	if (unlikely((s64)delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
 		return;
 	}
 
+	if (delta_wall > 0) {
+		dl_se->walltime += delta_wall;
+		dl_se->wallstamp = wall;
+	}
+
 	schedstat_set(curr->se.statistics.exec_max,
 		      max(curr->se.statistics.exec_max, delta_exec));
 
@@ -1230,22 +1239,47 @@ static void update_curr_dl(struct rq *rq)
 
 	dl_se->runtime -= scaled_delta_exec;
 
+	if (dl_runtime_exceeded(dl_se) ||
+	    dl_se->dl_yielded ||
+	    unlikely(dl_se->walltime > dl_se->dl_period)) {
 throttle:
-	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
 		dl_se->dl_throttled = 1;
 
 		/* If requested, inform the user about runtime overruns. */
 		if (dl_runtime_exceeded(dl_se) &&
 		    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
 			dl_se->dl_overrun = 1;
-
 		__dequeue_task_dl(rq, curr, 0);
 
+		/*
+		 * We keep moving the deadline away until we get some available
+		 * runtime for the entity. This ensures correct handling of
+		 * situations where the runtime overrun is arbitrary large.
+		 */
+		while (dl_se->runtime <= 0 || dl_se->walltime > (s64)dl_se->dl_period) {
+
+			if (delta_exec != delta_wall &&
+			    dl_se->walltime > (s64)dl_se->dl_period && !adjusted) {
+				dl_se->deadline = wall;
+				adjusted = true;
+			}
+
+			dl_se->deadline += dl_se->dl_period;
+
+			if (dl_se->runtime <= 0)
+				dl_se->runtime  += dl_se->dl_runtime;
+
+			dl_se->walltime -= dl_se->dl_period;
+		}
+
+		WARN_ON_ONCE(dl_se->runtime > dl_se->dl_runtime);
+
 		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
 			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
 
@@ -1783,9 +1817,10 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = dl_task_of(dl_se);
 	p->se.exec_start = rq_clock_task(rq);
+	dl_se->wallstamp = rq_clock(rq);
 
 	/* Running task will never be pushed. */
-       dequeue_pushable_dl_task(rq, p);
+	dequeue_pushable_dl_task(rq, p);
 
 	if (hrtick_enabled(rq))
 		start_hrtick_dl(rq, p);
@@ -1843,6 +1878,7 @@ static void set_curr_task_dl(struct rq *rq)
 	struct task_struct *p = rq->curr;
 
 	p->se.exec_start = rq_clock_task(rq);
+	p->dl.wallstamp = rq_clock(rq);
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
