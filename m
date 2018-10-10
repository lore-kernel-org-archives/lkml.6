Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37111C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D723E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo3X619o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D723E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJKGhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbeJKGhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:12 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDD042151C;
        Wed, 10 Oct 2018 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213170;
        bh=QqXfPRI82GWTDjXZ/0NDcLN3fUbuBeUQMm2D+zJBesk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yo3X619oVWtp8WTQ/vxDX04QvZHtZI4HlE91J09wLbE6Xv1EAqbKRvvJC2ocOm/Qk
         855EIzA8VZkMezu1LFIjo1aLxmYcgNSEEZHG+Y+UqPP33K1hcgFRFfQ2oqIhyIZbpV
         oU3lJR8OKZXDJkKhVQj+XHRkuFsqfgh1whGuFu+w=
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
Subject: [RFC PATCH 06/30] softirq: Introduce disabled softirq vectors bits
Date:   Thu, 11 Oct 2018 01:11:53 +0200
Message-Id: <1539213137-13953-7-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
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
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/s390/include/asm/hardirq.h |  7 +++++-
 include/linux/interrupt.h       | 54 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index 84ad789..5a6c5c7 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -13,7 +13,12 @@
 
 #include <asm/lowcore.h>
 
-#define local_softirq_pending() (S390_lowcore.softirq_data)
+#define local_softirq_data() (S390_lowcore.softirq_data)
+#define local_softirq_pending() (local_softirq_data() & SOFTIRQ_PENDING_MASK)
+#define local_softirq_disabled() (local_softirq_data() & ~SOFTIRQ_PENDING_MASK)
+#define softirq_enabled_nand(x) (S390_lowcore.softirq_data &= ~((x) << SOFTIRQ_ENABLED_SHIFT))
+#define softirq_pending_or(x) (S390_lowcore.softirq_data |= ((x) << SOFTIRQ_ENABLED_SHIFT))
+#define softirq_pending_set(x) (S390_lowcore.softirq_data = ((x) << SOFTIRQ_ENABLED_SHIFT))
 #define softirq_pending_nand(x) (S390_lowcore.softirq_data &= ~(x))
 #define softirq_pending_or(x)  (S390_lowcore.softirq_data |= (x))
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a577a54..4882196 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -468,19 +468,63 @@ enum
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
-#define softirq_pending_nand(x)	(__this_cpu_and(local_softirq_data_ref, ~(x)))
-#define softirq_pending_or(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
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
+static inline void softirq_enabled_nand(unsigned int enabled)
+{
+	enabled <<= SOFTIRQ_ENABLED_SHIFT;
+	__this_cpu_and(local_softirq_data_ref, ~enabled);
+}
+
+static inline void softirq_enabled_or(unsigned int enabled)
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
+static inline void softirq_pending_nand(unsigned int pending)
+{
+	__this_cpu_and(local_softirq_data_ref, ~pending);
+}
+
+static inline void softirq_pending_or(unsigned int pending)
+{
+	__this_cpu_or(local_softirq_data_ref, pending);
+}
 #endif /* local_softirq_pending */
 
-
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
  */
-- 
2.7.4

