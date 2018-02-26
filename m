Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x227jGJ+Eqb68m7pNWrGBRPeHPYASz7f5NjCvEw/FNgYSxSLy4lL08xxtew54Sc3Pvnmw8/k5
ARC-Seal: i=1; a=rsa-sha256; t=1519651508; cv=none;
        d=google.com; s=arc-20160816;
        b=e/p+tGqHeidbtNdragtUZi7xn0B/oLjbn1Xsja9ugb0MoYLMh3RI8q+ILntp9S8Y7L
         Yx2/ktCq97JUqSzEY6Qx0wYCt7Pbd75VA6IoLGiMHTilmumEnD4zmNvqfqoTx1QeLqp2
         EOZR+QWPDiH7jAyl7COP8VEx0qyzy2cCbUN7cixb6f++vCUMhjmVAYspns84AbdTTxR0
         2gf+T6JYv2ePSVYWCJ/2MSA8HXuohMJJHDMemXxU9pizeuzpSodsix4F2NFeVJ9mNnZt
         Hj+FsWyQHd6brPnyyUrkmkab0pjmfdiWsZofW/WtjotN6NUXP3jKnG6LB4FUPwgFqEbD
         zO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=SJ6WyXcnQMYLKMbJvSeXRG8LavT4R9KzkduxYoA5Oy0=;
        b=Uug9KJniWaJ/GfgT92g8HZJzzZ/yv6drdZyd6rpoT5xsPDHJ/AHzoW0hJsoKqh+t/y
         8YOQfUXVre+12AhJCHpzrTC/Ef0KoqlziuIZA4QEEPFbVCaDM9fA3jrQCj5A134dwa02
         1dQcWhu4apLyqAdqAJCS/R2fXMb8ybUQkMFTt2tUj45KLTNVXxLsucdWWKEILriFs8Uk
         PsjZXclpQM8B0p2StBuyJO2Zxta8izeXg3SbMx7J6Z7NNskZQseeJMKRzawlu4cdoKH8
         E/W525WWXVfr/LVrfn5lLCmQKuefxqZuAuViVDHGxUw45usk7uYI5Zp+SGH8d2JOCXgf
         LOiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Mon, 26 Feb 2018 14:25:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
    Greg KH <gregkh@linuxfoundation.org>, David Woodhouse <dwmw@amazon.co.uk>
Subject: [GIT pull] x86/pti updates for 4.16
Message-ID: <alpine.DEB.2.21.1802261358090.1896@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-421047950-1519651523=:1896"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593470100080212890?=
X-GMAIL-MSGID: =?utf-8?q?1593470100080212890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-421047950-1519651523=:1896
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

Yet another pile of melted spectrum related changes:

 - Sanitize the array_index_nospec protection mechanism: Remove the
   overengineered array_index_nospec_mask_check() magic and allow
   const-qualified types as index to avoid temporary storage in a non-const
   local variable.

 - Make the microcode loader more robust by properly propagating error
   codes. Provide information about new feature bits after micro code was
   updated so administrators can act upon.

 - Optimizations of the entry ASM code which reduce code footprint and make
   the code simpler and faster.

 - Fix the {pmd,pud}_{set,clear}_flags() implementations to work properly
   on paravirt kernels by removing the address translation operations.

 - Revert the harmful vmexit_fill_RSB() optimization

 - Use IBRS around firmware calls

 - Teach objtool about retpolines and add annotations for indirect jumps
   and calls.

 - Explicitely disable jumplabel patching in __init code and handle
   patching failures proper instead of silently ignoring them.

 - Remove indirect paravirt calls for writing the speculation control MSR
   as these calls are obviously proving the same attack vector which is
   tried to be mitigated.

 - A few small fixes which address build issues with recent compiler and
   assembler versions.

Thanks,

	tglx

------------------>
Borislav Petkov (3):
      x86/microcode: Propagate return value from updating functions
      x86/CPU: Add a microcode loader callback
      x86/CPU: Check CPU feature bits after microcode upgrade

Dan Williams (2):
      nospec: Kill array_index_nospec_mask_check()
      nospec: Include <asm/barrier.h> dependency

David Woodhouse (3):
      Revert "x86/retpoline: Simplify vmexit_fill_RSB()"
      x86/speculation: Use IBRS if available before calling into firmware
      x86/retpoline: Support retpoline builds with Clang

Dominik Brodowski (8):
      x86/entry: Reduce the code footprint of the 'idtentry' macro
      x86/entry/64: Use 'xorl' for faster register clearing
      x86/entry/64: Move PUSH_AND_CLEAR_REGS from interrupt macro to helper function
      x86/entry/64: Move ENTER_IRQ_STACK from interrupt macro to interrupt_entry
      x86/entry/64: Move the switch_to_thread_stack() call to interrupt_entry()
      x86/entry/64: Remove 'interrupt' macro
      x86/entry/64: Move ASM_CLAC to interrupt_entry()
      x86/entry/64: Open-code switch_to_thread_stack()

Ingo Molnar (1):
      x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP

Jan Beulich (5):
      x86/mm: Fix {pmd,pud}_{set,clear}_flags()
      x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify clobbers
      x86/IO-APIC: Avoid warning in 32-bit builds
      x86/LDT: Avoid warning in 32-bit builds with older gcc
      x86-64/realmode: Add instruction suffix

Jann Horn (1):
      x86/mm: Remove stale comment about KMEMCHECK

Josh Poimboeuf (4):
      jump_label: Explicitly disable jump labels in __init code
      jump_label: Warn on failed jump_label patching attempt
      extable: Make init_kernel_text() global
      x86/entry/64: Simplify ENCODE_FRAME_POINTER

Paolo Bonzini (2):
      KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
      KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RDMSR path as unlikely()

Peter Zijlstra (8):
      x86/speculation, objtool: Annotate indirect calls/jumps for objtool
      x86/paravirt, objtool: Annotate indirect calls
      x86/boot, objtool: Annotate indirect jump in secondary_startup_64()
      x86/mm/sme, objtool: Annotate indirect call in sme_encrypt_execute()
      objtool: Use existing global variables for options
      objtool: Add retpoline validation
      objtool: Add module specific retpoline rules
      objtool, retpolines: Integrate objtool with retpoline support more closely

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type


 Makefile                              |   5 ++
 arch/x86/Kconfig                      |   1 +
 arch/x86/Makefile                     |   7 +-
 arch/x86/entry/calling.h              |  34 ++++----
 arch/x86/entry/entry_32.S             |   3 +-
 arch/x86/entry/entry_64.S             | 153 ++++++++++++++++++++--------------
 arch/x86/entry/entry_64_compat.S      |  71 +++++++++-------
 arch/x86/include/asm/apm.h            |   6 ++
 arch/x86/include/asm/asm-prototypes.h |   3 -
 arch/x86/include/asm/cpufeatures.h    |   1 +
 arch/x86/include/asm/efi.h            |  17 +++-
 arch/x86/include/asm/microcode.h      |   9 +-
 arch/x86/include/asm/mmu_context.h    |   1 +
 arch/x86/include/asm/nospec-branch.h  | 138 +++++++++++++++++++++++++-----
 arch/x86/include/asm/paravirt.h       |  17 +++-
 arch/x86/include/asm/paravirt_types.h |   5 +-
 arch/x86/include/asm/pgtable.h        |   8 +-
 arch/x86/include/asm/pgtable_types.h  |  10 +++
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/include/asm/refcount.h       |   4 +-
 arch/x86/include/asm/rmwcc.h          |  16 ++--
 arch/x86/kernel/apic/io_apic.c        |   2 +-
 arch/x86/kernel/cpu/bugs.c            |  12 ++-
 arch/x86/kernel/cpu/common.c          |  30 +++++++
 arch/x86/kernel/cpu/microcode/amd.c   |  10 +--
 arch/x86/kernel/cpu/microcode/core.c  |  39 +++++----
 arch/x86/kernel/cpu/microcode/intel.c |  10 +--
 arch/x86/kernel/head_64.S             |   2 +
 arch/x86/kernel/unwind_orc.c          |   3 +-
 arch/x86/kvm/svm.c                    |   9 +-
 arch/x86/kvm/vmx.c                    |   9 +-
 arch/x86/lib/Makefile                 |   1 -
 arch/x86/lib/retpoline.S              |  56 -------------
 arch/x86/mm/fault.c                   |   4 -
 arch/x86/mm/mem_encrypt_boot.S        |   2 +
 arch/x86/realmode/rm/trampoline_64.S  |   2 +-
 include/linux/compiler-clang.h        |   5 ++
 include/linux/compiler-gcc.h          |   4 +
 include/linux/init.h                  |   8 +-
 include/linux/jump_label.h            |   3 +
 include/linux/kernel.h                |   1 +
 include/linux/nospec.h                |  26 +-----
 init/main.c                           |   2 +
 kernel/extable.c                      |   2 +-
 kernel/jump_label.c                   |  27 ++++--
 scripts/Makefile.build                |   8 ++
 tools/objtool/builtin-check.c         |   6 +-
 tools/objtool/builtin-orc.c           |   6 +-
 tools/objtool/builtin.h               |   5 ++
 tools/objtool/check.c                 | 100 +++++++++++++++++++++-
 tools/objtool/check.h                 |   3 +-
 51 files changed, 604 insertions(+), 303 deletions(-)

