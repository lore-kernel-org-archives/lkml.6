Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5559C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C7121529
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1ChsSeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C7121529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJKGhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKGhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:18 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4D9A2087A;
        Wed, 10 Oct 2018 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213176;
        bh=lSbdMQYGepXRPLhXM8b178k7nLvP5cclxAZisXNYq/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1ChsSeu4YrFOHu/lBHhsqeQjHKGSb/WmuckOV328uwOVYETaPOTATapqMZeq/n1L
         /+u8Jjd2FDLB9/CHcBH5ioA1yVsjVJkEgM0K+ySZPxTqnGRp+CIKZfrU0Yd1oHePJ0
         pk5UR0tlqmMpMdBLOyYK0DqMcCVItwuxKbIBBBqI=
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
Subject: [RFC PATCH 08/30] softirq: Move vectors bits to bottom_half.h
Date:   Thu, 11 Oct 2018 01:11:55 +0200
Message-Id: <1539213137-13953-9-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

Using the bottom-half masking APIs defined in linux/bottom-half.h won't
be possible without passing the relevant softirq vectors that are
currently defined in linux/interrupt.h

Yet we can't include linux/interrupt.h from linux/bottom-half.h due to
circular dependencies.

Now the vector bits belong to bottom halves anyway, so moving them there
is more natural and avoid nasty header dances.

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
 include/linux/bottom_half.h | 30 ++++++++++++++++++++++++++++++
 include/linux/interrupt.h   | 30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index a104f81..a9571ad 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,6 +4,36 @@
 
 #include <linux/preempt.h>
 
+/* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
+   frequency threaded job scheduling. For almost all the purposes
+   tasklets are more than enough. F.e. all serial device BHs et
+   al. should be converted to tasklets, not to softirqs.
+ */
+
+enum
+{
+	HI_SOFTIRQ=0,
+	TIMER_SOFTIRQ,
+	NET_TX_SOFTIRQ,
+	NET_RX_SOFTIRQ,
+	BLOCK_SOFTIRQ,
+	IRQ_POLL_SOFTIRQ,
+	TASKLET_SOFTIRQ,
+	SCHED_SOFTIRQ,
+	HRTIMER_SOFTIRQ, /* Unused, but kept as tools rely on the
+			    numbering. Sigh! */
+	RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */
+
+	NR_SOFTIRQS
+};
+
+#define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
+#define SOFTIRQ_ALL_MASK (BIT(NR_SOFTIRQS) - 1)
+
+#define SOFTIRQ_ENABLED_SHIFT 16
+#define SOFTIRQ_PENDING_MASK (BIT(SOFTIRQ_ENABLED_SHIFT) - 1)
+
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4882196..b4425e6 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -442,36 +442,6 @@ extern bool force_irqthreads;
 #define hard_irq_disable()	do { } while(0)
 #endif
 
-/* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
-   frequency threaded job scheduling. For almost all the purposes
-   tasklets are more than enough. F.e. all serial device BHs et
-   al. should be converted to tasklets, not to softirqs.
- */
-
-enum
-{
-	HI_SOFTIRQ=0,
-	TIMER_SOFTIRQ,
-	NET_TX_SOFTIRQ,
-	NET_RX_SOFTIRQ,
-	BLOCK_SOFTIRQ,
-	IRQ_POLL_SOFTIRQ,
-	TASKLET_SOFTIRQ,
-	SCHED_SOFTIRQ,
-	HRTIMER_SOFTIRQ, /* Unused, but kept as tools rely on the
-			    numbering. Sigh! */
-	RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */
-
-	NR_SOFTIRQS
-};
-
-#define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
-#define SOFTIRQ_ALL_MASK (BIT(NR_SOFTIRQS) - 1)
-
-#define SOFTIRQ_ENABLED_SHIFT 16
-#define SOFTIRQ_PENDING_MASK (BIT(SOFTIRQ_ENABLED_SHIFT) - 1)
-
-
 #ifndef local_softirq_data
 
 #ifndef local_softirq_data_ref
-- 
2.7.4

