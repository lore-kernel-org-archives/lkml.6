Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeBZFMV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 00:12:21 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:52541 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeBZFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 00:12:20 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] rcu: Remove the unnecessary separate function, rcu_preempt_do_callback()
Date: Mon, 26 Feb 2018 14:11:36 +0900
Message-Id: <1519621896-8786-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_preemptp_do_callback() was introduced in commit 09223371dea(rcu:
Use softirq to address performance regression), where it had to be
distinguished between in the case CONFIG_TREE_PREEMPT_RCU is set and
it's not.

Now that the code was cleaned up so that rcu_preemt_do_callback() is
only called in rcu_kthread_do_work() in the same file, tree_plugin.h,
we don't have to keep the separate function anymore. Remove it for a
better readability.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_plugin.h | 11 +----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 478b79e..4172833 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -439,7 +439,6 @@ struct rcu_state {
 static void invoke_rcu_callbacks_kthread(void);
 static bool rcu_is_callbacks_kthread(void);
 #ifdef CONFIG_RCU_BOOST
-static void rcu_preempt_do_callbacks(void);
 static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
 						 struct rcu_node *rnp);
 #endif /* #ifdef CONFIG_RCU_BOOST */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 26d7a31..1070a04 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -686,15 +686,6 @@ static void rcu_preempt_check_callbacks(void)
 		t->rcu_read_unlock_special.b.need_qs = true;
 }
 
-#ifdef CONFIG_RCU_BOOST
-
-static void rcu_preempt_do_callbacks(void)
-{
-	rcu_do_batch(rcu_state_p, this_cpu_ptr(rcu_data_p));
-}
-
-#endif /* #ifdef CONFIG_RCU_BOOST */
-
 /**
  * call_rcu() - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -1170,7 +1161,7 @@ static void rcu_kthread_do_work(void)
 {
 	rcu_do_batch(&rcu_sched_state, this_cpu_ptr(&rcu_sched_data));
 	rcu_do_batch(&rcu_bh_state, this_cpu_ptr(&rcu_bh_data));
-	rcu_preempt_do_callbacks();
+	rcu_do_batch(rcu_state_p, this_cpu_ptr(rcu_data_p));
 }
 
 static void rcu_cpu_kthread_setup(unsigned int cpu)
-- 
1.9.1
