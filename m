Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926EC206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfAHOJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:09:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbfAHOIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F0680D;
        Tue,  8 Jan 2019 06:08:44 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 742D33F70D;
        Tue,  8 Jan 2019 06:08:42 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v8 20/26] irqchip/gic-v3: Handle pseudo-NMIs
Date:   Tue,  8 Jan 2019 14:07:38 +0000
Message-Id: <1546956464-48825-21-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a higher priority to be used for pseudo-NMIs. When such an
interrupt is received, keep interrupts fully disabled at CPU level to
prevent receiving other pseudo-NMIs while handling the current one.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5374b43..4df1e94 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -41,6 +41,8 @@
 
 #include "irq-gic-common.h"
 
+#define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
+
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 
 struct redist_region {
@@ -381,12 +383,45 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 	return aff;
 }
 
+static inline void gic_deactivate_unexpected_irq(u32 irqnr)
+{
+	if (static_branch_likely(&supports_deactivate_key)) {
+		if (irqnr < 8192)
+			gic_write_dir(irqnr);
+	} else {
+		gic_write_eoir(irqnr);
+	}
+}
+
+static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
+{
+	int err;
+
+	if (static_branch_likely(&supports_deactivate_key))
+		gic_write_eoir(irqnr);
+	/*
+	 * Leave the PSR.I bit set to prevent other NMIs to be
+	 * received while handling this one.
+	 * PSR.I will be restored when we ERET to the
+	 * interrupted context.
+	 */
+	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+	if (err)
+		gic_deactivate_unexpected_irq(irqnr);
+}
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
 	irqnr = gic_read_iar();
 
+	if (gic_supports_nmi() &&
+	    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+		gic_handle_nmi(irqnr, regs);
+		return;
+	}
+
 	if (gic_prio_masking_enabled()) {
 		gic_pmr_mask_irqs();
 		gic_arch_enable_irqs();
@@ -403,12 +438,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		err = handle_domain_irq(gic_data.domain, irqnr, regs);
 		if (err) {
 			WARN_ONCE(true, "Unexpected interrupt received!\n");
-			if (static_branch_likely(&supports_deactivate_key)) {
-				if (irqnr < 8192)
-					gic_write_dir(irqnr);
-			} else {
-				gic_write_eoir(irqnr);
-			}
+			gic_deactivate_unexpected_irq(irqnr);
 		}
 		return;
 	}
-- 
1.9.1

