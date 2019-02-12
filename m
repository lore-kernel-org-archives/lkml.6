Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33719C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED35C222AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991737;
	bh=MiLqOzr/GmjbggE9JgAj+pL3uB0Tu6jPeBNrqQh0Cvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UuW8kRK0/LVw2S1Q+0Zq8PtYpYYGCcp0M4VPTQNXBOu8vQJjed9gJ1MgPbTMghs6i
	 WKvq8/wrsRM+IYC5OhvQkGC2o07dpltFYe2P/E7LxLpopwZ4hNwnUoGsV1HVpCvnwt
	 HaqBZLusFZEgCYcPqDYCtn5JzkLBwgQfZ0bcF4K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfBLRPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731570AbfBLRPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:33 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB585222A7;
        Tue, 12 Feb 2019 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991732;
        bh=MiLqOzr/GmjbggE9JgAj+pL3uB0Tu6jPeBNrqQh0Cvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1XtQBZ9CxyvY3ohklC+3bT6wM1rCWUimhXlObw7E83b/slO/8PmVZE0qDAoFJaCDb
         nPB1pMzujgz84Bk5cNWGbQwcs9xtW+arv5HBta93NP5S5PWUGv3Li85iry36AJ70vV
         UqZrAWwR1dke3Z5lFqfvre5q6e7YPM+PD2x5PZtw=
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
Subject: [PATCH 19/32] softirq: Rename _local_bh_enable() to local_bh_enable_no_softirq()
Date:   Tue, 12 Feb 2019 18:14:10 +0100
Message-Id: <20190212171423.8308-20-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bottom half masking APIs have become interestingly confusing with all
these flavours:

		local_bh_enable()
		_local_bh_enable()
		local_bh_enable_ip()
		__local_bh_enable_ip()

_local_bh_enable() is an exception here because it's the only version
that won't execute do_softirq() in the end.

Clarify this straight in the name. It may help reviewers who are already
familiar with functions such as preempt_enable_no_resched().

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
 arch/s390/lib/delay.c       |  2 +-
 drivers/s390/char/sclp.c    |  2 +-
 drivers/s390/cio/cio.c      |  2 +-
 include/linux/bottom_half.h |  2 +-
 kernel/softirq.c            | 12 ++++++------
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index d4aa10795605..3f83ee9446b7 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -91,7 +91,7 @@ void __udelay(unsigned long long usecs)
 	if (raw_irqs_disabled_flags(flags)) {
 		local_bh_disable();
 		__udelay_disabled(usecs);
-		_local_bh_enable();
+		local_bh_enable_no_softirq();
 		goto out;
 	}
 	__udelay_enabled(usecs);
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index e9aa71cdfc44..6c6b7456b368 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -572,7 +572,7 @@ sclp_sync_wait(void)
 	local_irq_disable();
 	__ctl_load(cr0, 0, 0);
 	if (!irq_context)
-		_local_bh_enable();
+		local_bh_enable_no_softirq();
 	local_tick_enable(old_tick);
 	local_irq_restore(flags);
 }
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index de744ca158fd..e3fb83b3c6c1 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -607,7 +607,7 @@ void cio_tsch(struct subchannel *sch)
 		inc_irq_stat(IRQIO_CIO);
 	if (!irq_context) {
 		irq_exit();
-		_local_bh_enable();
+		local_bh_enable_no_softirq();
 	}
 }
 
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index a19519f4241d..a104f815efcf 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -19,7 +19,7 @@ static inline void local_bh_disable(void)
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
-extern void _local_bh_enable(void);
+extern void local_bh_enable_no_softirq(void);
 extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
 static inline void local_bh_enable_ip(unsigned long ip)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5f167fc43ab9..d305b4c8d1a7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -139,7 +139,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 EXPORT_SYMBOL(__local_bh_disable_ip);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-static void __local_bh_enable(unsigned int cnt)
+static void __local_bh_enable_no_softirq(unsigned int cnt)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -156,12 +156,12 @@ static void __local_bh_enable(unsigned int cnt)
  * Special-case - softirqs can safely be enabled by __do_softirq(),
  * without processing still-pending softirqs:
  */
-void _local_bh_enable(void)
+void local_bh_enable_no_softirq(void)
 {
 	WARN_ON_ONCE(in_irq());
-	__local_bh_enable(SOFTIRQ_DISABLE_OFFSET);
+	__local_bh_enable_no_softirq(SOFTIRQ_DISABLE_OFFSET);
 }
-EXPORT_SYMBOL(_local_bh_enable);
+EXPORT_SYMBOL(local_bh_enable_no_softirq);
 
 void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 {
@@ -316,7 +316,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
-	__local_bh_enable(SOFTIRQ_OFFSET);
+	__local_bh_enable_no_softirq(SOFTIRQ_OFFSET);
 	WARN_ON_ONCE(in_interrupt());
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
@@ -352,7 +352,7 @@ void irq_enter(void)
 		 */
 		local_bh_disable();
 		tick_irq_enter();
-		_local_bh_enable();
+		local_bh_enable_no_softirq();
 	}
 
 	__irq_enter();
-- 
2.17.1

