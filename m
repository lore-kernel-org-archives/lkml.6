Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54121C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CDC2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CDC2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeI3E1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:27:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51683 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728293AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N65-0000Gy-QG; Sat, 29 Sep 2018 22:48:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006xO-WE; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Hansen" <dave.hansen@intel.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Guenter Roeck" <linux@roeck-us.net>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.786378837@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 106/131] x86/speculation/l1tf: Disallow non
 privileged high MMIO PROT_NONE mappings
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 42e4089c7890725fcd329999252dc489b72f2921 upstream.

For L1TF PROT_NONE mappings are protected by inverting the PFN in the page
table entry. This sets the high bits in the CPU's address space, thus
making sure to point to not point an unmapped entry to valid cached memory.

Some server system BIOSes put the MMIO mappings high up in the physical
address space. If such an high mapping was mapped to unprivileged users
they could attack low memory by setting such a mapping to PROT_NONE. This
could happen through a special device driver which is not access
protected. Normal /dev/mem is of course access protected.

To avoid this forbid PROT_NONE mappings or mprotect for high MMIO mappings.

Valid page mappings are allowed because the system is then unsafe anyways.

It's not expected that users commonly use PROT_NONE on MMIO. But to
minimize any impact this is only enforced if the mapping actually refers to
a high MMIO address (defined as the MAX_PA-1 bit being set), and also skip
the check for root.

For mmaps this is straight forward and can be handled in vm_insert_pfn and
in remap_pfn_range().

For mprotect it's a bit trickier. At the point where the actual PTEs are
accessed a lot of state has been changed and it would be difficult to undo
on an error. Since this is a uncommon case use a separate early page talk
walk pass for MMIO PROT_NONE mappings that checks for this condition
early. For non MMIO and non PROT_NONE there are no changes.

[dwmw2: Backport to 4.9]
[groeck: Backport to 4.4]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pgtable.h |  8 ++++++
 arch/x86/mm/mmap.c             | 21 +++++++++++++++
 include/asm-generic/pgtable.h  | 12 +++++++++
 mm/memory.c                    | 29 +++++++++++++++-----
 mm/mprotect.c                  | 49 ++++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -940,6 +940,14 @@ static inline pte_t pte_swp_clear_soft_d
 }
 #endif
 
