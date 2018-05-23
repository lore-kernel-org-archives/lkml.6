Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeEWGjA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:39:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32965 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754111AbeEWGii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:38:38 -0400
X-Google-Smtp-Source: AB8JxZrAmapH+Aldmj3gHFDDK3N/bgcHwRcaU1fhVZJ1mU2I9wiHzYy/b6C38DoysMqkZDpObaALFA==
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
Subject: [PATCH 4/4] rcu: Identify grace period is in progress as we advance up the tree
Date: Tue, 22 May 2018 23:38:15 -0700
Message-Id: <20180523063815.198302-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180523063815.198302-1-joel@joelfernandes.org>
References: <20180523063815.198302-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

There's no need to keep checking the same starting node for whether a
grace period is in progress as we advance up the funnel lock loop. Its
sufficient if we just checked it in the start, and then subsequently
checked the internal nodes as we advanced up the combining tree. This
also makes sense because the grace-period updates propogate from the
root to the leaf, so there's a chance we may find a grace period has
started as we advance up, lets check for the same.

Reported-by: Paul McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31f4b4b7d824..65e49282429c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1570,11 +1570,12 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 			goto unlock_out;
 		}
 		rnp->gp_seq_needed = gp_seq_req;
-		if (rcu_seq_state(rcu_seq_current(&rnp_start->gp_seq))) {
+		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
 			/*
-			 * We just marked the leaf, and a grace period
-			 * is in progress, which means that rcu_gp_cleanup()
-			 * will see the marking.  Bail to reduce contention.
+			 * We just marked the leaf or internal node, and a
+			 * grace period is in progress, which means that
+			 * rcu_gp_cleanup() will see the marking.  Bail to
+			 * reduce contention.
 			 */
 			trace_rcu_this_gp(rnp_start, rdp, gp_seq_req,
 					  TPS("Startedleaf"));
-- 
2.17.0.441.gb46fe60e1d-goog
