Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B74AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C6A2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C6A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeIGUZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:25:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36690 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbeIGUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:59 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyIuw-00056g-2e; Fri, 07 Sep 2018 17:43:30 +0200
Message-Id: <20180907152055.248101027@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 17:01:29 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch 10/10] x86/mm/cpa: Avoid the 4k pages check completely
References: <20180907150119.325866892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-cpa--Avoid-the-4k-pages-check-completely.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extra loop which tries hard to preserve large pages in case of conflicts
with static protection regions turns out to be not preserving anything, at
least not in the experiments which have been conducted.

There might be corner cases in which the code would be able to preserve a
large page oaccsionally, but it's really not worth the extra code and the
cycles wasted in the common case.

Before:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  541
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:                  514
 4K pages set-checked:             7668

After:
 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  538
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages set-checked:             7668

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pageattr.c |   66 ++++++++++++-------------------------------------
 1 file changed, 17 insertions(+), 49 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -111,7 +111,6 @@ static unsigned long cpa_1g_preserved;
 static unsigned long cpa_2m_checked;
 static unsigned long cpa_2m_sameprot;
 static unsigned long cpa_2m_preserved;
-static unsigned long cpa_4k_checked;
 static unsigned long cpa_4k_install;
 
 static inline void cpa_inc_1g_checked(void)
@@ -124,11 +123,6 @@ static inline void cpa_inc_2m_checked(vo
 	cpa_2m_checked++;
 }
 
-static inline void cpa_inc_4k_checked(void)
-{
-	cpa_4k_checked++;
-}
-
 static inline void cpa_inc_4k_install(void)
 {
 	cpa_4k_install++;
@@ -158,7 +152,6 @@ static int cpastats_show(struct seq_file
 	seq_printf(m, "2M pages checked:     %16lu\n", cpa_2m_checked);
 	seq_printf(m, "2M pages sameprot:    %16lu\n", cpa_2m_sameprot);
 	seq_printf(m, "2M pages preserved:   %16lu\n", cpa_2m_preserved);
-	seq_printf(m, "4K pages checked:     %16lu\n", cpa_4k_checked);
 	seq_printf(m, "4K pages set-checked: %16lu\n", cpa_4k_install);
 	return 0;
 }
@@ -185,7 +178,6 @@ late_initcall(cpa_stats_init);
 #else
 static inline void cpa_inc_1g_checked(void) { }
 static inline void cpa_inc_2m_checked(void) { }
-static inline void cpa_inc_4k_checked(void) { }
 static inline void cpa_inc_4k_install(void) { }
 static inline void cpa_inc_lp_sameprot(int level) { }
 static inline void cpa_inc_lp_preserved(int level) { }
@@ -741,11 +733,10 @@ static pgprot_t pgprot_clear_protnone_bi
 static int __should_split_large_page(pte_t *kpte, unsigned long address,
 				     struct cpa_data *cpa)
 {
-	unsigned long numpages, pmask, psize, lpaddr, addr, pfn, old_pfn;
+	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
 	pte_t new_pte, old_pte, *tmp;
 	enum pg_level level;
-	int i;
 
 	/*
 	 * Check for races, another CPU might have split this page
@@ -850,53 +841,30 @@ static int __should_split_large_page(pte
 	}
 
 	/*
-	 * Optimization: Check whether the requested pgprot is conflicting
-	 * with a static protection requirement in the large page. If not,
-	 * then checking whether the requested range is fully covering the
-	 * large page can be done right here.
+	 * If the requested range does not cover the full page, split it up
 	 */
-	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
-				      CPA_DETECT);
-
-	if (pgprot_val(req_prot) == pgprot_val(new_prot)) {
-		if (address != lpaddr || cpa->numpages != numpages)
-			return 1;
-		goto setlp;
-	}
+	if (address != lpaddr || cpa->numpages != numpages)
+		return 1;
 
 	/*
-	 * Slow path. The full large page check above established that the
-	 * requested pgprot cannot be applied to the full large page due to
-	 * conflicting requirements of static protection regions. It might
-	 * turn out that the whole requested range is covered by the
-	 * modified protection of the first 4k segment at @address. This
-	 * might result in the ability to preserve the large page
-	 * nevertheless.
-	 */
-	new_prot = static_protections(req_prot, address, pfn, 1, CPA_DETECT);
-	pfn = old_pfn;
-	for (i = 0, addr = lpaddr; i < numpages; i++, addr += PAGE_SIZE, pfn++) {
-		chk_prot = static_protections(req_prot, addr, pfn, 1,
-					      CPA_DETECT);
-		cpa_inc_4k_checked();
-		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
-			return 1;
-	}
-
-	/* If there are no changes, return. */
-	if (pgprot_val(new_prot) == pgprot_val(old_prot)) {
-		cpa_inc_lp_sameprot(level);
-		return 0;
-	}
+	 * Check whether the requested pgprot is conflicting with a static
+	 * protection requirement in the large page.
+	 */
+	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
+				      CPA_DETECT);
 
 	/*
-	 * Verify that the address is aligned and the number of pages
-	 * covers the full page.
+	 * If there is a conflict, split the large page.
+	 *
+	 * There used to be a 4k wise evaluation trying really hard to
+	 * preserve the large pages, but experimentation has shown, that this
+	 * does not help at all. There might be corner cases which would
+	 * preserve one large page occasionally, but it's really not worth the
+	 * extra code and cycles for the common case.
 	 */
-	if (address != lpaddr || cpa->numpages != numpages)
+	if (pgprot_val(req_prot) != pgprot_val(new_prot))
 		return 1;
 
-setlp:
 	/* All checks passed. Update the large page mapping. */
 	new_pte = pfn_pte(old_pfn, new_prot);
 	__set_pmd_pte(kpte, address, new_pte);


