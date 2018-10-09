Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FEDC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF15421479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF15421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJIWTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:19:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:19:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F23Xa1081683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:02:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F23MR1081680;
        Tue, 9 Oct 2018 08:02:03 -0700
Date:   Tue, 9 Oct 2018 08:02:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-164477c2331be75d9bd57fb76704e676b2bcd1cd@git.kernel.org>
Cc:     jannh@google.com, sean.j.christopherson@intel.com, luto@kernel.org,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: jannh@google.com, sean.j.christopherson@intel.com,
          luto@kernel.org, peterz@infradead.org, hpa@zytor.com,
          tglx@linutronix.de, dave.hansen@linux.intel.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180928160220.4A2272C9@viggo.jf.intel.com>
References: <20180928160220.4A2272C9@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Clarify hardware vs. software "error_code"
Git-Commit-ID: 164477c2331be75d9bd57fb76704e676b2bcd1cd
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

Commit-ID:  164477c2331be75d9bd57fb76704e676b2bcd1cd
Gitweb:     https://git.kernel.org/tip/164477c2331be75d9bd57fb76704e676b2bcd1cd
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 28 Sep 2018 09:02:20 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:15 +0200

x86/mm: Clarify hardware vs. software "error_code"

We pass around a variable called "error_code" all around the page
fault code.  Sounds simple enough, especially since "error_code" looks
like it exactly matches the values that the hardware gives us on the
stack to report the page fault error code (PFEC in SDM parlance).

But, that's not how it works.

For part of the page fault handler, "error_code" does exactly match
PFEC.  But, during later parts, it diverges and starts to mean
something a bit different.

Give it two names for its two jobs.

The place it diverges is also really screwy.  It's only in a spot
where the hardware tells us we have kernel-mode access that occurred
while we were in usermode accessing user-controlled address space.
Add a warning in there.

Cc: x86@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180928160220.4A2272C9@viggo.jf.intel.com
---
 arch/x86/mm/fault.c | 77 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 47bebfe6efa7..cd08f4fef836 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1208,9 +1208,10 @@ static inline bool smap_violation(int error_code, struct pt_regs *regs)
  * routines.
  */
 static noinline void
