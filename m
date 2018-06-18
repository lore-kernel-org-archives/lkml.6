Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC58208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC58208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966283AbeFRJ0L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:26:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966044AbeFRI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:26:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B7AECA0;
        Mon, 18 Jun 2018 08:26:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 236/279] x86/selftests: Add mov_to_ss test
Date:   Mon, 18 Jun 2018 10:13:41 +0200
Message-Id: <20180618080618.571707339@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

[ Upstream commit 59c2a7226fc5130032021c99f05ad5c0a56551cd ]

This exercises a nasty corner case of the x86 ISA.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/67e08b69817171da8026e0eb3af0214b06b4d74f.1525800455.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/x86/Makefile      |    2 
 tools/testing/selftests/x86/mov_ss_trap.c |  285 ++++++++++++++++++++++++++++++
 2 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/mov_ss_trap.c

--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,7 @@ CAN_BUILD_X86_64 := $(shell ./check_cc.s
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
-			protection_keys test_vdso test_vsyscall
+			protection_keys test_vdso test_vsyscall mov_ss_trap
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
--- /dev/null
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -0,0 +1,285 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mov_ss_trap.c: Exercise the bizarre side effects of a watchpoint on MOV SS
+ *
+ * This does MOV SS from a watchpointed address followed by various
+ * types of kernel entries.  A MOV SS that hits a watchpoint will queue
+ * up a #DB trap but will not actually deliver that trap.  The trap
+ * will be delivered after the next instruction instead.  The CPU's logic
+ * seems to be:
+ *
+ *  - Any fault: drop the pending #DB trap.
+ *  - INT $N, INT3, INTO, SYSCALL, SYSENTER: enter the kernel and then
+ *    deliver #DB.
+ *  - ICEBP: enter the kernel but do not deliver the watchpoint trap
+ *  - breakpoint: only one #DB is delivered (phew!)
+ *
+ * There are plenty of ways for a kernel to handle this incorrectly.  This
+ * test tries to exercise all the cases.
+ *
+ * This should mostly cover CVE-2018-1087 and CVE-2018-8897.
+ */
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/user.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <err.h>
+#include <string.h>
+#include <setjmp.h>
+#include <sys/prctl.h>
+
+#define X86_EFLAGS_RF (1UL << 16)
+
+#if __x86_64__
+# define REG_IP REG_RIP
+#else
+# define REG_IP REG_EIP
+#endif
+
+unsigned short ss;
+extern unsigned char breakpoint_insn[];
+sigjmp_buf jmpbuf;
+static unsigned char altstack_data[SIGSTKSZ];
+
+static void enable_watchpoint(void)
+{
+	pid_t parent = getpid();
+	int status;
+
+	pid_t child = fork();
+	if (child < 0)
+		err(1, "fork");
+
+	if (child) {
+		if (waitpid(child, &status, 0) != child)
+			err(1, "waitpid for child");
+	} else {
+		unsigned long dr0, dr1, dr7;
+
+		dr0 = (unsigned long)&ss;
+		dr1 = (unsigned long)breakpoint_insn;
+		dr7 = ((1UL << 1) |	/* G0 */
+		       (3UL << 16) |	/* RW0 = read or write */
+		       (1UL << 18) |	/* LEN0 = 2 bytes */
+		       (1UL << 3));	/* G1, RW1 = insn */
+
+		if (ptrace(PTRACE_ATTACH, parent, NULL, NULL) != 0)
+			err(1, "PTRACE_ATTACH");
+
+		if (waitpid(parent, &status, 0) != parent)
+			err(1, "waitpid for child");
+
+		if (ptrace(PTRACE_POKEUSER, parent, (void *)offsetof(struct user, u_debugreg[0]), dr0) != 0)
+			err(1, "PTRACE_POKEUSER DR0");
+
+		if (ptrace(PTRACE_POKEUSER, parent, (void *)offsetof(struct user, u_debugreg[1]), dr1) != 0)
+			err(1, "PTRACE_POKEUSER DR1");
+
+		if (ptrace(PTRACE_POKEUSER, parent, (void *)offsetof(struct user, u_debugreg[7]), dr7) != 0)
+			err(1, "PTRACE_POKEUSER DR7");
+
+		printf("\tDR0 = %lx, DR1 = %lx, DR7 = %lx\n", dr0, dr1, dr7);
+
+		if (ptrace(PTRACE_DETACH, parent, NULL, NULL) != 0)
+			err(1, "PTRACE_DETACH");
+
+		exit(0);
+	}
+}
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static char const * const signames[] = {
+	[SIGSEGV] = "SIGSEGV",
+	[SIGBUS] = "SIBGUS",
+	[SIGTRAP] = "SIGTRAP",
+	[SIGILL] = "SIGILL",
+};
+
+static void sigtrap(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = ctx_void;
+
+	printf("\tGot SIGTRAP with RIP=%lx, EFLAGS.RF=%d\n",
+	       (unsigned long)ctx->uc_mcontext.gregs[REG_IP],
+	       !!(ctx->uc_mcontext.gregs[REG_EFL] & X86_EFLAGS_RF));
+}
+
+static void handle_and_return(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = ctx_void;
+
+	printf("\tGot %s with RIP=%lx\n", signames[sig],
+	       (unsigned long)ctx->uc_mcontext.gregs[REG_IP]);
+}
+
+static void handle_and_longjmp(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = ctx_void;
+
+	printf("\tGot %s with RIP=%lx\n", signames[sig],
+	       (unsigned long)ctx->uc_mcontext.gregs[REG_IP]);
+
+	siglongjmp(jmpbuf, 1);
+}
+
+int main()
+{
+	unsigned long nr;
+
+	asm volatile ("mov %%ss, %[ss]" : [ss] "=m" (ss));
+	printf("\tSS = 0x%hx, &SS = 0x%p\n", ss, &ss);
+
+	if (prctl(PR_SET_PTRACER, PR_SET_PTRACER_ANY, 0, 0, 0) == 0)
+		printf("\tPR_SET_PTRACER_ANY succeeded\n");
+
+	printf("\tSet up a watchpoint\n");
+	sethandler(SIGTRAP, sigtrap, 0);
+	enable_watchpoint();
+
+	printf("[RUN]\tRead from watched memory (should get SIGTRAP)\n");
+	asm volatile ("mov %[ss], %[tmp]" : [tmp] "=r" (nr) : [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; INT3\n");
+	asm volatile ("mov %[ss], %%ss; int3" :: [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; INT 3\n");
+	asm volatile ("mov %[ss], %%ss; .byte 0xcd, 0x3" :: [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; CS CS INT3\n");
+	asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; CSx14 INT3\n");
+	asm volatile ("mov %[ss], %%ss; .fill 14,1,0x2e; int3" :: [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; INT 4\n");
+	sethandler(SIGSEGV, handle_and_return, SA_RESETHAND);
+	asm volatile ("mov %[ss], %%ss; int $4" :: [ss] "m" (ss));
+
+#ifdef __i386__
+	printf("[RUN]\tMOV SS; INTO\n");
+	sethandler(SIGSEGV, handle_and_return, SA_RESETHAND);
+	nr = -1;
+	asm volatile ("add $1, %[tmp]; mov %[ss], %%ss; into"
+		      : [tmp] "+r" (nr) : [ss] "m" (ss));
+#endif
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; ICEBP\n");
+
+		/* Some emulators (e.g. QEMU TCG) don't emulate ICEBP. */
+		sethandler(SIGILL, handle_and_longjmp, SA_RESETHAND);
+
+		asm volatile ("mov %[ss], %%ss; .byte 0xf1" :: [ss] "m" (ss));
+	}
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; CLI\n");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND);
+		asm volatile ("mov %[ss], %%ss; cli" :: [ss] "m" (ss));
+	}
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; #PF\n");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND);
+		asm volatile ("mov %[ss], %%ss; mov (-1), %[tmp]"
+			      : [tmp] "=r" (nr) : [ss] "m" (ss));
+	}
+
+	/*
+	 * INT $1: if #DB has DPL=3 and there isn't special handling,
+	 * then the kernel will die.
+	 */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; INT 1\n");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND);
+		asm volatile ("mov %[ss], %%ss; int $1" :: [ss] "m" (ss));
+	}
+
+#ifdef __x86_64__
+	/*
+	 * In principle, we should test 32-bit SYSCALL as well, but
+	 * the calling convention is so unpredictable that it's
+	 * not obviously worth the effort.
+	 */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; SYSCALL\n");
+		sethandler(SIGILL, handle_and_longjmp, SA_RESETHAND);
+		nr = SYS_getpid;
+		/*
+		 * Toggle the high bit of RSP to make it noncanonical to
+		 * strengthen this test on non-SMAP systems.
+		 */
+		asm volatile ("btc $63, %%rsp\n\t"
+			      "mov %[ss], %%ss; syscall\n\t"
+			      "btc $63, %%rsp"
+			      : "+a" (nr) : [ss] "m" (ss)
+			      : "rcx"
+#ifdef __x86_64__
+				, "r11"
+#endif
+			);
+	}
+#endif
+
+	printf("[RUN]\tMOV SS; breakpointed NOP\n");
+	asm volatile ("mov %[ss], %%ss; breakpoint_insn: nop" :: [ss] "m" (ss));
+
+	/*
+	 * Invoking SYSENTER directly breaks all the rules.  Just handle
+	 * the SIGSEGV.
+	 */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; SYSENTER\n");
+		stack_t stack = {
+			.ss_sp = altstack_data,
+			.ss_size = SIGSTKSZ,
+		};
+		if (sigaltstack(&stack, NULL) != 0)
+			err(1, "sigaltstack");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND | SA_ONSTACK);
+		nr = SYS_getpid;
+		asm volatile ("mov %[ss], %%ss; SYSENTER" : "+a" (nr)
+			      : [ss] "m" (ss) : "flags", "rcx"
+#ifdef __x86_64__
+				, "r11"
+#endif
+			);
+
+		/* We're unreachable here.  SYSENTER forgets RIP. */
+	}
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; INT $0x80\n");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND);
+		nr = 20;	/* compat getpid */
+		asm volatile ("mov %[ss], %%ss; int $0x80"
+			      : "+a" (nr) : [ss] "m" (ss)
+			      : "flags"
+#ifdef __x86_64__
+				, "r8", "r9", "r10", "r11"
+#endif
+			);
+	}
+
+	printf("[OK]\tI aten't dead\n");
+	return 0;
+}


