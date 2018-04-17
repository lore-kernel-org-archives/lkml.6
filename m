Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756058AbeDQQN2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:13:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56966 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754580AbeDQQN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:13:27 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9] x86/dumpstack: Carve out Code: dumping into a function
Date: Tue, 17 Apr 2018 18:11:18 +0200
Message-Id: <20180417161124.5294-4-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180417161124.5294-1-bp@alien8.de>
References: <20180417161124.5294-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

No functionality change, carve it out into a separate function for later
changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/dumpstack.c | 57 ++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 579455c2b91e..eb9d6c00a52f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -70,6 +70,35 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
+static void show_opcodes(u8 *rip)
+{
+	unsigned int code_prologue = OPCODE_BUFSIZE * 43 / 64;
+	unsigned int code_len = OPCODE_BUFSIZE;
+	unsigned char c;
+	u8 *ip;
+	int i;
+
+	printk(KERN_DEFAULT "Code: ");
+
+	ip = (u8 *)rip - code_prologue;
+	if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
+		/* try starting at IP */
+		ip = (u8 *)rip;
+		code_len = code_len - code_prologue + 1;
+	}
+	for (i = 0; i < code_len; i++, ip++) {
+		if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
+			pr_cont(" Bad RIP value.");
+			break;
+		}
+		if (ip == (u8 *)rip)
+			pr_cont("<%02x> ", c);
+		else
+			pr_cont("%02x ", c);
+	}
+	pr_cont("\n");
+}
+
 void show_iret_regs(struct pt_regs *regs)
 {
 	printk(KERN_DEFAULT "RIP: %04x:%pS\n", (int)regs->cs, (void *)regs->ip);
@@ -359,7 +388,6 @@ void die(const char *str, struct pt_regs *regs, long err)
 void show_regs(struct pt_regs *regs)
 {
 	bool all = true;
-	int i;
 
 	show_regs_print_info(KERN_DEFAULT);
 
@@ -373,32 +401,7 @@ void show_regs(struct pt_regs *regs)
 	 * time of the fault..
 	 */
 	if (!user_mode(regs)) {
-		unsigned int code_prologue = OPCODE_BUFSIZE * 43 / 64;
-		unsigned int code_len = OPCODE_BUFSIZE;
-		unsigned char c;
-		u8 *ip;
-
 		show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
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
+		show_opcodes((u8 *)regs->ip);
 	}
-	pr_cont("\n");
 }
-- 
2.13.0
