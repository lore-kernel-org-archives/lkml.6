Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932682AbeCOPqJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:46:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752587AbeCOPqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:46:06 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/9] x86/dumpstack: Add loglevel argument to show_opcodes()
Date: Thu, 15 Mar 2018 16:44:44 +0100
Message-Id: <20180315154448.16222-6-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180315154448.16222-1-bp@alien8.de>
References: <20180315154448.16222-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Will be used in the next patch.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/stacktrace.h | 1 +
 arch/x86/kernel/dumpstack.c       | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 133d9425fced..0630eeb18bbc 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -111,4 +111,5 @@ static inline unsigned long caller_frame_pointer(void)
 	return (unsigned long)frame;
 }
 
+void show_opcodes(u8 *rip, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 3f781a8dddb8..82562f327a99 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -68,7 +68,7 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
-static void show_opcodes(u8 *rip)
+void show_opcodes(u8 *rip, const char *loglvl)
 {
 #define OPCODE_BUFSIZE 64
 	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
@@ -76,7 +76,7 @@ static void show_opcodes(u8 *rip)
 	u8 *ip;
 	int i;
 
-	printk(KERN_DEFAULT "Code: ");
+	printk("%sCode: ", loglvl);
 
 	ip = (u8 *)rip - code_prologue;
 	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
@@ -400,6 +400,6 @@ void show_regs(struct pt_regs *regs)
 		if (regs->ip < PAGE_OFFSET)
 			pr_cont(" Bad RIP value.\n");
 		else
-			show_opcodes((u8 *)regs->ip);
+			show_opcodes((u8 *)regs->ip, KERN_DEFAULT);
 	}
 }
-- 
2.13.0
