Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756067AbeDQQNn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:13:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56974 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754580AbeDQQNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:13:41 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/9] x86/dumpstack: Improve opcodes dumping in the Code: section
Date: Tue, 17 Apr 2018 18:11:19 +0200
Message-Id: <20180417161124.5294-5-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180417161124.5294-1-bp@alien8.de>
References: <20180417161124.5294-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The code used to iterate byte-by-byte over the bytes around RIP and that
is expensive: disabling pagefaults around it, copy_from_user, etc...

Make it read the whole buffer of OPCODE_BUFSIZE size in one go. Use a
statically allocated 64 bytes buffer so that concurrent show_opcodes()
do not interleave in the output even though in the majority of the cases
we sync on die_lock. Except the #PF path which doesn't...

Also, do the PAGE_OFFSET check outside of the function because latter
will be reused in other context.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/dumpstack.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index eb9d6c00a52f..1d6698b54527 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -72,29 +72,24 @@ static void printk_stack_address(unsigned long address, int reliable,
 
 static void show_opcodes(u8 *rip)
 {
-	unsigned int code_prologue = OPCODE_BUFSIZE * 43 / 64;
-	unsigned int code_len = OPCODE_BUFSIZE;
-	unsigned char c;
+	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
+	u8 opcodes[OPCODE_BUFSIZE];
 	u8 *ip;
 	int i;
 
 	printk(KERN_DEFAULT "Code: ");
 
 	ip = (u8 *)rip - code_prologue;
-	if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
-		/* try starting at IP */
-		ip = (u8 *)rip;
-		code_len = code_len - code_prologue + 1;
+	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
+		pr_cont("Bad RIP value.\n");
+		return;
 	}
-	for (i = 0; i < code_len; i++, ip++) {
-		if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
-			pr_cont(" Bad RIP value.");
-			break;
-		}
-		if (ip == (u8 *)rip)
-			pr_cont("<%02x> ", c);
+
+	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
+		if (ip == rip)
+			pr_cont("<%02x> ", opcodes[i]);
 		else
-			pr_cont("%02x ", c);
+			pr_cont("%02x ", opcodes[i]);
 	}
 	pr_cont("\n");
 }
@@ -402,6 +397,10 @@ void show_regs(struct pt_regs *regs)
 	 */
 	if (!user_mode(regs)) {
 		show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
-		show_opcodes((u8 *)regs->ip);
+
+		if (regs->ip < PAGE_OFFSET)
+			printk(KERN_DEFAULT "Code: Bad RIP value.\n");
+		else
+			show_opcodes((u8 *)regs->ip);
 	}
 }
-- 
2.13.0
