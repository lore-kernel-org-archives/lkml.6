Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98F9223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98F9223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbeKLVvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:51:04 -0500
Received: from foss.arm.com ([217.140.101.70]:34738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeKLVvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:51:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9AD61684;
        Mon, 12 Nov 2018 03:58:06 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D71FB3F5A0;
        Mon, 12 Nov 2018 03:58:04 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v6 18/24] irqchip/gic-v3: Handle pseudo-NMIs
Date:   Mon, 12 Nov 2018 11:57:09 +0000
Message-Id: <1542023835-21446-19-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
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
 drivers/irqchip/irq-gic-v3.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5245791..c763f1a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -41,6 +41,8 @@
 
 #include "irq-gic-common.h"
 
+#define GICD_INT_NMI_PRI		0xa0
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -375,6 +377,16 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
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
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
@@ -384,6 +396,22 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 		int err;
 
+		if (gic_supports_nmi() &&
+		    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+			if (static_branch_likely(&supports_deactivate_key))
+				gic_write_eoir(irqnr);
+			/*
+			 * Leave the PSR.I bit set to prevent other NMIs to be
+			 * received while handling this one.
+			 * PSR.I will be restored when we ERET to the
+			 * interrupted context.
+			 */
+			err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+			if (err)
+				gic_deactivate_unexpected_irq(irqnr);
+			return;
+		}
+
 		if (gic_prio_masking_enabled()) {
 			gic_pmr_mask_irqs();
 			gic_arch_enable_irqs();
@@ -397,12 +425,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
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

