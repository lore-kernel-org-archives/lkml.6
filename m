Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeDWCd3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:33:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753957AbeDWCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:23 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 21/22] EXP rcu: Add checks for setting ->gp_flags
Date: Sun, 22 Apr 2018 19:32:26 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0040-0000-0000-000004207260
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0041-0000-0000-000008267BD6
Message-Id: <1524450747-22778-21-git-send-email-paulmck@linux.vnet.ibm.com>
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

The ->gp_flags pointer must not be set unless the current rcu_node structure
is waiting on at least one quiescent state.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 2 ++
 kernel/rcu/tree.h        | 1 +
 kernel/rcu/tree_plugin.h | 6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3bfd1519d378..d275c49aa0e8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2419,6 +2419,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			return;
 		}
+		rnp->completedqs = rnp->gpnum;
 		mask = rnp->grpmask;
 		if (rnp->parent == NULL) {
 
@@ -4035,6 +4036,7 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 						   &rcu_fqs_class[i], fqs[i]);
 			rnp->gpnum = rsp->gpnum;
 			rnp->completed = rsp->completed;
+			rnp->completedqs = rsp->completed;
 			rnp->qsmask = 0;
 			rnp->qsmaskinit = 0;
 			rnp->grplo = j * cpustride;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 23ae7c00d3c5..f03da0b091fb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -79,6 +79,7 @@ struct rcu_node {
 	unsigned long completed; /* Last GP completed for this node. */
 				/*  This will either be equal to or one */
 				/*  behind the root rcu_node's gpnum. */
+	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
 				/*  order for current grace period to proceed.*/
 				/*  In leaf rcu_node, each bit corresponds to */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 429f9358d0b6..8014a09a5c9b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -260,8 +260,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * ->exp_tasks pointers, respectively, to reference the newly
 	 * blocked tasks.
 	 */
-	if (!rnp->gp_tasks && (blkd_state & RCU_GP_BLKD))
+	if (!rnp->gp_tasks && (blkd_state & RCU_GP_BLKD)) {
 		rnp->gp_tasks = &t->rcu_node_entry;
+		WARN_ON_ONCE(rnp->completedqs == rnp->gpnum);
+	}
 	if (!rnp->exp_tasks && (blkd_state & RCU_EXP_BLKD))
 		rnp->exp_tasks = &t->rcu_node_entry;
 	WARN_ON_ONCE(!(blkd_state & RCU_GP_BLKD) !=
@@ -535,6 +537,8 @@ void rcu_read_unlock_special(struct task_struct *t)
 		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
 		WARN_ON_ONCE(!rcu_is_leaf_node(rnp));
 		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp);
+		WARN_ON_ONCE(rnp->completedqs == rnp->gpnum &&
+			     (!empty_norm || rnp->qsmask));
 		empty_exp = sync_rcu_preempt_exp_done(rnp);
 		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
 		np = rcu_next_node_entry(t, rnp);
-- 
2.5.2
