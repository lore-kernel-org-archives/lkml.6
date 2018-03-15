Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeCOPqL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:46:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47974 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752503AbeCOPqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:46:06 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/9] x86/dumpstack: Improve opcodes dumping in the Code: section
Date: Thu, 15 Mar 2018 16:44:43 +0100
Message-Id: <20180315154448.16222-5-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180315154448.16222-1-bp@alien8.de>
References: <20180315154448.16222-1-bp@alien8.de>
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
 arch/x86/kernel/dumpstack.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index eb9d6c00a52f..3f781a8dddb8 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -22,8 +22,6 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-#define OPCODE_BUFSIZE 64
-
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
 static int die_counter;
@@ -72,29 +70,25 @@ static void printk_stack_address(unsigned long address, int reliable,
 
 static void show_opcodes(u8 *rip)
 {
-	unsigned int code_prologue = OPCODE_BUFSIZE * 43 / 64;
-	unsigned int code_len = OPCODE_BUFSIZE;
-	unsigned char c;
+#define OPCODE_BUFSIZE 64
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
+		pr_cont(" Bad RIP value.\n");
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
@@ -402,6 +396,10 @@ void show_regs(struct pt_regs *regs)
 	 */
 	if (!user_mode(regs)) {
 		show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
-		show_opcodes((u8 *)regs->ip);
+
+		if (regs->ip < PAGE_OFFSET)
+			pr_cont(" Bad RIP value.\n");
+		else
+			show_opcodes((u8 *)regs->ip);
 	}
 }
-- 
2.13.0
