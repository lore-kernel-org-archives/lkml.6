Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756510AbeDZOTZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:19:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756425AbeDZOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:19:20 -0400
Date: Thu, 26 Apr 2018 07:18:46 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-5d12f0424edf01ccd8abbcba1c7d45fe0b23c779@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jpoimboe@redhat.com, mingo@kernel.org,
        peterz@infradead.org, luto@amacapital.net, hpa@zytor.com,
        torvalds@linux-foundation.org, bp@suse.de, tglx@linutronix.de
Reply-To: tglx@linutronix.de, bp@suse.de, torvalds@linux-foundation.org,
        hpa@zytor.com, luto@amacapital.net, peterz@infradead.org,
        mingo@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180417161124.5294-2-bp@alien8.de>
References: <20180417161124.5294-2-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/dumpstack: Remove code_bytes
Git-Commit-ID: 5d12f0424edf01ccd8abbcba1c7d45fe0b23c779
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

Commit-ID:  5d12f0424edf01ccd8abbcba1c7d45fe0b23c779
Gitweb:     https://git.kernel.org/tip/5d12f0424edf01ccd8abbcba1c7d45fe0b23c779
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 17 Apr 2018 18:11:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:15:25 +0200

x86/dumpstack: Remove code_bytes

This was added by

  86c418374223 ("[PATCH] i386: add option to show more code in oops reports")

long time ago but experience shows that 64 instruction bytes are plenty
when deciphering an oops. So get rid of it.

Removing it will simplify further enhancements to the opcodes dumping
machinery coming in the following patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180417161124.5294-2-bp@alien8.de

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
 
