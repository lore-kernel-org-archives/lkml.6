Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753570AbeCFJvH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:51:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33334 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbeCFJtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:40 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/9] x86/fault: Dump user opcode bytes on fatal faults
Date: Tue,  6 Mar 2018 10:49:18 +0100
Message-Id: <20180306094920.16917-8-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306094920.16917-1-bp@alien8.de>
References: <20180306094920.16917-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Sometimes it is useful to see which user opcode bytes RIP points to
when a fault happens: be it to rule out RIP corruption, to dump info
early during boot, when doing core dumps is impossible due to not having
writable fs yet.

Sometimes it is useful if debugging an issue and one doesn't have access
to the executable which caused the fault in order to disassemble it.

That last aspect might have some security implications so
show_unhandled_signals could be revisited for that or a new config
option added.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/mm/fault.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 26865147a507..b3c19f734442 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -850,6 +850,8 @@ static inline void
 show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address, struct task_struct *tsk)
 {
+	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
+
 	if (!unhandled_signal(tsk, SIGSEGV))
 		return;
 
@@ -857,13 +859,14 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 		return;
 
 	printk("%s%s[%d]: segfault at %lx ip %px sp %px error %lx",
-		task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
-		tsk->comm, task_pid_nr(tsk), address,
+		loglvl, tsk->comm, task_pid_nr(tsk), address,
 		(void *)regs->ip, (void *)regs->sp, error_code);
 
 	print_vma_addr(KERN_CONT " in ", regs->ip);
 
 	printk(KERN_CONT "\n");
+
+	show_opcodes((u8 *)regs->ip, loglvl);
 }
 
 static void
-- 
2.13.0
