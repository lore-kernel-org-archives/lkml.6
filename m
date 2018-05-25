Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966083AbeEYJua (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:30 -0400
Received: from foss.arm.com ([217.140.101.70]:57522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966029AbeEYJuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:25 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 12/26] arm64: Unmask PMR before going idle
Date: Fri, 25 May 2018 10:49:18 +0100
Message-Id: <1527241772-48007-13-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU does not received signals for interrupts with a priority masked by
ICC_PMR_EL1. This means the CPU might not come back from a WFI
instruction.

Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/proc.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a..e7cafbf 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
@@ -53,10 +54,27 @@
  *	cpu_do_idle()
  *
  *	Idle the processor (wait for interrupt).
+ *
+ *	If the CPU supports priority masking we must do additional work to
+ *	ensure that interrupts are not masked at the PMR (because the core will
+ *	not wake up if we block the wake up signal in the interrupt controller).
  */
 ENTRY(cpu_do_idle)
+alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
+	dsb	sy				// WFI may enter a low-power mode
+	wfi
+	ret
+alternative_else
+	mrs	x0, daif			// save I bit
+	msr	daifset, #2			// set I bit
+	mrs_s	x1, SYS_ICC_PMR_EL1		// save PMR
+alternative_endif
+	mov	x2, #ICC_PMR_EL1_UNMASKED
+	msr_s	SYS_ICC_PMR_EL1, x2		// unmask at PMR
 	dsb	sy				// WFI may enter a low-power mode
 	wfi
+	msr_s	SYS_ICC_PMR_EL1, x1		// restore PMR
+	msr	daif, x0			// restore I bit
 	ret
 ENDPROC(cpu_do_idle)
 
-- 
1.9.1
