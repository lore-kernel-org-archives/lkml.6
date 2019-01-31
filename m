Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D168CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0244218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfAaO7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:59:50 -0500
Received: from foss.arm.com ([217.140.101.70]:45616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732917AbfAaO7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:59:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F350C80D;
        Thu, 31 Jan 2019 06:59:46 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 062DE3F59C;
        Thu, 31 Jan 2019 06:59:44 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v10 13/25] arm64: daifflags: Include PMR in daifflags restore operations
Date:   Thu, 31 Jan 2019 14:58:51 +0000
Message-Id: <1548946743-38979-14-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 50 +++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 546bc39..1dd3d7a 100644
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
 
@@ -45,12 +53,46 @@ static inline unsigned long local_daif_save(void)
 
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
+			/*
+			 * There has been concern that the write to daif
+			 * might be reordered before this write to PMR.
+			 * From the ARM ARM DDI 0487D.a, section D1.7.1
+			 * "Accessing PSTATE fields":
+			 *   Writes to the PSTATE fields have side-effects on
+			 *   various aspects of the PE operation. All of these
+			 *   side-effects are guaranteed:
+			 *     - Not to be visible to earlier instructions in
+			 *       the execution stream.
+			 *     - To be visible to later instructions in the
+			 *       execution stream
+			 *
+			 * Also, writes to PMR are self-synchronizing, so no
+			 * interrupts with a lower priority than PMR is signaled
+			 * to the PE after the write.
+			 *
+			 * So we don't need additional synchronization here.
+			 */
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

