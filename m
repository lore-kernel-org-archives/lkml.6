Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeBKKuy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:50:54 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:39500 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbeBKKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:50:47 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: dan.j.williams@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, luto@kernel.org
Subject: [PATCH v3 2/7] x86/entry: merge POP_C_REGS and POP_EXTRA_REGS
Date: Sun, 11 Feb 2018 11:49:43 +0100
Message-Id: <20180211104949.12992-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211104949.12992-1-linux@dominikbrodowski.net>
References: <20180211104949.12992-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two special, opencoded cases for POP_C_REGS can be handled by ASM
macros.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/calling.h  | 15 +++++++++++----
 arch/x86/entry/entry_64.S | 26 ++++----------------------
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 8907a6593b42..3bda31736a7b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -139,25 +139,32 @@ For 32-bit we have the following conventions - kernel is built with
 	xorq %r15, %r15
 	.endm
 
-	.macro POP_EXTRA_REGS
+	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
-	.endm
-
-	.macro POP_C_REGS
+	.if \skip_r11rcx
+	popq %rsi
+	.else
 	popq %r11
+	.endif
 	popq %r10
 	popq %r9
 	popq %r8
 	popq %rax
+	.if \skip_r11rcx
+	popq %rsi
+	.else
 	popq %rcx
+	.endif
 	popq %rdx
 	popq %rsi
+	.if \pop_rdi
 	popq %rdi
+	.endif
 	.endm
 
 	.macro icebp
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 91e8d84c2496..286b24b650da 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -334,15 +334,7 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
 	UNWIND_HINT_EMPTY
-	POP_EXTRA_REGS
-	popq	%rsi	/* skip r11 */
-	popq	%r10
-	popq	%r9
-	popq	%r8
-	popq	%rax
-	popq	%rsi	/* skip rcx */
-	popq	%rdx
-	popq	%rsi
+	POP_REGS pop_rdi=0 skip_r11rcx=1
 
 	/*
 	 * Now all regs are restored except RSP and RDI.
@@ -635,15 +627,7 @@ GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 	ud2
 1:
 #endif
-	POP_EXTRA_REGS
-	popq	%r11
-	popq	%r10
-	popq	%r9
-	popq	%r8
-	popq	%rax
-	popq	%rcx
-	popq	%rdx
-	popq	%rsi
+	POP_REGS pop_rdi=0
 
 	/*
 	 * The stack is now user RDI, orig_ax, RIP, CS, EFLAGS, RSP, SS.
@@ -701,8 +685,7 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	ud2
 1:
 #endif
-	POP_EXTRA_REGS
-	POP_C_REGS
+	POP_REGS
 	addq	$8, %rsp	/* skip regs->orig_ax */
 	INTERRUPT_RETURN
 
@@ -1661,8 +1644,7 @@ end_repeat_nmi:
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
 nmi_restore:
-	POP_EXTRA_REGS
-	POP_C_REGS
+	POP_REGS
 
 	/*
 	 * Skip orig_ax and the "outermost" frame to point RSP at the "iret"
-- 
2.16.1
