Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756041AbeDQQNN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:13:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56942 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756020AbeDQQNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:13:11 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/9] x86/dumpstack: Remove code_bytes
Date: Tue, 17 Apr 2018 18:11:16 +0200
Message-Id: <20180417161124.5294-2-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180417161124.5294-1-bp@alien8.de>
References: <20180417161124.5294-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This was added by

  86c418374223 ("[PATCH] i386: add option to show more code in oops reports")

long time ago but experience shows that 64 instruction bytes are plenty
when deciphering an oops. So get rid of it.

Removing it will simplify further enhancements to the opcodes dumping
machinery coming in the following patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 -----
 arch/x86/kernel/dumpstack.c                     | 27 ++++---------------------
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..47aa554e41b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -587,11 +587,6 @@
 			Sets the size of memory pool for coherent, atomic dma
 			allocations, by default set to 256K.
 
-	code_bytes	[X86] How many bytes of object code to print
-			in an oops report.
-			Range: 0 - 8192
-			Default: 64
-
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
 			<io>[,<irq>[,<nodeID>[,<backplane>[,<ckp>[,<timeout>]]]]]
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 18fa9d74c182..593db796374d 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -22,9 +22,10 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
+#define OPCODE_BUFSIZE 64
+
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
-static unsigned int code_bytes = 64;
 static int die_counter;
 
 bool in_task_stack(unsigned long *stack, struct task_struct *task,
@@ -356,26 +357,6 @@ void die(const char *str, struct pt_regs *regs, long err)
 	oops_end(flags, regs, sig);
 }
 
-static int __init code_bytes_setup(char *s)
-{
-	ssize_t ret;
-	unsigned long val;
-
-	if (!s)
-		return -EINVAL;
-
-	ret = kstrtoul(s, 0, &val);
-	if (ret)
-		return ret;
-
-	code_bytes = val;
-	if (code_bytes > 8192)
-		code_bytes = 8192;
-
-	return 1;
-}
-__setup("code_bytes=", code_bytes_setup);
-
 void show_regs(struct pt_regs *regs)
 {
 	bool all = true;
@@ -393,8 +374,8 @@ void show_regs(struct pt_regs *regs)
 	 * time of the fault..
 	 */
 	if (!user_mode(regs)) {
-		unsigned int code_prologue = code_bytes * 43 / 64;
-		unsigned int code_len = code_bytes;
+		unsigned int code_prologue = OPCODE_BUFSIZE * 43 / 64;
+		unsigned int code_len = OPCODE_BUFSIZE;
 		unsigned char c;
 		u8 *ip;
 
-- 
2.13.0