diff --git a/Makefile b/Makefile
index 79ad2bfa24b6..3dfce4d2f25d 100644
--- a/Makefile
+++ b/Makefile
@@ -489,6 +489,11 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 endif
 
+RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
+export RETPOLINE_CFLAGS
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 63bf349b2b24..c1aed6c0e413 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -436,6 +436,7 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
+	select STACK_VALIDATION if HAVE_STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fad55160dcb9..498c1b812300 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,10 +232,9 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-    RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
-    ifneq ($(RETPOLINE_CFLAGS),)
-        KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
-    endif
+ifneq ($(RETPOLINE_CFLAGS),)
+  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
+endif
 endif
 
 archscripts: scripts_basic
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index dce7092ab24a..be63330c5511 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,7 +97,7 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -105,32 +105,41 @@ For 32-bit we have the following conventions - kernel is built with
 	 * could be put to use in a speculative execution gadget.
 	 * Interleave XOR with PUSH for better uop scheduling:
 	 */
+	.if \save_ret
+	pushq	%rsi		/* pt_regs->si */
+	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
+	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
+	.else
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
+	.endif
 	pushq	\rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
-	xorq    %r8, %r8	/* nospec   r8 */
+	xorl	%r8d, %r8d	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
-	xorq    %r9, %r9	/* nospec   r9 */
+	xorl	%r9d, %r9d	/* nospec   r9 */
 	pushq   %r10		/* pt_regs->r10 */
-	xorq    %r10, %r10	/* nospec   r10 */
+	xorl	%r10d, %r10d	/* nospec   r10 */
 	pushq   %r11		/* pt_regs->r11 */
-	xorq    %r11, %r11	/* nospec   r11*/
+	xorl	%r11d, %r11d	/* nospec   r11*/
 	pushq	%rbx		/* pt_regs->rbx */
 	xorl    %ebx, %ebx	/* nospec   rbx*/
 	pushq	%rbp		/* pt_regs->rbp */
 	xorl    %ebp, %ebp	/* nospec   rbp*/
 	pushq	%r12		/* pt_regs->r12 */
-	xorq    %r12, %r12	/* nospec   r12*/
+	xorl	%r12d, %r12d	/* nospec   r12*/
 	pushq	%r13		/* pt_regs->r13 */
-	xorq    %r13, %r13	/* nospec   r13*/
+	xorl	%r13d, %r13d	/* nospec   r13*/
 	pushq	%r14		/* pt_regs->r14 */
-	xorq    %r14, %r14	/* nospec   r14*/
+	xorl	%r14d, %r14d	/* nospec   r14*/
 	pushq	%r15		/* pt_regs->r15 */
-	xorq    %r15, %r15	/* nospec   r15*/
+	xorl	%r15d, %r15d	/* nospec   r15*/
 	UNWIND_HINT_REGS
+	.if \save_ret
+	pushq	%rsi		/* return address on top of stack */
+	.endif
 .endm
 
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
@@ -172,12 +181,7 @@ For 32-bit we have the following conventions - kernel is built with
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
 #ifdef CONFIG_FRAME_POINTER
-	.if \ptregs_offset
-		leaq \ptregs_offset(%rsp), %rbp
-	.else
-		mov %rsp, %rbp
-	.endif
-	orq	$0x1, %rbp
+	leaq 1+\ptregs_offset(%rsp), %rbp
 #endif
 .endm
 
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 16c2c022540d..6ad064c8cf35 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -252,8 +252,7 @@ ENTRY(__switch_to_asm)
 	 * exist, overwrite the RSB with entries which capture
 	 * speculative execution to prevent attack.
 	 */
-	/* Clobbers %ebx */
-	FILL_RETURN_BUFFER RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
+	FILL_RETURN_BUFFER %ebx, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
 #endif
 
 	/* restore callee-saved registers */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8971bd64d515..d5c7f18f79ac 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -364,8 +364,7 @@ ENTRY(__switch_to_asm)
 	 * exist, overwrite the RSB with entries which capture
 	 * speculative execution to prevent attack.
 	 */
-	/* Clobbers %rbx */
-	FILL_RETURN_BUFFER RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
+	FILL_RETURN_BUFFER %r12, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
 #endif
 
 	/* restore callee-saved registers */
@@ -449,9 +448,19 @@ END(irq_entries_start)
  *
  * The invariant is that, if irq_count != -1, then the IRQ stack is in use.
  */
-.macro ENTER_IRQ_STACK regs=1 old_rsp
+.macro ENTER_IRQ_STACK regs=1 old_rsp save_ret=0
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
+
+	.if \save_ret
+	/*
+	 * If save_ret is set, the original stack contains one additional
+	 * entry -- the return address. Therefore, move the address one
+	 * entry below %rsp to \old_rsp.
+	 */
+	leaq	8(%rsp), \old_rsp
+	.else
 	movq	%rsp, \old_rsp
+	.endif
 
 	.if \regs
 	UNWIND_HINT_REGS base=\old_rsp
@@ -497,6 +506,15 @@ END(irq_entries_start)
 	.if \regs
 	UNWIND_HINT_REGS indirect=1
 	.endif
+
+	.if \save_ret
+	/*
+	 * Push the return address to the stack. This return address can
+	 * be found at the "real" original RSP, which was offset by 8 at
+	 * the beginning of this macro.
+	 */
+	pushq	-8(\old_rsp)
+	.endif
 .endm
 
 /*
@@ -520,27 +538,65 @@ END(irq_entries_start)
 .endm
 
 /*
- * Interrupt entry/exit.
- *
- * Interrupt entry points save only callee clobbered registers in fast path.
+ * Interrupt entry helper function.
  *
- * Entry runs with interrupts off.
+ * Entry runs with interrupts off. Stack layout at entry:
+ * +----------------------------------------------------+
+ * | regs->ss						|
+ * | regs->rsp						|
+ * | regs->eflags					|
+ * | regs->cs						|
+ * | regs->ip						|
+ * +----------------------------------------------------+
+ * | regs->orig_ax = ~(interrupt number)		|
+ * +----------------------------------------------------+
+ * | return address					|
+ * +----------------------------------------------------+
  */
