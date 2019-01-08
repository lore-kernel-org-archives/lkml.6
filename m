Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D83C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F64206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfAHOIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:08:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbfAHOIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0217B15AD;
        Tue,  8 Jan 2019 06:08:12 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3F033F70D;
        Tue,  8 Jan 2019 06:08:09 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v8 06/26] irqchip/gic-v3: Switch to PMR masking before calling IRQ handler
Date:   Tue,  8 Jan 2019 14:07:24 +0000
Message-Id: <1546956464-48825-7-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mask the IRQ priority through PMR and re-enable IRQs at CPU level,
allowing only higher priority interrupts to be received during interrupt
handling.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 17 +++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
 drivers/irqchip/irq-gic-v3.c        |  5 +++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index bef0b5d..f6f485f 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -363,5 +363,22 @@ static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
 
 #define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)
 
+static inline bool gic_prio_masking_enabled(void)
+{
+	return false;
+}
+
+static inline void gic_pmr_mask_irqs(void)
+{
+	/* Should not get called. */
+	WARN_ON_ONCE(true);
+}
+
+static inline void gic_arch_enable_irqs(void)
+{
+	/* Should not get called. */
+	WARN_ON_ONCE(true);
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 37193e2..b5f8142 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -155,5 +155,22 @@ static inline u32 gic_read_rpr(void)
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)
 
+static inline bool gic_prio_masking_enabled(void)
+{
+	return system_uses_irq_prio_masking();
+}
+
+static inline void gic_pmr_mask_irqs(void)
+{
+	/* Should not get called yet. */
+	WARN_ON_ONCE(true);
+}
+
+static inline void gic_arch_enable_irqs(void)
+{
+	/* Should not get called yet. */
+	WARN_ON_ONCE(true);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0868a9d..8148a92 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -356,6 +356,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 
 	irqnr = gic_read_iar();
 
+	if (gic_prio_masking_enabled()) {
+		gic_pmr_mask_irqs();
+		gic_arch_enable_irqs();
+	}
+
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;
 
-- 
1.9.1

