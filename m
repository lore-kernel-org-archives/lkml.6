Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33EBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74421222B5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991752;
	bh=3gjAtMtyTIQpoF1VYJpJ3AwZQ9n5+VpScVt5FF0m5ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pylv4OI6c6JxHz71zk52nI+3sLbA4V+YTnEIIH8dA4e3SGF3klWj0G9kO0nSY2eGo
	 3iDcRAsect4OS07wuq0HPxS86s+fLnGlWCCHjddvJiB0ZZNM0sCZ6zdSNORopjMNSd
	 nc0xzv+m9Bt/tHJnYeifeHrEfYPxR6j5vRa1XCg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfBLRPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730287AbfBLRPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:48 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41FD5222AF;
        Tue, 12 Feb 2019 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991747;
        bh=3gjAtMtyTIQpoF1VYJpJ3AwZQ9n5+VpScVt5FF0m5ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXgWu2kGAh6LFBY9z1XDN+F3ZophtMkoNSK4EPZpTH83G/oKQ1scX95ZYB88amGeh
         157oAnZArLhT8YFxExrXM7P6hi21E4Wm8iotmqJ0MdBQyLRa0gPVtskxNmBrZ9ji5m
         OjP7sgz+JzTjVQpQHLzjXdIDUTWVYjFOnsnUPTiE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 24/32] softirq: Uninline !CONFIG_TRACE_IRQFLAGS __local_bh_disable_ip()
Date:   Tue, 12 Feb 2019 18:14:15 +0100
Message-Id: <20190212171423.8308-25-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common code between both versions of __local_bh_disable_ip(), whether
CONFIG_TRACE_IRQFLAGS is on or off, is going to grow up in order to
support vector masking granularity.

Merge these versions together to prepare for that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/bottom_half.h | 10 ----------
 kernel/softirq.c            | 10 ++++++----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 240419382978..ef9e4c752f56 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -28,17 +28,7 @@ enum
 
 #define SOFTIRQ_DATA_INIT (SOFTIRQ_ALL_MASK << SOFTIRQ_ENABLED_SHIFT)
 
-
-
-#ifdef CONFIG_TRACE_IRQFLAGS
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
-#else
-static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
-{
-	preempt_count_add(cnt);
-	barrier();
-}
-#endif
 
 static inline void local_bh_disable(void)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5fea9e299caf..91dee716e139 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -102,14 +102,14 @@ static bool ksoftirqd_running(unsigned long pending)
  * softirq and whether we just have bh disabled.
  */
 
-#ifdef CONFIG_TRACE_IRQFLAGS
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
+#ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned long flags;
 
-	WARN_ON_ONCE(in_irq());
-
 	raw_local_irq_save(flags);
+#endif
+	WARN_ON_ONCE(in_irq());
 	/*
 	 * The preempt tracer hooks into preempt_count_add and will break
 	 * lockdep because it calls back into lockdep after SOFTIRQ_OFFSET
@@ -123,7 +123,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 */
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_off(ip);
+
+#ifdef CONFIG_TRACE_IRQFLAGS
 	raw_local_irq_restore(flags);
+#endif
 
 	if (preempt_count() == cnt) {
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -133,7 +136,6 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
-#endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void __local_bh_enable_no_softirq(unsigned int cnt)
 {
-- 
2.17.1