-
-/* 0(%rsp): ~(interrupt number) */
-	.macro interrupt func
+ENTRY(interrupt_entry)
+	UNWIND_HINT_FUNC
+	ASM_CLAC
 	cld
 
-	testb	$3, CS-ORIG_RAX(%rsp)
+	testb	$3, CS-ORIG_RAX+8(%rsp)
 	jz	1f
 	SWAPGS
-	call	switch_to_thread_stack
+
+	/*
+	 * Switch to the thread stack. The IRET frame and orig_ax are
+	 * on the stack, as well as the return address. RDI..R12 are
+	 * not (yet) on the stack and space has not (yet) been
+	 * allocated for them.
+	 */
+	pushq	%rdi
+
+	/* Need to switch before accessing the thread stack. */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+	movq	%rsp, %rdi
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+
+	 /*
+	  * We have RDI, return address, and orig_ax on the stack on
+	  * top of the IRET frame. That means offset=24
+	  */
+	UNWIND_HINT_IRET_REGS base=%rdi offset=24
+
+	pushq	7*8(%rdi)		/* regs->ss */
+	pushq	6*8(%rdi)		/* regs->rsp */
+	pushq	5*8(%rdi)		/* regs->eflags */
+	pushq	4*8(%rdi)		/* regs->cs */
+	pushq	3*8(%rdi)		/* regs->ip */
+	pushq	2*8(%rdi)		/* regs->orig_ax */
+	pushq	8(%rdi)			/* return address */
+	UNWIND_HINT_FUNC
+
+	movq	(%rdi), %rdi
 1:
 
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
 
-	testb	$3, CS(%rsp)
+	testb	$3, CS+8(%rsp)
 	jz	1f
 
 	/*
@@ -548,7 +604,7 @@ END(irq_entries_start)
 	 *
 	 * We need to tell lockdep that IRQs are off.  We can't do this until
 	 * we fix gsbase, and we should do it before enter_from_user_mode
-	 * (which can take locks).  Since TRACE_IRQS_OFF idempotent,
+	 * (which can take locks).  Since TRACE_IRQS_OFF is idempotent,
 	 * the simplest way to handle it is to just call it twice if
 	 * we enter from user mode.  There's no reason to optimize this since
 	 * TRACE_IRQS_OFF is a no-op if lockdep is off.
@@ -558,12 +614,15 @@ END(irq_entries_start)
 	CALL_enter_from_user_mode
 
 1:
-	ENTER_IRQ_STACK old_rsp=%rdi
+	ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
 	/* We entered an interrupt context - irqs are off: */
 	TRACE_IRQS_OFF
 
-	call	\func	/* rdi points to pt_regs */
-	.endm
+	ret
+END(interrupt_entry)
+
+
+/* Interrupt entry/exit. */
 
 	/*
 	 * The interrupt stubs push (~vector+0x80) onto the stack and
@@ -571,9 +630,10 @@ END(irq_entries_start)
 	 */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
 common_interrupt:
-	ASM_CLAC
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
-	interrupt do_IRQ
+	call	interrupt_entry
+	UNWIND_HINT_REGS indirect=1
+	call	do_IRQ	/* rdi points to pt_regs */
 	/* 0(%rsp): old RSP */
 ret_from_intr:
 	DISABLE_INTERRUPTS(CLBR_ANY)
@@ -766,10 +826,11 @@ END(common_interrupt)
 .macro apicinterrupt3 num sym do_sym
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS
-	ASM_CLAC
 	pushq	$~(\num)
 .Lcommon_\sym:
-	interrupt \do_sym
+	call	interrupt_entry
+	UNWIND_HINT_REGS indirect=1
+	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
 END(\sym)
 .endm
@@ -832,34 +893,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
 
-/*
- * Switch to the thread stack.  This is called with the IRET frame and
- * orig_ax on the stack.  (That is, RDI..R12 are not on the stack and
- * space has not been allocated for them.)
- */
-ENTRY(switch_to_thread_stack)
-	UNWIND_HINT_FUNC
-
-	pushq	%rdi
-	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-	movq	%rsp, %rdi
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-	UNWIND_HINT sp_offset=16 sp_reg=ORC_REG_DI
-
-	pushq	7*8(%rdi)		/* regs->ss */
-	pushq	6*8(%rdi)		/* regs->rsp */
-	pushq	5*8(%rdi)		/* regs->eflags */
-	pushq	4*8(%rdi)		/* regs->cs */
-	pushq	3*8(%rdi)		/* regs->ip */
-	pushq	2*8(%rdi)		/* regs->orig_ax */
-	pushq	8(%rdi)			/* return address */
-	UNWIND_HINT_FUNC
-
-	movq	(%rdi), %rdi
-	ret
-END(switch_to_thread_stack)
-
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
@@ -875,12 +908,8 @@ ENTRY(\sym)
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
 
@@ -1130,13 +1159,15 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Switch gs if needed.
+ * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
@@ -1181,12 +1212,14 @@ ENTRY(paranoid_exit)
 END(paranoid_exit)
 
 /*
- * Switch gs if needed.
+ * Save all registers in pt_regs, and switch GS if needed.
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
 
@@ -1577,8 +1610,6 @@ end_repeat_nmi:
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index fd65e016e413..e811dd9c5e99 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -85,25 +85,25 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
 	/*
@@ -224,25 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -298,9 +298,9 @@ sysret32_from_system_call:
 	 */
 	SWITCH_TO_USER_CR3_NOSTACK scratch_reg=%r8 scratch_reg2=%r9
 
-	xorq	%r8, %r8
-	xorq	%r9, %r9
-	xorq	%r10, %r10
+	xorl	%r8d, %r8d
+	xorl	%r9d, %r9d
+	xorl	%r10d, %r10d
 	swapgs
 	sysretl
 END(entry_SYSCALL_compat)
@@ -347,10 +347,23 @@ ENTRY(entry_INT80_compat)
 	 */
 	movl	%eax, %eax
 
+	/* switch to thread stack expects orig_ax and rdi to be pushed */
 	pushq	%rax			/* pt_regs->orig_ax */
+	pushq	%rdi			/* pt_regs->di */
+
+	/* Need to switch before accessing the thread stack. */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+	movq	%rsp, %rdi
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+
+	pushq	6*8(%rdi)		/* regs->ss */
+	pushq	5*8(%rdi)		/* regs->rsp */
+	pushq	4*8(%rdi)		/* regs->eflags */
+	pushq	3*8(%rdi)		/* regs->cs */
+	pushq	2*8(%rdi)		/* regs->ip */
+	pushq	1*8(%rdi)		/* regs->orig_ax */
 
