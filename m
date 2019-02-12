Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1045C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AB9222AB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991734;
	bh=O6ln6NhnDId73YVWTrLXgXCOfvOeGlPM7cP9NkHbaxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nAX3B7KwKZEYdkuhUPrC/gt8Gxq5c6iWGkBP7bpq+hxwgdCDHjTgsXTQXO+KJsiXh
	 NRNlQqKT5w4UYyDomWnsuwO3mpmPA/iLz2qfa+kly4VQb1IrlJ4mQFcUtEaUeY4uQh
	 hd/Qcpv7sn3l5NOlWJ9C6oHSsPruTko6v5VgElzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbfBLRPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbfBLRP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:29 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE9C4222A5;
        Tue, 12 Feb 2019 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991728;
        bh=O6ln6NhnDId73YVWTrLXgXCOfvOeGlPM7cP9NkHbaxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1hrl8eeKno7wGuitGC4FtFj4FJKIKPhCfLt/+BGr0T//SrIoO5+xHYnGcrtsrmaum
         E1jDglt8KuyuFdrzgDEe7g8g5aUq3l7F3g8rjKqFOtZ2/1JYiaG51TlpA4+k2bs2C3
         ufdXP+4HsYKN2OQl89Q55eMBLalXCOYMPW62t3Ks=
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
Subject: [PATCH 18/32] softirq: Introduce disabled softirq vectors bits
Date:   Tue, 12 Feb 2019 18:14:09 +0100
Message-Id: <20190212171423.8308-19-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling the softirqs is currently an all-or-nothing operation: either
all softirqs are enabled or none of them. However we plan to introduce a
per vector granularity of this ability to improve latency response and
make each softirq vector interruptible by the others.

The first step carried here is to provide the necessary APIs to control
the per-vector enable bits.

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
 arch/s390/include/asm/hardirq.h |  9 ++++--
 include/linux/interrupt.h       | 53 ++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index 54e81f520175..377fd4184f86 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -13,9 +13,14 @@
 
 #include <asm/lowcore.h>
 
-#define local_softirq_pending() (S390_lowcore.softirq_data)
-#define softirq_pending_clear_mask(x) (S390_lowcore.softirq_data &= ~(x))
+#define local_softirq_data() (S390_lowcore.softirq_data)
+#define local_softirq_pending() (local_softirq_data() & SOFTIRQ_PENDING_MASK)
+#define local_softirq_disabled() (local_softirq_data() & ~SOFTIRQ_PENDING_MASK)
+#define softirq_enabled_set_mask(x) (S390_lowcore.softirq_data |= ((x) << SOFTIRQ_ENABLED_SHIFT))
+#define softirq_enabled_clear_mask(x) (S390_lowcore.softirq_data &= ~((x) << SOFTIRQ_ENABLED_SHIFT))
+#define softirq_enabled_set(x) (S390_lowcore.softirq_data = ((x) << SOFTIRQ_ENABLED_SHIFT))
 #define softirq_pending_set_mask(x)  (S390_lowcore.softirq_data |= (x))
+#define softirq_pending_clear_mask(x) (S390_lowcore.softirq_data &= ~(x))
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c402770ae45b..1a08fb0e4781 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -474,16 +474,61 @@ enum
 #define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
 #define SOFTIRQ_ALL_MASK (BIT(NR_SOFTIRQS) - 1)
 
-#ifndef local_softirq_pending
+#define SOFTIRQ_ENABLED_SHIFT 16
+#define SOFTIRQ_PENDING_MASK (BIT(SOFTIRQ_ENABLED_SHIFT) - 1)
+
+
+#ifndef local_softirq_data
 
 #ifndef local_softirq_data_ref
 #define local_softirq_data_ref irq_stat.__softirq_data
 #endif
 
-#define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
-#define softirq_pending_clear_mask(x)	(__this_cpu_and(local_softirq_data_ref, ~(x)))
-#define softirq_pending_set_mask(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
+static inline unsigned int local_softirq_data(void)
+{
+	return __this_cpu_read(local_softirq_data_ref);
+}
 
+static inline unsigned int local_softirq_enabled(void)
+{
+	return local_softirq_data() >> SOFTIRQ_ENABLED_SHIFT;
+}
+
+static inline unsigned int local_softirq_pending(void)
+{
+	return local_softirq_data() & SOFTIRQ_PENDING_MASK;
+}
+
+static inline void softirq_enabled_clear_mask(unsigned int enabled)
+{
+	enabled <<= SOFTIRQ_ENABLED_SHIFT;
+	__this_cpu_and(local_softirq_data_ref, ~enabled);
+}
+
+static inline void softirq_enabled_set_mask(unsigned int enabled)
+{
+	enabled <<= SOFTIRQ_ENABLED_SHIFT;
+	__this_cpu_or(local_softirq_data_ref, enabled);
+}
+
+static inline void softirq_enabled_set(unsigned int enabled)
+{
+	unsigned int data;
+
+	data = enabled << SOFTIRQ_ENABLED_SHIFT;
+	data |= local_softirq_pending();
+	__this_cpu_write(local_softirq_data_ref, data);
+}
+
+static inline void softirq_pending_clear_mask(unsigned int pending)
+{
+	__this_cpu_and(local_softirq_data_ref, ~pending);
+}
+
+static inline void softirq_pending_set_mask(unsigned int pending)
+{
+	__this_cpu_or(local_softirq_data_ref, pending);
+}
 #endif /* local_softirq_pending */
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
-- 
2.17.1

