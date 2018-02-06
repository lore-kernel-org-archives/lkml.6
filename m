Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeBFB1S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:27:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:37892 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752468AbeBFB1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:27:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,467,1511856000";
   d="scan'208";a="201637391"
Subject: [PATCH v3 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Date: Mon, 05 Feb 2018 17:18:05 -0800
Message-ID: <151787988577.7847.16733592218894189003.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At entry userspace may have populated the extra registers outside the
syscall calling convention with values that could be useful in a
speculative execution attack. Clear them to minimize the kernel's attack
surface. Note, this only clears the extra registers and not the unused
registers for syscalls less than 6 arguments since those registers are
likely to be clobbered well before their values could be put to use
under speculation.

Note, Linus found that the 'xor' instructions can be executed with
minimized cost if interleaved with the 'push' instructions, and Ingo's
analysis found that r10 and r11 should be included in the register
clearing beyond the typical 'extra' syscall calling convention
registers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/entry/entry_64.S |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c752abe89d80..e8c3a902333d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -235,13 +235,26 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	pushq	%r8				/* pt_regs->r8 */
 	pushq	%r9				/* pt_regs->r9 */
 	pushq	%r10				/* pt_regs->r10 */
+	/*
+	 * Sanitize extra registers of values that a speculation attack
+	 * might want to exploit. Interleave xor with pushq for better
+	 * uop scheduling.
+	 */
+	xorq	%r10, %r10			/* nospec   r10 */
 	pushq	%r11				/* pt_regs->r11 */
+	xorq	%r11, %r11			/* nospec   r11 */
 	pushq	%rbx				/* pt_regs->rbx */
+	xorl	%ebx, %ebx			/* nospec   rbx */
 	pushq	%rbp				/* pt_regs->rbp */
+	xorl	%ebp, %ebp			/* nospec   rbp */
 	pushq	%r12				/* pt_regs->r12 */
+	xorq	%r12, %r12			/* nospec   r12 */
 	pushq	%r13				/* pt_regs->r13 */
+	xorq	%r13, %r13			/* nospec   r13 */
 	pushq	%r14				/* pt_regs->r14 */
+	xorq	%r14, %r14			/* nospec   r14 */
 	pushq	%r15				/* pt_regs->r15 */
+	xorq	%r15, %r15			/* nospec   r15 */
 	UNWIND_HINT_REGS
 
 	TRACE_IRQS_OFF
