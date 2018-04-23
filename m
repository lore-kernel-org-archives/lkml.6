Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754073AbeDWDCy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:02:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753990AbeDWDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:41 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 15/21] rcu: Make rcu_start_future_gp() caller select grace period
Date: Sun, 22 Apr 2018 20:03:38 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0048-0000-0000-000002618C6C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0049-0000-0000-000044DF84C7
Message-Id: <1524452624-27589-15-git-send-email-paulmck@linux.vnet.ibm.com>
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

The rcu_accelerate_cbs() function selects a grace-period target, which
it uses to have rcu_segcblist_accelerate() assign numbers to recently
queued callbacks.  Then it invokes rcu_start_future_gp(), which selects
a grace-period target again, which is a bit pointless.  This commit
therefore changes rcu_start_future_gp() to take the grace-period target as
a parameter, thus avoiding double selection.  This commit also changes
the name of rcu_start_future_gp() to rcu_start_this_gp() to reflect
this change in functionality, and also makes a similar change to the
name of trace_rcu_future_gp().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 53 ++++++++++++++++++++----------------------------
 kernel/rcu/tree_plugin.h |  9 ++++----
 2 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4433f68a1c7b..94519c7d552f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1659,12 +1659,9 @@ static unsigned long rcu_cbs_completed(struct rcu_state *rsp,
 	return rnp->completed + 2;
 }
 
-/*
- * Trace-event helper function for rcu_start_future_gp() and
- * rcu_nocb_wait_gp().
- */
-static void trace_rcu_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-				unsigned long c, const char *s)
+/* Trace-event wrapper function for trace_rcu_future_grace_period.  */
+static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
+			      unsigned long c, const char *s)
 {
 	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gpnum,
 				      rnp->completed, c, rnp->level,
@@ -1672,33 +1669,27 @@ static void trace_rcu_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 }
 
 /*
- * Start some future grace period, as needed to handle newly arrived
+ * Start the specified grace period, as needed to handle newly arrived
  * callbacks.  The required future grace periods are recorded in each
- * rcu_node structure's ->need_future_gp field.  Returns true if there
+ * rcu_node structure's ->need_future_gp[] field.  Returns true if there
  * is reason to awaken the grace-period kthread.
  *
  * The caller must hold the specified rcu_node structure's ->lock, which
  * is why the caller is responsible for waking the grace-period kthread.
  */
-static bool __maybe_unused
-rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-		    unsigned long *c_out)
+static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
+			      unsigned long c)
 {
-	unsigned long c;
 	bool ret = false;
 	struct rcu_state *rsp = rdp->rsp;
 	struct rcu_node *rnp_root = rcu_get_root(rsp);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
-	/*
-	 * Pick up grace-period number for new callbacks.  If this
-	 * grace period is already marked as needed, return to the caller.
-	 */
-	c = rcu_cbs_completed(rsp, rnp);
-	trace_rcu_future_gp(rnp, rdp, c, TPS("Startleaf"));
+	/* If the specified GP is already known needed, return to caller. */
+	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
 	if (need_future_gp_element(rnp, c)) {
-		trace_rcu_future_gp(rnp, rdp, c, TPS("Prestartleaf"));
+		trace_rcu_this_gp(rnp, rdp, c, TPS("Prestartleaf"));
 		goto out;
 	}
 
@@ -1710,7 +1701,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 */
 	if (rnp->gpnum != rnp->completed) {
 		need_future_gp_element(rnp, c) = true;
-		trace_rcu_future_gp(rnp, rdp, c, TPS("Startedleaf"));
+		trace_rcu_this_gp(rnp, rdp, c, TPS("Startedleaf"));
 		goto out;
 	}
 
@@ -1736,7 +1727,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * recorded, trace and leave.
 	 */
 	if (need_future_gp_element(rnp_root, c)) {
-		trace_rcu_future_gp(rnp, rdp, c, TPS("Prestartedroot"));
+		trace_rcu_this_gp(rnp, rdp, c, TPS("Prestartedroot"));
 		goto unlock_out;
 	}
 
@@ -1745,9 +1736,9 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 
 	/* If a grace period is not already in progress, start one. */
 	if (rnp_root->gpnum != rnp_root->completed) {
-		trace_rcu_future_gp(rnp, rdp, c, TPS("Startedleafroot"));
+		trace_rcu_this_gp(rnp, rdp, c, TPS("Startedleafroot"));
 	} else {
-		trace_rcu_future_gp(rnp, rdp, c, TPS("Startedroot"));
+		trace_rcu_this_gp(rnp, rdp, c, TPS("Startedroot"));
 		if (!rsp->gp_kthread)
 			goto unlock_out; /* No grace-period kthread yet! */
 		WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
@@ -1759,8 +1750,6 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	if (rnp != rnp_root)
 		raw_spin_unlock_rcu_node(rnp_root);
 out:
-	if (c_out != NULL)
-		*c_out = c;
 	return ret;
 }
 
@@ -1776,8 +1765,8 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 
 	need_future_gp_element(rnp, c) = false;
 	needmore = need_any_future_gp(rnp);
-	trace_rcu_future_gp(rnp, rdp, c,
-			    needmore ? TPS("CleanupMore") : TPS("Cleanup"));
+	trace_rcu_this_gp(rnp, rdp, c,
+			  needmore ? TPS("CleanupMore") : TPS("Cleanup"));
 	return needmore;
 }
 
