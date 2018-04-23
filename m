Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754241AbeDWDFr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:05:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753959AbeDWDCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:39 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/21] rcu: Make rcu_gp_cleanup() more accurately predict need for new GP
Date: Sun, 22 Apr 2018 20:03:28 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0040-0000-0000-000004207438
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801134;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0041-0000-0000-000008267DAD
Message-Id: <1524452624-27589-5-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_gp_cleanup() scans the rcu_node tree in order to reset
state to reflect the end of the grace period.  It also checks to see
whether a new grace period is needed, but in a number of cases, rather
than directly cause the new grace period to be immediately started, it
instead leaves the grace-period-needed state where various fail-safes
can find it.  This works fine, but results in higher contention on the
root rcu_node structure's ->lock, which is undesirable, and contention
on that lock has recently become noticeable.

This commit therefore makes rcu_gp_cleanup() immediately start a new
grace period if there is any need for one.

It is quite possible that it will later be necessary to throttle the
grace-period rate, but that can be dealt with when and if.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 16 ++++++++++------
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_plugin.h | 17 -----------------
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 497f139056c7..afc5e32f0da4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1763,14 +1763,14 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  * Clean up any old requests for the just-ended grace period.  Also return
  * whether any additional grace periods have been requested.
  */
-static int rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
+static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 {
 	int c = rnp->completed;
-	int needmore;
+	bool needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
 	need_future_gp_element(rnp, c) = 0;
-	needmore = need_future_gp_element(rnp, c + 1);
+	needmore = need_any_future_gp(rnp);
 	trace_rcu_future_gp(rnp, rdp, c,
 			    needmore ? TPS("CleanupMore") : TPS("Cleanup"));
 	return needmore;
@@ -2113,7 +2113,6 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 {
 	unsigned long gp_duration;
 	bool needgp = false;
-	int nocb = 0;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root(rsp);
 	struct swait_queue_head *sq;
@@ -2152,7 +2151,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		if (rnp == rdp->mynode)
 			needgp = __note_gp_changes(rsp, rnp, rdp) || needgp;
 		/* smp_mb() provided by prior unlock-lock pair. */
-		nocb += rcu_future_gp_cleanup(rsp, rnp);
+		needgp = rcu_future_gp_cleanup(rsp, rnp) || needgp;
 		sq = rcu_nocb_gp_get(rnp);
 		raw_spin_unlock_irq_rcu_node(rnp);
 		rcu_nocb_gp_cleanup(sq);
@@ -2162,13 +2161,18 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	}
 	rnp = rcu_get_root(rsp);
 	raw_spin_lock_irq_rcu_node(rnp); /* Order GP before ->completed update. */
-	rcu_nocb_gp_set(rnp, nocb);
 
 	/* Declare grace period done. */
 	WRITE_ONCE(rsp->completed, rsp->gpnum);
 	trace_rcu_grace_period(rsp->name, rsp->completed, TPS("end"));
 	rsp->gp_state = RCU_GP_IDLE;
+	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(rsp->rda);
+	if (need_any_future_gp(rnp)) {
+		trace_rcu_future_gp(rnp, rdp, rsp->completed - 1,
+				    TPS("CleanupMore"));
+		needgp = true;
+	}
 	/* Advance CBs to reduce false positives below. */
 	needgp = rcu_advance_cbs(rsp, rnp, rdp) || needgp;
 	if (needgp || cpu_needs_another_gp(rsp, rdp)) {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 18b091474ffa..bd1103763551 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -469,7 +469,6 @@ static void print_cpu_stall_info_end(void);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static void increment_cpu_stall_ticks(void);
 static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu);
-static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 640ea927d8a4..313b77d9cf06 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1780,19 +1780,6 @@ static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 	swake_up_all(sq);
 }
 
-/*
- * Set the root rcu_node structure's ->need_future_gp field
- * based on the sum of those of all rcu_node structures.  This does
- * double-count the root rcu_node structure's requests, but this
- * is necessary to handle the possibility of a rcu_nocb_kthread()
- * having awakened during the time that the rcu_node structures
- * were being updated for the end of the previous grace period.
- */
-static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
-{
-	need_future_gp_element(rnp, rnp->completed + 1) += nrq;
-}
-
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
 {
 	return &rnp->nocb_gp_wq[rnp->completed & 0x1];
@@ -2495,10 +2482,6 @@ static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
 }
 
-static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
-{
-}
-
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
 {
 	return NULL;
-- 
2.5.2
