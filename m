Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeB1Ftv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:49:51 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:37514 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeB1Ftu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:49:50 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] rcu: Call wake_nocb_leader_defer() with 'FORCE' when nocb_q_count is high
Date: Wed, 28 Feb 2018 14:49:02 +0900
Message-Id: <1519796942-20947-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If many callbacks have been queued and waking up the nocb leader should
be deferred, then we should wake up the leader unconditionally when
it's safe to do so.

It was well managed in commit fbce7497ee(rcu: Parallelize and economize
NOCB kthread wakeups) at first, but the commit 8be6e1b15c(rcu: Use timer
as backstop for NOCB deferred wakeups) made a mistake which passed
RCU_NOCB_WAKE instead of RCU_NOCB_WAKE_FORCE as a parameter. Fix it.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b0d7f9b..c06cf87 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1987,7 +1987,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 			trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
 					    TPS("WakeOvf"));
 		} else {
-			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE,
+			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					       TPS("WakeOvfIsDeferred"));
 		}
 		rdp->qlen_last_fqs_check = LONG_MAX / 2;
-- 
1.9.1