-	/* switch to thread stack expects orig_ax to be pushed */
-	call	switch_to_thread_stack
+	movq	(%rdi), %rdi		/* restore %rdi */
 
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
@@ -358,25 +371,25 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   %r12                    /* pt_regs->r12 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   %r13                    /* pt_regs->r13 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   %r14                    /* pt_regs->r14 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   %r15                    /* pt_regs->r15 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
 	/*
diff --git a/arch/x86/include/asm/apm.h b/arch/x86/include/asm/apm.h
index 4d4015ddcf26..c356098b6fb9 100644
--- a/arch/x86/include/asm/apm.h
+++ b/arch/x86/include/asm/apm.h
@@ -7,6 +7,8 @@
 #ifndef _ASM_X86_MACH_DEFAULT_APM_H
 #define _ASM_X86_MACH_DEFAULT_APM_H
 
+#include <asm/nospec-branch.h>
+
 #ifdef APM_ZERO_SEGS
 #	define APM_DO_ZERO_SEGS \
 		"pushl %%ds\n\t" \
@@ -32,6 +34,7 @@ static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
+	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -44,6 +47,7 @@ static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
 		  "=S" (*esi)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
+	firmware_restrict_branch_speculation_end();
 }
 
 static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
@@ -56,6 +60,7 @@ static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
+	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -68,6 +73,7 @@ static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
 		  "=S" (si)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
+	firmware_restrict_branch_speculation_end();
 	return error;
 }
 
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 4d111616524b..1908214b9125 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -38,7 +38,4 @@ INDIRECT_THUNK(dx)
 INDIRECT_THUNK(si)
 INDIRECT_THUNK(di)
 INDIRECT_THUNK(bp)
-asmlinkage void __fill_rsb(void);
-asmlinkage void __clear_rsb(void);
-
 #endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 0dfe4d3f74e2..f41079da38c5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -213,6 +213,7 @@
 #define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
+#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 85f6ccb80b91..a399c1ebf6f0 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -6,6 +6,7 @@
 #include <asm/pgtable.h>
 #include <asm/processor-flags.h>
 #include <asm/tlb.h>
+#include <asm/nospec-branch.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -36,8 +37,18 @@
 
 extern asmlinkage unsigned long efi_call_phys(void *, ...);
 
-#define arch_efi_call_virt_setup()	kernel_fpu_begin()
-#define arch_efi_call_virt_teardown()	kernel_fpu_end()
+#define arch_efi_call_virt_setup()					\
+({									\
+	kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
+})
+
+#define arch_efi_call_virt_teardown()					\
+({									\
+	firmware_restrict_branch_speculation_end();			\
+	kernel_fpu_end();						\
+})
+
 
 /*
  * Wrap all the virtual calls in a way that forces the parameters on the stack.
@@ -73,6 +84,7 @@ struct efi_scratch {
 	efi_sync_low_kernel_mappings();					\
 	preempt_disable();						\
 	__kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
 									\
 	if (efi_scratch.use_pgd) {					\
 		efi_scratch.prev_cr3 = __read_cr3();			\
@@ -91,6 +103,7 @@ struct efi_scratch {
 		__flush_tlb_all();					\
 	}								\
 									\
+	firmware_restrict_branch_speculation_end();			\
 	__kernel_fpu_end();						\
 	preempt_enable();						\
 })
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 55520cec8b27..7fb1047d61c7 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -37,7 +37,12 @@ struct cpu_signature {
 
 struct device;
 
-enum ucode_state { UCODE_ERROR, UCODE_OK, UCODE_NFOUND };
+enum ucode_state {
+	UCODE_OK	= 0,
+	UCODE_UPDATED,
+	UCODE_NFOUND,
+	UCODE_ERROR,
+};
 
 struct microcode_ops {
 	enum ucode_state (*request_microcode_user) (int cpu,
@@ -54,7 +59,7 @@ struct microcode_ops {
 	 * are being called.
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
-	int (*apply_microcode) (int cpu);
+	enum ucode_state (*apply_microcode) (int cpu);
 	int (*collect_cpu_info) (int cpu, struct cpu_signature *csig);
 };
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index c931b88982a0..1de72ce514cd 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -74,6 +74,7 @@ static inline void *ldt_slot_va(int slot)
 	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
 #else
 	BUG();
+	return (void *)fix_to_virt(FIX_HOLE);
 #endif
 }
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 76b058533e47..b7063cfa19f9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -8,6 +8,50 @@
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 
+/*
+ * Fill the CPU return stack buffer.
+ *
+ * Each entry in the RSB, if used for a speculative 'ret', contains an
+ * infinite 'pause; lfence; jmp' loop to capture speculative execution.
+ *
+ * This is required in various cases for retpoline and IBRS-based
+ * mitigations for the Spectre variant 2 vulnerability. Sometimes to
+ * eliminate potentially bogus entries from the RSB, and sometimes
+ * purely to ensure that it doesn't get empty, which on some CPUs would
+ * allow predictions from other (unwanted!) sources to be used.
+ *
+ * We define a CPP macro such that it can be used from both .S files and
+ * inline assembly. It's possible to do a .macro and then include that
+ * from C via asm(".include <asm/nospec-branch.h>") but let's not go there.
+ */
+
+#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
+#define RSB_FILL_LOOPS		16	/* To avoid underflow */
+
+/*
+ * Google experimented with loop-unrolling and this turned out to be
+ * the optimal version — two calls, each with their own speculation
+ * trap should their return address end up getting used, in a loop.
+ */
+#define __FILL_RETURN_BUFFER(reg, nr, sp)	\
+	mov	$(nr/2), reg;			\
+771:						\
+	call	772f;				\
+773:	/* speculation trap */			\
+	pause;					\
+	lfence;					\
+	jmp	773b;				\
+772:						\
+	call	774f;				\
+775:	/* speculation trap */			\
+	pause;					\
+	lfence;					\
+	jmp	775b;				\
+774:						\
+	dec	reg;				\
+	jnz	771b;				\
+	add	$(BITS_PER_LONG/8) * nr, sp;
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -23,6 +67,18 @@
 	.popsection
 .endm
 
+/*
+ * This should be used immediately before an indirect jump/call. It tells
+ * objtool the subsequent indirect jump/call is vouched safe for retpoline
+ * builds.
+ */
+.macro ANNOTATE_RETPOLINE_SAFE
+	.Lannotate_\@:
+	.pushsection .discard.retpoline_safe
+	_ASM_PTR .Lannotate_\@
+	.popsection
+.endm
+
 /*
  * These are the bare retpoline primitives for indirect jmp and call.
  * Do not use these directly; they only exist to make the ALTERNATIVE
@@ -59,9 +115,9 @@
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(jmp *\reg),				\
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
 		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
-		__stringify(lfence; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	jmp	*\reg
 #endif
@@ -70,18 +126,25 @@
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(call *\reg),				\
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
 		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; call *\reg), X86_FEATURE_RETPOLINE_AMD
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	call	*\reg
 #endif
 .endm
 
-/* This clobbers the BX register */
-.macro FILL_RETURN_BUFFER nr:req ftr:req
+ /*
+  * A simpler FILL_RETURN_BUFFER macro. Don't make people use the CPP
+  * monstrosity above, manually.
+  */
+.macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE "", "call __clear_rsb", \ftr
+	ANNOTATE_NOSPEC_ALTERNATIVE
+	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
+		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
+		\ftr
+.Lskip_rsb_\@:
 #endif
 .endm
 
@@ -93,6 +156,12 @@
 	".long 999b - .\n\t"					\
 	".popsection\n\t"
 
