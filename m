Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755439AbeCHIpA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:45:00 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55203 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755260AbeCHIo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:44:57 -0500
X-Google-Smtp-Source: AG47ELt2ct2zxJuBaMpqJs/DMqlmwD9lERJFQ1lFKq07mLofBuwVg8kAfd0YFGuR14DbUN55Bndd7Q==
X-ME-Sender: <xms:BvigWioI0fePOZ11hCCAqi2ngZ3x4_FfCL1Ehy3oMfysK-BKFm1efg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v2] rcu: exp: Protect all sync_rcu_preempt_exp_done() with rcu_node lock
Date: Thu,  8 Mar 2018 16:48:27 +0800
Message-Id: <20180308084831.29674-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently some callsites of sync_rcu_preempt_exp_done() are not called
with the corresponding rcu_node's ->lock held, which could introduces
bugs as per Paul:

o	CPU 0 in sync_rcu_preempt_exp_done() reads ->exp_tasks and
	sees that it is NULL.

o	CPU 1 blocks within an RCU read-side critical section, so
	it enqueues the task and points ->exp_tasks at it and
	clears CPU 1's bit in ->expmask.

o	All other CPUs clear their bits in ->expmask.

o	CPU 0 reads ->expmask, sees that it is zero, so incorrectly
	concludes that all quiescent states have completed, despite
	the fact that ->exp_tasks is non-NULL.

To fix this, sync_rcu_preempt_exp_unlocked() is introduced to replace
lockless callsites of sync_rcu_preempt_exp_done().

Further, a lockdep annotation is added into sync_rcu_preempt_exp_done()
to prevent mis-use in the future.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1 --> v2:
	Kill unnecessary blank lines


 kernel/rcu/tree_exp.h | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2fd882b08b7c..3f30cc3b7669 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -20,6 +20,8 @@
  * Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
  */
 
+#include <linux/lockdep.h>
+
 /*
  * Record the start of an expedited grace period.
  */
@@ -158,10 +160,30 @@ static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
  */
 static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
 {
+	lockdep_assert_held(&rnp->lock);
+
 	return rnp->exp_tasks == NULL &&
 	       READ_ONCE(rnp->expmask) == 0;
 }
 
+/*
+ * Like sync_rcu_preempt_exp_done(), but this function assumes the caller
+ * doesn't hold the rcu_node's ->lock, and will acquire and release the lock
+ * itself
+ */
+static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
+{
+	unsigned long flags;
+	bool ret;
+
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	ret = sync_rcu_preempt_exp_done(rnp);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
+	return ret;
+}
+
+
 /*
  * Report the exit from RCU read-side critical section for the last task
  * that queued itself during or before the current expedited preemptible-RCU
@@ -498,9 +520,9 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 	for (;;) {
 		ret = swait_event_timeout(
 				rsp->expedited_wq,
-				sync_rcu_preempt_exp_done(rnp_root),
+				sync_rcu_preempt_exp_done_unlocked(rnp_root),
 				jiffies_stall);
-		if (ret > 0 || sync_rcu_preempt_exp_done(rnp_root))
+		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
 			return;
 		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
 		if (rcu_cpu_stall_suppress)
@@ -533,7 +555,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			rcu_for_each_node_breadth_first(rsp, rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
-				if (sync_rcu_preempt_exp_done(rnp))
+				if (sync_rcu_preempt_exp_done_unlocked(rnp))
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
-- 
2.16.2
