Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeENDQp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:16:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42428 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeENDQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:16:04 -0400
X-Google-Smtp-Source: AB8JxZosfOJQ32NxsGNHA7Yeo/XsgVDI7WsH4CPCGawQ9cMmO6iZoxpNP9lrpGXLIsV7aWwoq9LZEA==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH RFC 5/8] rcu: Use rcu_node as temporary variable in funnel locking loop
Date: Sun, 13 May 2018 20:15:38 -0700
Message-Id: <20180514031541.67247-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180514031541.67247-1-joel@joelfernandes.org>
References: <20180514031541.67247-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The funnel locking loop in rcu_start_this_gp uses rcu_root as a
temporary variable while walking the combining tree. This causes a
tiresome exercise of a code reader reminding themselves that rcu_root
may not be root. Lets just call it rcu_node, and then finally when
rcu_node is the rcu_root, lets assign it at that time.

Just a clean up patch, no logical change.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9f5679ba413b..40670047d22c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1568,7 +1568,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 {
 	bool ret = false;
 	struct rcu_state *rsp = rdp->rsp;
-	struct rcu_node *rnp_root;
+	struct rcu_node *rnp_node, *rnp_root = NULL;
 
 	/*
 	 * Use funnel locking to either acquire the root rcu_node
@@ -1581,24 +1581,26 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp);
 	trace_rcu_this_gp(rnp, rdp, gp_seq_start, TPS("Startleaf"));
-	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
-		if (rnp_root != rnp)
-			raw_spin_lock_rcu_node(rnp_root);
-		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_start) ||
-		    rcu_seq_done(&rnp_root->gp_seq, gp_seq_start) ||
-		    (rnp != rnp_root &&
-		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
-			trace_rcu_this_gp(rnp_root, rdp, gp_seq_start,
+	for (rnp_node = rnp; 1; rnp_node = rnp_node->parent) {
+		if (rnp_node != rnp)
+			raw_spin_lock_rcu_node(rnp_node);
+		if (ULONG_CMP_GE(rnp_node->gp_seq_needed, gp_seq_start) ||
+		    rcu_seq_done(&rnp_node->gp_seq, gp_seq_start) ||
+		    (rnp != rnp_node &&
+		     rcu_seq_state(rcu_seq_current(&rnp_node->gp_seq)))) {
+			trace_rcu_this_gp(rnp_node, rdp, gp_seq_start,
 					  TPS("Prestarted"));
 			goto unlock_out;
 		}
-		rnp_root->gp_seq_needed = gp_seq_start;
+		rnp_node->gp_seq_needed = gp_seq_start;
 		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
 			goto unlock_out;
-		if (rnp_root != rnp && rnp_root->parent != NULL)
-			raw_spin_unlock_rcu_node(rnp_root);
-		if (!rnp_root->parent)
+		if (rnp_node != rnp && rnp_node->parent != NULL)
+			raw_spin_unlock_rcu_node(rnp_node);
+		if (!rnp_node->parent) {
+			rnp_root = rnp_node;
 			break;  /* At root, and perhaps also leaf. */
+		}
 	}
 
 	/* If GP already in progress, just leave, otherwise start one. */
@@ -1616,10 +1618,10 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
-	if (rnp != rnp_root)
-		raw_spin_unlock_rcu_node(rnp_root);
+	if (rnp != rnp_node)
+		raw_spin_unlock_rcu_node(rnp_node);
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
-	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_start)) {
+	if (ULONG_CMP_GE(rnp_node->gp_seq_needed, gp_seq_start)) {
 		rnp->gp_seq_needed = gp_seq_start;
 		rdp->gp_seq_needed = gp_seq_start;
 	}
-- 
2.17.0.441.gb46fe60e1d-goog