+#define ANNOTATE_RETPOLINE_SAFE					\
+	"999:\n\t"						\
+	".pushsection .discard.retpoline_safe\n\t"		\
+	_ASM_PTR " 999b\n\t"					\
+	".popsection\n\t"
+
 #if defined(CONFIG_X86_64) && defined(RETPOLINE)
 
 /*
@@ -102,6 +171,7 @@
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE(						\
+	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
 	X86_FEATURE_RETPOLINE)
@@ -156,25 +226,53 @@ extern char __indirect_thunk_end[];
 static inline void vmexit_fill_RSB(void)
 {
 #ifdef CONFIG_RETPOLINE
-	alternative_input("",
-			  "call __fill_rsb",
-			  X86_FEATURE_RETPOLINE,
-			  ASM_NO_INPUT_CLOBBER(_ASM_BX, "memory"));
+	unsigned long loops;
+
+	asm volatile (ANNOTATE_NOSPEC_ALTERNATIVE
+		      ALTERNATIVE("jmp 910f",
+				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
+				  X86_FEATURE_RETPOLINE)
+		      "910:"
+		      : "=r" (loops), ASM_CALL_CONSTRAINT
+		      : : "memory" );
 #endif
 }
 
+#define alternative_msr_write(_msr, _val, _feature)		\
+	asm volatile(ALTERNATIVE("",				\
+				 "movl %[msr], %%ecx\n\t"	\
+				 "movl %[val], %%eax\n\t"	\
+				 "movl $0, %%edx\n\t"		\
+				 "wrmsr",			\
+				 _feature)			\
+		     : : [msr] "i" (_msr), [val] "i" (_val)	\
+		     : "eax", "ecx", "edx", "memory")
+
 static inline void indirect_branch_prediction_barrier(void)
 {
-	asm volatile(ALTERNATIVE("",
-				 "movl %[msr], %%ecx\n\t"
-				 "movl %[val], %%eax\n\t"
-				 "movl $0, %%edx\n\t"
-				 "wrmsr",
-				 X86_FEATURE_USE_IBPB)
-		     : : [msr] "i" (MSR_IA32_PRED_CMD),
-			 [val] "i" (PRED_CMD_IBPB)
-		     : "eax", "ecx", "edx", "memory");
+	alternative_msr_write(MSR_IA32_PRED_CMD, PRED_CMD_IBPB,
+			      X86_FEATURE_USE_IBPB);
 }
 
+/*
+ * With retpoline, we must use IBRS to restrict branch prediction
+ * before calling into firmware.
+ *
+ * (Implemented as CPP macros due to header hell.)
+ */
+#define firmware_restrict_branch_speculation_start()			\
+do {									\
+	preempt_disable();						\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,	\
+			      X86_FEATURE_USE_IBRS_FW);			\
+} while (0)
+
+#define firmware_restrict_branch_speculation_end()			\
+do {									\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,			\
+			      X86_FEATURE_USE_IBRS_FW);			\
+	preempt_enable();						\
+} while (0)
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 554841fab717..c83a2f418cea 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -7,6 +7,7 @@
 #ifdef CONFIG_PARAVIRT
 #include <asm/pgtable_types.h>
 #include <asm/asm.h>
+#include <asm/nospec-branch.h>
 
 #include <asm/paravirt_types.h>
 
@@ -879,23 +880,27 @@ extern void default_banner(void);
 
 #define INTERRUPT_RETURN						\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret))
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret);)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #ifdef CONFIG_X86_32
 #define GET_CR0_INTO_EAX				\
 	push %ecx; push %edx;				\
+	ANNOTATE_RETPOLINE_SAFE;				\
 	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
 	pop %edx; pop %ecx
 #else	/* !CONFIG_X86_32 */
@@ -917,21 +922,25 @@ extern void default_banner(void);
  */
 #define SWAPGS								\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs)		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs);		\
 		 )
 
 #define GET_CR2_INTO_RAX				\
-	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
+	ANNOTATE_RETPOLINE_SAFE;				\
+	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2);
 
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
 		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64))
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64);)
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_save_fl), clobbers, \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);        \
+		  ANNOTATE_RETPOLINE_SAFE;				    \
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_save_fl);    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f624f1f10316..180bc0bff0fb 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -43,6 +43,7 @@
 #include <asm/desc_defs.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable_types.h>
+#include <asm/nospec-branch.h>
 
 struct page;
 struct thread_struct;
@@ -392,7 +393,9 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_patch_template structure, and can therefore be
  * freely converted back into a structure offset.
  */
-#define PARAVIRT_CALL	"call *%c[paravirt_opptr];"
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 63c2552b6b65..b444d83cfc95 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -350,14 +350,14 @@ static inline pmd_t pmd_set_flags(pmd_t pmd, pmdval_t set)
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v | set);
+	return native_make_pmd(v | set);
 }
 
 static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v & ~clear);
+	return native_make_pmd(v & ~clear);
 }
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
@@ -409,14 +409,14 @@ static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
 {
 	pudval_t v = native_pud_val(pud);
 
-	return __pud(v | set);
+	return native_make_pud(v | set);
 }
 
 static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 {
 	pudval_t v = native_pud_val(pud);
 
-	return __pud(v & ~clear);
+	return native_make_pud(v & ~clear);
 }
 
 static inline pud_t pud_mkold(pud_t pud)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 3696398a9475..246f15b4e64c 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -323,6 +323,11 @@ static inline pudval_t native_pud_val(pud_t pud)
 #else
 #include <asm-generic/pgtable-nopud.h>
 
+static inline pud_t native_make_pud(pudval_t val)
+{
+	return (pud_t) { .p4d.pgd = native_make_pgd(val) };
+}
+
 static inline pudval_t native_pud_val(pud_t pud)
 {
 	return native_pgd_val(pud.p4d.pgd);
@@ -344,6 +349,11 @@ static inline pmdval_t native_pmd_val(pmd_t pmd)
 #else
 #include <asm-generic/pgtable-nopmd.h>
 
+static inline pmd_t native_make_pmd(pmdval_t val)
+{
+	return (pmd_t) { .pud.p4d.pgd = native_make_pgd(val) };
+}
+
 static inline pmdval_t native_pmd_val(pmd_t pmd)
 {
 	return native_pgd_val(pmd.pud.p4d.pgd);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 1bd9ed87606f..b0ccd4847a58 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -977,4 +977,5 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
+void microcode_check(void);
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index 4e44250e7d0d..d65171120e90 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -67,13 +67,13 @@ static __always_inline __must_check
 bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 {
 	GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl", REFCOUNT_CHECK_LT_ZERO,
-				  r->refs.counter, "er", i, "%0", e);
+				  r->refs.counter, "er", i, "%0", e, "cx");
 }
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
 	GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl", REFCOUNT_CHECK_LT_ZERO,
-				 r->refs.counter, "%0", e);
+				 r->refs.counter, "%0", e, "cx");
 }
 
 static __always_inline __must_check
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index f91c365e57c3..4914a3e7c803 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -2,8 +2,7 @@
 #ifndef _ASM_X86_RMWcc
 #define _ASM_X86_RMWcc
 
-#define __CLOBBERS_MEM		"memory"
-#define __CLOBBERS_MEM_CC_CX	"memory", "cc", "cx"
+#define __CLOBBERS_MEM(clb...)	"memory", ## clb
 
 #if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CC_HAVE_ASM_GOTO)
 
@@ -40,18 +39,19 @@ do {									\
 #endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
 
 #define GEN_UNARY_RMWcc(op, var, arg0, cc)				\
-	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM)
+	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
 
-#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc)		\
+#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc, clobbers...)\
 	__GEN_RMWcc(op " " arg0 "\n\t" suffix, var, cc,			\
-		    __CLOBBERS_MEM_CC_CX)
+		    __CLOBBERS_MEM(clobbers))
 
 #define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)			\
 	__GEN_RMWcc(op __BINARY_RMWcc_ARG arg0, var, cc,		\
-		    __CLOBBERS_MEM, vcon (val))
+		    __CLOBBERS_MEM(), vcon (val))
 
-#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0, cc)	\
+#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0, cc,	\
+				  clobbers...)				\
 	__GEN_RMWcc(op __BINARY_RMWcc_ARG arg0 "\n\t" suffix, var, cc,	\
-		    __CLOBBERS_MEM_CC_CX, vcon (val))
+		    __CLOBBERS_MEM(clobbers), vcon (val))
 
 #endif /* _ASM_X86_RMWcc */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 8ad2e410974f..7c5538769f7e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1603,7 +1603,7 @@ static void __init delay_with_tsc(void)
 	do {
 		rep_nop();
 		now = rdtsc();
-	} while ((now - start) < 40000000000UL / HZ &&
+	} while ((now - start) < 40000000000ULL / HZ &&
 		time_before_eq(jiffies, end));
 }
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d71c8b54b696..bfca937bdcc3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -300,6 +300,15 @@ static void __init spectre_v2_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
 	}
