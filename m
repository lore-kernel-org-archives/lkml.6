Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbeBSU24 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:28:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932232AbeBSU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:28:53 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] x86/dumpstack: Improve opcodes dumping in the Code: section
Date: Mon, 19 Feb 2018 21:28:24 +0100
Message-Id: <20180219202826.19797-4-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180219202826.19797-1-bp@alien8.de>
References: <20180219202826.19797-1-bp@alien8.de>
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
index 954b1dd1c04a..aef0d98cc282 100644
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
@@ -358,8 +362,8 @@ void die(const char *str, struct pt_regs *regs, long err)
 
 static int __init code_bytes_setup(char *s)
 {
-	ssize_t ret;
 	unsigned long val;
+	ssize_t ret;
 
 	if (!s)
 		return -EINVAL;
@@ -372,35 +376,37 @@ static int __init code_bytes_setup(char *s)
 	if (code_bytes > 8192)
 		code_bytes = 8192;
 
+	if (code_bytes > OPCODE_BUFSIZE) {
+		u8 *new_buf = kzalloc(code_bytes, GFP_KERNEL);
+		if (!new_buf)
+			return -EINVAL;
+
+		opcodes = new_buf;
+	}
+
 	return 1;
 }
 __setup("code_bytes=", code_bytes_setup);
 
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
