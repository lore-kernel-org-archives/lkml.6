Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2962085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ODBKa4OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbfBRRlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:41:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47750 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfBRRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mmiLVoUZRU37lvRwwkq3RS7+d9n1wBBbA2xql9rJN9I=; b=ODBKa4ODMjJKtAd2+qrsD+E9gx
        lJL1meuPuYNwpl7aYs24+suxJ04WBAjyKg8pZoOChTYtL4Z8Jh+n9zCj8KmeuhBsQxyO3bVlE1Qil
        Cwmimhc3pdb4sPm46SxJZUefGosJjWuu+vJNH5gOc0DN5yszPkmULcY707uD3HMKdQ0+mIkirAoqV
        44IKnERTRBNGf0d5Zrj/1DMlT+EoVijfptj20PCD1Yden/9WRwk8QqeLNMtG3Ejd4ENR5OEN3IGNS
        gOmWcXQw/hg70hfFykHBAdWmzFaxsaYYMnIPmi917pr9z2KdGKBY0bDfYr7VcYlFUMcP2J8l2e+yl
        YMp2+1bA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu2-0001Ew-FM; Mon, 18 Feb 2019 17:40:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2E2582848B879; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.359026684@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 08/16] sched: Rework pick_next_task() slow-path
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the RETRY_TASK case in the pick_next_task() slow path.

By doing the put_prev_task() early, we get the rt/deadline pull done,
and by testing rq->nr_running we know if we need newidle_balance().

This then gives a stable state to pick a task from.

Since the fast-path is fair only; it means the other classes will
always have pick_next_task(.prev=NULL, .rf=NULL) and we can simplify.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |   19 ++++++++++++-------
 kernel/sched/deadline.c  |   30 ++----------------------------
 kernel/sched/fair.c      |    9 ++++++---
 kernel/sched/idle.c      |    4 +++-
 kernel/sched/rt.c        |   29 +----------------------------
 kernel/sched/sched.h     |   13 ++++++++-----
 kernel/sched/stop_task.c |    3 ++-
 7 files changed, 34 insertions(+), 73 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3360,7 +3360,7 @@ pick_next_task(struct rq *rq, struct tas
 
 		p = fair_sched_class.pick_next_task(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
-			goto again;
+			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
 		if (unlikely(!p))
@@ -3369,14 +3369,19 @@ pick_next_task(struct rq *rq, struct tas
 		return p;
 	}
 
-again:
+restart:
+	/*
+	 * Ensure that we put DL/RT tasks before the pick loop, such that they
+	 * can PULL higher prio tasks when we lower the RQ 'priority'.
+	 */
+	prev->sched_class->put_prev_task(rq, prev, rf);
+	if (!rq->nr_running)
+		newidle_balance(rq, rf);
+
 	for_each_class(class) {
-		p = class->pick_next_task(rq, prev, rf);
-		if (p) {
-			if (unlikely(p == RETRY_TASK))
-				goto again;
+		p = class->pick_next_task(rq, NULL, NULL);
+		if (p)
 			return p;
-		}
 	}
 
 	/* The idle class should always have a runnable task: */
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1730,39 +1730,13 @@ pick_next_task_dl(struct rq *rq, struct
 	struct task_struct *p;
 	struct dl_rq *dl_rq;
 
-	dl_rq = &rq->dl;
-
-	if (need_pull_dl_task(rq, prev)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we're
-		 * being very careful to re-start the picking loop.
-		 */
-		rq_unpin_lock(rq, rf);
-		pull_dl_task(rq);
-		rq_repin_lock(rq, rf);
-		/*
-		 * pull_dl_task() can drop (and re-acquire) rq->lock; this
-		 * means a stop task can slip in, in which case we need to
-		 * re-start task selection.
-		 */
-		if (rq->stop && task_on_rq_queued(rq->stop))
-			return RETRY_TASK;
-	}
+	WARN_ON_ONCE(prev || rf);
 
-	/*
-	 * When prev is DL, we may throttle it in put_prev_task().
-	 * So, we update time before we check for dl_nr_running.
-	 */
-	if (prev->sched_class == &dl_sched_class)
-		update_curr_dl(rq);
+	dl_rq = &rq->dl;
 
 	if (unlikely(!dl_rq->dl_nr_running))
 		return NULL;
 
-	put_prev_task(rq, prev);
-
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6949,7 +6949,7 @@ pick_next_task_fair(struct rq *rq, struc
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (prev->sched_class != &fair_sched_class)
+	if (!prev || prev->sched_class != &fair_sched_class)
 		goto simple;
 
 	/*
@@ -7026,8 +7026,8 @@ pick_next_task_fair(struct rq *rq, struc
 	goto done;
 simple:
 #endif
-
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
 
 	do {
 		se = pick_next_entity(cfs_rq, NULL);
@@ -7055,6 +7055,9 @@ done: __maybe_unused;
 	return p;
 
 idle:
+	if (!rf)
+		return NULL;
+
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -388,7 +388,9 @@ pick_next_task_idle(struct rq *rq, struc
 {
 	struct task_struct *next = rq->idle;
 
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
+
 	set_next_task_idle(rq, next);
 
 	return next;
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1554,38 +1554,11 @@ pick_next_task_rt(struct rq *rq, struct
 	struct task_struct *p;
 	struct rt_rq *rt_rq = &rq->rt;
 
-	if (need_pull_rt_task(rq, prev)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we're
-		 * being very careful to re-start the picking loop.
-		 */
-		rq_unpin_lock(rq, rf);
-		pull_rt_task(rq);
-		rq_repin_lock(rq, rf);
-		/*
-		 * pull_rt_task() can drop (and re-acquire) rq->lock; this
-		 * means a dl or stop task can slip in, in which case we need
-		 * to re-start task selection.
-		 */
-		if (unlikely((rq->stop && task_on_rq_queued(rq->stop)) ||
-			     rq->dl.dl_nr_running))
-			return RETRY_TASK;
-	}
-
-	/*
-	 * We may dequeue prev's rt_rq in put_prev_task().
-	 * So, we update time before rt_queued check.
-	 */
-	if (prev->sched_class == &rt_sched_class)
-		update_curr_rt(rq);
+	WARN_ON_ONCE(prev || rf);
 
 	if (!rt_rq->rt_queued)
 		return NULL;
 
-	put_prev_task(rq, prev);
-
 	p = _pick_next_task_rt(rq);
 
 	set_next_task_rt(rq, p);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1665,12 +1665,15 @@ struct sched_class {
 	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
 
 	/*
-	 * It is the responsibility of the pick_next_task() method that will
-	 * return the next task to call put_prev_task() on the @prev task or
-	 * something equivalent.
+	 * Both @prev and @rf are optional and may be NULL, in which case the
+	 * caller must already have invoked put_prev_task(rq, prev, rf).
 	 *
-	 * May return RETRY_TASK when it finds a higher prio class has runnable
-	 * tasks.
+	 * Otherwise it is the responsibility of the pick_next_task() to call
+	 * put_prev_task() on the @prev task or something equivalent, IFF it
+	 * returns a next task.
+	 *
+	 * In that case (@rf != NULL) it may return RETRY_TASK when it finds a
+	 * higher prio class has runnable tasks.
 	 */
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -33,10 +33,11 @@ pick_next_task_stop(struct rq *rq, struc
 {
 	struct task_struct *stop = rq->stop;
 
+	WARN_ON_ONCE(prev || rf);
+
 	if (!stop || !task_on_rq_queued(stop))
 		return NULL;
 
-	put_prev_task(rq, prev);
 	set_next_task_stop(rq, stop);
 
 	return stop;


