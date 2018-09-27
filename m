Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15980C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82DC21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82DC21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeI1BJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:09:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60973 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeI1BJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:09:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIndYx129747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:49:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIndWL129744;
        Thu, 27 Sep 2018 11:49:39 -0700
Date:   Thu, 27 Sep 2018 11:49:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f61c5ba2885eabc7bc4b0b2f5232f475216ba446@git.kernel.org>
Cc:     mark.gross@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        bin.yang@intel.com, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mark.gross@intel.com, dave.hansen@intel.com,
          linux-kernel@vger.kernel.org, bin.yang@intel.com,
          peterz@infradead.org
In-Reply-To: <20180917143546.331408643@linutronix.de>
References: <20180917143546.331408643@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Add sanity check for existing mappings
Git-Commit-ID: f61c5ba2885eabc7bc4b0b2f5232f475216ba446
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

Commit-ID:  f61c5ba2885eabc7bc4b0b2f5232f475216ba446
Gitweb:     https://git.kernel.org/tip/f61c5ba2885eabc7bc4b0b2f5232f475216ba446
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:39 +0200

x86/mm/cpa: Add sanity check for existing mappings

With the range check it is possible to do a quick verification that the
current mapping is correct vs. the static protection areas.

In case a incorrect mapping is detected a warning is emitted and the large
page is split up. If the large page is a 2M page, then the split code is
forced to check the static protections for the PTE entries to fix up the
incorrectness. For 1G pages this can't be done easily because that would
require to either find the offending 2M areas before the split or
afterwards. For now just warn about that case and revisit it when reported.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143546.331408643@linutronix.de

---
 arch/x86/mm/pageattr.c | 77 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 8f9083eb21ac..19781b0ab4b4 100644
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
@@ -501,6 +503,7 @@ static inline void check_conflict(int warnlvl, pgprot_t prot, pgprotval_t val,
 				  unsigned long pfn, const char *txt)
 {
 	static const char *lvltxt[] = {
+		[CPA_CONFLICT]	= "conflict",
 		[CPA_PROTECT]	= "protect",
 		[CPA_DETECT]	= "detect",
 	};
@@ -743,7 +746,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 				     struct cpa_data *cpa)
 {
 	unsigned long numpages, pmask, psize, lpaddr, addr, pfn, old_pfn;
-	pgprot_t old_prot, new_prot, req_prot;
+	pgprot_t old_prot, new_prot, req_prot, chk_prot;
 	pte_t new_pte, old_pte, *tmp;
 	enum pg_level level;
 	int i;
@@ -819,6 +822,23 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	lpaddr = address & pmask;
 	numpages = psize >> PAGE_SHIFT;
 
+	/*
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
 	/*
 	 * Make sure that the requested pgprot does not violate the static
 	 * protections. Check the full large page whether one of the pages
@@ -828,8 +848,8 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
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
@@ -871,15 +891,50 @@ static int should_split_large_page(pte_t *kpte, unsigned long address,
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
+	 * If should_split_large_page() discovered an inconsistent mapping,
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
@@ -902,15 +957,17 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
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
@@ -931,8 +988,8 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * Get the target pfn from the original entry:
 	 */
 	pfn = ref_pfn;
-	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
-		set_pte(&pbase[i], pfn_pte(pfn, ref_prot));
+	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc, lpaddr += lpinc)
+		split_set_pte(cpa, pbase + i, pfn, ref_prot, lpaddr, lpinc);
 
 	if (virt_addr_valid(address)) {
 		unsigned long pfn = PFN_DOWN(__pa(address));
