Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96E0C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC27214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC27214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJIWUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:20:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIWUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:20:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F2agp1081718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:02:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F2a6f1081715;
        Tue, 9 Oct 2018 08:02:36 -0700
Date:   Tue, 9 Oct 2018 08:02:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-8fed62000039058adfd8b663344e2f448aed1e7a@git.kernel.org>
Cc:     jannh@google.com, hpa@zytor.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, peterz@infradead.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, jannh@google.com,
          hpa@zytor.com, sean.j.christopherson@intel.com
In-Reply-To: <20180928160222.401F4E10@viggo.jf.intel.com>
References: <20180928160222.401F4E10@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Break out kernel address space handling
Git-Commit-ID: 8fed62000039058adfd8b663344e2f448aed1e7a
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

Commit-ID:  8fed62000039058adfd8b663344e2f448aed1e7a
Gitweb:     https://git.kernel.org/tip/8fed62000039058adfd8b663344e2f448aed1e7a
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 28 Sep 2018 09:02:22 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:15 +0200

x86/mm: Break out kernel address space handling

The page fault handler (__do_page_fault())  basically has two sections:
one for handling faults in the kernel portion of the address space
and another for faults in the user portion of the address space.

But, these two parts don't stick out that well.  Let's make that more
clear from code separation and naming.  Pull kernel fault
handling into its own helper, and reflect that naming by renaming
spurious_fault() -> spurious_kernel_fault().

Also, rewrite the vmalloc() handling comment a bit.  It was a bit
stale and also glossed over the reserved bit handling.

Cc: x86@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180928160222.401F4E10@viggo.jf.intel.com
---
 arch/x86/mm/fault.c | 101 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 39 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index cd08f4fef836..c7e32f453852 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1032,7 +1032,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 	}
 }
 
-static int spurious_fault_check(unsigned long error_code, pte_t *pte)
+static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 {
 	if ((error_code & X86_PF_WRITE) && !pte_write(*pte))
 		return 0;
@@ -1071,7 +1071,7 @@ static int spurious_fault_check(unsigned long error_code, pte_t *pte)
  * (Optional Invalidation).
  */
 static noinline int
-spurious_fault(unsigned long error_code, unsigned long address)
+spurious_kernel_fault(unsigned long error_code, unsigned long address)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -1102,27 +1102,27 @@ spurious_fault(unsigned long error_code, unsigned long address)
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
 
@@ -1130,12 +1130,12 @@ spurious_fault(unsigned long error_code, unsigned long address)
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
 
@@ -1202,6 +1202,58 @@ static inline bool smap_violation(int error_code, struct pt_regs *regs)
 	return true;
 }
 
+/*
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
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
@@ -1227,38 +1279,9 @@ __do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
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
 
