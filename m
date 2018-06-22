Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701BEC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBE323DA6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBE323DA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeFVGMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:12:13 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:39986 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750931AbeFVGMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:12:12 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 22 Jun 2018 15:12:09 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 22 Jun 2018 15:12:09 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Date:   Fri, 22 Jun 2018 15:12:06 +0900
Message-Id: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When passing through irq or NMI contexts, the current code uses
->dynticks_nmi_nesting to detect if it's in the ourmost at the moment.

Here, the thing is that all the related functions, rcu_irq_enter(),
rcu_nmi_enter(), rcu_irq_exit() and rcu_nmi_exit() are carrying out
the check within each under the following call relationship so there
must be redundant conditional branches:

   rcu_irq_enter()
      /* A conditional branch with ->dynticks_nmi_nesting */
      rcu_nmi_enter()
         /* A conditional branch with ->dynticks_nmi_nesting */
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_irq_exit()
      /* A conditional branch with ->dynticks_nmi_nesting */
      rcu_nmi_exit()
         /* A conditional branch with ->dynticks_nmi_nesting */
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_nmi_enter()
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_nmi_exit()
      /* A conditional branch with ->dynticks_nmi_nesting */

In order to make the code more readable and remove redundant
conditional branches, we need to refactor rcu_{nmi,irq}_{enter,exit}()
so they use a common function for each like:

   rcu_irq_enter() inlining rcu_nmi_enter_common(irq)
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_irq_exit() inlining rcu_nmi_exit_common(irq)
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_nmi_enter() inlining rcu_nmi_enter_common(nmi)
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_nmi_exit() inlining rcu_nmi_exit_common(nmi)
      /* A conditional branch with ->dynticks_nmi_nesting */

Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.c | 59 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index deb2508..cdae85f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -764,17 +764,17 @@ void rcu_user_enter(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_exit - inform RCU of exit from NMI context
+ * rcu_nmi_exit_common - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
  * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
+ * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_exit(void)
+static __always_inline void rcu_nmi_exit_common(bool irq)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 
@@ -800,7 +800,22 @@ void rcu_nmi_exit(void)
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
 	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
 	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+
+	if (irq)
+		rcu_prepare_for_idle();
+
 	rcu_dynticks_eqs_enter();
+
+	if (irq)
+		rcu_dynticks_task_enter();
+}
+
+/**
+ * rcu_nmi_exit - inform RCU of exit from NMI context
+ */
+void rcu_nmi_exit(void)
+{
+	rcu_nmi_exit_common(false);
 }
 
 /**
@@ -824,14 +839,8 @@ void rcu_nmi_exit(void)
  */
 void rcu_irq_exit(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-
 	lockdep_assert_irqs_disabled();
-	if (rdtp->dynticks_nmi_nesting == 1)
-		rcu_prepare_for_idle();
-	rcu_nmi_exit();
-	if (rdtp->dynticks_nmi_nesting == 0)
-		rcu_dynticks_task_enter();
+	rcu_nmi_exit_common(true);
 }
 
 /*
@@ -914,7 +923,7 @@ void rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_enter - inform RCU of entry to NMI context
+ * rcu_nmi_enter_common - inform RCU of entry to NMI context
  *
  * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
  * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
@@ -922,10 +931,10 @@ void rcu_user_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter(), be sure to test
+ * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_enter(void)
+static __always_inline void rcu_nmi_enter_common(bool irq)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	long incby = 2;
@@ -942,7 +951,15 @@ void rcu_nmi_enter(void)
 	 * period (observation due to Andy Lutomirski).
 	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
+
+		if (irq)
+			rcu_dynticks_task_exit();
+
 		rcu_dynticks_eqs_exit();
+
+		if (irq)
+			rcu_cleanup_after_idle();
+
 		incby = 1;
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
@@ -954,6 +971,14 @@ void rcu_nmi_enter(void)
 }
 
 /**
+ * rcu_nmi_enter - inform RCU of entry to NMI context
+ */
+void rcu_nmi_enter(void)
+{
+	rcu_nmi_enter_common(false);
+}
+
+/**
  * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
  *
  * Enter an interrupt handler, which might possibly result in exiting
@@ -977,14 +1002,8 @@ void rcu_nmi_enter(void)
  */
 void rcu_irq_enter(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-
 	lockdep_assert_irqs_disabled();
-	if (rdtp->dynticks_nmi_nesting == 0)
-		rcu_dynticks_task_exit();
-	rcu_nmi_enter();
-	if (rdtp->dynticks_nmi_nesting == 1)
-		rcu_cleanup_after_idle();
+	rcu_nmi_enter_common(true);
 }
 
 /*
-- 
1.9.1

