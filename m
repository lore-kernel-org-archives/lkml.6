Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeDZOUo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:20:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeDZOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:20:40 -0400
Date: Thu, 26 Apr 2018 07:20:17 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-9e4a90fd34445df64a13d136676a31a4dd22aea3@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net,
        hpa@zytor.com, jpoimboe@redhat.com, peterz@infradead.org, bp@suse.de,
        tglx@linutronix.de, torvalds@linux-foundation.org
Reply-To: bp@suse.de, torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, jpoimboe@redhat.com, mingo@kernel.org,
        luto@amacapital.net, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180417161124.5294-5-bp@alien8.de>
References: <20180417161124.5294-5-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/dumpstack: Improve opcodes dumping in the
 code section
Git-Commit-ID: 9e4a90fd34445df64a13d136676a31a4dd22aea3
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

Commit-ID:  9e4a90fd34445df64a13d136676a31a4dd22aea3
Gitweb:     https://git.kernel.org/tip/9e4a90fd34445df64a13d136676a31a4dd22aea3
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 17 Apr 2018 18:11:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:15:26 +0200

x86/dumpstack: Improve opcodes dumping in the code section

The code used to iterate byte-by-byte over the bytes around RIP and that
is expensive: disabling pagefaults around it, copy_from_user, etc...

Make it read the whole buffer of OPCODE_BUFSIZE size in one go. Use a
statically allocated 64 bytes buffer so that concurrent show_opcodes()
do not interleave in the output even though in the majority of the cases
it's serialized via die_lock. Except the #PF path which doesn't...

Also, do the PAGE_OFFSET check outside of the function because latter
will be reused in other context.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180417161124.5294-5-bp@alien8.de

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
