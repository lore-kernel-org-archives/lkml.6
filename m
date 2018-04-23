Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeDWCcx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:32:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753977AbeDWCbX (ORCPT
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
Subject: [PATCH tip/core/rcu 17/22] EXP: rcu: Abstract addition of debugging information to assertion
Date: Sun, 22 Apr 2018 19:32:22 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0044-0000-0000-0000040972DC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0045-0000-0000-0000083B7BD9
Message-Id: <1524450747-22778-17-git-send-email-paulmck@linux.vnet.ibm.com>
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

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 18 ++----------------
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6ad2ac34558f..3bfd1519d378 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2147,22 +2147,8 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	 */
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
-#ifdef CONFIG_PREEMPT_RCU
-		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp))) {
-			int i;
-			struct task_struct *t;
-
-			pr_info("%s: grp: %d-%d level: %d ->gp_tasks %p ->exp_tasks %p &->blkd_tasks: %p offset: %u\n", __func__, rnp->grplo, rnp->grphi, rnp->level, rnp->gp_tasks, rnp->exp_tasks, &rnp->blkd_tasks, (unsigned int)offsetof(typeof(*rnp), blkd_tasks));
-			pr_cont("\t->blkd_tasks");
-			i = 0;
-			list_for_each_entry(t, &rnp->blkd_tasks, rcu_node_entry) {
-				pr_cont(" %p", t);
-				if (++i >= 10)
-					break;
-			}
-			pr_cont("\n");
-		}
-#endif /* #ifdef CONFIG_PREEMPT_RCU */
+		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
+			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->completed, rsp->gpnum);
 		rdp = this_cpu_ptr(rsp->rda);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 0b3a90ebe225..23ae7c00d3c5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -428,6 +428,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_preempt_check_callbacks(void);
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 static void __init __rcu_init_preempt(void);
+static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static void invoke_rcu_callbacks_kthread(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b999032e9466..a2ae6b49f900 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -841,6 +841,27 @@ void exit_rcu(void)
 	__rcu_read_unlock();
 }
 
+/*
+ * Dump the blocked-tasks state, but limit the list dump to the
+ * specified number of elements.
+ */
+static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
+{
+	int i;
+	struct list_head *lhp;
+
+	lockdep_assert_held(&rnp->lock);
+	pr_info("%s: grp: %d-%d level: %d ->gp_tasks %p ->exp_tasks %p &->blkd_tasks: %p offset: %u\n", __func__, rnp->grplo, rnp->grphi, rnp->level, rnp->gp_tasks, rnp->exp_tasks, &rnp->blkd_tasks, (unsigned int)offsetof(typeof(*rnp), blkd_tasks));
+	pr_cont("\t->blkd_tasks");
+	i = 0;
+	list_for_each(lhp, &rnp->blkd_tasks) {
+		pr_cont(" %p", lhp);
+		if (++i >= 10)
+			break;
+	}
+	pr_cont("\n");
+}
+
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 static struct rcu_state *const rcu_state_p = &rcu_sched_state;
@@ -949,6 +970,14 @@ void exit_rcu(void)
 {
 }
 
+/*
+ * Dump the guaranteed-empty blocked-tasks state.  Trust but verify.
+ */
+static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
+{
+	WARN_ON_ONCE(!list_empty(&rnp->blkd_tasks));
+}
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 #ifdef CONFIG_RCU_BOOST
-- 
2.5.2
