Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E154FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAE6206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfAHOIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:08:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52292 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbfAHOI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E62591A25;
        Tue,  8 Jan 2019 06:08:27 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22BA13F70D;
        Tue,  8 Jan 2019 06:08:25 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v8 13/26] arm64: daifflags: Include PMR in daifflags restore operations
Date:   Tue,  8 Jan 2019 14:07:31 +0000
Message-Id: <1546956464-48825-14-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of PMR should not bypass the semantics of daifflags.

When DA_F are set, I bit is also set as no interrupts (even of higher
priority) is allowed.

When DA_F are cleared, I bit is cleared and interrupt enabling/disabling
goes through ICC_PMR_EL1.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 546bc39..1fd390e 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -18,6 +18,8 @@
 
 #include <linux/irqflags.h>
 
+#include <asm/cpufeature.h>
+
 #define DAIF_PROCCTX		0
 #define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
 
@@ -36,7 +38,13 @@ static inline unsigned long local_daif_save(void)
 {
 	unsigned long flags;
 
-	flags = arch_local_save_flags();
+	flags = read_sysreg(daif);
+
+	if (system_uses_irq_prio_masking()) {
+		/* If IRQs are masked with PMR, reflect it in the flags */
+		if (read_sysreg_s(SYS_ICC_PMR_EL1) <= GIC_PRIO_IRQOFF)
+			flags |= PSR_I_BIT;
+	}
 
 	local_daif_mask();
 
@@ -45,12 +53,27 @@ static inline unsigned long local_daif_save(void)
 
 static inline void local_daif_restore(unsigned long flags)
 {
-	if (!arch_irqs_disabled_flags(flags))
+	bool irq_disabled = flags & PSR_I_BIT;
+
+	if (!irq_disabled) {
 		trace_hardirqs_on();
 
-	arch_local_irq_restore(flags);
+		if (system_uses_irq_prio_masking())
+			arch_local_irq_enable();
+	} else if (!(flags & PSR_A_BIT)) {
+		/*
+		 * If interrupts are disabled but we can take
+		 * asynchronous errors, we can take NMIs
+		 */
+		if (system_uses_irq_prio_masking()) {
+			flags &= ~PSR_I_BIT;
+			arch_local_irq_disable();
+		}
+	}
+
+	write_sysreg(flags, daif);
 
-	if (arch_irqs_disabled_flags(flags))
+	if (irq_disabled)
 		trace_hardirqs_off();
 }
 
-- 
1.9.1

