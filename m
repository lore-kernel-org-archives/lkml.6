Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeA3Oyf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:54:35 -0500
Received: from terminus.zytor.com ([65.50.211.136]:37965 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeA3Oyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:54:32 -0500
Date: Tue, 30 Jan 2018 06:50:09 -0800
From: tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-d1f7732009e0549eedf8ea1db948dc37be77fd46@git.kernel.org>
Cc: luto@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, kernel-hardening@lists.openwall.com, bp@alien8.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        luto@kernel.org, torvalds@linux-foundation.org,
        kernel-hardening@lists.openwall.com, tglx@linutronix.de, bp@alien8.de
In-Reply-To: <462dff8d4d64dfbfc851fbf3130641809d980ecd.1517164461.git.luto@kernel.org>
References: <462dff8d4d64dfbfc851fbf3130641809d980ecd.1517164461.git.luto@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Push extra regs right away
Git-Commit-ID: d1f7732009e0549eedf8ea1db948dc37be77fd46
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

Commit-ID:  d1f7732009e0549eedf8ea1db948dc37be77fd46
Gitweb:     https://git.kernel.org/tip/d1f7732009e0549eedf8ea1db948dc37be77fd46
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 28 Jan 2018 10:38:49 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 15:30:36 +0100

x86/entry/64: Push extra regs right away

With the fast path removed there is no point in splitting the push of the
normal and the extra register set. Just push the extra regs right away.

[ tglx: Split out from 'x86/entry/64: Remove the SYSCALL64 fast path' ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Link: https://lkml.kernel.org/r/462dff8d4d64dfbfc851fbf3130641809d980ecd.1517164461.git.luto@kernel.org

---
 arch/x86/entry/entry_64.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c46c755..c752abe 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -236,13 +236,17 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	pushq	%r9				/* pt_regs->r9 */
 	pushq	%r10				/* pt_regs->r10 */
 	pushq	%r11				/* pt_regs->r11 */
-	sub	$(6*8), %rsp			/* pt_regs->bp, bx, r12-15 not saved */
-	UNWIND_HINT_REGS extra=0
+	pushq	%rbx				/* pt_regs->rbx */
+	pushq	%rbp				/* pt_regs->rbp */
+	pushq	%r12				/* pt_regs->r12 */
+	pushq	%r13				/* pt_regs->r13 */
+	pushq	%r14				/* pt_regs->r14 */
+	pushq	%r15				/* pt_regs->r15 */
+	UNWIND_HINT_REGS
 
 	TRACE_IRQS_OFF
 
 	/* IRQs are off. */
-	SAVE_EXTRA_REGS
 	movq	%rsp, %rdi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
