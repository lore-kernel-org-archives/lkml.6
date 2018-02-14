Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966536AbeBNJA2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:00:28 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:58150 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754570AbeBNJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:00:27 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] srcu: Fix incorrect condition in srcu_funnel_exp_start()
Date: Wed, 14 Feb 2018 17:59:54 +0900
Message-Id: <1518598794-26752-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should've kept sp->srcu_gp_seq_needed_exp the furthest. But
it probably fails because of the incorrect condition. Fix it.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d5cea81..44bc0fa 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -626,7 +626,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *sp, struct srcu_node *snp,
 		spin_unlock_irqrestore_rcu_node(snp, flags);
 	}
 	spin_lock_irqsave_rcu_node(sp, flags);
-	if (!ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
+	if (ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
 		sp->srcu_gp_seq_needed_exp = s;
 	spin_unlock_irqrestore_rcu_node(sp, flags);
 }
-- 
1.9.1
