Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeEKIbg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:31:36 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:55008 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750852AbeEKIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:31:35 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] rcu: Report a quiescent state when it's exactly in the state
Date: Fri, 11 May 2018 17:30:34 +0900
Message-Id: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expect a quiescent state of TASKS_RCU when cond_resched_tasks_rcu_qs()
is called, no matter whether it actually be scheduled or not. However,
it currently doesn't report the quiescent state when the task enters
into __schedule() as it's called with preempt = true. So make it report
the quiescent state unconditionally when cond_resched_tasks_rcu_qs() is
called.

And in TINY_RCU, even though the quiescent state of rcu_bh also should
be reported when the tick interrupt comes from user, it doesn't. So make
it reported.

Lastly in TREE_RCU, rcu_note_voluntary_context_switch() should be
reported when the tick interrupt comes from not only user but also idle,
as an extended quiescent state.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/rcupdate.h | 4 ++--
 kernel/rcu/tiny.c        | 6 +++---
 kernel/rcu/tree.c        | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index ee8cf5fc..7432261 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -195,8 +195,8 @@ static inline void exit_tasks_rcu_finish(void) { }
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
-	if (!cond_resched()) \
-		rcu_note_voluntary_context_switch_lite(current); \
+	rcu_note_voluntary_context_switch_lite(current); \
+	cond_resched(); \
 } while (0)
 
 /*
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index a64eee0..68d2332 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -120,12 +120,12 @@ void rcu_bh_qs(void)
  */
 void rcu_check_callbacks(int user)
 {
-	if (user)
+	if (user) {
 		rcu_sched_qs();
-	else if (!in_softirq())
 		rcu_bh_qs();
-	if (user)
 		rcu_note_voluntary_context_switch(current);
+	} else if (!in_softirq())
+		rcu_bh_qs();
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 36075dd..1abe29a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2595,6 +2595,7 @@ void rcu_check_callbacks(int user)
 
 		rcu_sched_qs();
 		rcu_bh_qs();
+		rcu_note_voluntary_context_switch(current);
 
 	} else if (!in_softirq()) {
 
@@ -2610,8 +2611,7 @@ void rcu_check_callbacks(int user)
 	rcu_preempt_check_callbacks();
 	if (rcu_pending())
 		invoke_rcu_core();
-	if (user)
-		rcu_note_voluntary_context_switch(current);
+
 	trace_rcu_utilization(TPS("End scheduler-tick"));
 }
 
-- 
1.9.1
