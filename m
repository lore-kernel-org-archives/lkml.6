Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE111C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C922063F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfAILAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:00:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53529 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfAILAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:00:54 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghBbO-00047a-2E; Wed, 09 Jan 2019 12:00:50 +0100
Date:   Wed, 9 Jan 2019 12:00:50 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.19.13-rt10
Message-ID: <20190109110049.cp5scbhd2xaqqjn3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.19.13-rt10 patch set. 

Changes since v4.19.13-rt9:

  - Two scheduler timer were moved from hardirq context to softirq.
    Patch by Peter Zijlstra.

  - Flush I/O while waiting for readlock of a rwsem to avoid I/O
    deadlocks. Patch by Scott Wood.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.19.13-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.13-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.19.13-rt10

The RT patch against v4.19.13 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.13-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patches-4.19.13-rt10.tar.xz

Sebastian

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 27f144b2d87b9..bbac843464de1 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1932,7 +1932,7 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	 * If rt_mutex blocks, the function sched_submit_work will not call
 	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
 	 * We must call blk_schedule_flush_plug here, if we don't call it,
-	 * a deadlock in device mapper may happen.
+	 * a deadlock in I/O may happen.
 	 */
 	if (unlikely(blk_needs_flush_plug(current)))
 		blk_schedule_flush_plug(current);
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 660e22caf7099..f518495bd6ccd 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -1,5 +1,6 @@
 /*
  */
+#include <linux/blkdev.h>
 #include <linux/rwsem.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -87,6 +88,14 @@ static int __sched __down_read_common(struct rw_semaphore *sem, int state)
 
 	if (__down_read_trylock(sem))
 		return 0;
+	/*
+	 * If rt_mutex blocks, the function sched_submit_work will not call
+	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
+	 * We must call blk_schedule_flush_plug here, if we don't call it,
+	 * a deadlock in I/O may happen.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
 
 	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4d4dbed98adf2..049ff794c74e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4554,7 +4554,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 		struct rq *rq = rq_of(cfs_rq);
 		struct rq_flags rf;
 
-		rq_lock(rq, &rf);
+		rq_lock_irqsave(rq, &rf);
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
@@ -4571,7 +4571,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 			unthrottle_cfs_rq(cfs_rq);
 
 next:
-		rq_unlock(rq, &rf);
+		rq_unlock_irqrestore(rq, &rf);
 
 		if (!remaining)
 			break;
@@ -4587,7 +4587,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
  * period the timer is deactivated until scheduling resumes; cfs_b->idle is
  * used to track this state.
  */
-static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
+static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
 	u64 runtime, runtime_expires;
 	int throttled;
@@ -4629,11 +4629,11 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
 		runtime = cfs_b->runtime;
 		cfs_b->distribute_running = 1;
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
 		runtime = distribute_cfs_runtime(cfs_b, runtime,
 						 runtime_expires);
-		raw_spin_lock(&cfs_b->lock);
+		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
@@ -4742,17 +4742,18 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
 	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	unsigned long flags;
 	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (cfs_b->distribute_running) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
 	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
@@ -4763,18 +4764,18 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (runtime)
 		cfs_b->distribute_running = 1;
 
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	if (!runtime)
 		return;
 
 	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (expires == cfs_b->runtime_expires)
 		cfs_b->runtime -= min(runtime, cfs_b->runtime);
 	cfs_b->distribute_running = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
@@ -4852,20 +4853,21 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
+	unsigned long flags;
 	int overrun;
 	int idle = 0;
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
 		if (!overrun)
 			break;
 
-		idle = do_sched_cfs_period_timer(cfs_b, overrun);
+		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
 		cfs_b->period_active = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
 }
@@ -4878,9 +4880,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->distribute_running = 0;
 }
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a42..d79dde624aaac 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
