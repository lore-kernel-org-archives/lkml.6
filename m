Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeB1JFv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:05:51 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:45720 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbeB1JFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:05:48 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] rcu: Clean up rcu_init_nohz() by removing unnecessary statements
Date: Wed, 28 Feb 2018 18:04:55 +0900
Message-Id: <1519808695-28097-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 44c65ff2e3b0(rcu: Eliminate NOCBs CPU-state Kconfig
options) made nocb-cpus identified only through the rcu_nocbs= boot
parameter, we don't have to care NOCBs CPU-state Kconfig options
anymore, which means now we can just rely on rcu_nocb_mask to
decide whether going ahead in rcu_init_nohz().

Remove the deprecated code.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree_plugin.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b0d7f9b..510a6af 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2313,22 +2313,14 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = true;
 	struct rcu_state *rsp;
 
-#if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
-		need_rcu_nocb_mask = true;
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
-
-	if (!cpumask_available(rcu_nocb_mask) && need_rcu_nocb_mask) {
+	if (!cpumask_available(rcu_nocb_mask)) {
 		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
 			pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
 			return;
 		}
 	}
-	if (!cpumask_available(rcu_nocb_mask))
-		return;
 
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running)
-- 
1.9.1
