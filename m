Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756653AbeDZOWp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:22:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52297 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756111AbeDZOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:22:42 -0400
Date: Thu, 26 Apr 2018 07:22:20 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-602bd705da334f214fc03db328dc37d2f1f33307@git.kernel.org>
Cc: tglx@linutronix.de, luto@amacapital.net, bp@suse.de, hpa@zytor.com,
        mingo@kernel.org, jpoimboe@redhat.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, torvalds@linux-foundation.org, bp@suse.de,
        hpa@zytor.com, mingo@kernel.org, luto@amacapital.net,
        tglx@linutronix.de
In-Reply-To: <20180417161124.5294-9-bp@alien8.de>
References: <20180417161124.5294-9-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/dumpstack: Save first regs set for the
 executive summary
Git-Commit-ID: 602bd705da334f214fc03db328dc37d2f1f33307
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

Commit-ID:  602bd705da334f214fc03db328dc37d2f1f33307
Gitweb:     https://git.kernel.org/tip/602bd705da334f214fc03db328dc37d2f1f33307
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 17 Apr 2018 18:11:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:15:28 +0200

x86/dumpstack: Save first regs set for the executive summary

Save the regs set when __die() is onvoked for the first time and print it
in oops_end().

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180417161124.5294-9-bp@alien8.de

---
 arch/x86/kernel/dumpstack.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 82da808b5c36..ee344030fd0a 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -28,6 +28,8 @@ int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
 static int die_counter;
 
+static struct pt_regs exec_summary_regs;
+
 bool in_task_stack(unsigned long *stack, struct task_struct *task,
 		   struct stack_info *info)
 {
@@ -321,6 +323,9 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	raw_local_irq_restore(flags);
 	oops_exit();
 
+	/* Executive summary in case the oops scrolled away */
+	__show_regs(&exec_summary_regs, true);
+
 	if (!signr)
 		return;
 	if (in_interrupt())
@@ -339,10 +344,10 @@ NOKPROBE_SYMBOL(oops_end);
 
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
@@ -352,26 +357,13 @@ int __die(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
 
+	show_regs(regs);
+	print_modules();
+
 	if (notify_die(DIE_OOPS, str, regs, err,
 			current->thread.trap_nr, SIGSEGV) == NOTIFY_STOP)
 		return 1;
 
-	print_modules();
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
 	return 0;
 }
 NOKPROBE_SYMBOL(__die);
