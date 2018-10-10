Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4ED2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQYsVGMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4ED2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJKGhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKGhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:00 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A572087A;
        Wed, 10 Oct 2018 23:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213158;
        bh=rIZXzx1XE7Ul2hvFjiFkTtZVVASdUWcUDZpoIVBxbxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQYsVGMAOpPJIg5sofVp/RrpZUmZR3CgkOO/MgcgsjeZiPwERphGS+n0ApdbuAikT
         nUTvq5jHhTZN5L9542ct1vzWYkn42EIQs7ibIh26ButhMHDFZHMgBxfGTJFytXMvR9
         b5EAM95gFQ7WztlxU5lIKDLD5X/QFY75rSoiWg4M=
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
Subject: [RFC PATCH 02/30] arch/softirq: Rename softirq_pending fields to softirq_data
Date:   Thu, 11 Oct 2018 01:11:49 +0200
Message-Id: <1539213137-13953-3-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to extend the softirq bits with an enabled vector mask.
Provide the field with a more generic name to later layout the pending
states on the lower bits and the enabled states on the higher bits.

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
 arch/arm/include/asm/hardirq.h      |  2 +-
 arch/arm64/include/asm/hardirq.h    |  2 +-
 arch/h8300/kernel/asm-offsets.c     |  2 +-
 arch/ia64/include/asm/hardirq.h     |  2 +-
 arch/ia64/include/asm/processor.h   |  2 +-
 arch/m68k/include/asm/hardirq.h     |  2 +-
 arch/m68k/kernel/asm-offsets.c      |  2 +-
 arch/parisc/include/asm/hardirq.h   |  2 +-
 arch/powerpc/include/asm/hardirq.h  |  2 +-
 arch/s390/include/asm/hardirq.h     |  6 +++---
 arch/sh/include/asm/hardirq.h       |  2 +-
 arch/sparc/include/asm/cpudata_64.h |  2 +-
 arch/sparc/include/asm/hardirq_64.h |  4 ++--
 arch/um/include/asm/hardirq.h       |  2 +-
 arch/x86/include/asm/hardirq.h      |  2 +-
 include/asm-generic/hardirq.h       |  2 +-
 include/linux/interrupt.h           | 10 +++++-----
 17 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index cba23ea..e5b06dd 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -9,7 +9,7 @@
 #define NR_IPI	7
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 #ifdef CONFIG_SMP
 	unsigned int ipi_irqs[NR_IPI];
 #endif
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 1473fc2..e9add887 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -23,7 +23,7 @@
 #define NR_IPI	7
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 	unsigned int ipi_irqs[NR_IPI];
 } ____cacheline_aligned irq_cpustat_t;
 
diff --git a/arch/h8300/kernel/asm-offsets.c b/arch/h8300/kernel/asm-offsets.c
index 85e6050..719d4cf 100644
--- a/arch/h8300/kernel/asm-offsets.c
+++ b/arch/h8300/kernel/asm-offsets.c
@@ -32,7 +32,7 @@ int main(void)
 
 	/* offsets into the irq_cpustat_t struct */
 	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t,
-						 __softirq_pending));
+						 __softirq_data));
 
 	/* offsets into the thread struct */
 	OFFSET(THREAD_KSP, thread_struct, ksp);
