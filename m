Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeDWDGH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:06:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753944AbeDWDCj (ORCPT
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
Subject: [PATCH tip/core/rcu 03/21] rcu: Add accessor macros for the ->need_future_gp[] array
Date: Sun, 22 Apr 2018 20:03:26 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-2213-0000-0000-0000029783A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-2214-0000-0000-000059DC4069
Message-Id: <1524452624-27589-3-git-send-email-paulmck@linux.vnet.ibm.com>
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

Accessors for the ->need_future_gp[] array are currently open-coded,
which makes them difficult to change.  To improve maintainability, this
commit adds need_future_gp_mask() to compute the indexing mask from the
array size, need_future_gp_element() to access the element corresponding
to the specified grace-period number, and need_any_future_gp() to
determine if any future grace period is needed.  This commit also applies
need_future_gp_element() to existing open-coded single-element accesses.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 16 +++++++---------
 kernel/rcu/tree.h        | 15 +++++++++++++++
 kernel/rcu/tree_plugin.h |  2 +-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4bbba17422cd..79fb99951a0c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -718,11 +718,9 @@ static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
 static int rcu_future_needs_gp(struct rcu_state *rsp)
 {
 	struct rcu_node *rnp = rcu_get_root(rsp);
-	int idx = (READ_ONCE(rnp->completed) + 1) & 0x1;
-	int *fp = &rnp->need_future_gp[idx];
 
 	lockdep_assert_irqs_disabled();
-	return READ_ONCE(*fp);
+	return READ_ONCE(need_future_gp_element(rnp, rnp->completed));
 }
 
 /*
@@ -1699,7 +1697,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 */
 	c = rcu_cbs_completed(rdp->rsp, rnp);
 	trace_rcu_future_gp(rnp, rdp, c, TPS("Startleaf"));
-	if (rnp->need_future_gp[c & 0x1]) {
+	if (need_future_gp_element(rnp, c)) {
 		trace_rcu_future_gp(rnp, rdp, c, TPS("Prestartleaf"));
 		goto out;
 	}
@@ -1711,7 +1709,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * current grace period, we don't need to explicitly start one.
 	 */
 	if (rnp->gpnum != rnp->completed) {
-		rnp->need_future_gp[c & 0x1]++;
+		need_future_gp_element(rnp, c)++;
 		trace_rcu_future_gp(rnp, rdp, c, TPS("Startedleaf"));
 		goto out;
 	}
@@ -1737,13 +1735,13 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * If the needed for the required grace period is already
 	 * recorded, trace and leave.
 	 */
-	if (rnp_root->need_future_gp[c & 0x1]) {
+	if (need_future_gp_element(rnp_root, c)) {
 		trace_rcu_future_gp(rnp, rdp, c, TPS("Prestartedroot"));
 		goto unlock_out;
 	}
 
 	/* Record the need for the future grace period. */
-	rnp_root->need_future_gp[c & 0x1]++;
+	need_future_gp_element(rnp_root, c)++;
 
 	/* If a grace period is not already in progress, start one. */
 	if (rnp_root->gpnum != rnp_root->completed) {
@@ -1771,8 +1769,8 @@ static int rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 	int needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
-	rnp->need_future_gp[c & 0x1] = 0;
-	needmore = rnp->need_future_gp[(c + 1) & 0x1];
+	need_future_gp_element(rnp, c) = 0;
+	needmore = need_future_gp_element(rnp, c + 1);
 	trace_rcu_future_gp(rnp, rdp, c,
 			    needmore ? TPS("CleanupMore") : TPS("Cleanup"));
 	return needmore;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f491ab4f2e8e..18b091474ffa 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -159,6 +159,21 @@ struct rcu_node {
 	wait_queue_head_t exp_wq[4];
 } ____cacheline_internodealigned_in_smp;
 
+/* Accessors for ->need_future_gp[] array. */
+#define need_future_gp_mask() \
+	(ARRAY_SIZE(((struct rcu_node *)NULL)->need_future_gp) - 1)
+#define need_future_gp_element(rnp, c) \
+	((rnp)->need_future_gp[(c) & need_future_gp_mask()])
+#define need_any_future_gp(rnp)						\
+({									\
+	int __i;							\
+	bool __nonzero = false;						\
+									\
+	for (__i = 0; __i < ARRAY_SIZE((rnp)->need_future_gp); __i++)	\
+		__nonzero = __nonzero || (rnp)->need_future_gp[__i];	\
+	__nonzero;							\
+})
+
 /*
  * Bitmasks in an rcu_node cover the interval [grplo, grphi] of CPU IDs, and
  * are indexed relative to this interval rather than the global CPU ID space.
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 84fbee4686d3..640ea927d8a4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1790,7 +1790,7 @@ static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
  */
 static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
 {
-	rnp->need_future_gp[(rnp->completed + 1) & 0x1] += nrq;
+	need_future_gp_element(rnp, rnp->completed + 1) += nrq;
 }
 
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
-- 
2.5.2
