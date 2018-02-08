Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeBHHUF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:20:05 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53946 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBHHUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:20:04 -0500
Date: Thu, 8 Feb 2018 08:20:02 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [RFC v2 PATCH 6/7] x86/entry: get rid of
 ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS
Message-ID: <20180208072002.GA13799@isilmar-4.linta.de>
References: <20180207201517.6518-1-linux@dominikbrodowski.net>
 <20180207201517.6518-7-linux@dominikbrodowski.net>
 <CA+55aFxZ-pyx88rwykT0Dzh-_bwGQcmc00GhrMQ4OEwXqMO+pA@mail.gmail.com>
 <20180207212915.GA4633@isilmar-4.linta.de>
 <CA+55aFxyBrF+2uZYN7dfVJ4MFgfxEQPFWGqBAueRne4LWJP0QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxyBrF+2uZYN7dfVJ4MFgfxEQPFWGqBAueRne4LWJP0QA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 01:58:20PM -0800, Linus Torvalds wrote:
> I was just hoping that we could play some tricks.
> 
> [...]
> 
> See what I'm saying?

Clever. Though I'd include the "pushq %rsi" in the macro, to be even more
tricky.

   text    data     bss     dec     hex filename
  19500       0       0   19500    4c2c arch/x86/entry/entry_64.o-orig
  24307       0       0   24307    5ef3 arch/x86/entry/entry_64.o-7_of_7
  20987	      0	      0	  20987	   51fb arch/x86/entry/entry_64.o-trick

I'm not really sure yet where the increase in text size comes from in my
patch set, though.

I *hope* that the CS-ORIG_RAX(%rsp) testb is correct; again, excercise
an extremely stringent review of this patch, please.

Thanks,
	Dominik

--------------------------------------------------------
From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Wed, 7 Feb 2018 20:56:13 +0100
Subject: [PATCH] x86/entry: get rid of ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS

Previously, error_entry() and paranoid_entry() saved the GP registers
onto stack space previously allocated by its callers. Combine these two
steps in the callee, and use the generic PUSH_AND_CLEAR_REGS macro
for that, but play a litte trick in it -- suggested by Linus -- to insert
the GP registers "above" the original return address.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index d6a97e2945ee..dc60365547e1 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,47 +97,7 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
-	.macro ALLOC_PT_GPREGS_ON_STACK
-	addq	$-(15*8), %rsp
-	.endm
-
-	.macro SAVE_AND_CLEAR_REGS offset=0
-	/*
-	 * Save registers and sanitize registers of values that a
-	 * speculation attack might otherwise want to exploit. The
-	 * lower registers are likely clobbered well before they
-	 * could be put to use in a speculative execution gadget.
-	 * Interleave XOR with PUSH for better uop scheduling:
-	 */
-	movq %rdi, 14*8+\offset(%rsp)
-	movq %rsi, 13*8+\offset(%rsp)
-	movq %rdx, 12*8+\offset(%rsp)
-	movq %rcx, 11*8+\offset(%rsp)
-	movq %rax, 10*8+\offset(%rsp)
-	movq %r8,  9*8+\offset(%rsp)
-	xorq %r8, %r8				/* nospec r8 */
-	movq %r9,  8*8+\offset(%rsp)
-	xorq %r9, %r9				/* nospec r9 */
-	movq %r10, 7*8+\offset(%rsp)
-	xorq %r10, %r10				/* nospec r10 */
-	movq %r11, 6*8+\offset(%rsp)
-	xorq %r11, %r11				/* nospec r11 */
-	movq %rbx, 5*8+\offset(%rsp)
-	xorl %ebx, %ebx				/* nospec rbx */
-	movq %rbp, 4*8+\offset(%rsp)
-	xorl %ebp, %ebp				/* nospec rbp */
-	movq %r12, 3*8+\offset(%rsp)
-	xorq %r12, %r12				/* nospec r12 */
-	movq %r13, 2*8+\offset(%rsp)
-	xorq %r13, %r13				/* nospec r13 */
-	movq %r14, 1*8+\offset(%rsp)
-	xorq %r14, %r14				/* nospec r14 */
-	movq %r15, 0*8+\offset(%rsp)
-	xorq %r15, %r15				/* nospec r15 */
-	UNWIND_HINT_REGS offset=\offset
-	.endm
-
-	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -145,8 +105,14 @@ For 32-bit we have the following conventions - kernel is built with
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
@@ -171,6 +137,9 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r15		/* pt_regs->r15 */
 	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
+	.if \save_ret
+	pushq	%rsi		/* return address on top of stack */
+	.endif
 	.endm
 
 	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
@@ -211,7 +180,7 @@ For 32-bit we have the following conventions - kernel is built with
  * is just setting the LSB, which makes it an invalid stack address and is also
  * a signal to the unwinder that it's a pt_regs pointer in disguise.
  *
- * NOTE: This macro must be used *after* SAVE_AND_CLEAR_REGS because it corrupts
+ * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
  * the original rbp.
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9c4fe360db42..a2e41177e390 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -871,10 +871,8 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	ALLOC_PT_GPREGS_ON_STACK
-
 	.if \paranoid < 2
-	testb	$3, CS(%rsp)			/* If coming from userspace, switch stacks */
+	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
 	jnz	.Lfrom_usermode_switch_stack_\@
 	.endif
 
@@ -1128,7 +1126,7 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_AND_CLEAR_REGS 8
+	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1179,7 +1177,7 @@ END(paranoid_exit)
 ENTRY(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_AND_CLEAR_REGS 8
+	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
@@ -1571,7 +1569,6 @@ end_repeat_nmi:
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	ALLOC_PT_GPREGS_ON_STACK
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
