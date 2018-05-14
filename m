Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeENDQZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:16:25 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43344 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbeENDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:16:05 -0400
X-Google-Smtp-Source: AB8JxZoFBmXvIh3GIdmwVhk2YotMzpmyE52AaRZWEqwqiVSftKaocRYzjjlsHN94rse2wcTt2Sj2gQ==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH RFC 7/8] rcu: trace CleanupMore condition only if needed
Date: Sun, 13 May 2018 20:15:40 -0700
Message-Id: <20180514031541.67247-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180514031541.67247-1-joel@joelfernandes.org>
References: <20180514031541.67247-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the tree RCU clean up code records a CleanupMore trace event
even if the GP was already in progress. This makes CleanupMore show up
twice for no reason. Avoid it.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8401a253e7de..25c44328d071 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2083,7 +2083,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	rsp->gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(rsp->rda);
-	if (ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
+	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
 		trace_rcu_this_gp(rnp, rdp, rnp->gp_seq_needed,
 				  TPS("CleanupMore"));
 		needgp = true;
-- 
2.17.0.441.gb46fe60e1d-goog
