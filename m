Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeCFJvY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:51:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33318 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753420AbeCFJtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:39 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code: section
Date: Tue,  6 Mar 2018 10:49:16 +0100
Message-Id: <20180306094920.16917-6-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306094920.16917-1-bp@alien8.de>
References: <20180306094920.16917-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The code used to iterate byte-by-byte over the bytes around RIP and that
is expensive: disabling pagefaults around it, copy_from_user, etc...

Make it read the whole buffer of code_bytes size in one go. By default
use a statically allocated 64 bytes buffer. If "code_bytes=" is supplied
on the cmdline a new buffer gets allocated.

Also, do the PAGE_OFFSET check outside of the function because latter
will be reused in other context.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/dumpstack.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 19a5860b62c8..12ddfc9dcb01 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -22,9 +22,13 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
+#define OPCODE_BUFSIZE 64
+
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
-static unsigned int code_bytes = 64;
+static unsigned int code_bytes = OPCODE_BUFSIZE;
+static u8 __opc[OPCODE_BUFSIZE];
+static u8 *opcodes = __opc;
 static int die_counter;
 
 bool in_task_stack(unsigned long *stack, struct task_struct *task,
@@ -71,29 +75,23 @@ static void printk_stack_address(unsigned long address, int reliable,
 
 static void show_opcodes(u8 *rip)
 {
-	unsigned int code_prologue = code_bytes * 43 / 64;
-	unsigned int code_len = code_bytes;
-	unsigned char c;
+	unsigned int code_prologue = code_bytes * 43 / OPCODE_BUFSIZE;
 	u8 *ip;
 	int i;
 
 	printk(KERN_DEFAULT "Code: ");
 
 	ip = (u8 *)rip - code_prologue;
-	if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
-		/* try starting at IP */
-		ip = (u8 *)rip;
-		code_len = code_len - code_prologue + 1;
+	if (probe_kernel_read(opcodes, ip, code_bytes)) {
+		pr_cont(" Bad RIP value.\n");
+		return;
 	}
-	for (i = 0; i < code_len; i++, ip++) {
-		if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
-			pr_cont(" Bad RIP value.");
-			break;
-		}
+
+	for (i = 0; i < code_bytes; i++, ip++) {
 		if (ip == (u8 *)rip)
-			pr_cont("<%02x> ", c);
+			pr_cont("<%02x> ", opcodes[i]);
 		else
-			pr_cont("%02x ", c);
+			pr_cont("%02x ", opcodes[i]);
 	}
 	pr_cont("\n");
 }
@@ -387,8 +385,8 @@ void die(const char *str, struct pt_regs *regs, long err)
 
 static int __init code_bytes_setup(char *s)
 {
-	ssize_t ret;
 	unsigned long val;
+	ssize_t ret;
 
 	if (!s)
 		return -EINVAL;
@@ -401,6 +399,14 @@ static int __init code_bytes_setup(char *s)
 	if (code_bytes > 8192)
 		code_bytes = 8192;
 
+	if (code_bytes > OPCODE_BUFSIZE) {
+		u8 *new_buf = kzalloc(code_bytes, GFP_KERNEL);
+		if (!new_buf)
+			return -ENOMEM;
+
+		opcodes = new_buf;
+	}
+
 	return 1;
 }
 __setup("code_bytes=", code_bytes_setup);
@@ -422,6 +428,10 @@ void show_regs(struct pt_regs *regs)
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
