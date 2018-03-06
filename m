Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbeCFJui (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:50:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33344 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753455AbeCFJtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:40 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/9] x86/dumpstack: Add a show_ip() function
Date: Tue,  6 Mar 2018 10:49:19 +0100
Message-Id: <20180306094920.16917-9-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306094920.16917-1-bp@alien8.de>
References: <20180306094920.16917-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... which shows the Istruction Pointer along with the insn bytes around it.
Use it whenever we print rIP.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/stacktrace.h |  1 +
 arch/x86/kernel/dumpstack.c       | 13 ++++++++++++-
 arch/x86/kernel/process_32.c      |  4 +---
 3 files changed, 14 insertions(+), 4 deletions(-)

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
index 3625f79fbb42..e855815b00d4 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -96,9 +96,20 @@ void show_opcodes(u8 *rip, const char *loglvl)
 	pr_cont("\n");
 }
 
+void show_ip(struct pt_regs *regs, const char *loglvl)
+{
+#ifdef CONFIG_X86_32
+	printk("%sEIP: %pS\n", loglvl, (void *)regs->ip);
+#else
+	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
+#endif
+
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
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5224c6099184..3d1f1226b972 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -76,9 +76,7 @@ void __show_regs(struct pt_regs *regs, int all)
 		savesegment(gs, gs);
 	}
 
-	printk(KERN_DEFAULT "EIP: %pS\n", (void *)regs->ip);
-	printk(KERN_DEFAULT "EFLAGS: %08lx CPU: %d\n", regs->flags,
-		raw_smp_processor_id());
+	show_ip(regs, KERN_DEFAULT);
 
 	printk(KERN_DEFAULT "EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
 		regs->ax, regs->bx, regs->cx, regs->dx);
-- 
2.13.0
