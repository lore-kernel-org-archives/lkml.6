Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A734C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E54120657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E54120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbeI1Wav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:30:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:14956 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbeI1Wav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:30:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="236917992"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2018 09:06:03 -0700
Subject: [PATCH 1/8] x86/mm: clarify hardware vs. software "error_code"
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org,
        jannh@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:20 -0700
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
Message-Id: <20180928160220.4A2272C9@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

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

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---

 b/arch/x86/mm/fault.c |   77 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-0 arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~pkeys-fault-warnings-0	2018-09-27 10:17:21.481343572 -0700
+++ b/arch/x86/mm/fault.c	2018-09-27 10:17:21.485343572 -0700
@@ -1210,9 +1210,10 @@ static inline bool smap_violation(int er
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
@@ -1238,17 +1239,17 @@ __do_page_fault(struct pt_regs *regs, un
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
@@ -1258,7 +1259,7 @@ __do_page_fault(struct pt_regs *regs, un
 		 * Don't take the mm semaphore here. If we fixup a prefetch
 		 * fault we could otherwise deadlock:
 		 */
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 
 		return;
 	}
@@ -1267,11 +1268,11 @@ __do_page_fault(struct pt_regs *regs, un
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
 
@@ -1280,11 +1281,18 @@ __do_page_fault(struct pt_regs *regs, un
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 		return;
 	}
 
 	/*
+	 * hw_error_code is literally the "page fault error code" passed to
+	 * the kernel directly from the hardware.  But, we will shortly be
+	 * modifying it in software, so give it a new name.
+	 */
+	sw_error_code = hw_error_code;
+
+	/*
 	 * It's safe to allow irq's after cr2 has been saved and the
 	 * vmalloc fault has been handled.
 	 *
@@ -1293,7 +1301,26 @@ __do_page_fault(struct pt_regs *regs, un
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
@@ -1302,9 +1329,9 @@ __do_page_fault(struct pt_regs *regs, un
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (error_code & X86_PF_WRITE)
+	if (sw_error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
-	if (error_code & X86_PF_INSTR)
+	if (sw_error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 	/*
@@ -1324,9 +1351,9 @@ __do_page_fault(struct pt_regs *regs, un
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
@@ -1342,16 +1369,16 @@ retry:
 
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
@@ -1359,12 +1386,12 @@ retry:
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
 
@@ -1373,8 +1400,8 @@ retry:
 	 * we can handle it..
 	 */
 good_area:
-	if (unlikely(access_error(error_code, vma))) {
-		bad_area_access_error(regs, error_code, address, vma);
+	if (unlikely(access_error(sw_error_code, vma))) {
+		bad_area_access_error(regs, sw_error_code, address, vma);
 		return;
 	}
 
@@ -1416,13 +1443,13 @@ good_area:
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
 
_
