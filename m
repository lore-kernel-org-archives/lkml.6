Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbeCMSkt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:40:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49791 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeCMSkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:40:45 -0400
Date: Tue, 13 Mar 2018 19:40:39 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [RT PATCH 1/2] Revert "block: blk-mq: Use swait"
Message-ID: <20180313184039.begptzircgb5ketk@linutronix.de>
References: <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
 <20180309202550.j66qphz3txupt55u@linutronix.de>
 <20180309222643.GC5926@hirez.programming.kicks-ass.net>
 <20180312105113.p7jifhwdwbhpvxds@linutronix.de>
 <20180312132729.GI4064@hirez.programming.kicks-ass.net>
 <20180312141107.roveviectc6a75s7@linutronix.de>
 <20180312142933.GF4043@hirez.programming.kicks-ass.net>
 <20180312195118.rye5lg2pb26kmavn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312195118.rye5lg2pb26kmavn@linutronix.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit "block: blk-mq: Use swait". The issue remains but
will be fixed differently.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-core.c       | 6 +++---
 block/blk-mq.c         | 8 ++++----
 include/linux/blkdev.h | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ff1258ca236c..f9ac6f169c67 100644
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
@@ -819,7 +819,7 @@ static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
-	swake_up_all(&q->mq_freeze_wq);
+	wake_up_all(&q->mq_freeze_wq);
 }
 
 static void blk_rq_timed_out_timer(unsigned long data)
@@ -895,7 +895,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	q->bypass_depth = 1;
 	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 
-	init_swait_queue_head(&q->mq_freeze_wq);
+	init_waitqueue_head(&q->mq_freeze_wq);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
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
index 6f278f1fd634..b68752bfb645 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -598,7 +598,7 @@ struct request_queue {
 	struct throtl_data *td;
 #endif
 	struct rcu_head		rcu_head;
-	struct swait_queue_head	mq_freeze_wq;
+	wait_queue_head_t	mq_freeze_wq;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
-- 
2.16.2
