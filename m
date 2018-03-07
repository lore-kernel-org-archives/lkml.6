Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeCGIqW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:46:22 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeCGIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:46:12 -0500
X-Google-Smtp-Source: AG47ELs1nkApE65N4vJEfNfRlioLeQe1TOdGZWwMNzN4CV27jZ3Ii628pnWUvpoo8gPa22JTwgCXzA==
X-ME-Sender: <xms:z6afWhf3E-K3DTLI-UuzVSK1B-RfEh-J72Ia5nP-iRMlGcowfynogg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] rcu: exp: Fix "must hold exp_mutex" comments for QS reporting functions
Date: Wed,  7 Mar 2018 16:49:39 +0800
Message-Id: <20180307084944.10229-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d9a3da0699b2 ("rcu: Add expedited grace-period support for
preemptible RCU"), there are comments for some funtions in
rcu_report_exp_rnp()'s call-chain saying that exp_mutex or its
predecessors needs to be held.

However, exp_mutex and its predecessors are merely used for synchronize
between GPs, and it's clearly that all variables visited by those
functions are under the protection of rcu_node's ->lock. Moreover, those
functions are currently called without held exp_mutex, and seems that
doesn't introduce any trouble.

So this patch fix this problem by correcting the comments

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Fixes: d9a3da0699b2 ("rcu: Add expedited grace-period support for preemptible RCU")
---
 kernel/rcu/tree_exp.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f8e4571efabf..2fd882b08b7c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -154,7 +154,7 @@ static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
  * for the current expedited grace period.  Works only for preemptible
  * RCU -- other RCU implementation use other means.
  *
- * Caller must hold the rcu_state's exp_mutex.
+ * Caller must hold the specificed rcu_node structure's ->lock
  */
 static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
 {
@@ -170,8 +170,7 @@ static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
  * recursively up the tree.  (Calm down, calm down, we do the recursion
  * iteratively!)
  *
- * Caller must hold the rcu_state's exp_mutex and the specified rcu_node
- * structure's ->lock.
+ * Caller must hold the specified rcu_node structure's ->lock.
  */
 static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 				 bool wake, unsigned long flags)
@@ -207,8 +206,6 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 /*
  * Report expedited quiescent state for specified node.  This is a
  * lock-acquisition wrapper function for __rcu_report_exp_rnp().
- *
- * Caller must hold the rcu_state's exp_mutex.
  */
 static void __maybe_unused rcu_report_exp_rnp(struct rcu_state *rsp,
 					      struct rcu_node *rnp, bool wake)
@@ -221,8 +218,7 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_state *rsp,
 
 /*
  * Report expedited quiescent state for multiple CPUs, all covered by the
- * specified leaf rcu_node structure.  Caller must hold the rcu_state's
- * exp_mutex.
+ * specified leaf rcu_node structure.
  */
 static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
 				    unsigned long mask, bool wake)
-- 
2.16.2
