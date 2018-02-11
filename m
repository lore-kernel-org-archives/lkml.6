Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeBKKwS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:52:18 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:39486 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbeBKKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:50:47 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: dan.j.williams@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, luto@kernel.org
Subject: [PATCH v3 8/7] TESTING_ONLY x86/entry: reduce static footprint of idtentry
Date: Sun, 11 Feb 2018 11:49:49 +0100
Message-Id: <20180211104949.12992-9-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211104949.12992-1-linux@dominikbrodowski.net>
References: <20180211104949.12992-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Play a little trick in the generic PUSH_AND_CLEAR_REGS macro
to insert the GP registers "above" the original return address.
This allows us to (re-)insert the macro in error_entry() and
paranoid_entry() and to remove it from the idtentry macro. This
reduces the static footprint significantly.

NOTE: It still needs to be evaluated whether the reduced static
footprint at the cost of code readability is really needed here.

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/calling.h  | 11 ++++++++++-
 arch/x86/entry/entry_64.S | 21 ++++++++++-----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 6985440c68fa..2d4523ba04a8 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,7 +97,7 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -105,8 +105,14 @@ For 32-bit we have the following conventions - kernel is built with
 	 * could be put to use in a speculative execution gadget.
 	 * Interleave XOR with PUSH for better uop scheduling:
 	 */
+	.if \save_ret
+	pushq	%rsi		/* pt_regs->si */
+	movq	8(%rsp), %rsi	/* temporarily store ret address in %rsi */
+	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original ret) */
+	.else
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
+	.endif
 	pushq	\rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
@@ -131,6 +137,9 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r15		/* pt_regs->r15 */
 	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
+	.if \save_ret
+	pushq	%rsi		/* return address on top of stack */
+	.endif
 .endm
 
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b868433d7e68..a2e41177e390 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -871,12 +871,8 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	/* Save all registers in pt_regs */
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
-
 	.if \paranoid < 2
-	testb	$3, CS(%rsp)			/* If coming from userspace, switch stacks */
+	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
 	jnz	.Lfrom_usermode_switch_stack_\@
 	.endif
 
@@ -1123,12 +1119,15 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Switch gs if needed.
+ * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
+	UNWIND_HINT_FUNC
 	cld
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
@@ -1141,7 +1140,7 @@ ENTRY(paranoid_entry)
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
 	ret
-ENDPROC(paranoid_entry)
+END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
@@ -1172,12 +1171,14 @@ ENTRY(paranoid_exit)
 END(paranoid_exit)
 
 /*
- * Switch gs if needed.
+ * Save all registers in pt_regs, and switch gs if needed.
  * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
-	UNWIND_HINT_REGS offset=8
+	UNWIND_HINT_FUNC
 	cld
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1568,8 +1569,6 @@ end_repeat_nmi:
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
-- 
2.16.1
