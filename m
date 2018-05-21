Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeEUEeV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:34:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35329 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEUEdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:33:25 -0400
X-Google-Smtp-Source: AB8JxZqgyx+piYjnOF19Uc93SIqM1CfwuclySTBEBRjeqTl8mmJl1j4uhq9o3+G2DoEoIAaJguj5xg==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH v2 4/4] rcu: Use better variable names in funnel locking loop
Date: Sun, 20 May 2018 21:32:51 -0700
Message-Id: <20180521043251.120953-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180521043251.120953-1-joel@joelfernandes.org>
References: <20180521043251.120953-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The funnel locking loop in rcu_start_this_gp uses rcu_root as a
temporary variable while walking the combining tree. This causes a
tiresome exercise of a code reader reminding themselves that rcu_root
may not be root. Lets just call it rnp, and rename other variables as
well to be more appropriate.

Original patch: https://patchwork.kernel.org/patch/10396577/

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 48 ++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ffd41ba304f..879c67a31116 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1526,7 +1526,7 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 
 /*
  * rcu_start_this_gp - Request the start of a particular grace period
- * @rnp: The leaf node of the CPU from which to start.
+ * @rnp_start: The leaf node of the CPU from which to start.
  * @rdp: The rcu_data corresponding to the CPU from which to start.
  * @gp_seq_req: The gp_seq of the grace period to start.
  *
@@ -1540,12 +1540,12 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  *
  * Returns true if the GP thread needs to be awakened else false.
  */
-static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
+static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 			      unsigned long gp_seq_req)
 {
 	bool ret = false;
 	struct rcu_state *rsp = rdp->rsp;
-	struct rcu_node *rnp_root;
+	struct rcu_node *rnp, *rnp_root = NULL;
 
 	/*
 	 * Use funnel locking to either acquire the root rcu_node
@@ -1556,34 +1556,36 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * scan the leaf rcu_node structures.  Note that rnp->lock must
 	 * not be released.
 	 */
-	raw_lockdep_assert_held_rcu_node(rnp);
-	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startleaf"));
-	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
-		if (rnp_root != rnp)
-			raw_spin_lock_rcu_node(rnp_root);
-		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req) ||
-		    rcu_seq_started(&rnp_root->gp_seq, gp_seq_req) ||
-		    (rnp != rnp_root &&
-		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
-			trace_rcu_this_gp(rnp_root, rdp, gp_seq_req,
+	raw_lockdep_assert_held_rcu_node(rnp_start);
+	trace_rcu_this_gp(rnp_start, rdp, gp_seq_req, TPS("Startleaf"));
+	for (rnp = rnp_start; 1; rnp = rnp->parent) {
+		if (rnp != rnp_start)
+			raw_spin_lock_rcu_node(rnp);
+		if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req) ||
+		    rcu_seq_started(&rnp->gp_seq, gp_seq_req) ||
+		    (rnp != rnp_start &&
+		     rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))) {
+			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
 					  TPS("Prestarted"));
 			goto unlock_out;
 		}
-		rnp_root->gp_seq_needed = gp_seq_req;
-		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
+		rnp->gp_seq_needed = gp_seq_req;
+		if (rcu_seq_state(rcu_seq_current(&rnp_start->gp_seq))) {
 			/*
 			 * We just marked the leaf, and a grace period
 			 * is in progress, which means that rcu_gp_cleanup()
 			 * will see the marking.  Bail to reduce contention.
 			 */
-			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
+			trace_rcu_this_gp(rnp_start, rdp, gp_seq_req,
 					  TPS("Startedleaf"));
 			goto unlock_out;
 		}
-		if (rnp_root != rnp && rnp_root->parent != NULL)
-			raw_spin_unlock_rcu_node(rnp_root);
-		if (!rnp_root->parent)
+		if (rnp != rnp_start && rnp->parent != NULL)
+			raw_spin_unlock_rcu_node(rnp);
+		if (!rnp->parent) {
+			rnp_root = rnp;
 			break;  /* At root, and perhaps also leaf. */
+		}
 	}
 
 	/* If GP already in progress, just leave, otherwise start one. */
@@ -1601,11 +1603,11 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
-	if (rnp != rnp_root)
-		raw_spin_unlock_rcu_node(rnp_root);
+	if (rnp != rnp_start)
+		raw_spin_unlock_rcu_node(rnp);
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
-	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req)) {
-		rnp->gp_seq_needed = gp_seq_req;
+	if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req)) {
+		rnp_start->gp_seq_needed = gp_seq_req;
 		rdp->gp_seq_needed = gp_seq_req;
 	}
 	return ret;
-- 
2.17.0.441.gb46fe60e1d-goog
