Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD1CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C29220846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C29220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933163AbeFTIr2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:47:28 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:45304 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933111AbeFTIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:47:24 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 20 Jun 2018 17:47:22 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 20 Jun 2018 17:47:22 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [RFC 1/2] rcu: Do prepare and cleanup idle depending on in_nmi()
Date:   Wed, 20 Jun 2018 17:47:19 +0900
Message-Id: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of dependency on ->dynticks_nmi_nesting.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index deb2508..59ae94e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -797,6 +797,11 @@ void rcu_nmi_exit(void)
 		return;
 	}
 
+	if (!in_nmi()) {
+		rcu_prepare_for_idle();
+		rcu_dynticks_task_enter();
+	}
+
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
 	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
 	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
@@ -824,14 +829,8 @@ void rcu_nmi_exit(void)
  */
 void rcu_irq_exit(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-
 	lockdep_assert_irqs_disabled();
-	if (rdtp->dynticks_nmi_nesting == 1)
-		rcu_prepare_for_idle();
 	rcu_nmi_exit();
-	if (rdtp->dynticks_nmi_nesting == 0)
-		rcu_dynticks_task_enter();
 }
 
 /*
@@ -944,6 +943,11 @@ void rcu_nmi_enter(void)
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 		rcu_dynticks_eqs_exit();
 		incby = 1;
+
+		if (!in_nmi()) {
+			rcu_dynticks_task_exit();
+			rcu_cleanup_after_idle();
+		}
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdtp->dynticks_nmi_nesting,
@@ -977,14 +981,8 @@ void rcu_nmi_enter(void)
  */
 void rcu_irq_enter(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-
 	lockdep_assert_irqs_disabled();
-	if (rdtp->dynticks_nmi_nesting == 0)
-		rcu_dynticks_task_exit();
 	rcu_nmi_enter();
-	if (rdtp->dynticks_nmi_nesting == 1)
-		rcu_cleanup_after_idle();
 }
 
 /*
-- 
1.9.1

