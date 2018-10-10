Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB162C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8211C2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWh5I5RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8211C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeJKGiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeJKGiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:23 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E81B12075C;
        Wed, 10 Oct 2018 23:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213241;
        bh=I2AafpeYaUXl4kN5eeTd4hfwxbUvuIlODQlvFz//8yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWh5I5RJeK4SC49vQfWcW5uAvzRdeyxCKFviG4Zo2sJSYZnfMSb1AjOHEikByMhYO
         MsWEHxA4L853V7BWsptxEkfhsodo/iO64eZEHiM5B1bD1UlIGaovK5cJAQEinYbOmV
         lB3qRaPyfakGdVkt71rXMCrfF05v7RAD5CBIAALs=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 29/30] softirq: Make softirq processing softinterruptible
Date:   Thu, 11 Oct 2018 01:12:16 +0200
Message-Id: <1539213137-13953-30-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

Make do_softirq() re-entrant and allow a vector, being either processed
or disabled, to be interrupted by another vector. This way a vector
won't be able to monopolize the CPU for a long while at the expense of
the others that may rely on some predictable latency, especially on
softirq disabled sections that used to disable all vectors.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/softirq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 457bf60..f4cb1ea 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -195,7 +195,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt, unsigned int bh)
 	if (cnt)
 		preempt_count_sub(cnt - 1);
 
-	if (unlikely(!in_interrupt() && local_softirq_pending())) {
+	if (unlikely(!in_irq() && (local_softirq_pending() & local_softirq_enabled()))) {
 		/*
 		 * Run softirq if any pending. And do it in its own stack
 		 * as we may be calling this deep in a task call stack already.
@@ -387,7 +387,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
 	local_bh_exit();
-	WARN_ON_ONCE(in_interrupt());
+	WARN_ON_ONCE(in_irq());
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -396,12 +396,12 @@ asmlinkage __visible void do_softirq(void)
 	__u32 pending;
 	unsigned long flags;
 
-	if (in_interrupt())
+	if (in_irq())
 		return;
 
 	local_irq_save(flags);
 
-	pending = local_softirq_pending();
+	pending = local_softirq_pending() & local_softirq_enabled();
 
 	if (pending && !ksoftirqd_running(pending))
 		do_softirq_own_stack();
@@ -432,7 +432,7 @@ void irq_enter(void)
 
 static inline void invoke_softirq(void)
 {
-	if (ksoftirqd_running(local_softirq_pending()))
+	if (ksoftirqd_running(local_softirq_pending() & local_softirq_enabled()))
 		return;
 
 	if (!force_irqthreads) {
@@ -481,7 +481,7 @@ void irq_exit(void)
 #endif
 	account_irq_exit_time(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending())
+	if (!in_irq() && (local_softirq_pending() & local_softirq_enabled()))
 		invoke_softirq();
 
 	tick_irq_exit();
@@ -712,13 +712,13 @@ void __init softirq_init(void)
 
 static int ksoftirqd_should_run(unsigned int cpu)
 {
-	return local_softirq_pending();
+	return local_softirq_pending() & local_softirq_enabled();
 }
 
 static void run_ksoftirqd(unsigned int cpu)
 {
 	local_irq_disable();
-	if (local_softirq_pending()) {
+	if (local_softirq_pending() & local_softirq_enabled()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
-- 
2.7.4

