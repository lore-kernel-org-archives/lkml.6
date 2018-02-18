Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeBRMeD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 07:34:03 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:51544 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeBRMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 07:33:55 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        brgerst@gmail.com, luto@kernel.org, jpoimboe@redhat.com
Cc: torvalds@linux-foundation.org, ak@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com
Subject: [RFC PATCH v2 4/5] x86/entry/64: remove interrupt macro
Date: Sun, 18 Feb 2018 13:31:15 +0100
Message-Id: <20180218123116.21334-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180218123116.21334-1-linux@dominikbrodowski.net>
References: <20180218123116.21334-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now trivial to call the interrupt helper function and then the
actual worker. Therefore, remove the interrupt macro.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/entry_64.S | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 266bfcba3bb5..0ac2b4865d58 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -609,16 +609,6 @@ ENTRY(interrupt_helper)
 	ret
 END(interrupt_helper)
 
-/* 0(%rsp): ~(interrupt number) */
-	.macro interrupt func
-	cld
-
-	call	interrupt_helper
-
-	UNWIND_HINT_REGS indirect=1
-	call	\func	/* rdi points to pt_regs */
-	.endm
-
 	/*
 	 * The interrupt stubs push (~vector+0x80) onto the stack and
 	 * then jump to common_interrupt.
@@ -627,7 +617,9 @@ END(interrupt_helper)
 common_interrupt:
 	ASM_CLAC
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
-	interrupt do_IRQ
+	call	interrupt_helper
+	UNWIND_HINT_REGS indirect=1
+	call	do_IRQ	/* rdi points to pt_regs */
 	/* 0(%rsp): old RSP */
 ret_from_intr:
 	DISABLE_INTERRUPTS(CLBR_ANY)
@@ -823,7 +815,9 @@ ENTRY(\sym)
 	ASM_CLAC
 	pushq	$~(\num)
 .Lcommon_\sym:
-	interrupt \do_sym
+	call	interrupt_helper
+	UNWIND_HINT_REGS indirect=1
+	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
 END(\sym)
 .endm
-- 
2.16.1
