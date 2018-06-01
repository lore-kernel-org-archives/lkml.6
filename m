Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeFAL2L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:28:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751984AbeFALZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:10 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCHv2 11/19] arm64: don't reload GPRs after apply_ssbd
Date: Fri,  1 Jun 2018 12:24:33 +0100
Message-Id: <20180601112441.37810-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all of the syscall logic works on the saved pt_regs, apply_ssbd
can safely corrupt x0-x3 in the entry paths, and we no longer need to
restore them. So let's remotve the logic doing so.

With that logic gone, we can fold the branch target into the macro, so
that callers need not deal with this. GAS provides \@, which provides a
unique value per macro invocation, which we can use to create a unique
label.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 156c4e3fd1a4..22c58e7dfc0f 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -140,20 +140,21 @@ alternative_else_nop_endif
 
 	// This macro corrupts x0-x3. It is the caller's duty
 	// to save/restore them if required.
-	.macro	apply_ssbd, state, targ, tmp1, tmp2
+	.macro	apply_ssbd, state, tmp1, tmp2
 #ifdef CONFIG_ARM64_SSBD
 alternative_cb	arm64_enable_wa2_handling
-	b	\targ
+	b	skip_apply_ssbd\@
 alternative_cb_end
 	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
-	cbz	\tmp2, \targ
+	cbz	\tmp2, skip_apply_ssbd\@
 	ldr	\tmp2, [tsk, #TSK_TI_FLAGS]
-	tbnz	\tmp2, #TIF_SSBD, \targ
+	tbnz	\tmp2, #TIF_SSBD, skip_apply_ssbd\@
 	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
 	mov	w1, #\state
 alternative_cb	arm64_update_smccc_conduit
 	nop					// Patched to SMC/HVC #0
 alternative_cb_end
+skip_apply_ssbd\@:
 #endif
 	.endm
 
@@ -183,13 +184,7 @@ alternative_cb_end
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 
-	apply_ssbd 1, 1f, x22, x23
-
-#ifdef CONFIG_ARM64_SSBD
-	ldp	x0, x1, [sp, #16 * 0]
-	ldp	x2, x3, [sp, #16 * 1]
-#endif
-1:
+	apply_ssbd 1, x22, x23
 
 	mov	x29, xzr			// fp pointed to user-space
 	.else
@@ -331,8 +326,7 @@ alternative_if ARM64_WORKAROUND_845719
 alternative_else_nop_endif
 #endif
 3:
-	apply_ssbd 0, 5f, x0, x1
-5:
+	apply_ssbd 0, x0, x1
 	.endif
 
 	msr	elr_el1, x21			// set up the return data
-- 
2.11.0
