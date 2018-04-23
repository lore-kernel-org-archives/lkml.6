Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbeDWCUU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:20:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753726AbeDWCUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:20:14 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 1/3] rcu: Parallelize expedited grace-period initialization
Date: Sun, 22 Apr 2018 19:21:17 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423022047.GA20189@linux.vnet.ibm.com>
References: <20180423022047.GA20189@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0056-0000-0000-0000044374A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021884; UDB=6.00521534; IPR=6.00801120;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:20:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0057-0000-0000-000008877DD4
Message-Id: <1524450079-20938-1-git-send-email-paulmck@linux.vnet.ibm.com>
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

The latency of RCU expedited grace periods grows with increasing numbers
of CPUs, eventually failing to be all that expedited.  Much of the growth
in latency is in the initialization phase, so this commit uses workqueues
to carry out this initialization concurrently on a rcu_node-by-rcu_node
basis.

This change makes use of a new rcu_par_gp_wq because flushing a work
item from another work item running from the same workqueue can result
in deadlock.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h      |   1 +
 kernel/rcu/tree.c     |   3 +
 kernel/rcu/tree.h     |  10 +++
 kernel/rcu/tree_exp.h | 184 +++++++++++++++++++++++++++++---------------------
 4 files changed, 120 insertions(+), 78 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 7a693e31184a..976019d6fa06 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -486,6 +486,7 @@ void rcu_force_quiescent_state(void);
 void rcu_bh_force_quiescent_state(void);
 void rcu_sched_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
+extern struct workqueue_struct *rcu_par_gp_wq;
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a734692a581..23781fc90830 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4168,6 +4168,7 @@ static void __init rcu_dump_rcu_node_tree(struct rcu_state *rsp)
 }
 
 struct workqueue_struct *rcu_gp_wq;
