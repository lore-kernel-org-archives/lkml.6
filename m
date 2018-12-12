Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F3C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42132084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42132084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeLLQsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:48:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbeLLQsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:48:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945AE168F;
        Wed, 12 Dec 2018 08:48:13 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80F533F71D;
        Wed, 12 Dec 2018 08:48:11 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
Date:   Wed, 12 Dec 2018 16:47:11 +0000
Message-Id: <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
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
 arch/arm64/include/asm/efi.h      |   5 +-
 arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
 2 files changed, 99 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7ed3208..a9d3ebc 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -42,7 +42,10 @@
 
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
-#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+#define ARCH_EFI_IRQ_FLAGS_MASK						\
+	(system_uses_irq_prio_masking() ?				\
+		GIC_PRIO_IRQON :					\
+		(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT))
 
 /* arch specific definitions used by the stub code */
 
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

