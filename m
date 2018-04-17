Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932175AbeDQQOA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:14:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57014 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756080AbeDQQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:13:59 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/9] x86/dumpstack: Add a show_ip() function
Date: Tue, 17 Apr 2018 18:11:22 +0200
Message-Id: <20180417161124.5294-8-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180417161124.5294-1-bp@alien8.de>
References: <20180417161124.5294-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... which shows the Instruction Pointer along with the insn bytes around
it. Use it whenever we print rIP. Drop the rIP < PAGE_OFFSET check since
our probe_kernel_read() can handle any address properly.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/stacktrace.h |  1 +
 arch/x86/kernel/dumpstack.c       | 23 +++++++++++++----------
 arch/x86/kernel/process_32.c      |  8 +++-----
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 0630eeb18bbc..b6dc698f992a 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -112,4 +112,5 @@ static inline unsigned long caller_frame_pointer(void)
 }
 
 void show_opcodes(u8 *rip, const char *loglvl);
+void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 1592d0c3ebb5..82da808b5c36 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -94,9 +94,19 @@ void show_opcodes(u8 *rip, const char *loglvl)
 	pr_cont("\n");
 }
 
+void show_ip(struct pt_regs *regs, const char *loglvl)
+{
+#ifdef CONFIG_X86_32
+	printk("%sEIP: %pS\n", loglvl, (void *)regs->ip);
+#else
+	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
+#endif
+	show_opcodes((u8 *)regs->ip, loglvl);
+}
+
 void show_iret_regs(struct pt_regs *regs)
 {
-	printk(KERN_DEFAULT "RIP: %04x:%pS\n", (int)regs->cs, (void *)regs->ip);
+	show_ip(regs, KERN_DEFAULT);
 	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
 		regs->sp, regs->flags);
 }
@@ -392,15 +402,8 @@ void show_regs(struct pt_regs *regs)
 	__show_regs(regs, all);
 
 	/*
-	 * When in-kernel, we also print out the stack and code at the
-	 * time of the fault..
+	 * When in-kernel, we also print out the stack at the time of the fault..
 	 */
-	if (!user_mode(regs)) {
+	if (!user_mode(regs))
 		show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
-
-		if (regs->ip < PAGE_OFFSET)
-			printk(KERN_DEFAULT "Code: Bad RIP value.\n");
-		else
-			show_opcodes((u8 *)regs->ip, KERN_DEFAULT);
-	}
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5224c6099184..0ae659de21eb 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -76,16 +76,14 @@ void __show_regs(struct pt_regs *regs, int all)
 		savesegment(gs, gs);
 	}
 
-	printk(KERN_DEFAULT "EIP: %pS\n", (void *)regs->ip);
-	printk(KERN_DEFAULT "EFLAGS: %08lx CPU: %d\n", regs->flags,
-		raw_smp_processor_id());
+	show_ip(regs, KERN_DEFAULT);
 
 	printk(KERN_DEFAULT "EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
 		regs->ax, regs->bx, regs->cx, regs->dx);
 	printk(KERN_DEFAULT "ESI: %08lx EDI: %08lx EBP: %08lx ESP: %08lx\n",
 		regs->si, regs->di, regs->bp, sp);
-	printk(KERN_DEFAULT " DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x\n",
-	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss);
+	printk(KERN_DEFAULT "DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
+	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss, regs->flags);
 
 	if (!all)
 		return;
-- 
2.13.0
