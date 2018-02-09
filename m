Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184769-2-15588050741909075315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184768; b=TEN3JTqUarTxMLrV9VgfTBwQIv7UA4VC768+UuVIZy5d7ar
    FvVxzCRyG3Iump9Z6VUAvjO97W3lYZz6abpszjs1fHUmiXyqR0AufQ3S4xWMAqJd
    h+58INGDN2mpSEk/+y7/z7hqUIMwGkxS1SAz3DvOGaq9lgJh0houp8IX/l3qW2c8
    5g1+0tfVdKP+p1nUEQbY785AetN+Gw8JdSJooPe5c+FCkvT1LSpxWxioOIOAsTm7
    ouNfQiYUsC+WF9orid25TAnHyWckIPTZ5ouBo/lBoYCEXSnMRo46Lw9OcZ3aX/oZ
    3tOJJcNcMalQND0l12MxOURH3yh701RkzDuRakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184768; bh=Nsd2/ct6KUEfdOFB9wG5dXe6WZ
    jX+I1+oZUK+wwQ724=; b=itIj67d41YiigzMixLpZ0P87wXvyhpuZ64aMzOALRv
    NSPOcUbY/0OFTIyKnfE8zuN42liHj+7i96sXnZ8wxvL5J9zfi5vggwet3MuGAKWK
    uMyGfxKZPDdAEYbt9UFk9lhBFYL1+XF9PXirzhEBjeYZWzdyGWBLhEPz2tfyhVV8
    lIQl8PRsEY2Nu97X0SYwzsbLkbocErwqPGKq+ja3TgjY+75i3m+xEFddB1kgWoKu
    LOJCZ9HwvQRZDQapOOBV/8k0sZy9p7vY4VG6U8Hd527f8WulZeZ5jdSGPI9cgSXH
    J8cRrH3LzXVacB3nzMQeTn1X20YS5YVzlSwMW0pIhp+Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeBINo0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINoY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 53/92] x86/entry/64: Remove the SYSCALL64 fast path
Date: Fri,  9 Feb 2018 14:39:22 +0100
Message-Id: <20180209133935.046221181@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

(cherry picked from commit 21d375b6b34ff511a507de27bf316b3dde6938d9)

The SYCALLL64 fast path was a nice, if small, optimization back in the good
old days when syscalls were actually reasonably fast.  Now there is PTI to
slow everything down, and indirect branches are verboten, making everything
messier.  The retpoline code in the fast path is particularly nasty.

Just get rid of the fast path. The slow path is barely slower.

