Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeCFJwB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:52:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33298 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbeCFJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:37 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9] x86/dumpstack: Unify show_regs()
Date: Tue,  6 Mar 2018 10:49:14 +0100
Message-Id: <20180306094920.16917-4-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306094920.16917-1-bp@alien8.de>
References: <20180306094920.16917-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The 32-bit version uses KERN_EMERG and commit

  b0f4c4b32c8e ("bugs, x86: Fix printk levels for panic, softlockups and stack dumps")

changed the 64-bit version to KERN_DEFAULT. The same justification in
that commit that those messages do not belong in the terminal, holds
true for 32-bit also, so make it so.

Make code_bytes static, while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/stacktrace.h |  2 --
 arch/x86/kernel/dumpstack.c       | 49 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/dumpstack_32.c    | 42 ---------------------------------
 arch/x86/kernel/dumpstack_64.c    | 42 ---------------------------------
 4 files changed, 48 insertions(+), 87 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index f73706878772..133d9425fced 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -87,8 +87,6 @@ get_stack_pointer(struct task_struct *task, struct pt_regs *regs)
 void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			unsigned long *stack, char *log_lvl);
 
-extern unsigned int code_bytes;
-
 /* The form of the top of the frame on the stack */
 struct stack_frame {
 	struct stack_frame *next_frame;
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a2d8a3908670..18fa9d74c182 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -24,7 +24,7 @@
 
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
-unsigned int code_bytes = 64;
+static unsigned int code_bytes = 64;
 static int die_counter;
 
 bool in_task_stack(unsigned long *stack, struct task_struct *task,
@@ -375,3 +375,50 @@ static int __init code_bytes_setup(char *s)
 	return 1;
 }
 __setup("code_bytes=", code_bytes_setup);
+
+void show_regs(struct pt_regs *regs)
+{
+	bool all = true;
+	int i;
+
+	show_regs_print_info(KERN_DEFAULT);
+
+	if (IS_ENABLED(CONFIG_X86_32))
+		all = !user_mode(regs);
+
+	__show_regs(regs, all);
+
+	/*
+	 * When in-kernel, we also print out the stack and code at the
+	 * time of the fault..
+	 */
+	if (!user_mode(regs)) {
+		unsigned int code_prologue = code_bytes * 43 / 64;
+		unsigned int code_len = code_bytes;
+		unsigned char c;
+		u8 *ip;
+
+		show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
+
+		printk(KERN_DEFAULT "Code: ");
+
+		ip = (u8 *)regs->ip - code_prologue;
+		if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
+			/* try starting at IP */
+			ip = (u8 *)regs->ip;
+			code_len = code_len - code_prologue + 1;
+		}
+		for (i = 0; i < code_len; i++, ip++) {
+			if (ip < (u8 *)PAGE_OFFSET ||
+					probe_kernel_address(ip, c)) {
+				pr_cont(" Bad RIP value.");
+				break;
+			}
+			if (ip == (u8 *)regs->ip)
+				pr_cont("<%02x> ", c);
+			else
+				pr_cont("%02x ", c);
+		}
+	}
+	pr_cont("\n");
+}
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 04170f63e3a1..cd53f3030e40 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -127,45 +127,3 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 	info->type = STACK_TYPE_UNKNOWN;
 	return -EINVAL;
 }
-
-void show_regs(struct pt_regs *regs)
-{
-	int i;
-
-	show_regs_print_info(KERN_EMERG);
-	__show_regs(regs, !user_mode(regs));
-
-	/*
-	 * When in-kernel, we also print out the stack and code at the
-	 * time of the fault..
-	 */
-	if (!user_mode(regs)) {
-		unsigned int code_prologue = code_bytes * 43 / 64;
-		unsigned int code_len = code_bytes;
-		unsigned char c;
-		u8 *ip;
-
-		show_trace_log_lvl(current, regs, NULL, KERN_EMERG);
-
-		pr_emerg("Code:");
-
-		ip = (u8 *)regs->ip - code_prologue;
-		if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
-			/* try starting at IP */
-			ip = (u8 *)regs->ip;
-			code_len = code_len - code_prologue + 1;
-		}
-		for (i = 0; i < code_len; i++, ip++) {
-			if (ip < (u8 *)PAGE_OFFSET ||
-					probe_kernel_address(ip, c)) {
-				pr_cont("  Bad EIP value.");
-				break;
-			}
-			if (ip == (u8 *)regs->ip)
-				pr_cont(" <%02x>", c);
-			else
-				pr_cont(" %02x", c);
-		}
-	}
-	pr_cont("\n");
-}
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 563e28d14f2c..5cdb9e84da57 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -149,45 +149,3 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 	info->type = STACK_TYPE_UNKNOWN;
 	return -EINVAL;
 }
-
-void show_regs(struct pt_regs *regs)
-{
-	int i;
-
-	show_regs_print_info(KERN_DEFAULT);
-	__show_regs(regs, 1);
-
-	/*
-	 * When in-kernel, we also print out the stack and code at the
-	 * time of the fault..
-	 */
-	if (!user_mode(regs)) {
-		unsigned int code_prologue = code_bytes * 43 / 64;
-		unsigned int code_len = code_bytes;
-		unsigned char c;
-		u8 *ip;
-
-		show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
-
-		printk(KERN_DEFAULT "Code: ");
-
-		ip = (u8 *)regs->ip - code_prologue;
-		if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
-			/* try starting at IP */
-			ip = (u8 *)regs->ip;
-			code_len = code_len - code_prologue + 1;
-		}
-		for (i = 0; i < code_len; i++, ip++) {
-			if (ip < (u8 *)PAGE_OFFSET ||
-					probe_kernel_address(ip, c)) {
-				pr_cont(" Bad RIP value.");
-				break;
-			}
-			if (ip == (u8 *)regs->ip)
-				pr_cont("<%02x> ", c);
-			else
-				pr_cont("%02x ", c);
-		}
-	}
-	pr_cont("\n");
-}
-- 
2.13.0
