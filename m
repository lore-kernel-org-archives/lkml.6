Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756634AbeDZOVu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:21:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53239 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756637AbeDZOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:21:42 -0400
Date: Thu, 26 Apr 2018 07:21:17 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-ba54d856a9d8a9c56b87e20c88602b7e3cb568fb@git.kernel.org>
Cc: jpoimboe@redhat.com, bp@suse.de, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luto@amacapital.net, peterz@infradead.org, hpa@zytor.com
Reply-To: bp@suse.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        jpoimboe@redhat.com, hpa@zytor.com, luto@amacapital.net,
        peterz@infradead.org
In-Reply-To: <20180417161124.5294-7-bp@alien8.de>
References: <20180417161124.5294-7-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/fault: Dump user opcode bytes on fatal
 faults
Git-Commit-ID: ba54d856a9d8a9c56b87e20c88602b7e3cb568fb
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

Commit-ID:  ba54d856a9d8a9c56b87e20c88602b7e3cb568fb
Gitweb:     https://git.kernel.org/tip/ba54d856a9d8a9c56b87e20c88602b7e3cb568fb
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 17 Apr 2018 18:11:21 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:15:27 +0200

x86/fault: Dump user opcode bytes on fatal faults

Sometimes it is useful to see which user opcode bytes RIP points to
when a fault happens: be it to rule out RIP corruption, to dump info
early during boot, when doing core dumps is impossible due to not having
a writable filesystem yet.

Sometimes it is useful if debugging an issue and one doesn't have access
to the executable which caused the fault in order to disassemble it.

That last aspect might have some security implications so
show_unhandled_signals could be revisited for that or a new config option
added.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180417161124.5294-7-bp@alien8.de

---
 arch/x86/mm/fault.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 73bd8c95ac71..a3fd94eff04d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -828,6 +828,8 @@ static inline void
 show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address, struct task_struct *tsk)
 {
+	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
+
 	if (!unhandled_signal(tsk, SIGSEGV))
 		return;
 
@@ -835,13 +837,14 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
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
