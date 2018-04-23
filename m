Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbeDWDDB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:03:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753989AbeDWDCl (ORCPT
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
Subject: [PATCH tip/core/rcu 16/21] rcu: Add funnel locking to rcu_start_this_gp()
Date: Sun, 22 Apr 2018 20:03:39 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-2213-0000-0000-0000029783A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-2214-0000-0000-000059DC4076
Message-Id: <1524452624-27589-16-git-send-email-paulmck@linux.vnet.ibm.com>
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

The rcu_start_this_gp() function had a simple form of funnel locking that
used only the leaves and root of the rcu_node tree, which is fine for
systems with only a few hundred CPUs, but sub-optimal for systems having
thousands of CPUs.  This commit therefore adds full-tree funnel locking.

This variant of funnel locking is unusual in the following ways:

1.	The leaf-level rcu_node structure's ->lock is held throughout.
	Other funnel-locking implementations drop the leaf-level lock
	before progressing to the next level of the tree.

2.	Funnel locking can be started at the root, which is convenient
	for code that already holds the root rcu_node structure's ->lock.
	Other funnel-locking implementations start at the leaves.

3.	If an rcu_node structure other than the initial one believes
	that a grace period is in progress, it is not necessary to
	go further up the tree.  This is because grace-period cleanup
	scans the full tree, so that marking the need for a subsequent
	grace period anywhere in the tree suffices -- but only if
	a grace period is currently in progress.

4.	It is possible that the RCU grace-period kthread has not yet
	started, and this case must be handled appropriately.

However, the general approach of using a tree to control lock contention
is still in place.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 92 +++++++++++++++++++++----------------------------------
 1 file changed, 35 insertions(+), 57 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 94519c7d552f..d3c769502929 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1682,74 +1682,52 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 {
 	bool ret = false;
 	struct rcu_state *rsp = rdp->rsp;
-	struct rcu_node *rnp_root = rcu_get_root(rsp);
-
-	raw_lockdep_assert_held_rcu_node(rnp);
-
-	/* If the specified GP is already known needed, return to caller. */
-	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
-	if (need_future_gp_element(rnp, c)) {
-		trace_rcu_this_gp(rnp, rdp, c, TPS("Prestartleaf"));
-		goto out;
-	}
+	struct rcu_node *rnp_root;
 
 	/*
-	 * If this rcu_node structure believes that a grace period is in
-	 * progress, then we must wait for the one following, which is in
-	 * "c".  Because our request will be noticed at the end of the
-	 * current grace period, we don't need to explicitly start one.
+	 * Use funnel locking to either acquire the root rcu_node
+	 * structure's lock or bail out if the need for this grace period
+	 * has already been recorded -- or has already started.  If there
+	 * is already a grace period in progress in a non-leaf node, no
+	 * recording is needed because the end of the grace period will
+	 * scan the leaf rcu_node structures.  Note that rnp->lock must
+	 * not be released.
 	 */
-	if (rnp->gpnum != rnp->completed) {
-		need_future_gp_element(rnp, c) = true;
-		trace_rcu_this_gp(rnp, rdp, c, TPS("Startedleaf"));
-		goto out;
+	raw_lockdep_assert_held_rcu_node(rnp);
+	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
+	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
+		if (rnp_root != rnp)
+			raw_spin_lock_rcu_node(rnp_root);
+		if (need_future_gp_element(rnp_root, c) ||
+		    ULONG_CMP_GE(rnp_root->gpnum, c) ||
+		    (rnp != rnp_root &&
+		     rnp_root->gpnum != rnp_root->completed)) {
+			trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
+			goto unlock_out;
+		}
+		need_future_gp_element(rnp_root, c) = true;
+		if (rnp_root != rnp && rnp_root->parent != NULL)
+			raw_spin_unlock_rcu_node(rnp_root);
+		if (!rnp_root->parent)
+			break;  /* At root, and perhaps also leaf. */
 	}
 
-	/*
-	 * There might be no grace period in progress.  If we don't already
-	 * hold it, acquire the root rcu_node structure's lock in order to
-	 * start one (if needed).
-	 */
-	if (rnp != rnp_root)
-		raw_spin_lock_rcu_node(rnp_root);
-
-	/*
-	 * Get a new grace-period number.  If there really is no grace
-	 * period in progress, it will be smaller than the one we obtained
-	 * earlier.  Adjust callbacks as needed.
-	 */
-	c = rcu_cbs_completed(rsp, rnp_root);
-	if (!rcu_is_nocb_cpu(rdp->cpu))
-		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
-
-	/*
-	 * If the needed for the required grace period is already
-	 * recorded, trace and leave.
-	 */
-	if (need_future_gp_element(rnp_root, c)) {
-		trace_rcu_this_gp(rnp, rdp, c, TPS("Prestartedroot"));
+	/* If GP already in progress, just leave, otherwise start one. */
+	if (rnp_root->gpnum != rnp_root->completed) {
+		trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
-
-	/* Record the need for the future grace period. */
-	need_future_gp_element(rnp_root, c) = true;
-
-	/* If a grace period is not already in progress, start one. */
-	if (rnp_root->gpnum != rnp_root->completed) {
-		trace_rcu_this_gp(rnp, rdp, c, TPS("Startedleafroot"));
-	} else {
-		trace_rcu_this_gp(rnp, rdp, c, TPS("Startedroot"));
-		if (!rsp->gp_kthread)
-			goto unlock_out; /* No grace-period kthread yet! */
-		WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
-		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum),
-				       TPS("newreq"));
-		ret = true;  /* Caller must wake GP kthread. */
+	trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedroot"));
+	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
+	if (!rsp->gp_kthread) {
+		trace_rcu_this_gp(rnp_root, rdp, c, TPS("NoGPkthread"));
+		goto unlock_out;
 	}
+	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum), TPS("newreq"));
+	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	if (rnp != rnp_root)
 		raw_spin_unlock_rcu_node(rnp_root);
-out:
 	return ret;
 }
 
-- 
2.5.2
