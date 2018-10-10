Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC94C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48D22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPZUWA/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48D22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJKGhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeJKGhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:14 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE0D520870;
        Wed, 10 Oct 2018 23:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213173;
        bh=wq8jlGbzuZwQ2vItzn9jv3vCxHZh9o02e8GUGKlKN9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPZUWA/etbEroUmHL4aqINYaXw2eJc3r+CiKFMED4z0Zmf0T1eJq0LU3QT2wMbx/S
         KFn3U3UUd6mQR5mnxGQDqCoNlFtWZlbwMWooTa7UyTd4s8QQGki+ORUIIzp7xDhjEx
         MPXc/PvD/Dr6i7jFqFg5YimH5la+JuwPYzjGww/g=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 07/30] softirq: Rename _local_bh_enable() to local_bh_enable_no_softirq()
Date:   Thu, 11 Oct 2018 01:11:54 +0200
Message-Id: <1539213137-13953-8-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
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
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/s390/lib/delay.c       | 2 +-
 drivers/s390/char/sclp.c    | 2 +-
 drivers/s390/cio/cio.c      | 2 +-
 include/linux/bottom_half.h | 2 +-
 kernel/softirq.c            | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index d4aa1079..3f83ee9 100644
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
index e9aa71c..6c6b745 100644
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
index de744ca..e3fb83b 100644
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
index a19519f..a104f81 100644
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
index 288e007..fdb2574 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -156,12 +156,12 @@ static void __local_bh_enable(unsigned int cnt)
  * Special-case - softirqs can safely be enabled by __do_softirq(),
  * without processing still-pending softirqs:
  */
-void _local_bh_enable(void)
+void local_bh_enable_no_softirq(void)
 {
 	WARN_ON_ONCE(in_irq());
 	__local_bh_enable(SOFTIRQ_DISABLE_OFFSET);
 }
-EXPORT_SYMBOL(_local_bh_enable);
+EXPORT_SYMBOL(local_bh_enable_no_softirq);
 
 void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 {
@@ -351,7 +351,7 @@ void irq_enter(void)
 		 */
 		local_bh_disable();
 		tick_irq_enter();
-		_local_bh_enable();
+		local_bh_enable_no_softirq();
 	}
 
 	__irq_enter();
-- 
2.7.4

