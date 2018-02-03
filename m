Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeBCXbE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 18:31:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:8451 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752886AbeBCXas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 18:30:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,457,1511856000";
   d="scan'208";a="198436005"
Subject: [PATCH 2/3] x86/entry: Clear registers for 64bit
 exceptions/interrupts
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de
Cc: Andi Kleen <ak@linux.intel.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Date: Sat, 03 Feb 2018 15:21:42 -0800
Message-ID: <151770010215.7213.2691813454732314390.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
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
 arch/x86/entry/entry_64.S |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 46260e951da6..d73eedf1eb47 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -563,6 +563,7 @@ END(irq_entries_start)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_EXTRA_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1121,6 +1122,7 @@ ENTRY(xen_failsafe_callback)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_EXTRA_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
@@ -1166,6 +1168,7 @@ ENTRY(paranoid_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_EXTRA_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1218,6 +1221,7 @@ ENTRY(error_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_EXTRA_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
@@ -1416,6 +1420,7 @@ ENTRY(nmi)
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
 	UNWIND_HINT_REGS
+	CLEAR_EXTRA_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	/*
