Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeENDRc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:17:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35091 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeENDQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:16:02 -0400
X-Google-Smtp-Source: AB8JxZoh1Xmep/I3Z9r/rmfDzGk3fmqIeiaEyxCtuiQoz9rYSS7eO+1TAvJ3nxoJD95Rk/mNgPviRQ==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH RFC 3/8] rcu: Add back the cpuend tracepoint
Date: Sun, 13 May 2018 20:15:36 -0700
Message-Id: <20180514031541.67247-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180514031541.67247-1-joel@joelfernandes.org>
References: <20180514031541.67247-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit be4b8beed87d ("rcu: Move RCU's grace-period-change code to ->gp_seq")
removed the cpuend grace period trace point. This patch adds it back.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9ad931bff409..29ccc60bdbfc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1774,10 +1774,12 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap)))
+	    unlikely(READ_ONCE(rdp->gpwrap))) {
 		ret = rcu_advance_cbs(rsp, rnp, rdp); /* Advance callbacks. */
-	else
+		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuend"));
+	} else {
 		ret = rcu_accelerate_cbs(rsp, rnp, rdp); /* Recent callbacks. */
+	}
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
 	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
-- 
2.17.0.441.gb46fe60e1d-goog
