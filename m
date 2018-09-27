Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950ABC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5563021712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5563021712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeI1BLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:11:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38693 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbeI1BLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:11:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIpLh6130041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:51:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIpLUx130038;
        Thu, 27 Sep 2018 11:51:21 -0700
Date:   Thu, 27 Sep 2018 11:51:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-585948f4f695b07204702cfee0f828424af32aa7@git.kernel.org>
Cc:     tglx@linutronix.de, dave.hansen@intel.com, mark.gross@intel.com,
        mingo@kernel.org, peterz@infradead.org, bin.yang@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: dave.hansen@intel.com, tglx@linutronix.de, mingo@kernel.org,
          mark.gross@intel.com, bin.yang@intel.com, peterz@infradead.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180917143546.589642503@linutronix.de>
References: <20180917143546.589642503@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Avoid the 4k pages check completely
Git-Commit-ID: 585948f4f695b07204702cfee0f828424af32aa7
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

Commit-ID:  585948f4f695b07204702cfee0f828424af32aa7
Gitweb:     https://git.kernel.org/tip/585948f4f695b07204702cfee0f828424af32aa7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:17 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:39 +0200

x86/mm/cpa: Avoid the 4k pages check completely

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
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143546.589642503@linutronix.de

---
 arch/x86/mm/pageattr.c | 64 +++++++++++++-------------------------------------
 1 file changed, 16 insertions(+), 48 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index bbc5eb5cbc9d..4e55ded01be5 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -111,7 +111,6 @@ static unsigned long cpa_1g_preserved;
 static unsigned long cpa_2m_checked;
 static unsigned long cpa_2m_sameprot;
 static unsigned long cpa_2m_preserved;
-static unsigned long cpa_4k_checked;
 static unsigned long cpa_4k_install;
 
 static inline void cpa_inc_1g_checked(void)
@@ -124,11 +123,6 @@ static inline void cpa_inc_2m_checked(void)
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
@@ -158,7 +152,6 @@ static int cpastats_show(struct seq_file *m, void *p)
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
@@ -745,11 +737,10 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
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
@@ -854,53 +845,30 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
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
+	 * Check whether the requested pgprot is conflicting with a static
+	 * protection requirement in the large page.
 	 */
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
