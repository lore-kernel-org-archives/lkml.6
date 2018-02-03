Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeBCXau (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 18:30:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:50751 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752846AbeBCXan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 18:30:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,457,1511856000";
   d="scan'208";a="15669027"
Subject: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de
Cc: Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Date: Sat, 03 Feb 2018 15:21:37 -0800
Message-ID: <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/entry/calling.h  |   17 +++++++++++++++++
 arch/x86/entry/entry_64.S |    1 +
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 3f48f695d5e6..daee2d19e73d 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -147,6 +147,23 @@ For 32-bit we have the following conventions - kernel is built with
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
+	/*
+	 * Sanitize extra registers of values that a speculation attack
+	 * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
+	 * the expectation is that %ebp will be clobbered before it
+	 * could be used.
+	 */
+	.macro CLEAR_EXTRA_REGS_NOSPEC
+	xorq %r15, %r15
+	xorq %r14, %r14
+	xorq %r13, %r13
+	xorq %r12, %r12
+	xorl %ebx, %ebx
+#ifndef CONFIG_FRAME_POINTER
+	xorl %ebp, %ebp
+#endif
+	.endm
+
 	.macro POP_EXTRA_REGS
 	popq %r15
 	popq %r14
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c752abe89d80..46260e951da6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -247,6 +247,7 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	TRACE_IRQS_OFF
 
 	/* IRQs are off. */
+	CLEAR_EXTRA_REGS_NOSPEC
 	movq	%rsp, %rdi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
