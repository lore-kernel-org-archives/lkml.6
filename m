Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeBFB1Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:27:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:42024 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752506AbeBFB1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:27:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,467,1511856000";
   d="scan'208";a="17356231"
Subject: [PATCH v3 2/3] x86/entry: Clear registers for 64bit
 exceptions/interrupts
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Date: Mon, 05 Feb 2018 17:18:11 -0800
Message-ID: <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Clear the 'extra' registers on entering the 64bit kernel for exceptions
and interrupts. The common registers are not cleared since they are
likely clobbered well before they can be exploited in a speculative
execution attack.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/entry/calling.h  |   19 +++++++++++++++++++
 arch/x86/entry/entry_64.S |    7 +++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 3f48f695d5e6..5203bb57fb24 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -147,6 +147,25 @@ For 32-bit we have the following conventions - kernel is built with
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
+	/*
+	 * Sanitize registers of values that a speculation attack
+	 * might want to exploit. The lower registers are likely
+	 * clobbered well before they could be put to use in a
+	 * speculative execution gadget.
+	 */
+	.macro CLEAR_REGS_NOSPEC
+	xorl %ebp, %ebp
+	xorl %ebx, %ebx
+	xorq %r8, %r8
+	xorq %r9, %r9
+	xorq %r10, %r10
+	xorq %r11, %r11
+	xorq %r12, %r12
+	xorq %r13, %r13
+	xorq %r14, %r14
+	xorq %r15, %r15
+	.endm
+
 	.macro POP_EXTRA_REGS
 	popq %r15
 	popq %r14
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e8c3a902333d..fd88be099b6a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -575,6 +575,7 @@ END(irq_entries_start)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1133,6 +1134,7 @@ ENTRY(xen_failsafe_callback)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
@@ -1178,6 +1180,7 @@ ENTRY(paranoid_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1185,7 +1188,6 @@ ENTRY(paranoid_entry)
 	testl	%edx, %edx
 	js	1f				/* negative -> in kernel */
 	SWAPGS
-	xorl	%ebx, %ebx
 
 1:
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
@@ -1230,8 +1232,8 @@ ENTRY(error_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
-	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1428,6 +1430,7 @@ ENTRY(nmi)
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
 	UNWIND_HINT_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	/*
