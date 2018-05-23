Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeEWGin (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:38:43 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:44824 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754103AbeEWGig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:38:36 -0400
X-Google-Smtp-Source: AB8JxZrH5UmvaYTkKbPCtWrhlyXdy8vxwhKrbCUk5VybLDJykQqVd3xgRoMmLE0mi2sz94kqnjki9A==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
        kernel-team@android.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/4] rcu: Use better variable names in funnel locking loop
Date: Tue, 22 May 2018 23:38:14 -0700
Message-Id: <20180523063815.198302-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180523063815.198302-1-joel@joelfernandes.org>
References: <20180523063815.198302-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The funnel locking loop in rcu_start_this_gp uses rcu_root as a
temporary variable while walking the combining tree. This causes a
tiresome exercise of a code reader reminding themselves that rcu_root
may not be root. Lets just call it rnp, and rename other variables as
well to be more appropriate.

Original patch: https://patchwork.kernel.org/patch/10396577/

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ad61c97da69..31f4b4b7d824 100644
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
+	struct rcu_node *rnp;
 
 	/*
 	 * Use funnel locking to either acquire the root rcu_node
@@ -1556,58 +1556,58 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
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
+		if (!rnp->parent)
 			break;  /* At root, and perhaps also leaf. */
 	}
 
 	/* If GP already in progress, just leave, otherwise start one. */
 	if (rcu_gp_in_progress(rsp)) {
-		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedleafroot"));
+		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
-	trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedroot"));
+	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
 	rsp->gp_req_activity = jiffies;
 	if (!rsp->gp_kthread) {
-		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("NoGPkthread"));
+		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
-	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req)) {
-		rnp->gp_seq_needed = gp_seq_req;
+	if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req)) {
+		rnp_start->gp_seq_needed = gp_seq_req;
 		rdp->gp_seq_needed = gp_seq_req;
 	}
-	if (rnp != rnp_root)
-		raw_spin_unlock_rcu_node(rnp_root);
+	if (rnp != rnp_start)
+		raw_spin_unlock_rcu_node(rnp);
 	return ret;
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog
