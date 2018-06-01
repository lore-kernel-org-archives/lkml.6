Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeFAL1m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:27:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50344 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeFALZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:12 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 12/19] arm64: zero GPRs upon entry from EL0
Date: Fri,  1 Jun 2018 12:24:34 +0100
Message-Id: <20180601112441.37810-13-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can zero GPRs x0 - x29 upon entry from EL0 to make it harder for
userspace to control values consumed by speculative gadgets.

We don't blat x30, since this is stashed much later, and we'll blat it
before invoking C code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 22c58e7dfc0f..39440c2ee66d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -63,6 +63,12 @@
 #endif
 	.endm
 
+	.macro	clear_gp_regs
+	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
+	mov	x\n, xzr
+	.endr
+	.endm
+
 /*
  * Bad Abort numbers
  *-----------------
@@ -179,6 +185,7 @@ skip_apply_ssbd\@:
 	stp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
+	clear_gp_regs
 	mrs	x21, sp_el0
 	ldr_this_cpu	tsk, __entry_task, x20	// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
@@ -186,7 +193,6 @@ skip_apply_ssbd\@:
 
 	apply_ssbd 1, x22, x23
 
-	mov	x29, xzr			// fp pointed to user-space
 	.else
 	add	x21, sp, #S_FRAME_SIZE
 	get_thread_info tsk
-- 
2.11.0
