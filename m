Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965734AbeEYJzm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:55:42 -0400
Received: from foss.arm.com ([217.140.101.70]:57490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965963AbeEYJuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:18 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 09/26] arm64: Use daifflag_restore after bp_hardening
Date: Fri, 25 May 2018 10:49:15 +0100
Message-Id: <1527241772-48007-10-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For EL0 entries requiring bp_hardening, daif status is kept at
DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
are enabled through local_irq_enable().

Before using local_irq_* functions, daifflags should be properly restored
to a state where IRQs are enabled.

Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/mm/fault.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Note:
This doesn't introduce a real change in behaviour, but once PMR
is used for interrupt masking, PSR.I bit needs to be cleared and
local_irq_enable won't do that anymore.

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485..7a18634 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -37,6 +37,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/cpufeature.h>
 #include <asm/exception.h>
+#include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/sysreg.h>
@@ -712,7 +713,7 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	if (addr > TASK_SIZE)
 		arm64_apply_bp_hardening();

-	local_irq_enable();
+	local_daif_restore(DAIF_PROCCTX);
 	do_mem_abort(addr, esr, regs);
 }

@@ -726,7 +727,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
 			arm64_apply_bp_hardening();
-		local_irq_enable();
+		local_daif_restore(DAIF_PROCCTX);
 	}

 	info.si_signo = SIGBUS;
--
1.9.1
