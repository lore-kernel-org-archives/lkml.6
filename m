Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBZVyd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751849AbeBZVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:53 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 19/20] rcu: Make expedited RCU CPU selection avoid unnecessary stores
Date: Mon, 26 Feb 2018 13:53:09 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0024-0000-0000-0000032CF4E4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0025-0000-0000-000047283C15
Message-Id: <1519681990-31349-19-git-send-email-paulmck@linux.vnet.ibm.com>
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

This commit reworks the first loop in sync_rcu_exp_select_cpus()
to avoid doing unnecssary stores to other CPUs' rcu_data
structures.  This speeds up that first loop by roughly a factor of
two on an old x86 system.  In the case where the system is mostly
idle, this loop incurs a large fraction of the overhead of the
synchronize_rcu_expedited().  There is less benefit on busy systems
because the overhead of the smp_call_function_single() in the second
loop dominates in that case.

However, it is not unusual to do configuration chances involving
RCU grace periods (both expedited and normal) while the system is
mostly idle, so this optimization is worth doing.

While we are in the area, this commit also adds parentheses to arguments
used by the for_each_leaf_node_possible_cpu() macro.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h      | 16 +++++++++++++---
 kernel/rcu/tree_exp.h | 21 ++++++++++++++-------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 507a0802c717..1c868bcfd705 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -301,9 +301,19 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
  * Iterate over all possible CPUs in a leaf RCU node.
  */
 #define for_each_leaf_node_possible_cpu(rnp, cpu) \
-	for ((cpu) = cpumask_next(rnp->grplo - 1, cpu_possible_mask); \
-	     cpu <= rnp->grphi; \
-	     cpu = cpumask_next((cpu), cpu_possible_mask))
+	for ((cpu) = cpumask_next((rnp)->grplo - 1, cpu_possible_mask); \
+	     (cpu) <= rnp->grphi; \
+	     (cpu) = cpumask_next((cpu), cpu_possible_mask))
+
+/*
+ * Iterate over all CPUs in a leaf RCU node's specified mask.
+ */
+#define rcu_find_next_bit(rnp, cpu, mask) \
+	((rnp)->grplo + find_next_bit(&(mask), BITS_PER_LONG, (cpu)))
+#define for_each_leaf_node_cpu_mask(rnp, cpu, mask) \
+	for ((cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
+	     (cpu) <= rnp->grphi; \
+	     (cpu) = rcu_find_next_bit((rnp), (cpu) + 1 - (rnp->grplo), (mask)))
 
 /*
  * Wrappers for the rcu_node::lock acquire and release.
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fecb6b6ab452..6ad87642f44a 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -383,15 +383,22 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 
 		/* Each pass checks a CPU for identity, offline, and idle. */
 		mask_ofl_test = 0;
-		for_each_leaf_node_possible_cpu(rnp, cpu) {
+		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
+			unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 			struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+			struct rcu_dynticks *rdtp = per_cpu_ptr(&rcu_dynticks, cpu);
+			int snap;
 
-			rdp->exp_dynticks_snap =
-				rcu_dynticks_snap(rdp->dynticks);
 			if (raw_smp_processor_id() == cpu ||
-			    rcu_dynticks_in_eqs(rdp->exp_dynticks_snap) ||
-			    !(rnp->qsmaskinitnext & rdp->grpmask))
-				mask_ofl_test |= rdp->grpmask;
+			    !(rnp->qsmaskinitnext & mask)) {
+				mask_ofl_test |= mask;
+			} else {
+				snap = rcu_dynticks_snap(rdtp);
+				if (rcu_dynticks_in_eqs(snap))
+					mask_ofl_test |= mask;
+				else
+					rdp->exp_dynticks_snap = snap;
+			}
 		}
 		mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
 
@@ -405,7 +412,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 		/* IPI the remaining CPUs for expedited quiescent state. */
-		for_each_leaf_node_possible_cpu(rnp, cpu) {
+		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
 			unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 			struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
 
-- 
2.5.2
