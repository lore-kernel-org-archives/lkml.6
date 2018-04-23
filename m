Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbeDWDFj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:05:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753962AbeDWDCj (ORCPT
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
Subject: [PATCH tip/core/rcu 14/21] rcu: Inline rcu_start_gp_advanced() into rcu_start_future_gp()
Date: Sun, 22 Apr 2018 20:03:37 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0052-0000-0000-000002E0B3AF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801134;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0053-0000-0000-00005C6D8F3C
Message-Id: <1524452624-27589-14-git-send-email-paulmck@linux.vnet.ibm.com>
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

The rcu_start_gp_advanced() is invoked only from rcu_start_future_gp() and
much of its code is redundant when invoked from that context.  This commit
therefore inlines rcu_start_gp_advanced() into rcu_start_future_gp(),
then removes rcu_start_gp_advanced().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 56 ++++++++++++-------------------------------------------
 1 file changed, 12 insertions(+), 44 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 25dbbc753fef..4433f68a1c7b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -524,8 +524,6 @@ module_param(rcu_kick_kthreads, bool, 0644);
 static ulong jiffies_till_sched_qs = HZ / 10;
 module_param(jiffies_till_sched_qs, ulong, 0444);
 
-static bool rcu_start_gp_advanced(struct rcu_state *rsp, struct rcu_node *rnp,
-				  struct rcu_data *rdp);
 static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp));
 static void force_quiescent_state(struct rcu_state *rsp);
 static int rcu_pending(void);
@@ -1679,7 +1677,8 @@ static void trace_rcu_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  * rcu_node structure's ->need_future_gp field.  Returns true if there
  * is reason to awaken the grace-period kthread.
  *
- * The caller must hold the specified rcu_node structure's ->lock.
+ * The caller must hold the specified rcu_node structure's ->lock, which
+ * is why the caller is responsible for waking the grace-period kthread.
  */
 static bool __maybe_unused
 rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
@@ -1687,7 +1686,8 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 {
 	unsigned long c;
 	bool ret = false;
-	struct rcu_node *rnp_root = rcu_get_root(rdp->rsp);
+	struct rcu_state *rsp = rdp->rsp;
+	struct rcu_node *rnp_root = rcu_get_root(rsp);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1695,7 +1695,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * Pick up grace-period number for new callbacks.  If this
 	 * grace period is already marked as needed, return to the caller.
 	 */
-	c = rcu_cbs_completed(rdp->rsp, rnp);
+	c = rcu_cbs_completed(rsp, rnp);
 	trace_rcu_future_gp(rnp, rdp, c, TPS("Startleaf"));
 	if (need_future_gp_element(rnp, c)) {
 		trace_rcu_future_gp(rnp, rdp, c, TPS("Prestartleaf"));
@@ -1727,7 +1727,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * period in progress, it will be smaller than the one we obtained
 	 * earlier.  Adjust callbacks as needed.
 	 */
-	c = rcu_cbs_completed(rdp->rsp, rnp_root);
+	c = rcu_cbs_completed(rsp, rnp_root);
 	if (!rcu_is_nocb_cpu(rdp->cpu))
 		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
 
@@ -1748,7 +1748,12 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 		trace_rcu_future_gp(rnp, rdp, c, TPS("Startedleafroot"));
 	} else {
 		trace_rcu_future_gp(rnp, rdp, c, TPS("Startedroot"));
-		ret = rcu_start_gp_advanced(rdp->rsp, rnp_root, rdp);
+		if (!rsp->gp_kthread)
+			goto unlock_out; /* No grace-period kthread yet! */
+		WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
+		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum),
+				       TPS("newreq"));
+		ret = true;  /* Caller must wake GP kthread. */
 	}
 unlock_out:
 	if (rnp != rnp_root)
@@ -2299,43 +2304,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
 }
 
 /*
- * Start a new RCU grace period if warranted, re-initializing the hierarchy
- * in preparation for detecting the next grace period.  The caller must hold
- * the root node's ->lock and hard irqs must be disabled.
- *
- * Note that it is legal for a dying CPU (which is marked as offline) to
- * invoke this function.  This can happen when the dying CPU reports its
- * quiescent state.
- *
- * Returns true if the grace-period kthread must be awakened.
- */
-static bool
-rcu_start_gp_advanced(struct rcu_state *rsp, struct rcu_node *rnp,
-		      struct rcu_data *rdp)
-{
-	raw_lockdep_assert_held_rcu_node(rnp);
-	if (!rsp->gp_kthread || !cpu_needs_another_gp(rsp, rdp)) {
-		/*
-		 * Either we have not yet spawned the grace-period
-		 * task, this CPU does not need another grace period,
-		 * or a grace period is already in progress.
-		 * Either way, don't start a new grace period.
-		 */
-		return false;
-	}
-	WRITE_ONCE(rsp->gp_flags, RCU_GP_FLAG_INIT);
-	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum),
-			       TPS("newreq"));
-
-	/*
-	 * We can't do wakeups while holding the rnp->lock, as that
-	 * could cause possible deadlocks with the rq->lock. Defer
-	 * the wakeup to our caller.
-	 */
-	return true;
-}
-
-/*
  * Report a full set of quiescent states to the specified rcu_state data
  * structure.  Invoke rcu_gp_kthread_wake() to awaken the grace-period
  * kthread if another grace period is required.  Whether we wake
-- 
2.5.2
