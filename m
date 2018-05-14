Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeENDQI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:16:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45439 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeENDQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:16:06 -0400
X-Google-Smtp-Source: AB8JxZrgiKMcN+PI8OpR+HfUGVeFSOHPjjda4bkiSpfujy7mA6CB2ZhmM+gJ7fu8BRvgfM3PfaV+vQ==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH RFC 8/8] rcu: Fix cpustart tracepoint gp_seq number
Date: Sun, 13 May 2018 20:15:41 -0700
Message-Id: <20180514031541.67247-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180514031541.67247-1-joel@joelfernandes.org>
References: <20180514031541.67247-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpustart shows a stale gp_seq. This is because rdp->gp_seq is updated
only at the end of the __note_gp_changes function. For this reason, use
rnp->gp_seq instead. I believe we can't update rdp->gp_seq too early so
lets just use the gp_seq from rnp instead.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 25c44328d071..58d2b68f8b98 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1807,7 +1807,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 		 * set up to detect a quiescent state, otherwise don't
 		 * go looking for one.
 		 */
-		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpustart"));
+		trace_rcu_grace_period(rsp->name, rnp->gp_seq, TPS("cpustart"));
 		need_gp = !!(rnp->qsmask & rdp->grpmask);
 		rdp->cpu_no_qs.b.norm = need_gp;
 		rdp->rcu_qs_ctr_snap = __this_cpu_read(rcu_dynticks.rcu_qs_ctr);
-- 
2.17.0.441.gb46fe60e1d-goog