+#define __HAVE_ARCH_PFN_MODIFY_ALLOWED 1
+extern bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot);
+
+static inline bool arch_has_pfn_modify_check(void)
+{
+	return boot_cpu_has_bug(X86_BUG_L1TF);
+}
+
 #include <asm-generic/pgtable.h>
 #endif	/* __ASSEMBLY__ */
 
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -114,3 +114,24 @@ void arch_pick_mmap_layout(struct mm_str
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
+
+/*
+ * Only allow root to set high MMIO mappings to PROT_NONE.
+ * This prevents an unpriv. user to set them to PROT_NONE and invert
+ * them, then pointing to valid memory for L1TF speculation.
+ *
+ * Note: for locked down kernels may want to disable the root override.
+ */
+bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
+{
+	if (!boot_cpu_has_bug(X86_BUG_L1TF))
+		return true;
+	if (!__pte_needs_invert(pgprot_val(prot)))
+		return true;
+	/* If it's real memory always allow */
+	if (pfn_valid(pfn))
+		return true;
+	if (pfn > l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
+		return false;
+	return true;
+}
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -812,4 +812,16 @@ static inline void pmdp_set_numa(struct
 #define io_remap_pfn_range remap_pfn_range
 #endif
 
+#ifndef __HAVE_ARCH_PFN_MODIFY_ALLOWED
+static inline bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
+{
+	return true;
+}
+
+static inline bool arch_has_pfn_modify_check(void)
+{
+	return false;
+}
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1614,6 +1614,9 @@ int vm_insert_pfn_prot(struct vm_area_st
 	if (track_pfn_insert(vma, &pgprot, pfn))
 		return -EINVAL;
 
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return -EACCES;
+
 	ret = insert_pfn(vma, addr, pfn, pgprot);
 
 	return ret;
@@ -1632,6 +1635,9 @@ int vm_insert_mixed(struct vm_area_struc
 	if (track_pfn_insert(vma, &pgprot, pfn))
 		return -EINVAL;
 
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return -EACCES;
+
 	/*
 	 * If we don't have pte special, then we have to use the pfn_valid()
 	 * based VM_MIXEDMAP scheme (see vm_normal_page), and thus we *must*
@@ -1660,6 +1666,7 @@ static int remap_pte_range(struct mm_str
 {
 	pte_t *pte;
 	spinlock_t *ptl;
+	int err = 0;
 
 	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
@@ -1667,12 +1674,16 @@ static int remap_pte_range(struct mm_str
 	arch_enter_lazy_mmu_mode();
 	do {
 		BUG_ON(!pte_none(*pte));
+		if (!pfn_modify_allowed(pfn, prot)) {
+			err = -EACCES;
+			break;
+		}
 		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte - 1, ptl);
-	return 0;
+	return err;
 }
 
 static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
@@ -1681,6 +1692,7 @@ static inline int remap_pmd_range(struct
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int err;
 
 	pfn -= addr >> PAGE_SHIFT;
 	pmd = pmd_alloc(mm, pud, addr);
@@ -1689,9 +1701,10 @@ static inline int remap_pmd_range(struct
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 	do {
 		next = pmd_addr_end(addr, end);
-		if (remap_pte_range(mm, pmd, addr, next,
-				pfn + (addr >> PAGE_SHIFT), prot))
-			return -ENOMEM;
+		err = remap_pte_range(mm, pmd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot);
+		if (err)
+			return err;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
@@ -1702,6 +1715,7 @@ static inline int remap_pud_range(struct
 {
 	pud_t *pud;
 	unsigned long next;
+	int err;
 
 	pfn -= addr >> PAGE_SHIFT;
 	pud = pud_alloc(mm, pgd, addr);
@@ -1709,9 +1723,10 @@ static inline int remap_pud_range(struct
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (remap_pmd_range(mm, pud, addr, next,
-				pfn + (addr >> PAGE_SHIFT), prot))
-			return -ENOMEM;
+		err = remap_pmd_range(mm, pud, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot);
+		if (err)
+			return err;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -258,6 +258,42 @@ unsigned long change_protection(struct v
 	return pages;
 }
 
+static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
+			       unsigned long next, struct mm_walk *walk)
+{
+	return pfn_modify_allowed(pte_pfn(*pte), *(pgprot_t *)(walk->private)) ?
+		0 : -EACCES;
+}
+
+static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
+				   unsigned long addr, unsigned long next,
+				   struct mm_walk *walk)
+{
+	return pfn_modify_allowed(pte_pfn(*pte), *(pgprot_t *)(walk->private)) ?
+		0 : -EACCES;
+}
+
+static int prot_none_test(unsigned long addr, unsigned long next,
+			  struct mm_walk *walk)
+{
+	return 0;
+}
+
+static int prot_none_walk(struct vm_area_struct *vma, unsigned long start,
+			   unsigned long end, unsigned long newflags)
+{
+	pgprot_t new_pgprot = vm_get_page_prot(newflags);
+	struct mm_walk prot_none_walk = {
+		.pte_entry = prot_none_pte_entry,
+		.hugetlb_entry = prot_none_hugetlb_entry,
+		.test_walk = prot_none_test,
+		.mm = current->mm,
+		.private = &new_pgprot,
+	};
+
+	return walk_page_range(start, end, &prot_none_walk);
+}
+
 int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	unsigned long start, unsigned long end, unsigned long newflags)
@@ -276,6 +312,19 @@ mprotect_fixup(struct vm_area_struct *vm
 	}
 
 	/*
+	 * Do PROT_NONE PFN permission checks here when we can still
+	 * bail out without undoing a lot of state. This is a rather
+	 * uncommon case, so doesn't need to be very optimized.
+	 */
+	if (arch_has_pfn_modify_check() &&
+	    (vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
+	    (newflags & (VM_READ|VM_WRITE|VM_EXEC)) == 0) {
+		error = prot_none_walk(vma, start, end, newflags);
+		if (error)
+			return error;
+	}
+
+	/*
 	 * If we make a private mapping writable we increase our commit;
 	 * but (without finer accounting) cannot reduce our commit if we
 	 * make it unwritable again. hugetlb mapping were accounted for

