Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F0DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5AE2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5AE2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeH1Tow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:52 -0400
Received: from foss.arm.com ([217.140.101.70]:41148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1Tow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9C4C1682;
        Tue, 28 Aug 2018 08:52:35 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 818083F557;
        Tue, 28 Aug 2018 08:52:33 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v5 20/27] irqchip/gic-v3: Switch to PMR masking after IRQ acknowledge
Date:   Tue, 28 Aug 2018 16:51:30 +0100
Message-Id: <1535471497-38854-21-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an interrupt has been acknowledged, mask the IRQ priority through
PMR and clear PSR.I bit, allowing higher priority interrupts to be
received during interrupt handling.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
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
index 19a5b1f..eb55da8 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -161,5 +161,11 @@ static inline bool gic_prio_masking_enabled(void)
 	       && cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
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
index a467fcf..56d1fb9 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -350,12 +350,18 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs

 	irqnr = gic_read_iar();

+	if (gic_prio_masking_enabled()) {
+		isb();
+		/* Masking IRQs earlier would prevent to ack the current IRQ */
+		gic_start_pmr_masking();
+	}
+
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;

 		if (static_branch_likely(&supports_deactivate_key))
 			gic_write_eoir(irqnr);
-		else
+		else if (!gic_prio_masking_enabled())
 			isb();

 		err = handle_domain_irq(gic_data.domain, irqnr, regs);
--
1.9.1