+struct workqueue_struct *rcu_par_gp_wq;
 
 void __init rcu_init(void)
 {
@@ -4199,6 +4200,8 @@ void __init rcu_init(void)
 	/* Create workqueue for expedited GPs and for Tree SRCU. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
+	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
+	WARN_ON(!rcu_par_gp_wq);
 }
 
 #include "tree_exp.h"
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f491ab4f2e8e..98d33902b65c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -58,6 +58,14 @@ struct rcu_dynticks {
 #endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
 };
 
+/* Communicate arguments to a workqueue handler. */
+struct rcu_exp_work {
+	smp_call_func_t rew_func;
+	struct rcu_state *rew_rsp;
+	unsigned long rew_s;
+	struct work_struct rew_work;
+};
+
 /* RCU's kthread states for tracing. */
 #define RCU_KTHREAD_STOPPED  0
 #define RCU_KTHREAD_RUNNING  1
@@ -157,6 +165,8 @@ struct rcu_node {
 	spinlock_t exp_lock ____cacheline_internodealigned_in_smp;
 	unsigned long exp_seq_rq;
 	wait_queue_head_t exp_wq[4];
+	struct rcu_exp_work rew;
+	bool exp_need_flush;	/* Need to flush workitem? */
 } ____cacheline_internodealigned_in_smp;
 
 /*
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f72eefab8543..73e1d3dca5b1 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -362,93 +362,129 @@ static void sync_sched_exp_online_cleanup(int cpu)
 }
 
 /*
- * Select the nodes that the upcoming expedited grace period needs
- * to wait for.
+ * Select the CPUs within the specified rcu_node that the upcoming
+ * expedited grace period needs to wait for.
  */
-static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
-				     smp_call_func_t func)
+static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 {
 	int cpu;
 	unsigned long flags;
+	smp_call_func_t func;
 	unsigned long mask_ofl_test;
 	unsigned long mask_ofl_ipi;
 	int ret;
-	struct rcu_node *rnp;
+	struct rcu_exp_work *rewp =
+		container_of(wp, struct rcu_exp_work, rew_work);
+	struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
+	struct rcu_state *rsp = rewp->rew_rsp;
 
-	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
-	sync_exp_reset_tree(rsp);
-	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
-	rcu_for_each_leaf_node(rsp, rnp) {
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-
-		/* Each pass checks a CPU for identity, offline, and idle. */
-		mask_ofl_test = 0;
-		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
-			unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
-			struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
-			struct rcu_dynticks *rdtp = per_cpu_ptr(&rcu_dynticks, cpu);
-			int snap;
+	func = rewp->rew_func;
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 
-			if (raw_smp_processor_id() == cpu ||
-			    !(rnp->qsmaskinitnext & mask)) {
+	/* Each pass checks a CPU for identity, offline, and idle. */
+	mask_ofl_test = 0;
+	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
+		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
+		struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+		struct rcu_dynticks *rdtp = per_cpu_ptr(&rcu_dynticks, cpu);
+		int snap;
+
+		if (raw_smp_processor_id() == cpu ||
+		    !(rnp->qsmaskinitnext & mask)) {
+			mask_ofl_test |= mask;
+		} else {
+			snap = rcu_dynticks_snap(rdtp);
+			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
-			} else {
-				snap = rcu_dynticks_snap(rdtp);
-				if (rcu_dynticks_in_eqs(snap))
-					mask_ofl_test |= mask;
-				else
-					rdp->exp_dynticks_snap = snap;
-			}
+			else
+				rdp->exp_dynticks_snap = snap;
 		}
-		mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
-
-		/*
-		 * Need to wait for any blocked tasks as well.  Note that
-		 * additional blocking tasks will also block the expedited
-		 * GP until such time as the ->expmask bits are cleared.
-		 */
-		if (rcu_preempt_has_tasks(rnp))
-			rnp->exp_tasks = rnp->blkd_tasks.next;
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	}
+	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
 
-		/* IPI the remaining CPUs for expedited quiescent state. */
-		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
-			unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
-			struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	/*
+	 * Need to wait for any blocked tasks as well.	Note that
+	 * additional blocking tasks will also block the expedited GP
+	 * until such time as the ->expmask bits are cleared.
+	 */
+	if (rcu_preempt_has_tasks(rnp))
+		rnp->exp_tasks = rnp->blkd_tasks.next;
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
+	/* IPI the remaining CPUs for expedited quiescent state. */
+	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
+		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
+		struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
 
-			if (!(mask_ofl_ipi & mask))
-				continue;
+		if (!(mask_ofl_ipi & mask))
+			continue;
 retry_ipi:
-			if (rcu_dynticks_in_eqs_since(rdp->dynticks,
-						      rdp->exp_dynticks_snap)) {
-				mask_ofl_test |= mask;
-				continue;
-			}
-			ret = smp_call_function_single(cpu, func, rsp, 0);
-			if (!ret) {
-				mask_ofl_ipi &= ~mask;
-				continue;
-			}
-			/* Failed, raced with CPU hotplug operation. */
-			raw_spin_lock_irqsave_rcu_node(rnp, flags);
-			if ((rnp->qsmaskinitnext & mask) &&
-			    (rnp->expmask & mask)) {
-				/* Online, so delay for a bit and try again. */
-				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-				trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("selectofl"));
-				schedule_timeout_uninterruptible(1);
-				goto retry_ipi;
-			}
-			/* CPU really is offline, so we can ignore it. */
-			if (!(rnp->expmask & mask))
-				mask_ofl_ipi &= ~mask;
+		if (rcu_dynticks_in_eqs_since(rdp->dynticks,
+					      rdp->exp_dynticks_snap)) {
+			mask_ofl_test |= mask;
+			continue;
+		}
+		ret = smp_call_function_single(cpu, func, rsp, 0);
+		if (!ret) {
+			mask_ofl_ipi &= ~mask;
+			continue;
+		}
+		/* Failed, raced with CPU hotplug operation. */
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		if ((rnp->qsmaskinitnext & mask) &&
+		    (rnp->expmask & mask)) {
+			/* Online, so delay for a bit and try again. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+			trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("selectofl"));
+			schedule_timeout_uninterruptible(1);
+			goto retry_ipi;
+		}
+		/* CPU really is offline, so we can ignore it. */
+		if (!(rnp->expmask & mask))
+			mask_ofl_ipi &= ~mask;
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	}
+	/* Report quiescent states for those that went offline. */
+	mask_ofl_test |= mask_ofl_ipi;
+	if (mask_ofl_test)
+		rcu_report_exp_cpu_mult(rsp, rnp, mask_ofl_test, false);
+}
+
+/*
+ * Select the nodes that the upcoming expedited grace period needs
+ * to wait for.
+ */
+static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
+				     smp_call_func_t func)
+{
+	struct rcu_node *rnp;
+
+	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
+	sync_exp_reset_tree(rsp);
+	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
+
+	/* Schedule work for each leaf rcu_node structure. */
+	rcu_for_each_leaf_node(rsp, rnp) {
+		rnp->exp_need_flush = false;
+		if (!READ_ONCE(rnp->expmask))
+			continue; /* Avoid early boot non-existent wq. */
+		rnp->rew.rew_func = func;
+		rnp->rew.rew_rsp = rsp;
+		if (!READ_ONCE(rcu_par_gp_wq) ||
+		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
+			/* No workqueues yet. */
+			sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
+			continue;
 		}
-		/* Report quiescent states for those that went offline. */
-		mask_ofl_test |= mask_ofl_ipi;
-		if (mask_ofl_test)
-			rcu_report_exp_cpu_mult(rsp, rnp, mask_ofl_test, false);
+		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
+		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
+		rnp->exp_need_flush = true;
 	}
+
+	/* Wait for workqueue jobs (if any) to complete. */
+	rcu_for_each_leaf_node(rsp, rnp)
+		if (rnp->exp_need_flush)
+			flush_work(&rnp->rew.rew_work);
 }
 
 static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
@@ -560,14 +596,6 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
 	mutex_unlock(&rsp->exp_wake_mutex);
 }
 
-/* Let the workqueue handler know what it is supposed to do. */
-struct rcu_exp_work {
-	smp_call_func_t rew_func;
-	struct rcu_state *rew_rsp;
-	unsigned long rew_s;
-	struct work_struct rew_work;
-};
-
 /*
  * Common code to drive an expedited grace period forward, used by
  * workqueues and mid-boot-time tasks.
-- 
2.5.2
