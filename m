Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF2AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99112222A4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991723;
	bh=mZnmlZinM1NjjgBZBrDwV7xrihyqFQd6B3kP4me26XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eAYICvswQrS5UA5BrlFNY/gOcwwRoJS7OQSxojFnnm9h3I0I+YbOosZC0LyCc4oXK
	 6fYDk8YQt9+m8zmi/pk2cvuA8MTp5d5O6XK+CarG5/P82ik+SvLhwwD7WkyrYZ6MfJ
	 342oREt70CC9Vx53iJfM3gYR/Wdc7AsbtKq5T5HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbfBLRPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbfBLRPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:19 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2551F2229E;
        Tue, 12 Feb 2019 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991718;
        bh=mZnmlZinM1NjjgBZBrDwV7xrihyqFQd6B3kP4me26XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7T3gb5nPRxU7Tj2F/e0Q5+JFlmurnYQ4exZs0mZgBYKd7rbaJ2ARV5hJ5kH+H+Zq
         RLqm+Rv6jZE07gcWBZX8yNWDgnP1dygTTjz/jeHsMpJ+6JenKoOVcOF2QNcCE8C/ev
         IZyt0FvZA0shbyILYytVMyyG4i3SCB0d4EGEY0KM=
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
Subject: [PATCH 15/32] arch/softirq: Rename softirq_pending fields to softirq_data
Date:   Tue, 12 Feb 2019 18:14:06 +0100
Message-Id: <20190212171423.8308-16-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to extend the softirq bits with an enabled vector mask.
Provide the field with a more generic name to later layout the pending
states on the lower bits and the enabled states on the higher bits.

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
index cba23eaa6072..e5b06dd41b88 100644
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
index 1473fc2f7ab7..e9add887e2f2 100644
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
index 85e60509f0a8..719d4cff704e 100644
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
index ccde7c2ba00f..004f6093a11a 100644
--- a/arch/ia64/include/asm/hardirq.h
+++ b/arch/ia64/include/asm/hardirq.h
@@ -13,7 +13,7 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define local_softirq_pending_ref	ia64_cpu_info.softirq_pending
+#define local_softirq_data_ref	ia64_cpu_info.softirq_data
 
 #include <linux/threads.h>
 #include <linux/irq.h>
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index c91ef98ed6bf..72a70c42b701 100644
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
index 11793165445d..6ad364cc3799 100644
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
index ccea355052ef..93b6bea52c8b 100644
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
index 1a1235a9d533..28d8ceeab077 100644
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
index f1e9067bd5ac..d3a896b402da 100644
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
index dfbc3c6c0674..e26325fe287d 100644
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
index edaea3559a23..e364a63babd3 100644
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
index 9c3fc03abe9a..9e52c6bf69b9 100644
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
index 75b92bfe04b5..8ff0458870e1 100644
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
index b426796d26fd..96844938b92e 100644
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
index a8e8e126b421..875f7de3b65b 100644
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
index d14214dfc10b..4ea87b50a257 100644
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
index e871f361f1f1..a32bdd9bb103 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -449,13 +449,13 @@ extern bool force_irqthreads;
 
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
2.17.1