+
+	/*
+	 * Retpoline means the kernel is safe because it has no indirect
+	 * branches. But firmware isn't, so use IBRS to protect that.
+	 */
+	if (boot_cpu_has(X86_FEATURE_IBRS)) {
+		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
+		pr_info("Enabling Restricted Speculation for firmware calls\n");
+	}
 }
 
 #undef pr_fmt
@@ -326,8 +335,9 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+	return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
 		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
+		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 		       spectre_v2_module_string());
 }
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 824aee0117bb..348cf4821240 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1749,3 +1749,33 @@ static int __init init_cpu_syscore(void)
 	return 0;
 }
 core_initcall(init_cpu_syscore);
+
+/*
+ * The microcode loader calls this upon late microcode load to recheck features,
+ * only when microcode has been updated. Caller holds microcode_mutex and CPU
+ * hotplug lock.
+ */
+void microcode_check(void)
+{
+	struct cpuinfo_x86 info;
+
+	perf_check_microcode();
+
+	/* Reload CPUID max function as it might've changed. */
+	info.cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+
+	get_cpu_cap(&info);
+
+	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability)))
+		return;
+
+	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
+	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
+}
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 330b8462d426..a998e1a7d46f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -498,7 +498,7 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size,
 	return patch_size;
 }
 
-static int apply_microcode_amd(int cpu)
+static enum ucode_state apply_microcode_amd(int cpu)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_amd *mc_amd;
@@ -512,7 +512,7 @@ static int apply_microcode_amd(int cpu)
 
 	p = find_patch(cpu);
 	if (!p)
-		return 0;
+		return UCODE_NFOUND;
 
 	mc_amd  = p->data;
 	uci->mc = p->data;
@@ -523,13 +523,13 @@ static int apply_microcode_amd(int cpu)
 	if (rev >= mc_amd->hdr.patch_id) {
 		c->microcode = rev;
 		uci->cpu_sig.rev = rev;
-		return 0;
+		return UCODE_OK;
 	}
 
 	if (__apply_microcode_amd(mc_amd)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
-		return -1;
+		return UCODE_ERROR;
 	}
 	pr_info("CPU%d: new patch_level=0x%08x\n", cpu,
 		mc_amd->hdr.patch_id);
@@ -537,7 +537,7 @@ static int apply_microcode_amd(int cpu)
 	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
 	c->microcode = mc_amd->hdr.patch_id;
 
-	return 0;
+	return UCODE_UPDATED;
 }
 
 static int install_equiv_cpu_table(const u8 *buf)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 319dd65f98a2..aa1b9a422f2b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -374,7 +374,7 @@ static int collect_cpu_info(int cpu)
 }
 
 struct apply_microcode_ctx {
-	int err;
+	enum ucode_state err;
 };
 
 static void apply_microcode_local(void *arg)
@@ -489,31 +489,30 @@ static void __exit microcode_dev_exit(void)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
-static int reload_for_cpu(int cpu)
+static enum ucode_state reload_for_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	enum ucode_state ustate;
-	int err = 0;
 
 	if (!uci->valid)
-		return err;
+		return UCODE_OK;
 
 	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
-	if (ustate == UCODE_OK)
-		apply_microcode_on_target(cpu);
-	else
-		if (ustate == UCODE_ERROR)
-			err = -EINVAL;
-	return err;
+	if (ustate != UCODE_OK)
+		return ustate;
+
+	return apply_microcode_on_target(cpu);
 }
 
 static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
+	enum ucode_state tmp_ret = UCODE_OK;
+	bool do_callback = false;
 	unsigned long val;
+	ssize_t ret = 0;
 	int cpu;
-	ssize_t ret = 0, tmp_ret;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret)
@@ -526,15 +525,21 @@ static ssize_t reload_store(struct device *dev,
 	mutex_lock(&microcode_mutex);
 	for_each_online_cpu(cpu) {
 		tmp_ret = reload_for_cpu(cpu);
-		if (tmp_ret != 0)
+		if (tmp_ret > UCODE_NFOUND) {
 			pr_warn("Error reloading microcode on CPU %d\n", cpu);
 
-		/* save retval of the first encountered reload error */
-		if (!ret)
-			ret = tmp_ret;
+			/* set retval for the first encountered reload error */
+			if (!ret)
+				ret = -EINVAL;
+		}
+
+		if (tmp_ret == UCODE_UPDATED)
+			do_callback = true;
 	}
-	if (!ret)
-		perf_check_microcode();
+
+	if (!ret && do_callback)
+		microcode_check();
+
 	mutex_unlock(&microcode_mutex);
 	put_online_cpus();
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index a15db2b4e0d6..923054a6b760 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -772,7 +772,7 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 	return 0;
 }
 
-static int apply_microcode_intel(int cpu)
+static enum ucode_state apply_microcode_intel(int cpu)
 {
 	struct microcode_intel *mc;
 	struct ucode_cpu_info *uci;
@@ -782,7 +782,7 @@ static int apply_microcode_intel(int cpu)
 
 	/* We should bind the task to the CPU */
 	if (WARN_ON(raw_smp_processor_id() != cpu))
-		return -1;
+		return UCODE_ERROR;
 
 	uci = ucode_cpu_info + cpu;
 	mc = uci->mc;
@@ -790,7 +790,7 @@ static int apply_microcode_intel(int cpu)
 		/* Look for a newer patch in our cache: */
 		mc = find_patch(uci);
 		if (!mc)
-			return 0;
+			return UCODE_NFOUND;
 	}
 
 	/* write microcode via MSR 0x79 */
@@ -801,7 +801,7 @@ static int apply_microcode_intel(int cpu)
 	if (rev != mc->hdr.rev) {
 		pr_err("CPU%d update to revision 0x%x failed\n",
 		       cpu, mc->hdr.rev);
-		return -1;
+		return UCODE_ERROR;
 	}
 
 	if (rev != prev_rev) {
@@ -818,7 +818,7 @@ static int apply_microcode_intel(int cpu)
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
-	return 0;
+	return UCODE_UPDATED;
 }
 
 static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 04a625f0fcda..0f545b3cf926 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -23,6 +23,7 @@
 #include <asm/nops.h>
 #include "../entry/calling.h"
 #include <asm/export.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -134,6 +135,7 @@ ENTRY(secondary_startup_64)
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 1f9188f5357c..feb28fee6cea 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -5,7 +5,6 @@
 #include <asm/unwind.h>
 #include <asm/orc_types.h>
 #include <asm/orc_lookup.h>
-#include <asm/sections.h>
 
 #define orc_warn(fmt, ...) \
 	printk_deferred_once(KERN_WARNING pr_fmt("WARNING: " fmt), ##__VA_ARGS__)
@@ -148,7 +147,7 @@ static struct orc_entry *orc_find(unsigned long ip)
 	}
 
 	/* vmlinux .init slow lookup: */
-	if (ip >= (unsigned long)_sinittext && ip < (unsigned long)_einittext)
+	if (init_kernel_text(ip))
 		return __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
 				  __stop_orc_unwind_ip - __start_orc_unwind_ip, ip);
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b3e488a74828..24c9521ebc24 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -49,6 +49,7 @@
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include <asm/virtext.h>
@@ -5355,7 +5356,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * being speculatively taken.
 	 */
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5464,11 +5465,11 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
+		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 3dec126aa302..7f8401d05939 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -51,6 +51,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/mmu_context.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include "trace.h"
@@ -9452,7 +9453,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * being speculatively taken.
 	 */
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9587,11 +9588,11 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
+		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 91e9700cc6dc..25a972c61b0a 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -28,7 +28,6 @@ lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
-OBJECT_FILES_NON_STANDARD_retpoline.o :=y
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 480edc3a5e03..c909961e678a 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -7,7 +7,6 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
-#include <asm/bitsperlong.h>
 
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
@@ -47,58 +46,3 @@ GENERATE_THUNK(r13)
 GENERATE_THUNK(r14)
 GENERATE_THUNK(r15)
 #endif
