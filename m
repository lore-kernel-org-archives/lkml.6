Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA278C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E03C213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E03C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJIWXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:23:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:23:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F5KT51083705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:05:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F5KG91083702;
        Tue, 9 Oct 2018 08:05:20 -0700
Date:   Tue, 9 Oct 2018 08:05:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-3ae0ad92f53e0f05cf6ab781230b7902b88f73cd@git.kernel.org>
Cc:     mingo@kernel.org, luto@kernel.org, jannh@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        peterz@infradead.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, peterz@infradead.org,
          dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org, luto@kernel.org,
          jannh@google.com, sean.j.christopherson@intel.com
In-Reply-To: <20180928160230.6E9336EE@viggo.jf.intel.com>
References: <20180928160230.6E9336EE@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/vsyscall: Consider vsyscall page part of user
 address space
Git-Commit-ID: 3ae0ad92f53e0f05cf6ab781230b7902b88f73cd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3ae0ad92f53e0f05cf6ab781230b7902b88f73cd
Gitweb:     https://git.kernel.org/tip/3ae0ad92f53e0f05cf6ab781230b7902b88f73cd
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 28 Sep 2018 09:02:30 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:16 +0200

x86/mm/vsyscall: Consider vsyscall page part of user address space

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

Cc: x86@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180928160230.6E9336EE@viggo.jf.intel.com
---
 arch/x86/mm/fault.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7a627ac3a0d2..7e0fa7e24168 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -846,7 +846,7 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
  */
 static bool is_vsyscall_vaddr(unsigned long vaddr)
 {
-	return (vaddr & PAGE_MASK) == VSYSCALL_ADDR;
+	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
 }
 
 static void
@@ -872,18 +872,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
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
@@ -1192,6 +1180,14 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 
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
 
@@ -1359,6 +1355,22 @@ void do_user_addr_fault(struct pt_regs *regs,
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
