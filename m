Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E403C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F00B222AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991740;
	bh=xOgvBCXzaH7ybmLstBKFutS/4zGWnUpOhDCJ3tn7XwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/TNBViC32zkq4BjQCciEIBBrE99Z4xjkx106Qoy7iQc/aCiK1jNlrXjPNKNOhD/H
	 E/zES8tx7pMREnnoArWEjR6zu9sqJ8vcAREJ+VWWjbFrrtWt8WIWn3+8mrz7KSYYgL
	 guW2HtnFBKy29wsMmbLa+U43loxBqBHxGXNi9q/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbfBLRPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbfBLRPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:36 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76EE3222A9;
        Tue, 12 Feb 2019 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991735;
        bh=xOgvBCXzaH7ybmLstBKFutS/4zGWnUpOhDCJ3tn7XwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEHUBpm2LdEmdNfcgYJGn7XMDFrljMk9mtXEdaSMqGD2ncpuiCfHv9NLukcQhpMRd
         SN+Cqc/U7/LSKm/1LitO+Fz1X3gYigtmoM0I80kTGF0erLqV6DUtgkrZfviIu02e/E
         wiJIyyENk0+7Qmvam36JynFxzSuVbkCo+F9YoWkw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 20/32] softirq: Move vectors bits to bottom_half.h
Date:   Tue, 12 Feb 2019 18:14:11 +0100
Message-Id: <20190212171423.8308-21-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
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
 include/linux/bottom_half.h | 24 ++++++++++++++++++++++++
 include/linux/interrupt.h   | 21 ---------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index a104f815efcf..39aaf9189226 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,6 +4,30 @@
 
 #include <linux/preempt.h>
 
+
+/*
+ * PLEASE, avoid to allocate new softirqs, if you need not _really_ high
+ * frequency threaded job scheduling. For almost all the purposes
+ * tasklets are more than enough. F.e. all serial device BHs et
+ * al. should be converted to tasklets, not to softirqs.
+ */
+enum
+{
+#define SOFTIRQ_VECTOR(__SVEC) \
+	__SVEC##_SOFTIRQ,
+#include <linux/softirq_vector.h>
+#undef SOFTIRQ_VECTOR
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
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1a08fb0e4781..346fb1e8e55b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -457,27 +457,6 @@ extern bool force_irqthreads;
 #define hard_irq_disable()	do { } while(0)
 #endif
 
-/* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
-   frequency threaded job scheduling. For almost all the purposes
-   tasklets are more than enough. F.e. all serial device BHs et
-   al. should be converted to tasklets, not to softirqs.
- */
-enum
-{
-#define SOFTIRQ_VECTOR(__SVEC) \
-	__SVEC##_SOFTIRQ,
-#include <linux/softirq_vector.h>
-#undef SOFTIRQ_VECTOR
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
2.17.1

