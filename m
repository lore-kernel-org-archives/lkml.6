Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C48ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325802075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Hmsw7H1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325802075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbeGRKV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:21:27 -0400
Received: from 8bytes.org ([81.169.241.247]:53890 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731455AbeGRKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 284E5303; Wed, 18 Jul 2018 11:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906880; bh=BL7Kp5pV3wZ3fLTD6+BZbD9XXZrZVXd/ey+VQ3E4kjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hmsw7H1n7aKXDFnWQT+xh+dJ7FieGwYl7OPvIlCpjQZfHGG6VIdQ1CMKbr1+GoxVV
         6YT5hQiwB22vEQYZGy+boDAwE1JAmUSEcKtXNYq+ILxPTKjszi1dd/ae/wMKQxp7k2
         tUWWtO1+2jqGgSD7omV6a9QZBPc4GHIe+Y6nNP/tZMfcYvxUPJyCY4U7RuRXVqyXVJ
         PZGHRrL2iMs92G/Ou8ycs1Ucc3pKSdMyC9hsq0glvitfr36bWRZWr7KYKjhVVQQ/eA
         nJXKbdmkV2NIbk+D1aKBC/sNIrj5Iv2Nn42x8iPIeK0CI5FfcUsvsrClUPubUT0LHO
         jB+0aVYvs42XA==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 07/39] x86/entry/32: Enter the kernel via trampoline stack
Date:   Wed, 18 Jul 2018 11:40:44 +0200
Message-Id: <1531906876-13451-8-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the entry-stack as a trampoline to enter the kernel. The
entry-stack is already in the cpu_entry_area and will be
mapped to userspace when PTI is enabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S        | 119 ++++++++++++++++++++++++++++++++-------
 arch/x86/include/asm/switch_to.h |  14 ++++-
 arch/x86/kernel/asm-offsets.c    |   1 +
 arch/x86/kernel/cpu/common.c     |   5 +-
 arch/x86/kernel/process.c        |   2 -
 arch/x86/kernel/process_32.c     |   2 -
 6 files changed, 115 insertions(+), 28 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 7251c4f..fea49ec 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -154,7 +154,7 @@
 
 #endif /* CONFIG_X86_32_LAZY_GS */
 
-.macro SAVE_ALL pt_regs_ax=%eax
+.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
 	cld
 	PUSH_GS
 	pushl	%fs
@@ -173,6 +173,12 @@
 	movl	$(__KERNEL_PERCPU), %edx
 	movl	%edx, %fs
 	SET_KERNEL_GS %edx
+
+	/* Switch to kernel stack if necessary */
+.if \switch_stacks > 0
+	SWITCH_TO_KERNEL_STACK
+.endif
+
 .endm
 
 /*
@@ -269,6 +275,73 @@
 .Lend_\@:
 #endif /* CONFIG_X86_ESPFIX32 */
 .endm