-
-/*
- * Fill the CPU return stack buffer.
- *
- * Each entry in the RSB, if used for a speculative 'ret', contains an
- * infinite 'pause; lfence; jmp' loop to capture speculative execution.
- *
- * This is required in various cases for retpoline and IBRS-based
- * mitigations for the Spectre variant 2 vulnerability. Sometimes to
- * eliminate potentially bogus entries from the RSB, and sometimes
- * purely to ensure that it doesn't get empty, which on some CPUs would
- * allow predictions from other (unwanted!) sources to be used.
- *
- * Google experimented with loop-unrolling and this turned out to be
- * the optimal version - two calls, each with their own speculation
- * trap should their return address end up getting used, in a loop.
- */
-.macro STUFF_RSB nr:req sp:req
-	mov	$(\nr / 2), %_ASM_BX
-	.align 16
-771:
-	call	772f
-773:						/* speculation trap */
-	pause
-	lfence
-	jmp	773b
-	.align 16
-772:
-	call	774f
-775:						/* speculation trap */
-	pause
-	lfence
-	jmp	775b
-	.align 16
-774:
-	dec	%_ASM_BX
-	jnz	771b
-	add	$((BITS_PER_LONG/8) * \nr), \sp
-.endm
-
-#define RSB_FILL_LOOPS		16	/* To avoid underflow */
-
-ENTRY(__fill_rsb)
-	STUFF_RSB RSB_FILL_LOOPS, %_ASM_SP
-	ret
-END(__fill_rsb)
-EXPORT_SYMBOL_GPL(__fill_rsb)
-
-#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
-
-ENTRY(__clear_rsb)
-	STUFF_RSB RSB_CLEAR_LOOPS, %_ASM_SP
-	ret
-END(__clear_rsb)
-EXPORT_SYMBOL_GPL(__clear_rsb)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 800de815519c..c88573d90f3e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1248,10 +1248,6 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	tsk = current;
 	mm = tsk->mm;
 
-	/*
-	 * Detect and handle instructions that would cause a page fault for
-	 * both a tracked kernel page and a userspace page.
-	 */
 	prefetchw(&mm->mmap_sem);
 
 	if (unlikely(kmmio_fault(regs, address)))
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index 01f682cf77a8..40a6085063d6 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/processor-flags.h>
 #include <asm/msr-index.h>
+#include <asm/nospec-branch.h>
 
 	.text
 	.code64
@@ -59,6 +60,7 @@ ENTRY(sme_encrypt_execute)
 	movq	%rax, %r8		/* Workarea encryption routine */
 	addq	$PAGE_SIZE, %r8		/* Workarea intermediate copy buffer */
 
+	ANNOTATE_RETPOLINE_SAFE
 	call	*%rax			/* Call the encryption routine */
 
 	pop	%r12
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index de53bd15df5a..24bb7598774e 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -102,7 +102,7 @@ ENTRY(startup_32)
 	 * don't we'll eventually crash trying to execute encrypted
 	 * instructions.
 	 */
-	bt	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
+	btl	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
 	jnc	.Ldone
 	movl	$MSR_K8_SYSCFG, %ecx
 	rdmsr
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index d02a4df3f473..d3f264a5b04d 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -27,3 +27,8 @@
 #if __has_feature(address_sanitizer)
 #define __SANITIZE_ADDRESS__
 #endif
+
+/* Clang doesn't have a way to turn it off per-function, yet. */
+#ifdef __noretpoline
+#undef __noretpoline
+#endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 73bc63e0a1c4..673fbf904fe5 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -93,6 +93,10 @@
 #define __weak		__attribute__((weak))
 #define __alias(symbol)	__attribute__((alias(#symbol)))
 
+#ifdef RETPOLINE
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#endif
+
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
diff --git a/include/linux/init.h b/include/linux/init.h
index 506a98151131..bc27cf03c41e 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -6,10 +6,10 @@
 #include <linux/types.h>
 
 /* Built-in __init functions needn't be compiled with retpoline */
-#if defined(RETPOLINE) && !defined(MODULE)
-#define __noretpoline __attribute__((indirect_branch("keep")))
+#if defined(__noretpoline) && !defined(MODULE)
+#define __noinitretpoline __noretpoline
 #else
-#define __noretpoline
+#define __noinitretpoline
 #endif
 
 /* These macros are used to mark some functions or 
@@ -47,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold  __latent_entropy __noretpoline
+#define __init		__section(.init.text) __cold  __latent_entropy __noinitretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b6a29c126cc4..2168cc6b8b30 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -151,6 +151,7 @@ extern struct jump_entry __start___jump_table[];
 extern struct jump_entry __stop___jump_table[];
 
 extern void jump_label_init(void);
+extern void jump_label_invalidate_init(void);
 extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
@@ -198,6 +199,8 @@ static __always_inline void jump_label_init(void)
 	static_key_initialized = true;
 }
 
+static inline void jump_label_invalidate_init(void) {}
+
 static __always_inline bool static_key_false(struct static_key *key)
 {
 	if (unlikely(static_key_count(key) > 0))
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ce51455e2adf..3fd291503576 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -472,6 +472,7 @@ extern bool parse_option_str(const char *str, const char *option);
 extern char *next_arg(char *args, char **param, char **val);
 
 extern int core_kernel_text(unsigned long addr);
+extern int init_kernel_text(unsigned long addr);
 extern int core_kernel_data(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index fbc98e2c8228..e791ebc65c9c 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,7 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+#include <asm/barrier.h>
 
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
@@ -29,26 +30,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 }
 #endif
 
-/*
- * Warn developers about inappropriate array_index_nospec() usage.
- *
- * Even if the CPU speculates past the WARN_ONCE branch, the
- * sign bit of @index is taken into account when generating the
- * mask.
- *
- * This warning is compiled out when the compiler can infer that
- * @index and @size are less than LONG_MAX.
- */
-#define array_index_mask_nospec_check(index, size)				\
-({										\
-	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,			\
-	    "array_index_nospec() limited to range of [0, LONG_MAX]\n"))	\
-		_mask = 0;							\
-	else									\
-		_mask = array_index_mask_nospec(index, size);			\
-	_mask;									\
-})
-
 /*
  * array_index_nospec - sanitize an array index after a bounds check
  *
@@ -67,12 +48,11 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
+	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &= _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
diff --git a/init/main.c b/init/main.c
index a8100b954839..969eaf140ef0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -89,6 +89,7 @@
 #include <linux/io.h>
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
+#include <linux/jump_label.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1000,6 +1001,7 @@ static int __ref kernel_init(void *unused)
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
 	ftrace_free_init_mem();
+	jump_label_invalidate_init();
 	free_initmem();
 	mark_readonly();
 	system_state = SYSTEM_RUNNING;
diff --git a/kernel/extable.c b/kernel/extable.c
index a17fdb63dc3e..6a5b61ebc66c 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -64,7 +64,7 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
 	return e;
 }
 
-static inline int init_kernel_text(unsigned long addr)
+int init_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_sinittext &&
 	    addr < (unsigned long)_einittext)
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b4517095db6a..52a0a7af8640 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -366,12 +366,15 @@ static void __jump_label_update(struct static_key *key,
 {
 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
 		/*
-		 * entry->code set to 0 invalidates module init text sections
-		 * kernel_text_address() verifies we are not in core kernel
-		 * init code, see jump_label_invalidate_module_init().
+		 * An entry->code of 0 indicates an entry which has been
+		 * disabled because it was in an init text area.
 		 */
