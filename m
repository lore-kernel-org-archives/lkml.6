Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D605AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8C621765
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8C621765
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHUEef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:34:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:17761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeHUEee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:34:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 18:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,267,1531810800"; 
   d="scan'208";a="74359141"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2018 18:16:37 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com, bin.yang@intel.com
Subject: [PATCH v3 2/5] x86/mm: avoid static_protection() checking if not whole large page attr change
Date:   Tue, 21 Aug 2018 01:16:23 +0000
Message-Id: <1534814186-37067-3-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The range check whether the address is aligned to the large page and
covers the full large page (1G or 2M) is obvious to do _before_
static_protection() check, because if the requested range does not fit
and has a different pgprot_val() then it will decide to split after the
check anyway.

The approach and some of the comments came from Thomas Gleixner's
email example for how to do this

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 arch/x86/mm/pageattr.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 68613fd..091f1d3 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -645,11 +645,21 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	}
 
 	/*
+	 * If the requested address range is not aligned to the start of
+	 * the large page or does not cover the full range, split it up.
+	 * No matter what the static_protections() check below does, it
+	 * would anyway result in a split after doing all the check work
+	 * for nothing.
+	 */
+	addr = address & pmask;
+	if (address != addr || cpa->numpages != numpages)
+		goto out_unlock;
+
+	/*
 	 * We need to check the full range, whether
 	 * static_protection() requires a different pgprot for one of
 	 * the pages in the range we try to preserve:
 	 */
-	addr = address & pmask;
 	pfn = old_pfn;
 	for (i = 0; i < (psize >> PAGE_SHIFT); i++, addr += PAGE_SIZE, pfn++) {
 		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
@@ -659,24 +669,11 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	}
 
 
-	/*
-	 * We need to change the attributes. Check, whether we can
-	 * change the large page in one go. We request a split, when
-	 * the address is not aligned and the number of pages is
-	 * smaller than the number of pages in the large page. Note
-	 * that we limited the number of possible pages already to
-	 * the number of pages in the large page.
-	 */
-	if (address == (address & pmask) && cpa->numpages == (psize >> PAGE_SHIFT)) {
-		/*
-		 * The address is aligned and the number of pages
-		 * covers the full page.
-		 */
-		new_pte = pfn_pte(old_pfn, new_prot);
-		__set_pmd_pte(kpte, address, new_pte);
-		cpa->flags |= CPA_FLUSHTLB;
-		do_split = 0;
-	}
+	/* All checks passed. Just change the large mapping entry */
+	new_pte = pfn_pte(old_pfn, new_prot);
+	__set_pmd_pte(kpte, address, new_pte);
+	cpa->flags |= CPA_FLUSHTLB;
+	do_split = 0;
 
 out_unlock:
 	spin_unlock(&pgd_lock);
-- 
2.7.4

