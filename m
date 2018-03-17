Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeCQM3c (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 08:29:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbeCQM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 08:29:30 -0400
Date: Sat, 17 Mar 2018 13:29:27 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v4.14.27-rt21
Message-ID: <20180317122927.wlamwxfvqvnkgdhp@linutronix.de>
References: <20180317114919.r74kp5m35cz6wstw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180317114919.r74kp5m35cz6wstw@linutronix.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-17 12:49:20 [+0100], To Thomas Gleixner wrote:
> The delta patch against v4.14.27-rt20 is appended below and can be found here:

diff --git a/block/blk-core.c b/block/blk-core.c
index ff1258ca236c..b37ea6bb739c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -799,7 +799,7 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
 		 */
 		smp_rmb();
 
-		ret = swait_event_interruptible(q->mq_freeze_wq,
+		ret = wait_event_interruptible(q->mq_freeze_wq,
 				!atomic_read(&q->mq_freeze_depth) ||
 				blk_queue_dying(q));
 		if (blk_queue_dying(q))
@@ -814,12 +814,21 @@ void blk_queue_exit(struct request_queue *q)
 	percpu_ref_put(&q->q_usage_counter);
 }
 
+static void blk_queue_usage_counter_release_swork(struct swork_event *sev)
+{
+	struct request_queue *q =
+		container_of(sev, struct request_queue, mq_pcpu_wake);
+
+	wake_up_all(&q->mq_freeze_wq);
+}
+
 static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 {
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
-	swake_up_all(&q->mq_freeze_wq);
+	if (wq_has_sleeper(&q->mq_freeze_wq))
+		swork_queue(&q->mq_pcpu_wake);
 }
 
 static void blk_rq_timed_out_timer(unsigned long data)
@@ -895,7 +904,8 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	q->bypass_depth = 1;
 	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 
-	init_swait_queue_head(&q->mq_freeze_wq);
+	init_waitqueue_head(&q->mq_freeze_wq);
+	INIT_SWORK(&q->mq_pcpu_wake, blk_queue_usage_counter_release_swork);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
@@ -3623,6 +3633,8 @@ int __init blk_dev_init(void)
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
+	BUG_ON(swork_get());
+
 	request_cachep = kmem_cache_create("blkdev_requests",
 			sizeof(struct request), 0, SLAB_PANIC, NULL);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bbe43d32f71a..c5bd467dd97b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -132,14 +132,14 @@ EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
 void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
-	swait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
+	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout)
 {
-	return swait_event_timeout(q->mq_freeze_wq,
+	return wait_event_timeout(q->mq_freeze_wq,
 					percpu_ref_is_zero(&q->q_usage_counter),
 					timeout);
 }
@@ -182,7 +182,7 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
 		percpu_ref_reinit(&q->q_usage_counter);
-		swake_up_all(&q->mq_freeze_wq);
+		wake_up_all(&q->mq_freeze_wq);
 	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
@@ -263,7 +263,7 @@ void blk_mq_wake_waiters(struct request_queue *q)
 	 * dying, we need to ensure that processes currently waiting on
 	 * the queue are notified as well.
 	 */
-	swake_up_all(&q->mq_freeze_wq);
+	wake_up_all(&q->mq_freeze_wq);
 }
 
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6f278f1fd634..49b53ad6d2d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,6 +27,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
+#include <linux/swork.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -598,7 +599,8 @@ struct request_queue {
 	struct throtl_data *td;
 #endif
 	struct rcu_head		rcu_head;
-	struct swait_queue_head	mq_freeze_wq;
+	wait_queue_head_t	mq_freeze_wq;
+	struct swork_event	mq_pcpu_wake;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6c77643eaf02..ce2c2d04cbaa 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1742,13 +1742,12 @@ int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 	return -ERESTART_RESTARTBLOCK;
 }
 
-static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode,
-				unsigned long state)
+static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode)
 {
 	struct restart_block *restart;
 
 	do {
-		set_current_state(state);
+		set_current_state(TASK_INTERRUPTIBLE);
 		hrtimer_start_expires(&t->timer, mode);
 
 		if (likely(t->task))
@@ -1786,15 +1785,13 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
 				      HRTIMER_MODE_ABS, current);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-	/* cpu_chill() does not care about restart state. */
-	ret = do_nanosleep(&t, HRTIMER_MODE_ABS, TASK_INTERRUPTIBLE);
+	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
 }
 
-static long __hrtimer_nanosleep(const struct timespec64 *rqtp,
-				const enum hrtimer_mode mode, const clockid_t clockid,
-				unsigned long state)
+long hrtimer_nanosleep(const struct timespec64 *rqtp,
+		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
@@ -1807,7 +1804,7 @@ static long __hrtimer_nanosleep(const struct timespec64 *rqtp,
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode, current);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
-	ret = do_nanosleep(&t, mode, state);
+	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
 
@@ -1826,12 +1823,6 @@ static long __hrtimer_nanosleep(const struct timespec64 *rqtp,
 	return ret;
 }
 
-long hrtimer_nanosleep(const struct timespec64 *rqtp,
-		       const enum hrtimer_mode mode, const clockid_t clockid)
-{
-	return __hrtimer_nanosleep(rqtp, mode, clockid, TASK_INTERRUPTIBLE);
-}
-
 SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
 		struct timespec __user *, rmtp)
 {
@@ -1873,14 +1864,13 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
  */
 void cpu_chill(void)
 {
-	struct timespec64 tu = {
-		.tv_nsec = NSEC_PER_MSEC,
-	};
+	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
 
+	chill_time = ktime_set(0, NSEC_PER_MSEC);
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	current->flags |= PF_NOFREEZE;
-	__hrtimer_nanosleep(&tu, HRTIMER_MODE_REL_HARD, CLOCK_MONOTONIC,
-			    TASK_UNINTERRUPTIBLE);
+	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
 }
diff --git a/localversion-rt b/localversion-rt
index e095ab819714..6c6cde1c29e3 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt20
+-rt21
