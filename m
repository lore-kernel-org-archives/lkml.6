Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbeEUEnH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:43:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41928 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeEUEmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:42:38 -0400
X-Google-Smtp-Source: AB8JxZpUGAZlKhcB2vXsragHsHcx9yJ2nWC/mB5SpwaEbUDPbDJOsdmWYUpxD1vFu8EL5yYxtX1KyQ==
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
Subject: [PATCH v3 4/4] rcu: Unlock non-start node only after accessing its gp_seq_needed
Date: Sun, 20 May 2018 21:42:20 -0700
Message-Id: <20180521044220.123933-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180521044220.123933-1-joel@joelfernandes.org>
References: <20180521044220.123933-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We acquire gp_seq_needed locklessly. To be safe, lets do the unlocking
after the access.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 879c67a31116..efbd21b2a1a6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1603,13 +1603,13 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
-	if (rnp != rnp_start)
-		raw_spin_unlock_rcu_node(rnp);
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
 	if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req)) {
 		rnp_start->gp_seq_needed = gp_seq_req;
 		rdp->gp_seq_needed = gp_seq_req;
 	}
+	if (rnp != rnp_start)
+		raw_spin_unlock_rcu_node(rnp);
 	return ret;
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog
