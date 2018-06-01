Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbeFACEg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 22:04:36 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:60164 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeFACEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 22:04:32 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [PATCH] rcu: Check the range of jiffies_till_{first,next}_fqs when setting them
Date: Fri,  1 Jun 2018 11:03:09 +0900
Message-Id: <1527818589-13476-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the range of jiffies_till_{first,next}_fqs are checked and
adjusted on and on in the loop of rcu_gp_kthread on runtime.

However, it's enough to check them only when setting them, not every
time in the loop. So make them handled on a setting time via sysfs.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4e96761..eb54d7d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -518,8 +518,38 @@ void rcu_all_qs(void)
 static ulong jiffies_till_next_fqs = ULONG_MAX;
 static bool rcu_kick_kthreads;
 
-module_param(jiffies_till_first_fqs, ulong, 0644);
-module_param(jiffies_till_next_fqs, ulong, 0644);
+static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
+{
+	ulong j;
+	int ret = kstrtoul(val, 0, &j);
+
+	if (!ret)
+		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
+	return ret;
+}
+
+static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param *kp)
+{
+	ulong j;
+	int ret = kstrtoul(val, 0, &j);
+
+	if (!ret)
+		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
+	return ret;
+}
+
+static struct kernel_param_ops first_fqs_jiffies_ops = {
+	.set = param_set_first_fqs_jiffies,
+	.get = param_get_ulong,
+};
+
+static struct kernel_param_ops next_fqs_jiffies_ops = {
+	.set = param_set_next_fqs_jiffies,
+	.get = param_get_ulong,
+};
+
+module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
+module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
 module_param(rcu_kick_kthreads, bool, 0644);
 
 /*
@@ -2129,10 +2159,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
 		/* Handle quiescent-state forcing. */
 		first_gp_fqs = true;
 		j = jiffies_till_first_fqs;
-		if (j > HZ) {
-			j = HZ;
-			jiffies_till_first_fqs = HZ;
-		}
 		ret = 0;
 		for (;;) {
 			if (!ret) {
@@ -2167,13 +2193,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
 				WRITE_ONCE(rsp->gp_activity, jiffies);
 				ret = 0; /* Force full wait till next FQS. */
 				j = jiffies_till_next_fqs;
-				if (j > HZ) {
-					j = HZ;
-					jiffies_till_next_fqs = HZ;
-				} else if (j < 1) {
-					j = 1;
-					jiffies_till_next_fqs = 1;
-				}
 			} else {
 				/* Deal with stray signal. */
 				cond_resched_tasks_rcu_qs();
-- 
1.9.1
