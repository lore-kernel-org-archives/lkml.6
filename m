Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5A7C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5878220657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5878220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbeI1Wac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:30:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:48800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeI1Wac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:30:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="267797240"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2018 09:06:05 -0700
Subject: [PATCH 2/8] x86/mm: break out kernel address space handling
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org,
        jannh@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:22 -0700
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
Message-Id: <20180928160222.401F4E10@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The page fault handler (__do_page_fault())  basically has two sections:
one for handling faults in the kernel portion of the address space
and another for faults in the user portion of the address space.

But, these two parts don't stick out that well.  Let's make that more
clear from code separation and naming.  Pull kernel fault
handling into its own helper, and reflect that naming by renaming
spurious_fault() -> spurious_kernel_fault().

Also, rewrite the vmalloc() handling comment a bit.  It was a bit
stale and also glossed over the reserved bit handling.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---

 b/arch/x86/mm/fault.c |  101 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 39 deletions(-)

diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-00 arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~pkeys-fault-warnings-00	2018-09-27 10:17:21.985343570 -0700
+++ b/arch/x86/mm/fault.c	2018-09-27 10:17:21.988343570 -0700
@@ -1034,7 +1034,7 @@ mm_fault_error(struct pt_regs *regs, uns
 	}
 }
 
-static int spurious_fault_check(unsigned long error_code, pte_t *pte)
+static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 {
 	if ((error_code & X86_PF_WRITE) && !pte_write(*pte))
 		return 0;
@@ -1073,7 +1073,7 @@ static int spurious_fault_check(unsigned
  * (Optional Invalidation).
  */
 static noinline int
-spurious_fault(unsigned long error_code, unsigned long address)
+spurious_kernel_fault(unsigned long error_code, unsigned long address)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -1104,27 +1104,27 @@ spurious_fault(unsigned long error_code,
 		return 0;
 
 	if (p4d_large(*p4d))
-		return spurious_fault_check(error_code, (pte_t *) p4d);
+		return spurious_kernel_fault_check(error_code, (pte_t *) p4d);
 
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
 		return 0;
 
 	if (pud_large(*pud))
-		return spurious_fault_check(error_code, (pte_t *) pud);
+		return spurious_kernel_fault_check(error_code, (pte_t *) pud);
 
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return 0;
 
 	if (pmd_large(*pmd))
-		return spurious_fault_check(error_code, (pte_t *) pmd);
+		return spurious_kernel_fault_check(error_code, (pte_t *) pmd);
 
 	pte = pte_offset_kernel(pmd, address);
 	if (!pte_present(*pte))
 		return 0;
 
-	ret = spurious_fault_check(error_code, pte);
+	ret = spurious_kernel_fault_check(error_code, pte);
 	if (!ret)
 		return 0;
 
@@ -1132,12 +1132,12 @@ spurious_fault(unsigned long error_code,
 	 * Make sure we have permissions in PMD.
 	 * If not, then there's a bug in the page tables:
 	 */
-	ret = spurious_fault_check(error_code, (pte_t *) pmd);
+	ret = spurious_kernel_fault_check(error_code, (pte_t *) pmd);
 	WARN_ONCE(!ret, "PMD has incorrect permission bits\n");
 
 	return ret;
 }
-NOKPROBE_SYMBOL(spurious_fault);
+NOKPROBE_SYMBOL(spurious_kernel_fault);
 
 int show_unhandled_signals = 1;
 
@@ -1205,6 +1205,58 @@ static inline bool smap_violation(int er
 }
 
 /*
+ * Called for all faults where 'address' is part of the kernel address
+ * space.  Might get called for faults that originate from *code* that
+ * ran in userspace or the kernel.
+ */
+static void
+do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
+		   unsigned long address)
+{
+	/*
+	 * We can fault-in kernel-space virtual memory on-demand. The
+	 * 'reference' page table is init_mm.pgd.
+	 *
+	 * NOTE! We MUST NOT take any locks for this case. We may
+	 * be in an interrupt or a critical region, and should
+	 * only copy the information from the master page table,
+	 * nothing more.
+	 *
+	 * Before doing this on-demand faulting, ensure that the
+	 * fault is not any of the following:
+	 * 1. A fault on a PTE with a reserved bit set.
+	 * 2. A fault caused by a user-mode access.  (Do not demand-
+	 *    fault kernel memory due to user-mode accesses).
+	 * 3. A fault caused by a page-level protection violation.
+	 *    (A demand fault would be on a non-present page which
+	 *     would have X86_PF_PROT==0).
+	 */
+	if (!(hw_error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
+		if (vmalloc_fault(address) >= 0)
+			return;
+	}
+
+	/* Was the fault spurious, caused by lazy TLB invalidation? */
+	if (spurious_kernel_fault(hw_error_code, address))
+		return;
+
+	/* kprobes don't want to hook the spurious faults: */
+	if (kprobes_fault(regs))
+		return;
+
+	/*
+	 * Note, despite being a "bad area", there are quite a few
+	 * acceptable reasons to get here, such as erratum fixups
+	 * and handling kernel code that can fault, like get_user().
+	 *
+	 * Don't take the mm semaphore here. If we fixup a prefetch
+	 * fault we could otherwise deadlock:
+	 */
+	bad_area_nosemaphore(regs, hw_error_code, address, NULL);
+}
+NOKPROBE_SYMBOL(do_kern_addr_fault);
+
+/*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
  * routines.
@@ -1229,38 +1281,9 @@ __do_page_fault(struct pt_regs *regs, un
 	if (unlikely(kmmio_fault(regs, address)))
 		return;
 
-	/*
-	 * We fault-in kernel-space virtual memory on-demand. The
-	 * 'reference' page table is init_mm.pgd.
-	 *
-	 * NOTE! We MUST NOT take any locks for this case. We may
-	 * be in an interrupt or a critical region, and should
-	 * only copy the information from the master page table,
-	 * nothing more.
-	 *
-	 * This verifies that the fault happens in kernel space
-	 * (hw_error_code & 4) == 0, and that the fault was not a
-	 * protection error (hw_error_code & 9) == 0.
-	 */
+	/* Was the fault on kernel-controlled part of the address space? */
 	if (unlikely(fault_in_kernel_space(address))) {
-		if (!(hw_error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
-			if (vmalloc_fault(address) >= 0)
-				return;
-		}
-
-		/* Can handle a stale RO->RW TLB: */
-		if (spurious_fault(hw_error_code, address))
-			return;
-
-		/* kprobes don't want to hook the spurious faults: */
-		if (kprobes_fault(regs))
-			return;
-		/*
-		 * Don't take the mm semaphore here. If we fixup a prefetch
-		 * fault we could otherwise deadlock:
-		 */
-		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
-
+		do_kern_addr_fault(regs, hw_error_code, address);
 		return;
 	}
 
_
