Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDWCUR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:20:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753613AbeDWCUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:20:14 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 3/3] rcu: exp: Protect all sync_rcu_preempt_exp_done() with rcu_node lock
Date: Sun, 22 Apr 2018 19:21:19 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423022047.GA20189@linux.vnet.ibm.com>
References: <20180423022047.GA20189@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0036-0000-0000-000002E8AE30
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021884; UDB=6.00521534; IPR=6.00801119;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:20:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0037-0000-0000-00004414F848
Message-Id: <1524450079-20938-3-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

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
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_exp.h | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d7622cb85aa7..755d0f461f26 100644
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
@@ -158,11 +160,31 @@ static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
  */
 static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
 {
+	raw_lockdep_assert_held_rcu_node(rnp);
+
 	return rnp->exp_tasks == NULL &&
 	       READ_ONCE(rnp->expmask) == 0;
 }
 
 /*
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
+/*
  * Report the exit from RCU read-side critical section for the last task
  * that queued itself during or before the current expedited preemptible-RCU
  * grace period.  This event is reported either to the rcu_node structure on
@@ -501,9 +523,9 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
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
@@ -536,7 +558,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			rcu_for_each_node_breadth_first(rsp, rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
-				if (sync_rcu_preempt_exp_done(rnp))
+				if (sync_rcu_preempt_exp_done_unlocked(rnp))
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
-- 
2.5.2
