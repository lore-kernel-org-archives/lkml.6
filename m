Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeBCXbQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 18:31:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:4759 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752984AbeBCXax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 18:30:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,457,1511856000";
   d="scan'208";a="24500596"
Subject: [PATCH 3/3] x86/entry: Clear registers for compat syscalls
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de
Cc: Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Date: Sat, 03 Feb 2018 15:21:47 -0800
Message-ID: <151770010727.7213.10121554788880501079.stgit@dwillia2-desk3.amr.corp.intel.com>
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

At entry userspace may have populated registers with values that could
be useful in a speculative execution attack. Clear them to minimize the
kernel's attack surface.

[djbw: rename the macro, only clear the extra registers]
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/entry/entry_64_compat.S |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 98d5358e4041..f55b018a580b 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -95,6 +95,7 @@ ENTRY(entry_SYSENTER_compat)
 	pushq   $0			/* pt_regs->r14 = 0 */
 	pushq   $0			/* pt_regs->r15 = 0 */
 	cld
+	CLEAR_EXTRA_REGS_NOSPEC
 
 	/*
 	 * SYSENTER doesn't filter flags, so we need to clear NT and AC
@@ -223,6 +224,7 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq   $0			/* pt_regs->r13 = 0 */
 	pushq   $0			/* pt_regs->r14 = 0 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	CLEAR_EXTRA_REGS_NOSPEC
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -348,6 +350,7 @@ ENTRY(entry_INT80_compat)
 	pushq   %r14                    /* pt_regs->r14 */
 	pushq   %r15                    /* pt_regs->r15 */
 	cld
+	CLEAR_EXTRA_REGS_NOSPEC
 
 	/*
 	 * User mode is traced as though IRQs are on, and the interrupt
