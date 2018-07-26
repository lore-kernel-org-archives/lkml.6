Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC5D2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC5D2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeGZL5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:57:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:45074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728998AbeGZL5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:57:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE473AD73;
        Thu, 26 Jul 2018 10:41:33 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] x86/ftrace: make ftrace_int3_handler() not to skip fops invocation
Date:   Thu, 26 Jul 2018 12:40:29 +0200
Message-Id: <20180726104029.7736-2-nstange@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180726104029.7736-1-nstange@suse.de>
References: <20180726104029.7736-1-nstange@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With dynamic ftrace, ftrace patches call sites in a three steps:
1. Put a breakpoint at the to be patched location,
2. update call site and
3. finally remove the breakpoint again.

Note that the breakpoint ftrace_int3_handler() simply makes execution
to skip over the to be patched function.

This patching happens in the following circumstances:
- the global ftrace_trace_function changes and the call sites at
  ftrace_call and ftrace_regs_call get patched,
- an ftrace_ops' ->func changes and the call site in its trampoline gets
  patched,
- graph tracing gets enabled/disabled and the jump site at
  ftrace_graph_call gets patched
- a mcount site gets converted from nop -> call, call -> nop
  or call -> call.

The latter case, i.e. a mcount call getting redirected, happens for example
in a transition from trampolined to not trampolined upon a user enabling
function tracing on a live patched function.

The ftrace_int3_handler() simply skipping over the mcount callsite is
problematic here, because it means that a live patched function gets
temporarily reverted to its unpatched original and this breaks live
patching consistency.

Make ftrace_int3_handler not to skip over the fops invocation, but modify
the interrupted control flow to issue a call as needed.

For determining what the proper action actually is, modify
update_ftrace_func() to take an extra argument, func, to be called if the
corresponding breakpoint gets hit. Introduce a new global variable,
trace_update_func_dest and let update_ftrace_func() set it. For the special
case of patching the jmp insn at ftrace_graph_call, set it to zero and make
ftrace_int3_handler() just skip over the insn in this case as before.

Because there's no space left above the int3 handler's iret frame to stash
an extra call's return address in, this can't be mimicked from the
ftrace_int3_handler() itself.

Instead, make ftrace_int3_handler() change the iret frame's %rip slot to
point to the new ftrace_int3_call_trampoline to be executed immediately
after iret.

The original %rip gets communicated to ftrace_int3_call_trampoline which
can then take proper action. Note that ftrace_int3_call_trampoline can
nest, because of NMIs, for example. In order to avoid introducing another
stack, abuse %r11 for passing the original %rip. This is safe, because the
interrupted context is always at a call insn and according to the x86_64
ELF ABI allows %r11 is callee-clobbered. According to the glibc sources,
this is also true for the somewhat special mcount/fentry ABI.

OTOH, a spare register doesn't exist on i686 and thus, this is approach is
limited to x86_64.

For determining the call target address, let ftrace_int3_call_trampoline
compare ftrace_update_func against the interrupted %rip.

If they match, an update_ftrace_func() is currently pending and the
call site is either of ftrace_call, ftrace_regs_call or the call insn
within a fops' trampoline. Jump to the ftrace_update_func_dest location as
set by update_ftrace_func().

If OTOH the interrupted %rip doesn't equal ftrace_update_func, then
it points to an mcount call site. In this case, redirect control flow to
the most generic handler, ftrace_regs_caller, which will then do the right
thing.

Finally, reading ftrace_update_func and ftrace_update_func_dest from
outside of the int3 handler requires some care: inbetween adding and
removing the breakpoints, ftrace invokes run_sync() which basically
issues a couple of IPIs. Because the int3 handler has interrupts disabled,
it orders with run_sync().

To extend that ordering to also include ftrace_int3_call_trampoline, make
ftrace_int3_handler() disable interrupts within the iret frame returning to
it.

Store the original EFLAGS.IF into %r11's MSB which, because it represents
a kernel address, is redundant. Make ftrace_int3_call_trampoline restore
it when done.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 arch/x86/kernel/ftrace.c    | 48 ++++++++++++++++++++++++++++++++------
 arch/x86/kernel/ftrace_64.S | 56 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 01ebcb6f263e..3908a73370a8 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -227,9 +227,11 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	return -EINVAL;
 }
 
-static unsigned long ftrace_update_func;
+unsigned long ftrace_update_func;
+unsigned long ftrace_update_func_dest;
 
