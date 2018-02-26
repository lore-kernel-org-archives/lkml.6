Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeBZVyf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751847AbeBZVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:53 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 14/20] rcu: Use wrapper for lockdep asserts
Date: Mon, 26 Feb 2018 13:53:04 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0040-0000-0000-000003FD5BD9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0041-0000-0000-000007FE65EA
Message-Id: <1519681990-31349-14-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Commits c0b334c5bfa9 and ea9b0c8a26a2 introduced new sparse warnings
by accessing rcu_node->lock directly and ignoring the __private
marker.  Introduce a new wrapper and use it.  Also fix a similar problem
in srcutree.c introduced by a3883df3935e.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h         |  5 ++++-
 kernel/rcu/srcutree.c    |  2 +-
 kernel/rcu/tree.c        | 24 ++++++++++++------------
 kernel/rcu/tree_plugin.h |  4 ++--
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index c90812673d54..5d13f651cf08 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -337,7 +337,7 @@ do {									\
 } while (0)
 
 #define raw_spin_unlock_irqrestore_rcu_node(p, flags)			\
-	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)	\
+	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)
 
 #define raw_spin_trylock_rcu_node(p)					\
 ({									\
@@ -348,6 +348,9 @@ do {									\
 	___locked;							\
 })
 
+#define raw_lockdep_assert_held_rcu_node(p)				\
+	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
+
 #endif /* #if defined(SRCU) || !defined(TINY_RCU) */
 
 #ifdef CONFIG_TINY_RCU
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d5cea81378cc..9c6e0eaab4d5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -439,7 +439,7 @@ static void srcu_gp_start(struct srcu_struct *sp)
 	struct srcu_data *sdp = this_cpu_ptr(sp->sda);
 	int state;
 
-	lockdep_assert_held(&sp->lock);
+	lockdep_assert_held(&ACCESS_PRIVATE(sp, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&sp->srcu_gp_seq));
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4d7c727020f0..99d404c6bbbb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1161,7 +1161,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
  */
 static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 {
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	if (ULONG_CMP_LT(READ_ONCE(rdp->gpnum) + ULONG_MAX / 4, rnp->gpnum))
 		WRITE_ONCE(rdp->gpwrap, true);
 	if (ULONG_CMP_LT(rdp->rcu_iw_gpnum + ULONG_MAX / 4, rnp->gpnum))
@@ -1629,7 +1629,7 @@ void rcu_cpu_stall_reset(void)
 static unsigned long rcu_cbs_completed(struct rcu_state *rsp,
 				       struct rcu_node *rnp)
 {
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 
 	/*
 	 * If RCU is idle, we just wait for the next grace period.
@@ -1676,7 +1676,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	bool ret = false;
 	struct rcu_node *rnp_root = rcu_get_root(rdp->rsp);
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 
 	/*
 	 * Pick up grace-period number for new callbacks.  If this
@@ -1804,7 +1804,7 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 {
 	bool ret = false;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 
 	/* If no pending (not yet ready to invoke) callbacks, nothing to do. */
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
@@ -1844,7 +1844,7 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 static bool rcu_advance_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 			    struct rcu_data *rdp)
 {
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 
 	/* If no pending (not yet ready to invoke) callbacks, nothing to do. */
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
@@ -1872,7 +1872,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 	bool ret;
 	bool need_gp;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 
 	/* Handle the ends of any preceding grace periods first. */
 	if (rdp->completed == rnp->completed &&
@@ -2297,7 +2297,7 @@ static bool
 rcu_start_gp_advanced(struct rcu_state *rsp, struct rcu_node *rnp,
 		      struct rcu_data *rdp)
 {
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	if (!rsp->gp_kthread || !cpu_needs_another_gp(rsp, rdp)) {
 		/*
 		 * Either we have not yet spawned the grace-period
@@ -2359,7 +2359,7 @@ static bool rcu_start_gp(struct rcu_state *rsp)
 static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
 	__releases(rcu_get_root(rsp)->lock)
 {
-	lockdep_assert_held(&rcu_get_root(rsp)->lock);
+	raw_lockdep_assert_held_rcu_node(rcu_get_root(rsp));
 	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
@@ -2384,7 +2384,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 	unsigned long oldmask = 0;
 	struct rcu_node *rnp_c;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 
 	/* Walk up the rcu_node hierarchy. */
 	for (;;) {
@@ -2448,7 +2448,7 @@ static void rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 	unsigned long mask;
 	struct rcu_node *rnp_p;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	if (rcu_state_p == &rcu_sched_state || rsp != rcu_state_p ||
 	    rnp->qsmask != 0 || rcu_preempt_blocked_readers_cgp(rnp)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2593,7 +2593,7 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
 	long mask;
 	struct rcu_node *rnp = rnp_leaf;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
 	    rnp->qsmaskinit || rcu_preempt_has_tasks(rnp))
 		return;
@@ -3596,7 +3596,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
 	long mask;
 	struct rcu_node *rnp = rnp_leaf;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	for (;;) {
 		mask = rnp->grpmask;
 		rnp = rnp->parent;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1c2d58a85511..84fbee4686d3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -180,7 +180,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 			 (rnp->expmask & rdp->grpmask ? RCU_EXP_BLKD : 0);
 	struct task_struct *t = current;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	WARN_ON_ONCE(rdp->mynode != rnp);
 	WARN_ON_ONCE(rnp->level != rcu_num_lvls - 1);
 
@@ -1044,7 +1044,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 {
 	struct task_struct *t;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	if (!rcu_preempt_blocked_readers_cgp(rnp) && rnp->exp_tasks == NULL) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
-- 
2.5.2
