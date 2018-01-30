Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbeA3WjY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:39:24 -0500
Received: from terminus.zytor.com ([65.50.211.136]:48695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbeA3WjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:39:20 -0500
Date: Tue, 30 Jan 2018 14:37:14 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-2fbd7af5af8665d18bcefae3e9700be07e22b681@git.kernel.org>
Cc: luto@kernel.org, torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dan.j.williams@intel.com,
        mingo@kernel.org
Reply-To: dan.j.williams@intel.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org
In-Reply-To: <151727417984.33451.1216731042505722161.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727417984.33451.1216731042505722161.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/syscall: Sanitize syscall table de-references
 under speculation
Git-Commit-ID: 2fbd7af5af8665d18bcefae3e9700be07e22b681
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

Commit-ID:  2fbd7af5af8665d18bcefae3e9700be07e22b681
Gitweb:     https://git.kernel.org/tip/2fbd7af5af8665d18bcefae3e9700be07e22b681
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:02:59 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:31 +0100

x86/syscall: Sanitize syscall table de-references under speculation

The syscall table base is a user controlled function pointer in kernel
space. Use array_index_nospec() to prevent any out of bounds speculation.

While retpoline prevents speculating into a userspace directed target it
does not stop the pointer de-reference, the concern is leaking memory
relative to the syscall table base, by observing instruction cache
behavior.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727417984.33451.1216731042505722161.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/entry/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9908134..21dbdf0 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -21,6 +21,7 @@
 #include <linux/export.h>
 #include <linux/context_tracking.h>
 #include <linux/user-return-notifier.h>
+#include <linux/nospec.h>
 #include <linux/uprobes.h>
 #include <linux/livepatch.h>
 #include <linux/syscalls.h>
@@ -282,7 +283,8 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	 * regs->orig_ax, which changes the behavior of some syscalls.
 	 */
 	if (likely((nr & __SYSCALL_MASK) < NR_syscalls)) {
-		regs->ax = sys_call_table[nr & __SYSCALL_MASK](
+		nr = array_index_nospec(nr & __SYSCALL_MASK, NR_syscalls);
+		regs->ax = sys_call_table[nr](
 			regs->di, regs->si, regs->dx,
 			regs->r10, regs->r8, regs->r9);
 	}
@@ -318,6 +320,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 	}
 
 	if (likely(nr < IA32_NR_syscalls)) {
+		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		/*
 		 * It's possible that a 32-bit syscall implementation
 		 * takes a 64-bit parameter but nonetheless assumes that
