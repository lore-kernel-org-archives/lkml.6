Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeBSU2z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:28:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbeBSU2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:28:52 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] x86/dumpstack: Carve out Code: dumping into a function
Date: Mon, 19 Feb 2018 21:28:23 +0100
Message-Id: <20180219202826.19797-3-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180219202826.19797-1-bp@alien8.de>
References: <20180219202826.19797-1-bp@alien8.de>
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
index 18fa9d74c182..954b1dd1c04a 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -376,10 +376,38 @@ static int __init code_bytes_setup(char *s)
 }
 __setup("code_bytes=", code_bytes_setup);
 
+static void show_opcodes(u8 *rip)
+{
+	unsigned int code_prologue = code_bytes * 43 / 64;
+	unsigned int code_len = code_bytes;
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
 void show_regs(struct pt_regs *regs)
 {
 	bool all = true;
-	int i;
 
 	show_regs_print_info(KERN_DEFAULT);
 
@@ -393,32 +421,7 @@ void show_regs(struct pt_regs *regs)
 	 * time of the fault..
 	 */
 	if (!user_mode(regs)) {
-		unsigned int code_prologue = code_bytes * 43 / 64;
-		unsigned int code_len = code_bytes;
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
