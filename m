Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeENDQn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:16:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35093 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeENDQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:16:04 -0400
X-Google-Smtp-Source: AB8JxZogxBwEl/8KboPqMVUJeDqBkpixqfZrhNWj7Dduz8/OHXDNtXqFWxSuVnLFI8OnTF0aVxGTeg==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH RFC 6/8] rcu: Add back the Startedleaf tracepoint
Date: Sun, 13 May 2018 20:15:39 -0700
Message-Id: <20180514031541.67247-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180514031541.67247-1-joel@joelfernandes.org>
References: <20180514031541.67247-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In recent discussion [1], the check for whether a leaf believes RCU is
not idle, is being added back to funnel locking code, to avoid more
locking. In this we are marking the leaf node for a future grace-period
and bailing out since a GP is currently in progress. However the
tracepoint is missing. Lets add it back.

Also add a small comment about why we do this check (basically the point
is to avoid locking intermediate nodes unnecessarily) and clarify the
comments in the trace event header now that we are doing traversal of
one or more intermediate nodes.

[1] http://lkml.kernel.org/r/20180513190906.GL26088@linux.vnet.ibm.com

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h |  4 ++--
 kernel/rcu/tree.c          | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 539900a9f8c7..dc0bd11739c7 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -91,8 +91,8 @@ TRACE_EVENT(rcu_grace_period,
  *
  * "Startleaf": Request a grace period based on leaf-node data.
  * "Prestarted": Someone beat us to the request
- * "Startedleaf": Leaf-node start proved sufficient.
- * "Startedleafroot": Leaf-node start proved sufficient after checking root.
+ * "Startedleaf": Leaf and one or more non-root nodes marked for future start.
+ * "Startedleafroot": all non-root nodes from leaf to root marked for future start.
  * "Startedroot": Requested a nocb grace period based on root-node data.
  * "NoGPkthread": The RCU grace-period kthread has not yet started.
  * "StartWait": Start waiting for the requested grace period.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40670047d22c..8401a253e7de 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1593,8 +1593,17 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 			goto unlock_out;
 		}
 		rnp_node->gp_seq_needed = gp_seq_start;
-		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
+
+		/*
+		 * Check if leaf believes a GP is in progress, if yes we can
+		 * bail and avoid more locking. We have already marked the leaf.
+		 */
+		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
+			trace_rcu_this_gp(rnp_node, rdp, gp_seq_start,
+					  TPS("Startedleaf"));
 			goto unlock_out;
+		}
+
 		if (rnp_node != rnp && rnp_node->parent != NULL)
 			raw_spin_unlock_rcu_node(rnp_node);
 		if (!rnp_node->parent) {
-- 
2.17.0.441.gb46fe60e1d-goog
