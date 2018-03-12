Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeCLTvZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:51:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:51:24 -0400
Date: Mon, 12 Mar 2018 20:51:18 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180312195118.rye5lg2pb26kmavn@linutronix.de>
References: <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
 <20180309202550.j66qphz3txupt55u@linutronix.de>
 <20180309222643.GC5926@hirez.programming.kicks-ass.net>
 <20180312105113.p7jifhwdwbhpvxds@linutronix.de>
 <20180312132729.GI4064@hirez.programming.kicks-ass.net>
 <20180312141107.roveviectc6a75s7@linutronix.de>
 <20180312142933.GF4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312142933.GF4043@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-12 15:29:33 [+0100], Peter Zijlstra wrote:
> On Mon, Mar 12, 2018 at 03:11:07PM +0100, Sebastian Andrzej Siewior wrote:
> > I assumed you complained about the unbounded list-walk with interrupts
> > disabled (which is cheap but unbound is unbound). So here I suggested I
> > move 20 entries off that list a time and enable interrupts again so an
> > interrupt could set need_resched.
> > But if we get invoked !preemptible then nothing changes.
> 
> Right, so any !preemptible invocation of wake_all is bad.

I doubt can I can argue the move of wake_up_all() into a workqueue in a
sane way. Not to mention that it wouldn't do any good for me on RT since
I can't schedule workqueues in !preemptible context.

I've been staring at the original issue. The original commit that
properly introduced RCU-sched [0] reads like "it could have been normal
RCU but this one is faster in my micro bench so let's go for it".
Probably because the normal RCU invokes the callbacks once in a while.

So we could switch it to "normal" RCU instead. Anyone thinks that it
could be done? percpu_ref_get()/put() is a hot-path, I am not sure how
much worse it gets in a real benchmark.

In the meantime I prepared a patch which reverts the swait conversation
and invokes the callback swork_queue() which in turn moves the
wake_up_all() into a different process. Since it triggers rare, it
should not have performance regressions. And the wake_up_all() is
preemptible and RT is happy.

[0] a4244454df12 ("percpu-refcount: use RCU-sched insted of normal RCU")

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -381,7 +381,7 @@ void blk_clear_preempt_only(struct reque
 
 	spin_lock_irqsave(q->queue_lock, flags);
 	queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
-	swake_up_all(&q->mq_freeze_wq);
+	wake_up_all(&q->mq_freeze_wq);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
@@ -659,7 +659,7 @@ void blk_set_queue_dying(struct request_
 	}
 
 	/* Make blk_queue_enter() reexamine the DYING flag. */
-	swake_up_all(&q->mq_freeze_wq);
+	wake_up_all(&q->mq_freeze_wq);
 }
 EXPORT_SYMBOL_GPL(blk_set_queue_dying);
 
@@ -860,7 +860,7 @@ int blk_queue_enter(struct request_queue
 		 */
 		smp_rmb();
 
-		ret = swait_event_interruptible(q->mq_freeze_wq,
+		ret = wait_event_interruptible(q->mq_freeze_wq,
 				(atomic_read(&q->mq_freeze_depth) == 0 &&
 				 (preempt || !blk_queue_preempt_only(q))) ||
 				blk_queue_dying(q));
@@ -876,12 +876,20 @@ void blk_queue_exit(struct request_queue
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
+	swork_queue(&q->mq_pcpu_wake);
 }
 
 static void blk_rq_timed_out_timer(struct timer_list *t)
@@ -957,7 +965,8 @@ struct request_queue *blk_alloc_queue_no
 	q->bypass_depth = 1;
 	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 
-	init_swait_queue_head(&q->mq_freeze_wq);
+	init_waitqueue_head(&q->mq_freeze_wq);
+	INIT_SWORK(&q->mq_pcpu_wake, blk_queue_usage_counter_release_swork);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
@@ -3843,6 +3852,7 @@ int __init blk_dev_init(void)
 
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
+	BUG_ON(swork_get());
 
 #ifdef CONFIG_DEBUG_FS
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -133,14 +133,14 @@ EXPORT_SYMBOL_GPL(blk_freeze_queue_start
 
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
@@ -183,7 +183,7 @@ void blk_mq_unfreeze_queue(struct reques
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
 		percpu_ref_reinit(&q->q_usage_counter);
-		swake_up_all(&q->mq_freeze_wq);
+		wake_up_all(&q->mq_freeze_wq);
 	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -29,6 +29,7 @@
 #include <linux/blkzoned.h>
 #include <linux/seqlock.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/swork.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -647,7 +648,8 @@ struct request_queue {
 	struct throtl_data *td;
 #endif
 	struct rcu_head		rcu_head;
-	struct swait_queue_head	mq_freeze_wq;
+	wait_queue_head_t	mq_freeze_wq;
+	struct swork_event	mq_pcpu_wake;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
