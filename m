Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeDWCfb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:35:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753945AbeDWCbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:22 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 14/22] rcu: Add leaf-node macros
Date: Sun, 22 Apr 2018 19:32:19 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0056-0000-0000-0000044375FA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0057-0000-0000-000008877F33
Message-Id: <1524450747-22778-14-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds rcu_first_leaf_node() that returns a pointer to
the first leaf rcu_node structure in the specified RCU flavor and an
rcu_is_leaf_node() that returns true iff the specified rcu_node structure
is a leaf.  This commit also uses these macros where appropriate.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h         | 11 ++++++++---
 kernel/rcu/tree.c        |  4 ++--
 kernel/rcu/tree_plugin.h |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 7a693e31184a..5b5bb9ee2e20 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -270,6 +270,12 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 	}
 }
 
+/* Returns first leaf rcu_node of the specified RCU flavor. */
+#define rcu_first_leaf_node(rsp) ((rsp)->level[rcu_num_lvls - 1])
+
+/* Is this rcu_node a leaf? */
+#define rcu_is_leaf_node(rnp) ((rnp)->level == rcu_num_lvls - 1)
+
 /*
  * Do a full breadth-first scan of the rcu_node structures for the
  * specified rcu_state structure.
@@ -284,8 +290,7 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
  * rcu_node tree with but one rcu_node structure, this loop is a no-op.
  */
 #define rcu_for_each_nonleaf_node_breadth_first(rsp, rnp) \
-	for ((rnp) = &(rsp)->node[0]; \
-	     (rnp) < (rsp)->level[rcu_num_lvls - 1]; (rnp)++)
+	for ((rnp) = &(rsp)->node[0]; !rcu_is_leaf_node(rsp, rnp); (rnp)++)
 
 /*
  * Scan the leaves of the rcu_node hierarchy for the specified rcu_state
@@ -294,7 +299,7 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
  * It is still a leaf node, even if it is also the root node.
  */
 #define rcu_for_each_leaf_node(rsp, rnp) \
-	for ((rnp) = (rsp)->level[rcu_num_lvls - 1]; \
+	for ((rnp) = rcu_first_leaf_node(rsp); \
 	     (rnp) < &(rsp)->node[rcu_num_nodes]; (rnp)++)
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 19d9475d74f2..08b72dd02d88 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2405,7 +2405,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 			return;
 		}
 		WARN_ON_ONCE(oldmask); /* Any child must be all zeroed! */
-		WARN_ON_ONCE(rnp->level != rcu_num_lvls - 1 &&
+		WARN_ON_ONCE(!rcu_is_leaf_node(rnp) &&
 			     rcu_preempt_blocked_readers_cgp(rnp));
 		rnp->qsmask &= ~mask;
 		trace_rcu_quiescent_state_report(rsp->name, rnp->gpnum,
@@ -4063,7 +4063,7 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 
 	init_swait_queue_head(&rsp->gp_wq);
 	init_swait_queue_head(&rsp->expedited_wq);
-	rnp = rsp->level[rcu_num_lvls - 1];
+	rnp = rcu_first_leaf_node(rsp);
 	for_each_possible_cpu(i) {
 		while (i > rnp->grphi)
 			rnp++;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d37b9bb3f481..b999032e9466 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -182,7 +182,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 	WARN_ON_ONCE(rdp->mynode != rnp);
-	WARN_ON_ONCE(rnp->level != rcu_num_lvls - 1);
+	WARN_ON_ONCE(!rcu_is_leaf_node(rnp));
 
 	/*
 	 * Decide where to queue the newly blocked task.  In theory,
@@ -533,7 +533,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 		rnp = t->rcu_blocked_node;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
 		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
-		WARN_ON_ONCE(rnp->level != rcu_num_lvls - 1);
+		WARN_ON_ONCE(!rcu_is_leaf_node(rnp));
 		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp);
 		empty_exp = sync_rcu_preempt_exp_done(rnp);
 		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
-- 
2.5.2
