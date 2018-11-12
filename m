Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D25C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCAB22443
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCAB22443
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeKLVuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:50:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34618 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbeKLVup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:50:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60DFE15AB;
        Mon, 12 Nov 2018 03:57:49 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 716263F71F;
        Mon, 12 Nov 2018 03:57:47 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v6 10/24] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
Date:   Mon, 12 Nov 2018 11:57:01 +0000
Message-Id: <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead disabling interrupts by setting the PSR.I bit, use a priority
higher than the one used for interrupts to mask them via PMR.

The value chosen for PMR to enable/disable interrupts encodes the status
of interrupts on a single bit. This information is stored in the irqflags
values used when saving/restoring IRQ status.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 arch/arm64/include/asm/efi.h      |   3 +-
 arch/arm64/include/asm/irqflags.h | 132 +++++++++++++++++++++++++++++---------
 2 files changed, 105 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7ed3208..3e06891 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -42,7 +42,8 @@
 
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
-#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+#define ARCH_EFI_IRQ_FLAGS_MASK \
+	(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | ARCH_FLAG_PMR_EN)
 
 /* arch specific definitions used by the stub code */
 
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 24692ed..e0a32e4 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,7 +18,27 @@
 
 #ifdef __KERNEL__
 
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
+
+
+/*
+ * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
+ * whether the normal interrupts are masked is kept along with the daif
+ * flags.
+ */
+#define ARCH_FLAG_PMR_EN 0x1
+
+#define MAKE_ARCH_FLAGS(daif, pmr)					\
+	((daif) | (((pmr) >> GIC_PRIO_STATUS_SHIFT) & ARCH_FLAG_PMR_EN))
+
+#define ARCH_FLAGS_GET_PMR(flags)				 \
+	((((flags) & ARCH_FLAG_PMR_EN) << GIC_PRIO_STATUS_SHIFT) \
+		| GIC_PRIO_IRQOFF)
+
+#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
 
 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
@@ -34,35 +54,62 @@
  */
 
 /*
- * CPU interrupt mask handling.
+ * Local definitions to help us manage between PMR and daif
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
+#define _save_daif(dest)						\
+	asm volatile("mrs	%0, daif" : "=&r" (dest) : : "memory")
+
+#define _restore_daif(daif)						\
+	asm volatile("msr	daif, %0" : : "r" (daif) : "memory")
 
+#define _save_pmr(dest)							\
+	asm volatile(ALTERNATIVE(					\
+		     "mov	%0, #" __stringify(GIC_PRIO_IRQON),	\
+		     "mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),	\
+		     ARM64_HAS_IRQ_PRIO_MASKING)			\
+		: "=&r" (dest)						\
+		:							\
+		: "memory")
+
+#define _restore_pmr(pmr)						\
+	asm volatile(ALTERNATIVE(					\
+		     "nop\n"						\
+		     "nop",						\
+		     "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"	\
+		     "dsb	sy",					\
+		     ARM64_HAS_IRQ_PRIO_MASKING)			\
+		:							\
+		: "r" (pmr)						\
+		: "memory")
+
+/*
+ * CPU interrupt mask handling.
+ */
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
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (masked)
 		: "memory");
 }
 
@@ -71,12 +118,24 @@ static inline void arch_local_irq_disable(void)
  */
 static inline unsigned long arch_local_save_flags(void)
 {
+	unsigned long daif_flags;
+	unsigned long pmr;
+
+	_save_daif(daif_flags);
+
+	_save_pmr(pmr);
+
+	return MAKE_ARCH_FLAGS(daif_flags, pmr);
+}
+
+static inline unsigned long arch_local_irq_save(void)
+{
 	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_save_flags"
-		: "=r" (flags)
-		:
-		: "memory");
+
+	flags = arch_local_save_flags();
+
+	arch_local_irq_disable();
+
 	return flags;
 }
 
@@ -85,16 +144,31 @@ static inline unsigned long arch_local_save_flags(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	asm volatile(
-		"msr	daif, %0		// arch_local_irq_restore"
-	:
-	: "r" (flags)
-	: "memory");
+	unsigned long pmr = ARCH_FLAGS_GET_PMR(flags);
+
+	flags = ARCH_FLAGS_GET_DAIF(flags);
+
+	/*
+	 * Code switching from PSR.I interrupt disabling to PMR masking
+	 * should not lie between consecutive calls to local_irq_save()
+	 * and local_irq_restore() in the same context.
+	 * So restoring PMR and then the daif flags should be safe.
+	 */
+	_restore_pmr(pmr);
+
+	_restore_daif(flags);
 }
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags & PSR_I_BIT;
+	return (ARCH_FLAGS_GET_DAIF(flags) & (PSR_I_BIT)) |
+		!(ARCH_FLAGS_GET_PMR(flags) & GIC_PRIO_STATUS_BIT);
 }
+
+#undef _save_daif
+#undef _restore_daif
+#undef _save_pmr
+#undef _restore_pmr
+
 #endif
 #endif
-- 
1.9.1

