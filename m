Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756614AbeDZOUP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:20:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756431AbeDZOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:20:11 -0400
Date: Thu, 26 Apr 2018 07:19:48 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-f0a1d7c11c3ebe2f601b448d13e7fbc3a0364a03@git.kernel.org>
Cc: tglx@linutronix.de, bp@suse.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, mingo@kernel.org,
        peterz@infradead.org, luto@amacapital.net,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, bp@suse.de, tglx@linutronix.de, mingo@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, luto@amacapital.net,
        peterz@infradead.org, torvalds@linux-foundation.org
In-Reply-To: <20180417161124.5294-4-bp@alien8.de>
References: <20180417161124.5294-4-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/dumpstack: Carve out code-dumping into a
 function
Git-Commit-ID: f0a1d7c11c3ebe2f601b448d13e7fbc3a0364a03
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f0a1d7c11c3ebe2f601b448d13e7fbc3a0364a03
Gitweb:     https://git.kernel.org/tip/f0a1d7c11c3ebe2f601b448d13e7fbc3a0364a03
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 17 Apr 2018 18:11:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:15:26 +0200

x86/dumpstack: Carve out code-dumping into a function

No functionality change, carve it out into a separate function for later
changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180417161124.5294-4-bp@alien8.de

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
