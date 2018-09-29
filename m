Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36D7C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8608920880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8608920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeI3E0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51700 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728344AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N66-0000H6-4Z; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006we-KQ; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Hansen" <dave.hansen@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andi Kleen" <ak@linux.intel.com>, "Michal Hocko" <mhocko@suse.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.751361452@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 097/131] x86/speculation/l1tf: Protect PROT_NONE PTEs
 against speculation
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

commit 6b28baca9b1f0d4a42b865da7a05b1c81424bd5c upstream.

When PTEs are set to PROT_NONE the kernel just clears the Present bit and
preserves the PFN, which creates attack surface for L1TF speculation
speculation attacks.

This is important inside guests, because L1TF speculation bypasses physical
page remapping. While the host has its own migitations preventing leaking
data from other VMs into the guest, this would still risk leaking the wrong
page inside the current guest.

This uses the same technique as Linus' swap entry patch: while an entry is
is in PROTNONE state invert the complete PFN part part of it. This ensures
that the the highest bit will point to non existing memory.

The invert is done by pte/pmd_modify and pfn/pmd/pud_pte for PROTNONE and
pte/pmd/pud_pfn undo it.

This assume that no code path touches the PFN part of a PTE directly
without using these primitives.

This doesn't handle the case that MMIO is on the top of the CPU physical
memory. If such an MMIO region was exposed by an unpriviledged driver for
mmap it would be possible to attack some real memory.  However this
situation is all rather unlikely.

For 32bit non PAE the inversion is not done because there are really not
enough bits to protect anything.

Q: Why does the guest need to be protected when the HyperVisor already has
   L1TF mitigations?

A: Here's an example:

   Physical pages 1 2 get mapped into a guest as
   GPA 1 -> PA 2
   GPA 2 -> PA 1
   through EPT.

   The L1TF speculation ignores the EPT remapping.

   Now the guest kernel maps GPA 1 to process A and GPA 2 to process B, and
   they belong to different users and should be isolated.

   A sets the GPA 1 PA 2 PTE to PROT_NONE to bypass the EPT remapping and
   gets read access to the underlying physical page. Which in this case
   points to PA 2, so it can read process B's data, if it happened to be in
   L1, so isolation inside the guest is broken.

   There's nothing the hypervisor can do about this. This mitigation has to
   be done in the guest itself.

[ tglx: Massaged changelog ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Dave Hansen <dave.hansen@intel.com>
[bwh: Backported to 3.16:
 - s/check_pgprot/massage_pgprot/
 - Keep using PTE_PFN_MASK to extract PFN from pmd_pfn() and pud_pfn(),
   as we don't need to worry about the PAT bit being set here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pgtable-2level.h | 17 +++++++++++
 arch/x86/include/asm/pgtable-3level.h |  2 ++
 arch/x86/include/asm/pgtable-invert.h | 32 +++++++++++++++++++
 arch/x86/include/asm/pgtable.h        | 44 +++++++++++++++++++--------
 arch/x86/include/asm/pgtable_64.h     |  2 ++
 5 files changed, 84 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/include/asm/pgtable-invert.h

--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -77,4 +77,21 @@ static inline unsigned long pte_bitop(un
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
 
+/* No inverted PFNs on 2 level page tables */
+
+static inline u64 protnone_mask(u64 val)
+{
+	return 0;
+}
+
+static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask)
+{
+	return val;
+}
+
+static inline bool __pte_needs_invert(u64 val)
+{
+	return false;
+}
+
 #endif /* _ASM_X86_PGTABLE_2LEVEL_H */
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -184,4 +184,6 @@ static inline pmd_t native_pmdp_get_and_
 #define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t){ { .pte_high = (x).val } })
 
+#include <asm/pgtable-invert.h>
+
 #endif /* _ASM_X86_PGTABLE_3LEVEL_H */
--- /dev/null
+++ b/arch/x86/include/asm/pgtable-invert.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_PGTABLE_INVERT_H
+#define _ASM_PGTABLE_INVERT_H 1
+
+#ifndef __ASSEMBLY__
+
+static inline bool __pte_needs_invert(u64 val)
+{
+	return (val & (_PAGE_PRESENT|_PAGE_PROTNONE)) == _PAGE_PROTNONE;
+}
+
+/* Get a mask to xor with the page table entry to get the correct pfn. */
+static inline u64 protnone_mask(u64 val)
+{
+	return __pte_needs_invert(val) ?  ~0ull : 0;
+}
+
+static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask)
+{
+	/*
+	 * When a PTE transitions from NONE to !NONE or vice-versa
+	 * invert the PFN part to stop speculation.
+	 * pte_pfn undoes this when needed.
+	 */
+	if (__pte_needs_invert(oldval) != __pte_needs_invert(val))
+		val = (val & ~mask) | (~val & mask);
+	return val;
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -141,19 +141,29 @@ static inline int pte_special(pte_t pte)
 		(pte_flags(pte) & (_PAGE_PRESENT|_PAGE_PROTNONE));
 }
 
+/* Entries that were set to PROT_NONE are inverted */
+
+static inline u64 protnone_mask(u64 val);
+
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	return (pte_val(pte) & PTE_PFN_MASK) >> PAGE_SHIFT;
+	unsigned long pfn = pte_val(pte);
+	pfn ^= protnone_mask(pfn);
+	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
-	return (pmd_val(pmd) & PTE_PFN_MASK) >> PAGE_SHIFT;
+	unsigned long pfn = pmd_val(pmd);
+	pfn ^= protnone_mask(pfn);
+	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pud_pfn(pud_t pud)
 {
-	return (pud_val(pud) & PTE_PFN_MASK) >> PAGE_SHIFT;
+	unsigned long pfn = pud_val(pud);
+	pfn ^= protnone_mask(pfn);
+	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
@@ -361,25 +371,33 @@ static inline pgprotval_t massage_pgprot
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
-	return __pte(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	pfn ^= protnone_mask(pgprot_val(pgprot));
+	pfn &= PTE_PFN_MASK;
+	return __pte(pfn | massage_pgprot(pgprot));
 }
 
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
-	return __pmd(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	pfn ^= protnone_mask(pgprot_val(pgprot));
+	pfn &= PTE_PFN_MASK;
+	return __pmd(pfn | massage_pgprot(pgprot));
 }
 
 static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
 {
-	return __pud(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	pfn ^= protnone_mask(pgprot_val(pgprot));
+	pfn &= PTE_PFN_MASK;
+	return __pud(pfn | massage_pgprot(pgprot));
 }
 
+static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	pteval_t val = pte_val(pte);
+	pteval_t val = pte_val(pte), oldval = val;
 
 	/*
 	 * Chop off the NX bit (if present), and add the NX portion of
@@ -387,17 +405,17 @@ static inline pte_t pte_modify(pte_t pte
 	 */
 	val &= _PAGE_CHG_MASK;
 	val |= massage_pgprot(newprot) & ~_PAGE_CHG_MASK;
-
+	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
 	return __pte(val);
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-	pmdval_t val = pmd_val(pmd);
+	pmdval_t val = pmd_val(pmd), oldval = val;
 
 	val &= _HPAGE_CHG_MASK;
 	val |= massage_pgprot(newprot) & ~_HPAGE_CHG_MASK;
-
+	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
 	return __pmd(val);
 }
 
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -239,6 +239,8 @@ extern void cleanup_highmap(void);
 extern void init_extra_mapping_uc(unsigned long phys, unsigned long size);
 extern void init_extra_mapping_wb(unsigned long phys, unsigned long size);
 
+#include <asm/pgtable-invert.h>
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_64_H */