@@ -1812,6 +1801,7 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 			       struct rcu_data *rdp)
 {
+	unsigned long c;
 	bool ret = false;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
@@ -1830,8 +1820,9 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	if (rcu_segcblist_accelerate(&rdp->cblist, rcu_cbs_completed(rsp, rnp)))
-		ret = rcu_start_future_gp(rnp, rdp, NULL);
+	c = rcu_cbs_completed(rsp, rnp);
+	if (rcu_segcblist_accelerate(&rdp->cblist, c))
+		ret = rcu_start_this_gp(rnp, rdp, c);
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
@@ -2174,8 +2165,8 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(rsp->rda);
 	if (need_any_future_gp(rnp)) {
-		trace_rcu_future_gp(rnp, rdp, rsp->completed - 1,
-				    TPS("CleanupMore"));
+		trace_rcu_this_gp(rnp, rdp, rsp->completed - 1,
+				  TPS("CleanupMore"));
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 313b77d9cf06..322777492fff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2035,7 +2035,8 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 	struct rcu_node *rnp = rdp->mynode;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	needwake = rcu_start_future_gp(rnp, rdp, &c);
+	c = rcu_cbs_completed(rdp->rsp, rnp);
+	needwake = rcu_start_this_gp(rnp, rdp, c);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
 		rcu_gp_kthread_wake(rdp->rsp);
@@ -2044,7 +2045,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 	 * Wait for the grace period.  Do so interruptibly to avoid messing
 	 * up the load average.
 	 */
-	trace_rcu_future_gp(rnp, rdp, c, TPS("StartWait"));
+	trace_rcu_this_gp(rnp, rdp, c, TPS("StartWait"));
 	for (;;) {
 		swait_event_interruptible(
 			rnp->nocb_gp_wq[c & 0x1],
@@ -2052,9 +2053,9 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 		if (likely(d))
 			break;
 		WARN_ON(signal_pending(current));
-		trace_rcu_future_gp(rnp, rdp, c, TPS("ResumeWait"));
+		trace_rcu_this_gp(rnp, rdp, c, TPS("ResumeWait"));
 	}
-	trace_rcu_future_gp(rnp, rdp, c, TPS("EndWait"));
+	trace_rcu_this_gp(rnp, rdp, c, TPS("EndWait"));
 	smp_mb(); /* Ensure that CB invocation happens after GP end. */
 }
 
-- 
2.5.2
