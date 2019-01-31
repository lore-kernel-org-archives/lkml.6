Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9FCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3B4218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbfAaO7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:59:41 -0500
Received: from foss.arm.com ([217.140.101.70]:45566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732631AbfAaO7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:59:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 804BBEBD;
        Thu, 31 Jan 2019 06:59:37 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 86D693F59C;
        Thu, 31 Jan 2019 06:59:35 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v10 09/25] arm64: Unmask PMR before going idle
Date:   Thu, 31 Jan 2019 14:58:47 +0000
Message-Id: <1548946743-38979-10-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU does not received signals for interrupts with a priority masked by
ICC_PMR_EL1. This means the CPU might not come back from a WFI
instruction.

Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.

Since the logic of cpu_do_idle is becoming a bit more complex than just
two instructions, lets turn it from ASM to C.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/process.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/proc.S        | 11 -----------
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6d410fc..3767fb2 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -51,6 +51,7 @@
 #include <linux/thread_info.h>
 
 #include <asm/alternative.h>
+#include <asm/arch_gicv3.h>
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
@@ -74,6 +75,50 @@
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
+static void __cpu_do_idle(void)
+{
+	dsb(sy);
+	wfi();
+}
+
+static void __cpu_do_idle_irqprio(void)
+{
+	unsigned long pmr;
+	unsigned long daif_bits;
+
+	daif_bits = read_sysreg(daif);
+	write_sysreg(daif_bits | PSR_I_BIT, daif);
+
+	/*
+	 * Unmask PMR before going idle to make sure interrupts can
+	 * be raised.
+	 */
+	pmr = gic_read_pmr();
+	gic_write_pmr(GIC_PRIO_IRQON);
+
+	__cpu_do_idle();
+
+	gic_write_pmr(pmr);
+	write_sysreg(daif_bits, daif);
+}
+
+/*
+ *	cpu_do_idle()
+ *
+ *	Idle the processor (wait for interrupt).
+ *
+ *	If the CPU supports priority masking we must do additional work to
+ *	ensure that interrupts are not masked at the PMR (because the core will
+ *	not wake up if we block the wake up signal in the interrupt controller).
+ */
+void cpu_do_idle(void)
+{
+	if (system_uses_irq_prio_masking())
+		__cpu_do_idle_irqprio();
+	else
+		__cpu_do_idle();
+}
+
 /*
  * This is our default idle handler.
  */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 73886a5..3ea4f3b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -55,17 +55,6 @@
 
 #define MAIR(attr, mt)	((attr) << ((mt) * 8))
 
-/*
- *	cpu_do_idle()
- *
- *	Idle the processor (wait for interrupt).
- */
-ENTRY(cpu_do_idle)
-	dsb	sy				// WFI may enter a low-power mode
-	wfi
-	ret
-ENDPROC(cpu_do_idle)
-
 #ifdef CONFIG_CPU_PM
 /**
  * cpu_do_suspend - save CPU registers context
-- 
1.9.1