-		if (entry->code && kernel_text_address(entry->code))
-			arch_jump_label_transform(entry, jump_label_type(entry));
+		if (entry->code) {
+			if (kernel_text_address(entry->code))
+				arch_jump_label_transform(entry, jump_label_type(entry));
+			else
+				WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);
+		}
 	}
 }
 
@@ -417,6 +420,19 @@ void __init jump_label_init(void)
 	cpus_read_unlock();
 }
 
+/* Disable any jump label entries in __init code */
+void __init jump_label_invalidate_init(void)
+{
+	struct jump_entry *iter_start = __start___jump_table;
+	struct jump_entry *iter_stop = __stop___jump_table;
+	struct jump_entry *iter;
+
+	for (iter = iter_start; iter < iter_stop; iter++) {
+		if (init_kernel_text(iter->code))
+			iter->code = 0;
+	}
+}
+
 #ifdef CONFIG_MODULES
 
 static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
@@ -633,6 +649,7 @@ static void jump_label_del_module(struct module *mod)
 	}
 }
 
+/* Disable any jump label entries in module init code */
 static void jump_label_invalidate_module_init(struct module *mod)
 {
 	struct jump_entry *iter_start = mod->jump_entries;
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 47cddf32aeba..4f2b25d43ec9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -256,6 +256,8 @@ __objtool_obj := $(objtree)/tools/objtool/objtool
 
 objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
 
+objtool_args += $(if $(part-of-module), --module,)
+
 ifndef CONFIG_FRAME_POINTER
 objtool_args += --no-fp
 endif
@@ -264,6 +266,12 @@ objtool_args += --no-unreachable
 else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
+ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_CFLAGS),)
+  objtool_args += --retpoline
+endif
+endif
+
 
 ifdef CONFIG_MODVERSIONS
 objtool_o = $(@D)/.tmp_$(@F)
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 57254f5b2779..694abc628e9b 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable;
+bool no_fp, no_unreachable, retpoline, module;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -39,6 +39,8 @@ static const char * const check_usage[] = {
 const struct option check_options[] = {
 	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
+	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
+	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
 	OPT_END(),
 };
 
@@ -53,5 +55,5 @@ int cmd_check(int argc, const char **argv)
 
 	objname = argv[0];
 
-	return check(objname, no_fp, no_unreachable, false);
+	return check(objname, false);
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 91e8e19ff5e0..77ea2b97117d 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -25,7 +25,6 @@
  */
 
 #include <string.h>
-#include <subcmd/parse-options.h>
 #include "builtin.h"
 #include "check.h"
 
@@ -36,9 +35,6 @@ static const char *orc_usage[] = {
 	NULL,
 };
 
-extern const struct option check_options[];
-extern bool no_fp, no_unreachable;
-
 int cmd_orc(int argc, const char **argv)
 {
 	const char *objname;
@@ -54,7 +50,7 @@ int cmd_orc(int argc, const char **argv)
 
 		objname = argv[0];
 
-		return check(objname, no_fp, no_unreachable, true);
+		return check(objname, true);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index dd526067fed5..28ff40e19a14 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -17,6 +17,11 @@
 #ifndef _BUILTIN_H
 #define _BUILTIN_H
 
+#include <subcmd/parse-options.h>
+
+extern const struct option check_options[];
+extern bool no_fp, no_unreachable, retpoline, module;
+
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a8cb69a26576..472e64e95891 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "builtin.h"
 #include "check.h"
 #include "elf.h"
 #include "special.h"
@@ -33,7 +34,6 @@ struct alternative {
 };
 
 const char *objname;
-static bool no_fp;
 struct cfi_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
@@ -497,6 +497,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * disguise, so convert them accordingly.
 			 */
 			insn->type = INSN_JUMP_DYNAMIC;
+			insn->retpoline_safe = true;
 			continue;
 		} else {
 			/* sibling call */
@@ -548,7 +549,8 @@ static int add_call_destinations(struct objtool_file *file)
 			if (!insn->call_dest && !insn->ignore) {
 				WARN_FUNC("unsupported intra-function call",
 					  insn->sec, insn->offset);
-				WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+				if (retpoline)
+					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
 				return -1;
 			}
 
@@ -1108,6 +1110,54 @@ static int read_unwind_hints(struct objtool_file *file)
 	return 0;
 }
 
+static int read_retpoline_hints(struct objtool_file *file)
+{
+	struct section *sec, *relasec;
+	struct instruction *insn;
+	struct rela *rela;
+	int i;
+
+	sec = find_section_by_name(file->elf, ".discard.retpoline_safe");
+	if (!sec)
+		return 0;
+
+	relasec = sec->rela;
+	if (!relasec) {
+		WARN("missing .rela.discard.retpoline_safe section");
+		return -1;
+	}
+
+	if (sec->len % sizeof(unsigned long)) {
+		WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
+		return -1;
+	}
+
+	for (i = 0; i < sec->len / sizeof(unsigned long); i++) {
+		rela = find_rela_by_dest(sec, i * sizeof(unsigned long));
+		if (!rela) {
+			WARN("can't find rela for retpoline_safe[%d]", i);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("can't find insn for retpoline_safe[%d]", i);
+			return -1;
+		}
+
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC) {
+			WARN_FUNC("retpoline_safe hint not a indirect jump/call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		insn->retpoline_safe = true;
+	}
+
+	return 0;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
@@ -1146,6 +1196,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_retpoline_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1891,6 +1945,38 @@ static int validate_unwind_hints(struct objtool_file *file)
 	return warnings;
 }
 
+static int validate_retpoline(struct objtool_file *file)
+{
+	struct instruction *insn;
+	int warnings = 0;
+
+	for_each_insn(file, insn) {
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC)
+			continue;
+
+		if (insn->retpoline_safe)
+			continue;
+
+		/*
+		 * .init.text code is ran before userspace and thus doesn't
+		 * strictly need retpolines, except for modules which are
+		 * loaded late, they very much do need retpoline in their
+		 * .init.text
+		 */
+		if (!strcmp(insn->sec->name, ".init.text") && !module)
+			continue;
+
+		WARN_FUNC("indirect %s found in RETPOLINE build",
+			  insn->sec, insn->offset,
+			  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
+
+		warnings++;
+	}
+
+	return warnings;
+}
+
 static bool is_kasan_insn(struct instruction *insn)
 {
 	return (insn->type == INSN_CALL &&
@@ -2022,13 +2108,12 @@ static void cleanup(struct objtool_file *file)
 	elf_close(file->elf);
 }
 
-int check(const char *_objname, bool _no_fp, bool no_unreachable, bool orc)
+int check(const char *_objname, bool orc)
 {
 	struct objtool_file file;
 	int ret, warnings = 0;
 
 	objname = _objname;
-	no_fp = _no_fp;
 
 	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
@@ -2052,6 +2137,13 @@ int check(const char *_objname, bool _no_fp, bool no_unreachable, bool orc)
 	if (list_empty(&file.insn_list))
 		goto out;
 
+	if (retpoline) {
+		ret = validate_retpoline(&file);
+		if (ret < 0)
+			return ret;
+		warnings += ret;
+	}
+
 	ret = validate_functions(&file);
 	if (ret < 0)
 		goto out;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 23a1d065cae1..c6b68fcb926f 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -45,6 +45,7 @@ struct instruction {
 	unsigned char type;
 	unsigned long immediate;
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool retpoline_safe;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
@@ -63,7 +64,7 @@ struct objtool_file {
 	bool ignore_unreachables, c_file, hints;
 };
 
-int check(const char *objname, bool no_fp, bool no_unreachable, bool orc);
+int check(const char *objname, bool orc);
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
--8323329-421047950-1519651523=:1896--
