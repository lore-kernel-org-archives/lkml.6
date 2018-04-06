Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeDFRK7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:10:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDFRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:10:57 -0400
Date: Fri, 6 Apr 2018 10:09:56 -0700
From: tip-bot for Linus Torvalds <tipbot@zytor.com>
Message-ID: <tip-dfe64506c01e57159a4c550fe537c13a317ff01b@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, jpoimboe@redhat.com,
        brgerst@gmail.com, luto@kernel.org, hpa@zytor.com, bp@alien8.de,
        mingo@kernel.org, dvlasenk@redhat.com, linux@dominikbrodowski.net,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Reply-To: bp@alien8.de, hpa@zytor.com, brgerst@gmail.com, luto@kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        linux@dominikbrodowski.net, dvlasenk@redhat.com, mingo@kernel.org
In-Reply-To: <20180405095307.3730-2-linux@dominikbrodowski.net>
References: <20180405095307.3730-2-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/syscalls: Don't pointlessly reload the system
 call number
Git-Commit-ID: dfe64506c01e57159a4c550fe537c13a317ff01b
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

Commit-ID:  dfe64506c01e57159a4c550fe537c13a317ff01b
Gitweb:     https://git.kernel.org/tip/dfe64506c01e57159a4c550fe537c13a317ff01b
Author:     Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate: Thu, 5 Apr 2018 11:53:00 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 16:59:24 +0200

x86/syscalls: Don't pointlessly reload the system call number

We have it in a register in the low-level asm, just pass it in as an
argument rather than have do_syscall_64() load it back in from the
ptregs pointer.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180405095307.3730-2-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/common.c   | 12 ++++++------
 arch/x86/entry/entry_64.S |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 74f6eee15179..a8b066dbbf48 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -266,14 +266,13 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_X86_64
-__visible void do_syscall_64(struct pt_regs *regs)
+__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
-	struct thread_info *ti = current_thread_info();
-	unsigned long nr = regs->orig_ax;
+	struct thread_info *ti;
 
 	enter_from_user_mode();
 	local_irq_enable();
-
+	ti = current_thread_info();
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
@@ -282,8 +281,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	 * table.  The only functional difference is the x32 bit in
 	 * regs->orig_ax, which changes the behavior of some syscalls.
 	 */
-	if (likely((nr & __SYSCALL_MASK) < NR_syscalls)) {
-		nr = array_index_nospec(nr & __SYSCALL_MASK, NR_syscalls);
+	nr &= __SYSCALL_MASK;
+	if (likely(nr < NR_syscalls)) {
+		nr = array_index_nospec(nr, NR_syscalls);
 		regs->ax = sys_call_table[nr](
 			regs->di, regs->si, regs->dx,
 			regs->r10, regs->r8, regs->r9);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 936e19642eab..6cfe38665f3c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -233,7 +233,8 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	TRACE_IRQS_OFF
 
 	/* IRQs are off. */
-	movq	%rsp, %rdi
+	movq	%rax, %rdi
+	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	TRACE_IRQS_IRETQ		/* we're about to change IF */