+
+
+/*
+ * Called with pt_regs fully populated and kernel segments loaded,
+ * so we can access PER_CPU and use the integer registers.
+ *
+ * We need to be very careful here with the %esp switch, because an NMI
+ * can happen everywhere. If the NMI handler finds itself on the
+ * entry-stack, it will overwrite the task-stack and everything we
+ * copied there. So allocate the stack-frame on the task-stack and
+ * switch to it before we do any copying.
+ */
+.macro SWITCH_TO_KERNEL_STACK
+
+	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
+
+	/* Are we on the entry stack? Bail out if not! */
+	movl	PER_CPU_VAR(cpu_entry_area), %ecx
+	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
+	subl	%esp, %ecx	/* ecx = (end of entry_stack) - esp */
+	cmpl	$SIZEOF_entry_stack, %ecx
+	jae	.Lend_\@
+
+	/* Load stack pointer into %esi and %edi */
+	movl	%esp, %esi
+	movl	%esi, %edi
+
+	/* Move %edi to the top of the entry stack */
+	andl	$(MASK_entry_stack), %edi
+	addl	$(SIZEOF_entry_stack), %edi
+
+	/* Load top of task-stack into %edi */
+	movl	TSS_entry2task_stack(%edi), %edi
+
+	/* Bytes to copy */
+	movl	$PTREGS_SIZE, %ecx
+
+#ifdef CONFIG_VM86
+	testl	$X86_EFLAGS_VM, PT_EFLAGS(%esi)
+	jz	.Lcopy_pt_regs_\@
+
+	/*
+	 * Stack-frame contains 4 additional segment registers when
+	 * coming from VM86 mode
+	 */
+	addl	$(4 * 4), %ecx
+
+.Lcopy_pt_regs_\@:
+#endif
+
+	/* Allocate frame on task-stack */
+	subl	%ecx, %edi
+
+	/* Switch to task-stack */
+	movl	%edi, %esp
+
+	/*
+	 * We are now on the task-stack and can safely copy over the
+	 * stack-frame
+	 */
+	shrl	$2, %ecx
+	cld
+	rep movsl
+
+.Lend_\@:
+.endm
+
 /*
  * %eax: prev task
  * %edx: next task
@@ -469,7 +542,7 @@ ENTRY(entry_SYSENTER_32)
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
 	pushl	%eax			/* pt_regs->orig_ax */
-	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest */
+	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest, stack already switched */
 
 	/*
 	 * SYSENTER doesn't filter flags, so we need to clear NT, AC
@@ -580,7 +653,8 @@ ENDPROC(entry_SYSENTER_32)
 ENTRY(entry_INT80_32)
 	ASM_CLAC
 	pushl	%eax			/* pt_regs->orig_ax */
-	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest */
+
+	SAVE_ALL pt_regs_ax=$-ENOSYS switch_stacks=1	/* save rest */
 
 	/*
 	 * User mode is traced as though IRQs are on, and the interrupt gate
@@ -677,7 +751,8 @@ END(irq_entries_start)
 common_interrupt:
 	ASM_CLAC
 	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
-	SAVE_ALL
+
+	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
@@ -685,16 +760,16 @@ common_interrupt:
 	jmp	ret_from_intr
 ENDPROC(common_interrupt)
 
-#define BUILD_INTERRUPT3(name, nr, fn)	\
-ENTRY(name)				\
-	ASM_CLAC;			\
-	pushl	$~(nr);			\
-	SAVE_ALL;			\
-	ENCODE_FRAME_POINTER;		\
-	TRACE_IRQS_OFF			\
-	movl	%esp, %eax;		\
-	call	fn;			\
-	jmp	ret_from_intr;		\
+#define BUILD_INTERRUPT3(name, nr, fn)			\
+ENTRY(name)						\
+	ASM_CLAC;					\
+	pushl	$~(nr);					\
+	SAVE_ALL switch_stacks=1;			\
+	ENCODE_FRAME_POINTER;				\
+	TRACE_IRQS_OFF					\
+	movl	%esp, %eax;				\
+	call	fn;					\
+	jmp	ret_from_intr;				\
 ENDPROC(name)
 
 #define BUILD_INTERRUPT(name, nr)		\
@@ -926,16 +1001,20 @@ common_exception:
 	pushl	%es
 	pushl	%ds
 	pushl	%eax
+	movl	$(__USER_DS), %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	$(__KERNEL_PERCPU), %eax
+	movl	%eax, %fs
 	pushl	%ebp
 	pushl	%edi
 	pushl	%esi
 	pushl	%edx
 	pushl	%ecx
 	pushl	%ebx
+	SWITCH_TO_KERNEL_STACK
 	ENCODE_FRAME_POINTER
 	cld
-	movl	$(__KERNEL_PERCPU), %ecx
-	movl	%ecx, %fs
 	UNWIND_ESPFIX_STACK
 	GS_TO_REG %ecx
 	movl	PT_GS(%esp), %edi		# get the function address
@@ -943,9 +1022,6 @@ common_exception:
 	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
 	REG_TO_PTGS %ecx
 	SET_KERNEL_GS %ecx
-	movl	$(__USER_DS), %ecx
-	movl	%ecx, %ds
-	movl	%ecx, %es
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi
@@ -964,6 +1040,7 @@ ENTRY(debug)
 	 */
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
+
 	SAVE_ALL
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# error code 0
@@ -999,6 +1076,7 @@ END(debug)
  */
 ENTRY(nmi)
 	ASM_CLAC
