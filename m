Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDWDD5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:03:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753988AbeDWDCl (ORCPT
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
Subject: [PATCH tip/core/rcu 19/21] rcu: Simplify and inline cpu_needs_another_gp()
Date: Sun, 22 Apr 2018 20:03:42 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0036-0000-0000-000002E8B169
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801134;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0037-0000-0000-000044150A87
Message-Id: <1524452624-27589-19-git-send-email-paulmck@linux.vnet.ibm.com>
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

Now that RCU no longer relies on failsafe checks, cpu_needs_another_gp()
can be greatly simplified.  This simplification eliminates the last
call to rcu_future_needs_gp() and to rcu_segcblist_future_gp_needed(),
both of which which can then be eliminated.  And then, because
cpu_needs_another_gp() is called only from __rcu_pending(), it can be
inlined and eliminated.

This commit carries out the simplification, inlining, and elimination
called out above.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu_segcblist.c | 18 ------------------
 kernel/rcu/rcu_segcblist.h |  2 --
 kernel/rcu/tree.c          | 40 +++-------------------------------------
 3 files changed, 3 insertions(+), 57 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 88cba7c2956c..5aff271adf1e 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -404,24 +404,6 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 }
 
 /*
- * Scan the specified rcu_segcblist structure for callbacks that need
- * a grace period later than the one specified by "seq".  We don't look
- * at the RCU_DONE_TAIL or RCU_NEXT_TAIL segments because they don't
- * have a grace-period sequence number.
- */
-bool rcu_segcblist_future_gp_needed(struct rcu_segcblist *rsclp,
-				    unsigned long seq)
-{
-	int i;
-
-	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++)
-		if (rsclp->tails[i - 1] != rsclp->tails[i] &&
-		    ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
-			return true;
-	return false;
-}
-
-/*
  * Merge the source rcu_segcblist structure into the destination
  * rcu_segcblist structure, then initialize the source.  Any pending
  * callbacks from the source get to start over.  It is best to
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 581c12b63544..948470cef385 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -134,7 +134,5 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
 void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
-bool rcu_segcblist_future_gp_needed(struct rcu_segcblist *rsclp,
-				    unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7776d709e060..020a0fe2dbee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -709,42 +709,6 @@ static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
 }
 
 /*
- * Is there any need for future grace periods?
- * Interrupts must be disabled.  If the caller does not hold the root
- * rnp_node structure's ->lock, the results are advisory only.
- */
-static int rcu_future_needs_gp(struct rcu_state *rsp)
-{
-	struct rcu_node *rnp = rcu_get_root(rsp);
-
-	lockdep_assert_irqs_disabled();
-	return need_any_future_gp(rnp);
-}
-
-/*
- * Does the current CPU require a not-yet-started grace period?
- * The caller must have disabled interrupts to prevent races with
- * normal callback registry.
- */
-static bool
-cpu_needs_another_gp(struct rcu_state *rsp, struct rcu_data *rdp)
-{
-	lockdep_assert_irqs_disabled();
-	if (rcu_gp_in_progress(rsp))
-		return false;  /* No, a grace period is already in progress. */
-	if (rcu_future_needs_gp(rsp))
-		return true;  /* Yes, a no-CBs CPU needs one. */
-	if (!rcu_segcblist_is_enabled(&rdp->cblist))
-		return false;  /* No, this is a no-CBs (or offline) CPU. */
-	if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
-		return true;  /* Yes, CPU has newly registered callbacks. */
-	if (rcu_segcblist_future_gp_needed(&rdp->cblist,
-					   READ_ONCE(rsp->completed)))
-		return true;  /* Yes, CBs for future grace period. */
-	return false; /* No grace period needed. */
-}
-
-/*
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
  *
@@ -3298,7 +3262,9 @@ static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-	if (cpu_needs_another_gp(rsp, rdp))
+	if (!rcu_gp_in_progress(rsp) &&
+	    rcu_segcblist_is_enabled(&rdp->cblist) &&
+	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
 	/* Has another RCU grace period completed?  */
-- 
2.5.2
