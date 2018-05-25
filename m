Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966224AbeEYJus (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57614 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966147AbeEYJun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:43 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v4 19/26] irqchip/gic-v3: Switch to PMR masking after IRQ acknowledge
Date: Fri, 25 May 2018 10:49:25 +0100
Message-Id: <1527241772-48007-20-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an interrupt has been acknowledged, mask the IRQ priority through
PMR and clear PSR.I bit, allowing higher priority interrupts to be
received during interrupt handling.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 6 ++++++
 arch/arm64/include/asm/arch_gicv3.h | 6 ++++++
 drivers/irqchip/irq-gic-v3.c        | 8 +++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 58d5d3e..b39d620 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -368,5 +368,11 @@ static inline bool gic_prio_masking_enabled(void)
 	return false;
 }
 
+static inline void gic_start_pmr_masking(void)
+{
+	/* Should not get called */
+	WARN_ON(true);
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 98b09db..23c88ac0 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -160,5 +160,11 @@ static inline bool gic_prio_masking_enabled(void)
 	return cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
 }
 
+static inline void gic_start_pmr_masking(void)
+{
+	gic_write_pmr(ICC_PMR_EL1_MASKED);
+	asm volatile ("msr daifclr, #2" : : : "memory");
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fc477e2..2fd0440 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -355,12 +355,18 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 
 	irqnr = gic_read_iar();
 
+	if (arch_uses_gic_prios()) {
+		isb();
+		/* Masking IRQs earlier would prevent to ack the current interrupt */
+		gic_start_pmr_masking();
+	}
+
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;
 
 		if (static_branch_likely(&supports_deactivate_key))
 			gic_write_eoir(irqnr);
-		else
+		else if (!arch_uses_gic_prios())
 			isb();
 
 		err = handle_domain_irq(gic_data.domain, irqnr, regs);
-- 
1.9.1
