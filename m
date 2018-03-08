Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755900AbeCHLKs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:10:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755702AbeCHLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:45 -0500
Date: Thu, 8 Mar 2018 03:10:15 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-16d1cb0bc43642a4d934631a73c5210ad2499e2f@git.kernel.org>
Cc: luto@amacapital.net, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com, hpa@zytor.com, mingo@kernel.org, bp@suse.de,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, jpoimboe@redhat.com, mingo@kernel.org,
        peterz@infradead.org, bp@suse.de, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, luto@amacapital.net
In-Reply-To: <20180306094920.16917-4-bp@alien8.de>
References: <20180306094920.16917-4-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/dumpstack: Unify show_regs()
Git-Commit-ID: 16d1cb0bc43642a4d934631a73c5210ad2499e2f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  16d1cb0bc43642a4d934631a73c5210ad2499e2f
Gitweb:     https://git.kernel.org/tip/16d1cb0bc43642a4d934631a73c5210ad2499e2f
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 6 Mar 2018 10:49:14 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:04:59 +0100

x86/dumpstack: Unify show_regs()

The 32-bit version uses KERN_EMERG and commit

  b0f4c4b32c8e ("bugs, x86: Fix printk levels for panic, softlockups and stack dumps")

changed the 64-bit version to KERN_DEFAULT. The same justification in
that commit that those messages do not belong in the terminal, holds
true for 32-bit also, so make it so.

Make code_bytes static, while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180306094920.16917-4-bp@alien8.de

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
@@ -127,45 +127,3 @@ unknown:
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
@@ -149,45 +149,3 @@ unknown:
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
