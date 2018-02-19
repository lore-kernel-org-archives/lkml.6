Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbeBSU3q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:29:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932133AbeBSU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:28:53 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] x86/dumpstack: Add loglevel argument to show_opcodes()
Date: Mon, 19 Feb 2018 21:28:25 +0100
Message-Id: <20180219202826.19797-5-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180219202826.19797-1-bp@alien8.de>
References: <20180219202826.19797-1-bp@alien8.de>
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
index aef0d98cc282..17e9f358c42a 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -388,13 +388,13 @@ static int __init code_bytes_setup(char *s)
 }
 __setup("code_bytes=", code_bytes_setup);
 
-static void show_opcodes(u8 *rip)
+void show_opcodes(u8 *rip, const char *loglvl)
 {
 	unsigned int code_prologue = code_bytes * 43 / OPCODE_BUFSIZE;
 	u8 *ip;
 	int i;
 
-	printk(KERN_DEFAULT "Code: ");
+	printk("%sCode: ", loglvl);
 
 	ip = (u8 *)rip - code_prologue;
 	if (probe_kernel_read(opcodes, ip, code_bytes)) {
@@ -432,6 +432,6 @@ void show_regs(struct pt_regs *regs)
 		if (regs->ip < PAGE_OFFSET)
 			pr_cont(" Bad RIP value.\n");
 		else
-			show_opcodes((u8 *)regs->ip);
+			show_opcodes((u8 *)regs->ip, KERN_DEFAULT);
 	}
 }
-- 
2.13.0
