Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754880AbeE2HY6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:24:58 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:53636 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754751AbeE2HY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:24:57 -0400
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting them
Date: Tue, 29 May 2018 16:23:36 +0900
Message-Id: <1527578616-5595-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul and folks,

I've thought the code should've been like the below since the range
checking of jiffies_till_first_fqs and jiffies_till_next_fqs everytime
in the loop of rcu_gp_kthread are unnecessary at all. However, it's ok
even if you don't think it's worth doing it.

Secondly, I also think jiffies_till_first_fqs = 0 is meaningless so
added checking and adjusting it as what's done on jiffies_till_next_fqs.
Thought?

Thank you in advance.
Byungchul

----->8-----
>From 67fecc15b44b2521de96de109782c04ce65afb85 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Tue, 29 May 2018 15:49:26 +0900
Subject: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting them

Currently, the range of jiffies_till_first_fqs and jiffies_till_next_fqs
are always checked and adjusted in the loop of rcu_gp_kthread on runtime.
However, it would be better and enough to check them only on setting
them, so remove unnecessary checking and adjusting in the loop.

Additionally, add adjusting jiffies_till_first_fqs so guaranteed to be
greater than 0, which hasn't been done before.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4e96761..4964237 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -518,8 +518,31 @@ void rcu_all_qs(void)
 static ulong jiffies_till_next_fqs = ULONG_MAX;
 static bool rcu_kick_kthreads;
 
-module_param(jiffies_till_first_fqs, ulong, 0644);
-module_param(jiffies_till_next_fqs, ulong, 0644);
+static int param_set_fqs_jiffies(const char *val, const struct kernel_param *kp)
+{
+	ulong tmp;
+	int ret = kstrtoul(val, 0, &tmp);
+
+	if (ret < 0)
+		return ret;
+
+	if (tmp > HZ)
+		tmp = HZ;
+	else if (tmp < 1)
+		tmp = 1;
+
+	/* Prevent tearing */
+	WRITE_ONCE(*(ulong *)kp->arg, tmp);
+	return 0;
+}
+
+static struct kernel_param_ops fqs_jiffies_ops = {
+	.set = param_set_fqs_jiffies,
+	.get = param_get_ulong,
+};
+
+module_param_cb(jiffies_till_first_fqs, &fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
+module_param_cb(jiffies_till_next_fqs, &fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
 module_param(rcu_kick_kthreads, bool, 0644);
 
 /*
@@ -2129,10 +2152,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
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
@@ -2167,13 +2186,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
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
