Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226LkRXZT6iPakEfza+ZfoUQQz8U+Xg/lGA829F+oP0M4nLpR8/4J5ravRieT/0XfmCItMMx
ARC-Seal: i=1; a=rsa-sha256; t=1517855121; cv=none;
        d=google.com; s=arc-20160816;
        b=HQ93fp6ESj+eTgzqPf2SNGD15HpTefV0gFxEhQ4Q5EjRhJWoQOhLllTYBrY+Lu3huw
         PUPaD+hxZ9oQgxUJg63xcryqfpKtb3rJR+uFrCD8HF6I7wzA7VxY1GOKcPNdsJwWYVDl
         zDdgGdspRfYQr+t219L1NgwCLNZFxfHikWl+TWZ2CDeyXfGD0Lt7G2FIkIl64EGFFDEQ
         47O/enWIRG8gnvGjMxPCFn00vpQsTebfz1VXPt4rdkfSRUDUu/QMlj/MmjNtLwlu5wvL
         AYGy/+/VZNTjR8jxzwK7bC6trzjeMVgLqEXpauR3QBK4yX0dlegt5X2W/pPJBVMny7pB
         qTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X/8iSHH2hYFwlsflEDjnCV+ufcupDxGRAajjnWPSKJ4=;
        b=rFoNX+OdFAm9wLhDtYI5JajKIL/PqcFz0+JgcOmpxgtrp5trwVEOfKceM0LgmoJgi0
         7Te1NLW1SjyIlUP1Bv7O7xrGk5imsva1WV8TzPawpcWzBdimAFQ74eRDNOQHy7w2+y2o
         XgtL8lPhvMN9IewiPc95cSyxJ8dTFfz+K7+9+niJ4/RuTTVJ9M1GgkOU0pv204pfCxAu
         GMXvKd995n6AeHD6/bV6qssH3y8EjWQRl7U8xaXaxwbvfgk0TXm49Lbwl+Dj4h5a8Um/
         2ffixS4vi9iIKOwCjlEEJH6IpPVgxA2hArA6X+IqtjUkQzLq7+d1PVz9wSyIPxcqYfOA
         U1AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH 4.15 29/60] x86/entry/64: Remove the SYSCALL64 fast path
Date: Mon,  5 Feb 2018 10:23:02 -0800
Message-Id: <20180205182215.140851908@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586366090171464?=
X-GMAIL-MSGID: =?utf-8?q?1591586451972771489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski luto@kernel.org

commit 21d375b6b34ff511a507de27bf316b3dde6938d9

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/entry/entry_64.S   |  117 --------------------------------------------
 arch/x86/entry/syscall_64.c |    7 --
 2 files changed, 2 insertions(+), 122 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -241,86 +241,11 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 
 	TRACE_IRQS_OFF
 
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
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
-	movq	PER_CPU_VAR(current_task), %r11
-	testl	$_TIF_ALLWORK_MASK, TASK_TI_flags(%r11)
-	jnz	1f
-
-	LOCKDEP_SYS_EXIT
-	TRACE_IRQS_ON		/* user mode is traced as IRQs on */
-	movq	RIP(%rsp), %rcx
-	movq	EFLAGS(%rsp), %r11
-	addq	$6*8, %rsp	/* skip extra regs -- they were preserved */
-	UNWIND_HINT_EMPTY
-	jmp	.Lpop_c_regs_except_rcx_r11_and_sysret
-
-1:
-	/*
-	 * The fast path looked good when we started, but something changed
-	 * along the way and we need to switch to the slow path.  Calling
-	 * raise(3) will trigger this, for example.  IRQs are off.
-	 */
-	TRACE_IRQS_ON
-	ENABLE_INTERRUPTS(CLBR_ANY)
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
 	TRACE_IRQS_IRETQ		/* we're about to change IF */
 
 	/*
@@ -393,7 +318,6 @@ syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
 	UNWIND_HINT_EMPTY
 	POP_EXTRA_REGS
-.Lpop_c_regs_except_rcx_r11_and_sysret:
 	popq	%rsi	/* skip r11 */
 	popq	%r10
 	popq	%r9
@@ -424,47 +348,6 @@ syscall_return_via_sysret:
 	USERGS_SYSRET64
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
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
-	popq	%rax
-	UNWIND_HINT_REGS extra=0
-	jmp	entry_SYSCALL64_slow_path
-
-1:
-	JMP_NOSPEC %rax				/* Called from C */
-END(stub_ptregs_64)
-
-.macro ptregs_stub func
-ENTRY(ptregs_\func)
-	UNWIND_HINT_FUNC
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
@@ -7,14 +7,11 @@
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
 
