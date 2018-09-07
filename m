Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFFCC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FD72077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbeIGUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:25:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbeIGUY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:56 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyIut-000566-0X; Fri, 07 Sep 2018 17:43:27 +0200
Message-Id: <20180907152054.984350320@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 17:01:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch 07/10] x86/mm/cpa: Add sanity check for existing mappings
References: <20180907150119.325866892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-cpa--Add-sanity-check-for-existing-mappings.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the range check it is possible to do a quick verification that the
current mapping is correct vs. the static protection areas.

In case a incorrect mapping is detected a warning is emitted and the large
page is split up. If the large page is a 2M page, then the split code is
forced to check the static protections for the PTE entries to fix up the
incorrectness. For 1G pages this can't be done easily because that would
require to either find the offending 2M areas before the split or
afterwards. For now just warn about that case and revisit it when reported.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pageattr.c |   77 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 10 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -37,12 +37,14 @@ struct cpa_data {
 	unsigned long	numpages;
 	int		flags;
 	unsigned long	pfn;
-	unsigned	force_split : 1;
+	unsigned	force_split		: 1,
+			force_static_prot	: 1;
 	int		curpage;
 	struct page	**pages;
 };
 
 enum cpa_warn {
+	CPA_CONFLICT,
 	CPA_PROTECT,
 	CPA_DETECT,
 };
@@ -498,6 +500,7 @@ static inline void check_conflict(int wa
 				  unsigned long pfn, const char *txt)
 {
 	static const char *lvltxt[] = {
+		[CPA_CONFLICT]	= "conflict",
 		[CPA_PROTECT]	= "protect",
 		[CPA_DETECT]	= "detect",
 	};
@@ -739,7 +742,7 @@ static int __should_split_large_page(pte
 				     struct cpa_data *cpa)
 {
 	unsigned long numpages, pmask, psize, lpaddr, addr, pfn, old_pfn;
-	pgprot_t old_prot, new_prot, req_prot;
+	pgprot_t old_prot, new_prot, req_prot, chk_prot;
 	pte_t new_pte, old_pte, *tmp;
 	enum pg_level level;
 	int i;
@@ -816,6 +819,23 @@ static int __should_split_large_page(pte
 	numpages = psize >> PAGE_SHIFT;
 
 	/*
+	 * Sanity check that the existing mapping is correct versus the static
+	 * protections. static_protections() guards against !PRESENT, so no
+	 * extra conditional required here.
+	 */
+	chk_prot = static_protections(old_prot, lpaddr, old_pfn, numpages,
+				      CPA_CONFLICT);
+
+	if (WARN_ON_ONCE(pgprot_val(chk_prot) != pgprot_val(old_prot))) {
+		/*
+		 * Split the large page and tell the split code to
+		 * enforce static protections.
+		 */
+		cpa->force_static_prot = 1;
+		return 1;
+	}
+
+	/*
 	 * Make sure that the requested pgprot does not violate the static
 	 * protections. Check the full large page whether one of the pages
 	 * in it results in a different pgprot than the first one of the
@@ -824,8 +844,8 @@ static int __should_split_large_page(pte
 	new_prot = static_protections(req_prot, address, pfn, 1, CPA_DETECT);
 	pfn = old_pfn;
 	for (i = 0, addr = lpaddr; i < numpages; i++, addr += PAGE_SIZE, pfn++) {
-		pgprot_t chk_prot = static_protections(req_prot, addr, pfn, 1,
-						       CPA_DETECT);
+		chk_prot = static_protections(req_prot, addr, pfn, 1,
+					      CPA_DETECT);
 		cpa_inc_4k_checked();
 		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
 			return 1;
@@ -867,15 +887,50 @@ static int should_split_large_page(pte_t
 	return do_split;
 }
 
+static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
+			  pgprot_t ref_prot, unsigned long address,
+			  unsigned long size)
+{
+	unsigned int npg = PFN_DOWN(size);
+	pgprot_t prot;
+
+	/*
+	 * If try_preserve_large_page() discovered an inconsistent mapping,
+	 * remove the invalid protection in the split mapping.
+	 */
+	if (!cpa->force_static_prot)
+		goto set;
+
+	prot = static_protections(ref_prot, address, pfn, npg, CPA_PROTECT);
+
+	if (pgprot_val(prot) == pgprot_val(ref_prot))
+		goto set;
+
+	/*
+	 * If this is splitting a PMD, fix it up. PUD splits cannot be
+	 * fixed trivially as that would require to rescan the newly
+	 * installed PMD mappings after returning from split_large_page()
+	 * so an eventual further split can allocate the necessary PTE
+	 * pages. Warn for now and revisit it in case this actually
+	 * happens.
+	 */
+	if (size == PAGE_SIZE)
+		ref_prot = prot;
+	else
+		pr_warn_once("CPA: Cannot fixup static protections for PUD split\n");
+set:
+	set_pte(pte, pfn_pte(pfn, ref_prot));
+}
+
 static int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		   struct page *base)
 {
+	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc = 1;
 	pte_t *pbase = (pte_t *)page_address(base);
-	unsigned long ref_pfn, pfn, pfninc = 1;
 	unsigned int i, level;
-	pte_t *tmp;
 	pgprot_t ref_prot;
+	pte_t *tmp;
 
 	spin_lock(&pgd_lock);
 	/*
@@ -898,15 +953,17 @@ static int
 		 * PAT bit to correct position.
 		 */
 		ref_prot = pgprot_large_2_4k(ref_prot);
-
 		ref_pfn = pmd_pfn(*(pmd_t *)kpte);
+		lpaddr = address & PMD_MASK;
+		lpinc = PAGE_SIZE;
 		break;
 
 	case PG_LEVEL_1G:
 		ref_prot = pud_pgprot(*(pud_t *)kpte);
 		ref_pfn = pud_pfn(*(pud_t *)kpte);
 		pfninc = PMD_PAGE_SIZE >> PAGE_SHIFT;
-
+		lpaddr = address & PUD_MASK;
+		lpinc = PMD_SIZE;
 		/*
 		 * Clear the PSE flags if the PRESENT flag is not set
 		 * otherwise pmd_present/pmd_huge will return true
@@ -927,8 +984,8 @@ static int
 	 * Get the target pfn from the original entry:
 	 */
 	pfn = ref_pfn;
-	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
-		set_pte(&pbase[i], pfn_pte(pfn, ref_prot));
+	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc, lpaddr += lpinc)
+		split_set_pte(cpa, pbase + i, pfn, ref_prot, lpaddr, lpinc);
 
 	if (virt_addr_valid(address)) {
 		unsigned long pfn = PFN_DOWN(__pa(address));


