Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeDFROI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:14:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36085 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeDFROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:14:06 -0400
Date: Fri, 6 Apr 2018 10:13:23 -0700
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-6dc936f175cc6d12a8eb14d29b87e9238e460383@git.kernel.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        dvlasenk@redhat.com, luto@kernel.org, hpa@zytor.com,
        linux@dominikbrodowski.net, bp@alien8.de, tglx@linutronix.de,
        jpoimboe@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, brgerst@gmail.com, peterz@infradead.org
Reply-To: akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        dvlasenk@redhat.com, hpa@zytor.com, luto@kernel.org,
        linux@dominikbrodowski.net, tglx@linutronix.de, bp@alien8.de,
        mingo@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        brgerst@gmail.com, torvalds@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20180405095307.3730-8-linux@dominikbrodowski.net>
References: <20180405095307.3730-8-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] syscalls/x86: Extend register clearing on syscall
 entry to lower registers
Git-Commit-ID: 6dc936f175cc6d12a8eb14d29b87e9238e460383
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

Commit-ID:  6dc936f175cc6d12a8eb14d29b87e9238e460383
Gitweb:     https://git.kernel.org/tip/6dc936f175cc6d12a8eb14d29b87e9238e460383
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Thu, 5 Apr 2018 11:53:06 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 16:59:39 +0200

syscalls/x86: Extend register clearing on syscall entry to lower registers

To reduce the chance that random user space content leaks down the call
chain in registers, also clear lower registers on syscall entry:

For 64-bit syscalls, extend the register clearing in PUSH_AND_CLEAR_REGS
to %dx and %cx. This should not hurt at all, also on the other callers
of that macro. We do not need to clear %rdi and %rsi for syscall entry,
as those registers are used to pass the parameters to do_syscall_64().

For the 32-bit compat syscalls, do_int80_syscall_32() and
do_fast_syscall_32() each only take one parameter. Therefore, extend the
register clearing to %dx, %cx, and %si in entry_SYSCALL_compat and
entry_INT80_compat.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180405095307.3730-8-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h         | 2 ++
 arch/x86/entry/entry_64_compat.S | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index be63330c5511..352e70cd33e8 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -114,7 +114,9 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %rsi		/* pt_regs->si */
 	.endif
 	pushq	\rdx		/* pt_regs->dx */
+	xorl	%edx, %edx	/* nospec   dx */
 	pushq   %rcx		/* pt_regs->cx */
+	xorl	%ecx, %ecx	/* nospec   cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
 	xorl	%r8d, %r8d	/* nospec   r8 */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 08425c42f8b7..9af927e59d49 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -220,8 +220,11 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
+	xorl	%esi, %esi		/* nospec   si */
 	pushq	%rdx			/* pt_regs->dx */
+	xorl	%edx, %edx		/* nospec   dx */
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
+	xorl	%ecx, %ecx		/* nospec   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
@@ -365,8 +368,11 @@ ENTRY(entry_INT80_compat)
 
 	pushq	(%rdi)			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
+	xorl	%esi, %esi		/* nospec   si */
 	pushq	%rdx			/* pt_regs->dx */
+	xorl	%edx, %edx		/* nospec   dx */
 	pushq	%rcx			/* pt_regs->cx */
+	xorl	%ecx, %ecx		/* nospec   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
