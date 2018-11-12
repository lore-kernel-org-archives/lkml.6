Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F63C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385E22241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385E22241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbeKLVu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:50:59 -0500
Received: from foss.arm.com ([217.140.101.70]:34700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbeKLVu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:50:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45BFB15BF;
        Mon, 12 Nov 2018 03:58:02 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C2EF3F5A0;
        Mon, 12 Nov 2018 03:58:00 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v6 16/24] arm64: gic-v3: Implement arch support for priority masking
Date:   Mon, 12 Nov 2018 11:57:07 +0000
Message-Id: <1542023835-21446-17-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement architecture specific primitive allowing the GICv3 driver to
use priorities to mask interrupts.

Lower the default priority of interrupts to a value maskable with
priority mask used for PMR. This is safe to do as both arm and arm64
only use one priority and are do not currently care about which priority
value it is, as long as all interrupts use the same priority.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/arch_gicv3.h    | 8 ++++----
 include/linux/irqchip/arm-gic-common.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 3f8d5f4..154612a 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -22,6 +22,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/irqchip/arm-gic-common.h>
 #include <linux/stringify.h>
 #include <asm/barrier.h>
 #include <asm/cacheflush.h>
@@ -162,14 +163,13 @@ static inline bool gic_prio_masking_enabled(void)
 
 static inline void gic_pmr_mask_irqs(void)
 {
-	/* Should not get called yet. */
-	WARN_ON_ONCE(true);
+	BUILD_BUG_ON(GICD_INT_DEF_PRI <= GIC_PRIO_IRQOFF);
+	gic_write_pmr(GIC_PRIO_IRQOFF);
 }
 
 static inline void gic_arch_enable_irqs(void)
 {
-	/* Should not get called yet. */
-	WARN_ON_ONCE(true);
+	asm volatile ("msr daifclr, #2" : : : "memory");
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 9a1a479..2c9a4b3 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -13,7 +13,7 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 
-#define GICD_INT_DEF_PRI		0xa0
+#define GICD_INT_DEF_PRI		0xc0
 #define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
 					(GICD_INT_DEF_PRI << 16) |\
 					(GICD_INT_DEF_PRI << 8) |\
-- 
1.9.1

