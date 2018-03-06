Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeCFJuH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:50:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33318 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753463AbeCFJtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:41 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/9] x86/dumpstack: Save first regs set for the executive summary
Date: Tue,  6 Mar 2018 10:49:20 +0100
Message-Id: <20180306094920.16917-10-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306094920.16917-1-bp@alien8.de>
References: <20180306094920.16917-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Save the regs set when we call __die() for the first time and print it
in oops_end().

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/dumpstack.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index e855815b00d4..409a5bd02a18 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -31,6 +31,8 @@ static u8 __opc[OPCODE_BUFSIZE];
 static u8 *opcodes = __opc;
 static int die_counter;
 
+static struct pt_regs exec_summary_regs;
+
 bool in_task_stack(unsigned long *stack, struct task_struct *task,
 		   struct stack_info *info)
 {
@@ -325,6 +327,9 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	raw_local_irq_restore(flags);
 	oops_exit();
 
+	/* Executive summary in case the oops scrolled away */
+	__show_regs(&exec_summary_regs, false);
+
 	if (!signr)
 		return;
 	if (in_interrupt())
@@ -343,10 +348,10 @@ NOKPROBE_SYMBOL(oops_end);
 
 int __die(const char *str, struct pt_regs *regs, long err)
 {
-#ifdef CONFIG_X86_32
-	unsigned short ss;
-	unsigned long sp;
-#endif
+	/* Save the regs of the first oops for the executive summary later. */
+	if (!die_counter)
+		exec_summary_regs = *regs;
+
 	printk(KERN_DEFAULT
 	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
 	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT"         : "",
@@ -356,26 +361,14 @@ int __die(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
 
+	show_regs(regs);
+
 	if (notify_die(DIE_OOPS, str, regs, err,
 			current->thread.trap_nr, SIGSEGV) == NOTIFY_STOP)
 		return 1;
 
 	print_modules();
-	show_regs(regs);
-#ifdef CONFIG_X86_32
-	if (user_mode(regs)) {
-		sp = regs->sp;
-		ss = regs->ss;
-	} else {
-		sp = kernel_stack_pointer(regs);
-		savesegment(ss, ss);
-	}
-	printk(KERN_EMERG "EIP: %pS SS:ESP: %04x:%08lx\n",
-	       (void *)regs->ip, ss, sp);
-#else
-	/* Executive summary in case the oops scrolled away */
-	printk(KERN_ALERT "RIP: %pS RSP: %016lx\n", (void *)regs->ip, regs->sp);
-#endif
+
 	return 0;
 }
 NOKPROBE_SYMBOL(__die);
@@ -442,7 +435,5 @@ void show_regs(struct pt_regs *regs)
 
 		if (regs->ip < PAGE_OFFSET)
 			pr_cont(" Bad RIP value.\n");
-		else
-			show_opcodes((u8 *)regs->ip, KERN_DEFAULT);
 	}
 }
-- 
2.13.0