+
 #ifdef CONFIG_X86_ESPFIX32
 	pushl	%eax
 	movl	%ss, %eax
@@ -1066,7 +1144,8 @@ END(nmi)
 ENTRY(int3)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
-	SAVE_ALL
+
+	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 	TRACE_IRQS_OFF
 	xorl	%edx, %edx			# zero error code
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index eb5f799..8bc2f70 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -89,13 +89,23 @@ static inline void refresh_sysenter_cs(struct thread_struct *thread)
 /* This is used when switching tasks or entering/exiting vm86 mode. */
 static inline void update_sp0(struct task_struct *task)
 {
-	/* On x86_64, sp0 always points to the entry trampoline stack, which is constant: */
+	/* sp0 always points to the entry trampoline stack, which is constant: */
 #ifdef CONFIG_X86_32
-	load_sp0(task->thread.sp0);
+	if (static_cpu_has(X86_FEATURE_XENPV))
+		load_sp0(task->thread.sp0);
+	else
+		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
+	/*
+	 * x86-64 updates x86_tss.sp1 via cpu_current_top_of_stack. That
+	 * doesn't work on x86-32 because sp1 and
+	 * cpu_current_top_of_stack have different values (because of
+	 * the non-zero stack-padding on 32bit).
+	 */
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
+
 }
 
 #endif /* _ASM_X86_SWITCH_TO_H */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index a1e1628..01de31d 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -103,6 +103,7 @@ void common(void) {
 	OFFSET(CPU_ENTRY_AREA_entry_trampoline, cpu_entry_area, entry_trampoline);
 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
 	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
+	DEFINE(MASK_entry_stack, (~(sizeof(struct entry_stack) - 1)));
 
 	/* Offset for sp0 and sp1 into the tss_struct */
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3e..43a927e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1804,11 +1804,12 @@ void cpu_init(void)
 	enter_lazy_tlb(&init_mm, curr);
 
 	/*
-	 * Initialize the TSS.  Don't bother initializing sp0, as the initial
-	 * task never enters user mode.
+	 * Initialize the TSS.  sp0 points to the entry trampoline stack
+	 * regardless of what task is running.
 	 */
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 	load_TR_desc();
+	load_sp0((unsigned long)(cpu_entry_stack(cpu) + 1));
 
 	load_mm_ldt(&init_mm);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 30ca2d1..c93fcfd 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -57,14 +57,12 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw) = {
 		 */
 		.sp0 = (1UL << (BITS_PER_LONG-1)) + 1,
 
-#ifdef CONFIG_X86_64
 		/*
 		 * .sp1 is cpu_current_top_of_stack.  The init task never
 		 * runs user code, but cpu_current_top_of_stack should still
 		 * be well defined before the first context switch.
 		 */
 		.sp1 = TOP_OF_INIT_STACK,
-#endif
 
 #ifdef CONFIG_X86_32
 		.ss0 = __KERNEL_DS,
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index ec62cc7..0ae659d 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -290,8 +290,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
-	/* SYSENTER reads the task-stack from tss.sp1 */
-	this_cpu_write(cpu_tss_rw.x86_tss.sp1, next_p->thread.sp0);
 
 	/*
 	 * Restore %gs if needed (which is common)
-- 
2.7.4

