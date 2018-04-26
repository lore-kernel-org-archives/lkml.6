Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756564AbeDZOVP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:21:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756090AbeDZOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:21:11 -0400
Date: Thu, 26 Apr 2018 07:20:48 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-e8b6f984516b1fcb0ccf4469ca42777c9c2dc76d@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
        peterz@infradead.org, bp@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net, jpoimboe@redhat.com
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
        luto@amacapital.net, jpoimboe@redhat.com, bp@suse.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180417161124.5294-6-bp@alien8.de>
References: <20180417161124.5294-6-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/dumpstack: Add loglevel argument to
 show_opcodes()
Git-Commit-ID: e8b6f984516b1fcb0ccf4469ca42777c9c2dc76d
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

Commit-ID:  e8b6f984516b1fcb0ccf4469ca42777c9c2dc76d
Gitweb:     https://git.kernel.org/tip/e8b6f984516b1fcb0ccf4469ca42777c9c2dc76d
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 17 Apr 2018 18:11:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:15:26 +0200

x86/dumpstack: Add loglevel argument to show_opcodes()

Will be used in the next patch.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180417161124.5294-6-bp@alien8.de

---
 arch/x86/include/asm/stacktrace.h | 1 +
 arch/x86/kernel/dumpstack.c       | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 133d9425fced..0630eeb18bbc 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -111,4 +111,5 @@ static inline unsigned long caller_frame_pointer(void)
 	return (unsigned long)frame;
 }
 
+void show_opcodes(u8 *rip, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 1d6698b54527..1592d0c3ebb5 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -70,14 +70,14 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
-static void show_opcodes(u8 *rip)
+void show_opcodes(u8 *rip, const char *loglvl)
 {
 	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
 	u8 opcodes[OPCODE_BUFSIZE];
 	u8 *ip;
 	int i;
 
-	printk(KERN_DEFAULT "Code: ");
+	printk("%sCode: ", loglvl);
 
 	ip = (u8 *)rip - code_prologue;
 	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
@@ -401,6 +401,6 @@ void show_regs(struct pt_regs *regs)
 		if (regs->ip < PAGE_OFFSET)
 			printk(KERN_DEFAULT "Code: Bad RIP value.\n");
 		else
-			show_opcodes((u8 *)regs->ip);
+			show_opcodes((u8 *)regs->ip, KERN_DEFAULT);
 	}
 }