-__do_page_fault(struct pt_regs *regs, unsigned long error_code,
+__do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		unsigned long address)
 {
+	unsigned long sw_error_code;
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
@@ -1236,17 +1237,17 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * nothing more.
 	 *
 	 * This verifies that the fault happens in kernel space
-	 * (error_code & 4) == 0, and that the fault was not a
-	 * protection error (error_code & 9) == 0.
+	 * (hw_error_code & 4) == 0, and that the fault was not a
+	 * protection error (hw_error_code & 9) == 0.
 	 */
 	if (unlikely(fault_in_kernel_space(address))) {
-		if (!(error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
+		if (!(hw_error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
 			if (vmalloc_fault(address) >= 0)
 				return;
 		}
 
 		/* Can handle a stale RO->RW TLB: */
-		if (spurious_fault(error_code, address))
+		if (spurious_fault(hw_error_code, address))
 			return;
 
 		/* kprobes don't want to hook the spurious faults: */
@@ -1256,7 +1257,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		 * Don't take the mm semaphore here. If we fixup a prefetch
 		 * fault we could otherwise deadlock:
 		 */
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 
 		return;
 	}
@@ -1265,11 +1266,11 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (unlikely(kprobes_fault(regs)))
 		return;
 
-	if (unlikely(error_code & X86_PF_RSVD))
-		pgtable_bad(regs, error_code, address);
+	if (unlikely(hw_error_code & X86_PF_RSVD))
+		pgtable_bad(regs, hw_error_code, address);
 
-	if (unlikely(smap_violation(error_code, regs))) {
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+	if (unlikely(smap_violation(hw_error_code, regs))) {
+		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 		return;
 	}
 
@@ -1278,10 +1279,17 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 		return;
 	}
 
+	/*
+	 * hw_error_code is literally the "page fault error code" passed to
+	 * the kernel directly from the hardware.  But, we will shortly be
+	 * modifying it in software, so give it a new name.
+	 */
+	sw_error_code = hw_error_code;
+
 	/*
 	 * It's safe to allow irq's after cr2 has been saved and the
 	 * vmalloc fault has been handled.
@@ -1291,7 +1299,26 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 */
 	if (user_mode(regs)) {
 		local_irq_enable();
-		error_code |= X86_PF_USER;
+		/*
+		 * Up to this point, X86_PF_USER set in hw_error_code
+		 * indicated a user-mode access.  But, after this,
+		 * X86_PF_USER in sw_error_code will indicate either
+		 * that, *or* an implicit kernel(supervisor)-mode access
+		 * which originated from user mode.
+		 */
+		if (!(hw_error_code & X86_PF_USER)) {
+			/*
+			 * The CPU was in user mode, but the CPU says
+			 * the fault was not a user-mode access.
+			 * Must be an implicit kernel-mode access,
+			 * which we do not expect to happen in the
+			 * user address space.
+			 */
+			pr_warn_once("kernel-mode error from user-mode: %lx\n",
+					hw_error_code);
+
+			sw_error_code |= X86_PF_USER;
+		}
 		flags |= FAULT_FLAG_USER;
 	} else {
 		if (regs->flags & X86_EFLAGS_IF)
@@ -1300,9 +1327,9 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (error_code & X86_PF_WRITE)
+	if (sw_error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
-	if (error_code & X86_PF_INSTR)
+	if (sw_error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 	/*
@@ -1322,9 +1349,9 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * space check, thus avoiding the deadlock:
 	 */
 	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
-		if (!(error_code & X86_PF_USER) &&
+		if (!(sw_error_code & X86_PF_USER) &&
 		    !search_exception_tables(regs->ip)) {
-			bad_area_nosemaphore(regs, error_code, address, NULL);
+			bad_area_nosemaphore(regs, sw_error_code, address, NULL);
 			return;
 		}
 retry:
@@ -1340,16 +1367,16 @@ retry:
 
 	vma = find_vma(mm, address);
 	if (unlikely(!vma)) {
-		bad_area(regs, error_code, address);
+		bad_area(regs, sw_error_code, address);
 		return;
 	}
 	if (likely(vma->vm_start <= address))
 		goto good_area;
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, error_code, address);
+		bad_area(regs, sw_error_code, address);
 		return;
 	}
-	if (error_code & X86_PF_USER) {
+	if (sw_error_code & X86_PF_USER) {
 		/*
 		 * Accessing the stack below %sp is always a bug.
 		 * The large cushion allows instructions like enter
@@ -1357,12 +1384,12 @@ retry:
 		 * 32 pointers and then decrements %sp by 65535.)
 		 */
 		if (unlikely(address + 65536 + 32 * sizeof(unsigned long) < regs->sp)) {
-			bad_area(regs, error_code, address);
+			bad_area(regs, sw_error_code, address);
 			return;
 		}
 	}
 	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, error_code, address);
+		bad_area(regs, sw_error_code, address);
 		return;
 	}
 
@@ -1371,8 +1398,8 @@ retry:
 	 * we can handle it..
 	 */
 good_area:
-	if (unlikely(access_error(error_code, vma))) {
-		bad_area_access_error(regs, error_code, address, vma);
+	if (unlikely(access_error(sw_error_code, vma))) {
+		bad_area_access_error(regs, sw_error_code, address, vma);
 		return;
 	}
 
@@ -1414,13 +1441,13 @@ good_area:
 			return;
 
 		/* Not returning to user mode? Handle exceptions or die: */
-		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		no_context(regs, sw_error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
 
 	up_read(&mm->mmap_sem);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mm_fault_error(regs, error_code, address, &pkey, fault);
+		mm_fault_error(regs, sw_error_code, address, &pkey, fault);
 		return;
 	}
 
