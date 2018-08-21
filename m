Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD92C04AB9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D7E21770
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D7E21770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeHUEeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:34:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:17761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeHUEeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:34:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 18:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,267,1531810800"; 
   d="scan'208";a="74359144"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2018 18:16:39 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com, bin.yang@intel.com
Subject: [PATCH v3 3/5] x86/mm: add help function to check specific protection flags in range
Date:   Tue, 21 Aug 2018 01:16:24 +0000
Message-Id: <1534814186-37067-4-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the needs_static_protections() helper to check specific
protection flags in range. It calls static_protection() to check
whether any part of the address/len range is forced to change from 'prot'.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 arch/x86/mm/pageattr.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 091f1d3..f630eb4 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -367,6 +367,30 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 }
 
 /*
+ * static_protections() "forces" page protections for some address
+ * ranges.  Return true if any part of the address/len range is forced
+ * to change from 'prot'.
+ */
+static inline bool
+needs_static_protections(pgprot_t prot, unsigned long address,
+		unsigned long len, unsigned long pfn)
+{
+	int i;
+
+	address &= PAGE_MASK;
+	len = PFN_ALIGN(len);
+	for (i = 0; i < (len >> PAGE_SHIFT); i++, address += PAGE_SIZE, pfn++) {
+		pgprot_t chk_prot = static_protections(prot, address, pfn);
+
+		if (pgprot_val(chk_prot) != pgprot_val(prot))
+			return true;
+	}
+
+	/* Does static_protections() demand a change ? */
+	return false;
+}
+
+/*
  * Lookup the page table entry for a virtual address in a specific pgd.
  * Return a pointer to the entry and the level of the mapping.
  */
@@ -556,7 +580,7 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	unsigned long nextpage_addr, numpages, pmask, psize, addr, pfn, old_pfn;
 	pte_t new_pte, old_pte, *tmp;
 	pgprot_t old_prot, new_prot, req_prot;
-	int i, do_split = 1;
+	int do_split = 1;
 	enum pg_level level;
 
 	if (cpa->force_split)
@@ -660,14 +684,8 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	 * static_protection() requires a different pgprot for one of
 	 * the pages in the range we try to preserve:
 	 */
-	pfn = old_pfn;
-	for (i = 0; i < (psize >> PAGE_SHIFT); i++, addr += PAGE_SIZE, pfn++) {
-		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
-
-		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
-			goto out_unlock;
-	}
-
+	if (needs_static_protections(new_prot, addr, psize, old_pfn))
+		goto out_unlock;
 
 	/* All checks passed. Just change the large mapping entry */
 	new_pte = pfn_pte(old_pfn, new_prot);
-- 
2.7.4

