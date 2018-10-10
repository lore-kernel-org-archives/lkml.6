Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F34FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FA121527
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB8zAQgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FA121527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJKGiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeJKGiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:08 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E8721470;
        Wed, 10 Oct 2018 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213226;
        bh=u/ULlzZ4sRDGjTwsVTdpAfyTIEqe6zHqN3B0FBkUYH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YB8zAQgdApReL/1MTmd5jTqi0CpGG/nsWTkSDk75ZydtQJzFM/BKmcr2en1p5b0yh
         6XDBkkk10+uAOPyCs85JUVJ/0YL8zUxcqcrpc0NQ6/F2QGcTjJac+oI9XBLY5Zy0GD
         i485AkM/hEwgoLdxBduY4papUJK7f3UfpInJkeRA=
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
Subject: [RFC PATCH 24/30] softirq: Introduce Local_bh_enter/exit()
Date:   Thu, 11 Oct 2018 01:12:11 +0200
Message-Id: <1539213137-13953-25-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

So far, the state of handling the disablement of softirqs and processing
their callbacks have been handled the same: increment the softirq offset,
trace softirqs off, preempt off, etc...

The only difference remains in the way the preempt count is incremented:
by 1 for softirq processing (can't nest as softirqs processing aren't
re-entrant) and by 2 for softirq disablement (can nest).

Now their behaviour is going to drift entirely. Softirq processing will
need to be reentrant and accept stacking SOFTIRQ_OFFSET increments.
OTOH softirq disablement will be driven by the vector enabled mask and
toggled only once any vector get disabled.

Maintaining both behaviours under the same handler is going to be messy,
so move the preempt count related code on softirq processing to its own
handlers.

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
 kernel/softirq.c | 74 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index ae9e29f..22cc0a7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -139,19 +139,6 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 EXPORT_SYMBOL(__local_bh_disable_ip);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-static void __local_bh_enable(unsigned int cnt)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (preempt_count() == cnt)
-		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
-
-	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		trace_softirqs_on(_RET_IP_);
-
-	__preempt_count_sub(cnt);
-}
-
 /*
  * Special-case - softirqs can safely be enabled by __do_softirq(),
  * without processing still-pending softirqs:
@@ -159,7 +146,16 @@ static void __local_bh_enable(unsigned int cnt)
 void local_bh_enable_no_softirq(void)
 {
 	WARN_ON_ONCE(in_irq());
-	__local_bh_enable(SOFTIRQ_DISABLE_OFFSET);
+	lockdep_assert_irqs_disabled();
+
+	if (preempt_count() == SOFTIRQ_DISABLE_OFFSET)
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+
+	if (softirq_count() == SOFTIRQ_DISABLE_OFFSET)
+		trace_softirqs_on(_RET_IP_);
+
+	__preempt_count_sub(SOFTIRQ_DISABLE_OFFSET);
+
 }
 EXPORT_SYMBOL(local_bh_enable_no_softirq);
 
@@ -207,6 +203,52 @@ void local_bh_enable_all(void)
 	local_bh_enable(SOFTIRQ_ALL_MASK);
 }
 
+static void local_bh_enter(unsigned long ip)
+{
+	unsigned long flags;
+
+	WARN_ON_ONCE(in_irq());
+
+	raw_local_irq_save(flags);
+	/*
+	 * The preempt tracer hooks into preempt_count_add and will break
+	 * lockdep because it calls back into lockdep after SOFTIRQ_OFFSET
+	 * is set and before current->softirq_enabled is cleared.
+	 * We must manually increment preempt_count here and manually
+	 * call the trace_preempt_off later.
+	 */
+	__preempt_count_add(SOFTIRQ_OFFSET);
+	/*
+	 * Were softirqs turned off above:
+	 */
+	if (softirq_count() == SOFTIRQ_OFFSET)
+		trace_softirqs_off(ip);
+	raw_local_irq_restore(flags);
+
+	if (preempt_count() == SOFTIRQ_OFFSET) {
+#ifdef CONFIG_DEBUG_PREEMPT
+		current->preempt_disable_ip = get_lock_parent_ip();
+#endif
+		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
+	}
+}
+
+static void local_bh_exit(void)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (preempt_count() == SOFTIRQ_OFFSET)
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+
+	if (softirq_count() == SOFTIRQ_OFFSET)
+		trace_softirqs_on(_RET_IP_);
+
+	__preempt_count_sub(SOFTIRQ_OFFSET);
+}
+
+
+
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -276,7 +318,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	pending = local_softirq_pending() & local_softirq_enabled();
 	account_irq_enter_time(current);
 
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	local_bh_enter(_RET_IP_);
 	in_hardirq = lockdep_softirq_start();
 
 restart:
@@ -325,7 +367,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
-	__local_bh_enable(SOFTIRQ_OFFSET);
+	local_bh_exit();
 	WARN_ON_ONCE(in_interrupt());
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
-- 
2.7.4

