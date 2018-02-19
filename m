Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeBSU3X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:29:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932350AbeBSU2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:28:54 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 5/5] x86/fault: Dump user opcode bytes on fatal faults
Date: Mon, 19 Feb 2018 21:28:26 +0100
Message-Id: <20180219202826.19797-6-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180219202826.19797-1-bp@alien8.de>
References: <20180219202826.19797-1-bp@alien8.de>
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
index 321b78060e93..d81ea7835737 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -851,6 +851,8 @@ static inline void
 show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address, struct task_struct *tsk)
 {
+	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
+
 	if (!unhandled_signal(tsk, SIGSEGV))
 		return;
 
@@ -858,13 +860,14 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
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
