Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A07C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6571206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfAHOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:08:31 -0500
Received: from foss.arm.com ([217.140.101.70]:52282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbfAHOI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA8DB19BF;
        Tue,  8 Jan 2019 06:08:25 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3C133F70D;
        Tue,  8 Jan 2019 06:08:23 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
Date:   Tue,  8 Jan 2019 14:07:30 +0000
Message-Id: <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead disabling interrupts by setting the PSR.I bit, use a priority
higher than the one used for interrupts to mask them via PMR.

When using PMR to disable interrupts, the value of PMR will be used
instead of PSR.[DAIF] for the irqflags.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 arch/arm64/include/asm/efi.h      |  11 ++++
 arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
 2 files changed, 106 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7ed3208..134ff6e 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -44,6 +44,17 @@
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
+#define arch_efi_save_flags(state_flags)		\
+	do {						\
+		(state_flags) =	read_sysreg(daif);	\
+	} while (0)
+
+#define arch_efi_restore_flags(state_flags)		\
+	do {						\
+		write_sysreg(state_flags, daif);	\
+	} while (0)
+
+
 /* arch specific definitions used by the stub code */
 
 /*
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 24692ed..fa3b06f 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,7 +18,9 @@
 
 #ifdef __KERNEL__
 
+#include <asm/alternative.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 
 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
@@ -36,47 +38,96 @@
 /*
  * CPU interrupt mask handling.
  */
-static inline unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_irq_save\n"
-		"msr	daifset, #2"
-		: "=r" (flags)
-		:
-		: "memory");
-	return flags;
-}
-
 static inline void arch_local_irq_enable(void)
 {
-	asm volatile(
-		"msr	daifclr, #2		// arch_local_irq_enable"
-		:
+	unsigned long unmasked = GIC_PRIO_IRQON;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifclr, #2		// arch_local_irq_enable\n"
+		"nop",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
+		"dsb	sy",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (unmasked)
 		: "memory");
 }
 
 static inline void arch_local_irq_disable(void)
 {
-	asm volatile(
-		"msr	daifset, #2		// arch_local_irq_disable"
-		:
+	unsigned long masked = GIC_PRIO_IRQOFF;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (masked)
 		: "memory");
 }
 
 /*
+ * Having two ways to control interrupt status is a bit complicated. Some
+ * locations like exception entries will have PSR.I bit set by the architecture
+ * while PMR is unmasked.
+ * We need the irqflags to represent that interrupts are disabled in such cases.
+ *
+ * For this, we lower the value read from PMR when the I bit is set so it is
+ * considered as an irq masking priority. (With PMR, lower value means masking
+ * more interrupts).
+ */
+#define _get_irqflags(daif_bits, pmr)					\
+({									\
+	unsigned long flags;						\
+									\
+	BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));	\
+	asm volatile(ALTERNATIVE(					\
+		"mov	%0, %1\n"					\
+		"nop\n"							\
+		"nop",							\
+		"and	%0, %1, #" __stringify(PSR_I_BIT) "\n"		\
+		"mvn	%0, %0\n"					\
+		"and	%0, %0, %2",					\
+		ARM64_HAS_IRQ_PRIO_MASKING)				\
+		: "=&r" (flags)						\
+		: "r" (daif_bits), "r" (pmr)				\
+		: "memory");						\
+									\
+	flags;								\
+})
+
+/*
  * Save the current interrupt enable state.
  */
 static inline unsigned long arch_local_save_flags(void)
 {
-	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_save_flags"
-		: "=r" (flags)
+	unsigned long daif_bits;
+	unsigned long pmr; // Only used if alternative is on
+
+	daif_bits = read_sysreg(daif);
+
+	// Get PMR
+	asm volatile(ALTERNATIVE(
+			"nop",
+			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),
+			ARM64_HAS_IRQ_PRIO_MASKING)
+		: "=&r" (pmr)
 		:
 		: "memory");
+
+	return _get_irqflags(daif_bits, pmr);
+}
+
+#undef _get_irqflags
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+
+	flags = arch_local_save_flags();
+
+	arch_local_irq_disable();
+
 	return flags;
 }
 
@@ -85,16 +136,32 @@ static inline unsigned long arch_local_save_flags(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	asm volatile(
-		"msr	daif, %0		// arch_local_irq_restore"
-	:
-	: "r" (flags)
-	: "memory");
+	asm volatile(ALTERNATIVE(
+			"msr	daif, %0\n"
+			"nop",
+			"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %0\n"
+			"dsb	sy",
+			ARM64_HAS_IRQ_PRIO_MASKING)
+		: "+r" (flags)
+		:
+		: "memory");
 }
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags & PSR_I_BIT;
+	int res;
+
+	asm volatile(ALTERNATIVE(
+			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
+			"nop",
+			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
+			"cset	%w0, ls",
+			ARM64_HAS_IRQ_PRIO_MASKING)
+		: "=&r" (res)
+		: "r" ((int) flags)
+		: "memory");
+
+	return res;
 }
 #endif
 #endif
-- 
1.9.1

