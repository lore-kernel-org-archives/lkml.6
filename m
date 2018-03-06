Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbeCFFcx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:32:53 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:47582 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeCFFcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:32:52 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [RFC] rcu: Prevent expedite reporting within RCU read-side section
Date: Tue,  6 Mar 2018 14:31:58 +0900
Message-Id: <1520314318-30916-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul and RCU folks,

I am afraid I correctly understand and fix it. But I really wonder why
sync_rcu_exp_handler() reports the quiescent state even in the case that
current task is within a RCU read-side section. Do I miss something?

If I correctly understand it and you agree with it, I can add more logic
which make it more expedited by boosting current or making it urgent
when we fail to report the quiescent state on the IPI.

----->8-----
>From 0b0191f506c19ce331a1fdb7c2c5a00fb23fbcf2 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Tue, 6 Mar 2018 13:54:41 +0900
Subject: [RFC] rcu: Prevent expedite reporting within RCU read-side section

We report the quiescent state for this cpu if it's out of RCU read-side
section at the moment IPI was just fired during the expedite process.

However, current code reports the quiescent state even in the case:

   1) the current task is still within a RCU read-side section
   2) the current task has been blocked within the RCU read-side section

Since we don't get to the quiescent state yet in the case, we shouldn't
report it but check it another time.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree_exp.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 73e1d3d..cc69d14 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -731,13 +731,13 @@ static void sync_rcu_exp_handler(void *info)
 	/*
 	 * We are either exiting an RCU read-side critical section (negative
 	 * values of t->rcu_read_lock_nesting) or are not in one at all
-	 * (zero value of t->rcu_read_lock_nesting).  Or we are in an RCU
-	 * read-side critical section that blocked before this expedited
-	 * grace period started.  Either way, we can immediately report
-	 * the quiescent state.
+	 * (zero value of t->rcu_read_lock_nesting). We can immediately
+	 * report the quiescent state.
 	 */
-	rdp = this_cpu_ptr(rsp->rda);
-	rcu_report_exp_rdp(rsp, rdp, true);
+	if (t->rcu_read_lock_nesting <= 0) {
+		rdp = this_cpu_ptr(rsp->rda);
+		rcu_report_exp_rdp(rsp, rdp, true);
+	}
 }
 
 /**
-- 
1.9.1
