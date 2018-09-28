Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E5BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37251206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37251206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeI1Waj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:30:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:28126 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbeI1Waj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:30:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="84226914"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2018 09:06:13 -0700
Subject: [PATCH 7/8] x86/mm/vsyscall: consider vsyscall page part of user address space
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org,
        jannh@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:30 -0700
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
Message-Id: <20180928160230.6E9336EE@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The vsyscall page is weird.  It is in what is traditionally part of
the kernel address space.  But, it has user permissions and we handle
faults on it like we would on a user page: interrupts on.

Right now, we handle vsyscall emulation in the "bad_area" code, which
is used for both user-address-space and kernel-address-space faults.
Move the handling to the user-address-space code *only* and ensure we
get there by "excluding" the vsyscall page from the kernel address
space via a check in fault_in_kernel_space().

Since the fault_in_kernel_space() check is used on 32-bit, also add a
64-bit check to make it clear we only use this path on 64-bit.  Also
move the unlikely() to be in is_vsyscall_vaddr() itself.

This helps clean up the kernel fault handling path by removing a case
that can happen in normal[1] operation.  (Yeah, yeah, we can argue
about the vsyscall page being "normal" or not.)  This also makes
sanity checks easier, like the "we never take pkey faults in the
kernel address space" check in the next patch.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---

 b/arch/x86/mm/fault.c |   38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff -puN arch/x86/mm/fault.c~vsyscall-is-user-address-space arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~vsyscall-is-user-address-space	2018-09-27 10:17:24.487343564 -0700
+++ b/arch/x86/mm/fault.c	2018-09-27 10:17:24.490343564 -0700
@@ -848,7 +848,7 @@ show_signal_msg(struct pt_regs *regs, un
  */
 static bool is_vsyscall_vaddr(unsigned long vaddr)
 {
-	return (vaddr & PAGE_MASK) == VSYSCALL_ADDR;
+	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
 }
 
 static void
@@ -874,18 +874,6 @@ __bad_area_nosemaphore(struct pt_regs *r
 		if (is_errata100(regs, address))
 			return;
 
-#ifdef CONFIG_X86_64
-		/*
-		 * Instruction fetch faults in the vsyscall page might need
-		 * emulation.
-		 */
-		if (unlikely((error_code & X86_PF_INSTR) &&
-			     is_vsyscall_vaddr(address))) {
-			if (emulate_vsyscall(regs, address))
-				return;
-		}
-#endif
-
 		/*
 		 * To avoid leaking information about the kernel page table
 		 * layout, pretend that user-mode accesses to kernel addresses
@@ -1194,6 +1182,14 @@ access_error(unsigned long error_code, s
 
 static int fault_in_kernel_space(unsigned long address)
 {
+	/*
+	 * On 64-bit systems, the vsyscall page is at an address above
+	 * TASK_SIZE_MAX, but is not considered part of the kernel
+	 * address space.
+	 */
+	if (IS_ENABLED(CONFIG_X86_64) && is_vsyscall_vaddr(address))
+		return false;
+
 	return address >= TASK_SIZE_MAX;
 }
 
@@ -1361,6 +1357,22 @@ void do_user_addr_fault(struct pt_regs *
 	if (sw_error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+#ifdef CONFIG_X86_64
+	/*
+	 * Instruction fetch faults in the vsyscall page might need
+	 * emulation.  The vsyscall page is at a high address
+	 * (>PAGE_OFFSET), but is considered to be part of the user
+	 * address space.
+	 *
+	 * The vsyscall page does not have a "real" VMA, so do this
+	 * emulation before we go searching for VMAs.
+	 */
+	if ((sw_error_code & X86_PF_INSTR) && is_vsyscall_vaddr(address)) {
+		if (emulate_vsyscall(regs, address))
+			return;
+	}
+#endif
+
 	/*
 	 * Kernel-mode access to the user address space should only occur
 	 * on well-defined single instructions listed in the exception
_
