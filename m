Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeDWDFg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:05:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753967AbeDWDCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:40 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 11/21] rcu: Switch __rcu_process_callbacks() to rcu_accelerate_cbs()
Date: Sun, 22 Apr 2018 20:03:34 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0040-0000-0000-00000420743A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801134;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0041-0000-0000-000008267DAE
Message-Id: <1524452624-27589-11-git-send-email-paulmck@linux.vnet.ibm.com>
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

The __rcu_process_callbacks() function currently checks to see if
the current CPU needs a grace period and also if there is any other
reason to kick off a new grace period.  This is one of the fail-safe
checks that has been rendered unnecessary by the changes that increase
the accuracy of rcu_gp_cleanup()'s estimate as to whether another grace
period is required.  Because this particular fail-safe involved acquiring
the root rcu_node structure's ->lock, which has seen excessive contention
in real life, this fail-safe needs to go.

However, one check must remain, namely the check for newly arrived
RCU callbacks that have not yet been associated with a grace period.
One might hope that the checks in __note_gp_changes(), which is invoked
indirectly from rcu_check_quiescent_state(), would suffice, but this
function won't be invoked at all if RCU is idle.  It is therefore necessary
to replace the fail-safe checks with a simpler check for newly arrived
callbacks during an RCU idle period, which is exactly what this commit
does.  This change removes the final call to rcu_start_gp(), so this
function is removed as well.

Note that lockless use of cpu_needs_another_gp() is racy, but that
these races are harmless in this case.  If RCU really is idle, the
values will not change, so the return value from cpu_needs_another_gp()
will be correct.  If RCU is not idle, the resulting redundant call to
rcu_accelerate_cbs() will be harmless, and might even have the benefit
of reducing grace-period latency a bit.

This commit also moves interrupt disabling into the "if" statement to
improve real-time response a bit.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 53 +++++++++++++++--------------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6396a3d10be9..fbacc486ed4c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2335,34 +2335,6 @@ rcu_start_gp_advanced(struct rcu_state *rsp, struct rcu_node *rnp,
 }
 
 /*
- * Similar to rcu_start_gp_advanced(), but also advance the calling CPU's
- * callbacks.  Note that rcu_start_gp_advanced() cannot do this because it
- * is invoked indirectly from rcu_advance_cbs(), which would result in
- * endless recursion -- or would do so if it wasn't for the self-deadlock
- * that is encountered beforehand.
- *
- * Returns true if the grace-period kthread needs to be awakened.
- */
-static bool rcu_start_gp(struct rcu_state *rsp)
-{
-	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
-	struct rcu_node *rnp = rcu_get_root(rsp);
-	bool ret = false;
-
-	/*
-	 * If there is no grace period in progress right now, any
-	 * callbacks we have up to this point will be satisfied by the
-	 * next grace period.  Also, advancing the callbacks reduces the
-	 * probability of false positives from cpu_needs_another_gp()
-	 * resulting in pointless grace periods.  So, advance callbacks
-	 * then start the grace period!
-	 */
-	ret = rcu_advance_cbs(rsp, rnp, rdp) || ret;
-	ret = rcu_start_gp_advanced(rsp, rnp, rdp) || ret;
-	return ret;
-}
-
-/*
  * Report a full set of quiescent states to the specified rcu_state data
  * structure.  Invoke rcu_gp_kthread_wake() to awaken the grace-period
  * kthread if another grace period is required.  Whether we wake
@@ -2889,22 +2861,27 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 	unsigned long flags;
 	bool needwake;
 	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
+	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(!rdp->beenonline);
 
 	/* Update RCU state based on any recent quiescent states. */
 	rcu_check_quiescent_state(rsp, rdp);
 
-	/* Does this CPU require a not-yet-started grace period? */
-	local_irq_save(flags);
-	if (cpu_needs_another_gp(rsp, rdp)) {
-		raw_spin_lock_rcu_node(rcu_get_root(rsp)); /* irqs disabled. */
-		needwake = rcu_start_gp(rsp);
-		raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
-		if (needwake)
-			rcu_gp_kthread_wake(rsp);
-	} else {
-		local_irq_restore(flags);
+	/* No grace period and unregistered callbacks? */
+	if (!rcu_gp_in_progress(rsp) &&
+	    rcu_segcblist_is_enabled(&rdp->cblist)) {
+		local_irq_save(flags);
+		if (rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL)) {
+			local_irq_restore(flags);
+		} else {
+			rnp = rdp->mynode;
+			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
+			needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+			if (needwake)
+				rcu_gp_kthread_wake(rsp);
+		}
 	}
 
 	/* If there are callbacks ready, invoke them. */
-- 
2.5.2