-static int update_ftrace_func(unsigned long ip, void *new)
+static int update_ftrace_func(unsigned long ip, void *new,
+			      unsigned long func)
 {
 	unsigned char old[MCOUNT_INSN_SIZE];
 	int ret;
@@ -237,6 +239,8 @@ static int update_ftrace_func(unsigned long ip, void *new)
 	memcpy(old, (void *)ip, MCOUNT_INSN_SIZE);
 
 	ftrace_update_func = ip;
+	ftrace_update_func_dest = func;
+
 	/* Make sure the breakpoints see the ftrace_update_func update */
 	smp_wmb();
 
@@ -257,13 +261,13 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	int ret;
 
 	new = ftrace_call_replace(ip, (unsigned long)func);
-	ret = update_ftrace_func(ip, new);
+	ret = update_ftrace_func(ip, new, (unsigned long)func);
 
 	/* Also update the regs callback function */
 	if (!ret) {
 		ip = (unsigned long)(&ftrace_regs_call);
 		new = ftrace_call_replace(ip, (unsigned long)func);
-		ret = update_ftrace_func(ip, new);
+		ret = update_ftrace_func(ip, new, (unsigned long)func);
 	}
 
 	return ret;
@@ -277,6 +281,10 @@ static int is_ftrace_caller(unsigned long ip)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_X86_64)
+extern char ftrace_int3_call_trampoline[];
+#endif
+
 /*
  * A breakpoint was added to the code address we are about to
  * modify, and this is the handle that will just skip over it.
@@ -287,6 +295,7 @@ static int is_ftrace_caller(unsigned long ip)
 int ftrace_int3_handler(struct pt_regs *regs)
 {
 	unsigned long ip;
+	unsigned long __maybe_unused eflags_if;
 
 	if (WARN_ON_ONCE(!regs))
 		return 0;
@@ -295,8 +304,33 @@ int ftrace_int3_handler(struct pt_regs *regs)
 	if (!ftrace_location(ip) && !is_ftrace_caller(ip))
 		return 0;
 
-	regs->ip += MCOUNT_INSN_SIZE - 1;
+#if IS_ENABLED(CONFIG_X86_64)
+	if (is_ftrace_caller(ip) && !ftrace_update_func_dest) {
+		/*
+		 * There's an update on ftrace_graph_call pending.
+		 * Just skip over it.
+		 */
+		regs->ip += MCOUNT_INSN_SIZE - 1;
+		return 1;
+	}
 
+	/*
+	 * Return to ftrace_int3_call_trampoline with interrupts
+	 * disabled in order to block ftrace's run_sync() IPIs
+	 * and keep ftrace_update_func_dest valid.
+	 */
+	eflags_if = regs->flags & X86_EFLAGS_IF;
+	regs->flags ^= eflags_if;
+	/*
+	 * The MSB of ip, which is a kernel address, is always one.
+	 * Abuse it to store EFLAGS.IF there.
+	 */
+	ip &= eflags_if << (BITS_PER_LONG - 1 - X86_EFLAGS_IF_BIT);
+	regs->r11 = ip;
+	regs->ip = (unsigned long)ftrace_int3_call_trampoline;
+#else /* !IS_ENABLED(CONFIG_X86_64) */
+	regs->ip += MCOUNT_INSN_SIZE - 1;
+#endif
 	return 1;
 }
 
@@ -870,7 +904,7 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
-	ret = update_ftrace_func(ip, new);
+	ret = update_ftrace_func(ip, new, (unsigned long)func);
 	set_memory_ro(ops->trampoline, npages);
 
 	/* The update should never fail */
@@ -966,7 +1000,7 @@ static int ftrace_mod_jmp(unsigned long ip, void *func)
 
 	new = ftrace_jmp_replace(ip, (unsigned long)func);
 
-	return update_ftrace_func(ip, new);
+	return update_ftrace_func(ip, new, 0);
 }
 
 int ftrace_enable_ftrace_graph_caller(void)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 91b2cff4b79a..b51d4fb9af79 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -9,6 +9,7 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/irqflags.h>
 
 	.code64
 	.section .entry.text, "ax"
@@ -262,6 +263,61 @@ GLOBAL(ftrace_regs_caller_end)
 ENDPROC(ftrace_regs_caller)
 
 
+ENTRY(ftrace_int3_call_trampoline)
+	/*
+	 * A breakpoint was hit on what either had been or will become
+	 * a call insn. Mimic the function call here: push the desired
+	 * return address on the stack and jmp to the target function.
+	 * The inverted value of EFLAGS.IF is stored in %r11's high bit.
+	 * The remaining bits of %r11 store the break point address
+	 * (whose MSB is known to always be set, because it's a kernel
+	 * address).
+	 */
+	UNWIND_HINT_EMPTY
+	subq $8, %rsp
+	pushq %rax
+	movq $1, %rax
+	shlq $63, %rax
+	orq %r11, %rax   /* ip is in %rax now */
+
+	/* Prepare the on-stack return address. */
+	pushq %rax
+	addq $5, %rax    /* ip + MCOUNT_INSN_SIZE */
+	movq %rax, 16(%rsp)
+	popq %rax
+
+	/*
+	 * Determine where to redirect control flow to. There are
+	 * two cases:
+	 * 1.) The breakpoint is at either of ftrace_call,
+	 *     ftrace_regs_call or the callsite within a fops' trampoline.
+	 * 2.) The breakpoint is at an mcount callsite.
+	 *
+	 * For the first case, update_ftrace_func has setup
+	 * ftrace_update_func_dest to the target address.
+	 * For the second case, just branch to the most generic
+	 * ftrace_regs_caller which will then do the right thing.
+	 */
+	cmpq %rax, ftrace_update_func(%rip)
+	jne 1f
+	movq ftrace_update_func_dest(%rip), %rax
+	jmp 2f
+1:
+	leaq ftrace_regs_caller(%rip), %rax
+2:
+	/* Restore EFLAGS.IF */
+	btq $63, %r11
+	jnc 3f
+	sti
+	TRACE_IRQS_ON
+3:
+	mov %rax, %r11
+	popq %rax
+
+	JMP_NOSPEC %r11
+END(ftrace_int3_call_trampoline)
+
+
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(function_hook)
-- 
2.13.7