[ tglx: Split out the 'push all extra regs' part ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Link: https://lkml.kernel.org/r/462dff8d4d64dfbfc851fbf3130641809d980ecd.1517164461.git.luto@kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/entry_64.S   |  123 --------------------------------------------
 arch/x86/entry/syscall_64.c |    7 --
 2 files changed, 3 insertions(+), 127 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -179,94 +179,11 @@ GLOBAL(entry_SYSCALL_64_after_swapgs)
 	pushq	%r11				/* pt_regs->r11 */
 	sub	$(6*8), %rsp			/* pt_regs->bp, bx, r12-15 not saved */
 
-	/*
-	 * If we need to do entry work or if we guess we'll need to do
-	 * exit work, go straight to the slow path.
-	 */
-	movq	PER_CPU_VAR(current_task), %r11
-	testl	$_TIF_WORK_SYSCALL_ENTRY|_TIF_ALLWORK_MASK, TASK_TI_flags(%r11)
-	jnz	entry_SYSCALL64_slow_path
-
-entry_SYSCALL_64_fastpath:
-	/*
-	 * Easy case: enable interrupts and issue the syscall.  If the syscall
-	 * needs pt_regs, we'll call a stub that disables interrupts again
-	 * and jumps to the slow path.
-	 */
-	TRACE_IRQS_ON
-	ENABLE_INTERRUPTS(CLBR_NONE)
-#if __SYSCALL_MASK == ~0
-	cmpq	$__NR_syscall_max, %rax
-#else
-	andl	$__SYSCALL_MASK, %eax
-	cmpl	$__NR_syscall_max, %eax
-#endif
-	ja	1f				/* return -ENOSYS (already in pt_regs->ax) */
-	movq	%r10, %rcx
-
-	/*
-	 * This call instruction is handled specially in stub_ptregs_64.
-	 * It might end up jumping to the slow path.  If it jumps, RAX
-	 * and all argument registers are clobbered.
-	 */
-#ifdef CONFIG_RETPOLINE
-	movq	sys_call_table(, %rax, 8), %rax
-	call	__x86_indirect_thunk_rax
-#else
-	call	*sys_call_table(, %rax, 8)
-#endif
-.Lentry_SYSCALL_64_after_fastpath_call:
-
-	movq	%rax, RAX(%rsp)
-1:
-
-	/*
-	 * If we get here, then we know that pt_regs is clean for SYSRET64.
-	 * If we see that no exit work is required (which we are required
-	 * to check with IRQs off), then we can go straight to SYSRET64.
-	 */
-	DISABLE_INTERRUPTS(CLBR_NONE)
-	TRACE_IRQS_OFF
-	movq	PER_CPU_VAR(current_task), %r11
-	testl	$_TIF_ALLWORK_MASK, TASK_TI_flags(%r11)
-	jnz	1f
-
-	LOCKDEP_SYS_EXIT
-	TRACE_IRQS_ON		/* user mode is traced as IRQs on */
-	movq	RIP(%rsp), %rcx
-	movq	EFLAGS(%rsp), %r11
-	RESTORE_C_REGS_EXCEPT_RCX_R11
-	/*
-	 * This opens a window where we have a user CR3, but are
-	 * running in the kernel.  This makes using the CS
-	 * register useless for telling whether or not we need to
-	 * switch CR3 in NMIs.  Normal interrupts are OK because
-	 * they are off here.
-	 */
-	SWITCH_USER_CR3
-	movq	RSP(%rsp), %rsp
-	USERGS_SYSRET64
-
-1:
-	/*
-	 * The fast path looked good when we started, but something changed
-	 * along the way and we need to switch to the slow path.  Calling
-	 * raise(3) will trigger this, for example.  IRQs are off.
-	 */
-	TRACE_IRQS_ON
-	ENABLE_INTERRUPTS(CLBR_NONE)
-	SAVE_EXTRA_REGS
-	movq	%rsp, %rdi
-	call	syscall_return_slowpath	/* returns with IRQs disabled */
-	jmp	return_from_SYSCALL_64
-
-entry_SYSCALL64_slow_path:
 	/* IRQs are off. */
 	SAVE_EXTRA_REGS
 	movq	%rsp, %rdi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-return_from_SYSCALL_64:
 	RESTORE_EXTRA_REGS
 	TRACE_IRQS_IRETQ		/* we're about to change IF */
 
@@ -339,6 +256,7 @@ return_from_SYSCALL_64:
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
 	RESTORE_C_REGS_EXCEPT_RCX_R11
+
 	/*
 	 * This opens a window where we have a user CR3, but are
 	 * running in the kernel.  This makes using the CS
@@ -363,45 +281,6 @@ opportunistic_sysret_failed:
 	jmp	restore_c_regs_and_iret
 END(entry_SYSCALL_64)
 
-ENTRY(stub_ptregs_64)
-	/*
-	 * Syscalls marked as needing ptregs land here.
-	 * If we are on the fast path, we need to save the extra regs,
-	 * which we achieve by trying again on the slow path.  If we are on
-	 * the slow path, the extra regs are already saved.
-	 *
-	 * RAX stores a pointer to the C function implementing the syscall.
-	 * IRQs are on.
-	 */
-	cmpq	$.Lentry_SYSCALL_64_after_fastpath_call, (%rsp)
-	jne	1f
-
-	/*
-	 * Called from fast path -- disable IRQs again, pop return address
-	 * and jump to slow path
-	 */
-	DISABLE_INTERRUPTS(CLBR_NONE)
-	TRACE_IRQS_OFF
-	popq	%rax
-	jmp	entry_SYSCALL64_slow_path
-
-1:
-	JMP_NOSPEC %rax				/* Called from C */
-END(stub_ptregs_64)
-
-.macro ptregs_stub func
-ENTRY(ptregs_\func)
-	leaq	\func(%rip), %rax
-	jmp	stub_ptregs_64
-END(ptregs_\func)
-.endm
-
-/* Instantiate ptregs_stub for each ptregs-using syscall */
-#define __SYSCALL_64_QUAL_(sym)
-#define __SYSCALL_64_QUAL_ptregs(sym) ptregs_stub sym
-#define __SYSCALL_64(nr, sym, qual) __SYSCALL_64_QUAL_##qual(sym)
-#include <asm/syscalls_64.h>
-
 /*
  * %rdi: prev task
  * %rsi: next task
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -6,14 +6,11 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_64_QUAL_(sym) sym
-#define __SYSCALL_64_QUAL_ptregs(sym) ptregs_##sym
-
-#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long __SYSCALL_64_QUAL_##qual(sym)(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
-#define __SYSCALL_64(nr, sym, qual) [nr] = __SYSCALL_64_QUAL_##qual(sym),
+#define __SYSCALL_64(nr, sym, qual) [nr] = sym,
 
 extern long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