diff --git a/arch/ia64/include/asm/hardirq.h b/arch/ia64/include/asm/hardirq.h
index ccde7c2..004f609 100644
--- a/arch/ia64/include/asm/hardirq.h
+++ b/arch/ia64/include/asm/hardirq.h
@@ -13,7 +13,7 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define local_softirq_pending_ref	ia64_cpu_info.softirq_pending
+#define local_softirq_data_ref	ia64_cpu_info.softirq_data
 
 #include <linux/threads.h>
 #include <linux/irq.h>
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 10061ccf..ea29e19 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -188,7 +188,7 @@ union  ia64_rr {
  * state comes earlier:
  */
 struct cpuinfo_ia64 {
-	unsigned int softirq_pending;
+	unsigned int softirq_data;
 	unsigned long itm_delta;	/* # of clock cycles between clock ticks */
 	unsigned long itm_next;		/* interval timer mask value to use for next clock tick */
 	unsigned long nsec_per_cyc;	/* (1000000000<<IA64_NSEC_PER_CYC_SHIFT)/itc_freq */
diff --git a/arch/m68k/include/asm/hardirq.h b/arch/m68k/include/asm/hardirq.h
index 1179316..6ad364c 100644
--- a/arch/m68k/include/asm/hardirq.h
+++ b/arch/m68k/include/asm/hardirq.h
@@ -15,7 +15,7 @@ static inline void ack_bad_irq(unsigned int irq)
 
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff --git a/arch/m68k/kernel/asm-offsets.c b/arch/m68k/kernel/asm-offsets.c
index ccea355..93b6bea 100644
--- a/arch/m68k/kernel/asm-offsets.c
+++ b/arch/m68k/kernel/asm-offsets.c
@@ -64,7 +64,7 @@ int main(void)
 #endif
 
 	/* offsets into the irq_cpustat_t struct */
-	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_pending));
+	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_data));
 
 	/* signal defines */
 	DEFINE(LSIGSEGV, SIGSEGV);
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 1a1235a..28d8cee 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -17,7 +17,7 @@
 #endif
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 	unsigned int kernel_stack_usage;
 	unsigned int irq_stack_usage;
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index f1e9067..d3a896b 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/irq.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 	unsigned int timer_irqs_event;
 	unsigned int broadcast_irqs_event;
 	unsigned int timer_irqs_others;
diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index dfbc3c6c0..e26325f 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -13,9 +13,9 @@
 
 #include <asm/lowcore.h>
 
-#define local_softirq_pending() (S390_lowcore.softirq_pending)
-#define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
-#define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
+#define local_softirq_pending() (S390_lowcore.softirq_data)
+#define set_softirq_pending(x) (S390_lowcore.softirq_data = (x))
+#define or_softirq_pending(x)  (S390_lowcore.softirq_data |= (x))
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/arch/sh/include/asm/hardirq.h b/arch/sh/include/asm/hardirq.h
index edaea35..e364a63 100644
--- a/arch/sh/include/asm/hardirq.h
+++ b/arch/sh/include/asm/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/irq.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 	unsigned int __nmi_count;		/* arch dependent */
 } ____cacheline_aligned irq_cpustat_t;
 
diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 666d6b5..ff6d5f2 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -11,7 +11,7 @@
 
 typedef struct {
 	/* Dcache line 1 */
-	unsigned int	__softirq_pending; /* must be 1st, see rtrap.S */
+	unsigned int	__softirq_data; /* must be 1st, see rtrap.S */
 	unsigned int	__nmi_count;
 	unsigned long	clock_tick;	/* %tick's per second */
 	unsigned long	__pad;
diff --git a/arch/sparc/include/asm/hardirq_64.h b/arch/sparc/include/asm/hardirq_64.h
index 75b92bf..8ff0458 100644
--- a/arch/sparc/include/asm/hardirq_64.h
+++ b/arch/sparc/include/asm/hardirq_64.h
@@ -11,8 +11,8 @@
 
 #define __ARCH_IRQ_STAT
 
-#define local_softirq_pending_ref \
-	__cpu_data.__softirq_pending
+#define local_softirq_data_ref \
+	__cpu_data.__softirq_data
 
 void ack_bad_irq(unsigned int irq);
 
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index b426796..9684493 100644
--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/threads.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index a8e8e12..875f7de 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 	u8	     kvm_cpu_l1tf_flush_l1d;
 #endif
diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index d14214d..4ea87b5 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/threads.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index eeceac3..5888545 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -434,13 +434,13 @@ extern bool force_irqthreads;
 
 #ifndef local_softirq_pending
 
-#ifndef local_softirq_pending_ref
-#define local_softirq_pending_ref irq_stat.__softirq_pending
+#ifndef local_softirq_data_ref
+#define local_softirq_data_ref irq_stat.__softirq_data
 #endif
 
-#define local_softirq_pending()	(__this_cpu_read(local_softirq_pending_ref))
-#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_pending_ref, (x)))
-#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
+#define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
+#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
+#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
 
 #endif /* local_softirq_pending */
 
-- 
2.7.4

