Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5DEC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CFD271CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CFD271CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965261AbeF1KFn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:05:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:15220 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932831AbeF1KFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:05:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 03:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,282,1526367600"; 
   d="scan'208";a="68007505"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2018 03:05:40 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, bin.yang@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: fix cpu stuck issue in __change_page_attr_set_clr
Date:   Thu, 28 Jun 2018 10:05:40 +0000
Message-Id: <1530180340-18593-1-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    This issue can be easily triggered by free_initmem() functuion on
    x86_64 cpu.

    When changing page attr, __change_page_attr_set_clr will call
    __change_page_attr for every 4K page. And try_preserve_large_page
    will be called to check whether it needs to split the large page.

    If cpu supports "pdpe1gb", kernel will try to use 1G large page.
    In worst case, it needs to check every 4K page in 1G range in
    try_preserve_large_page function. If __change_page_attr_set_clr
    needs to change lots of 4K pages, cpu will be stuck for long time.

    This patch try to cache the last address which had been checked just
    now. If the next address is in same big page, the cache will be used
    without full range check.

Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 arch/x86/mm/pageattr.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 3bded76e..b9241ac 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -552,16 +552,20 @@ static int
 try_preserve_large_page(pte_t *kpte, unsigned long address,
 			struct cpa_data *cpa)
 {
+	static unsigned long address_cache;
+	static unsigned long do_split_cache = 1;
 	unsigned long nextpage_addr, numpages, pmask, psize, addr, pfn, old_pfn;
 	pte_t new_pte, old_pte, *tmp;
 	pgprot_t old_prot, new_prot, req_prot;
 	int i, do_split = 1;
 	enum pg_level level;
 
-	if (cpa->force_split)
+	spin_lock(&pgd_lock);
+	if (cpa->force_split) {
+		do_split_cache = 1;
 		return 1;
+	}
 
-	spin_lock(&pgd_lock);
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up already:
@@ -627,13 +631,25 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 
 	new_prot = static_protections(req_prot, address, pfn);
 
+	addr = address & pmask;
+	pfn = old_pfn;
+	/*
+	 * If an address in same range had been checked just now, re-use the
+	 * cache value without full range check. In the worst case, it needs to
+	 * check every 4K page in 1G range, which causes cpu stuck for long
+	 * time.
+	 */
+	if (!do_split_cache &&
+	    address_cache >= addr && address_cache < nextpage_addr &&
+	    pgprot_val(new_prot) == pgprot_val(old_prot)) {
+		do_split = do_split_cache;
+		goto out_unlock;
+	}
 	/*
 	 * We need to check the full range, whether
 	 * static_protection() requires a different pgprot for one of
 	 * the pages in the range we try to preserve:
 	 */
-	addr = address & pmask;
-	pfn = old_pfn;
 	for (i = 0; i < (psize >> PAGE_SHIFT); i++, addr += PAGE_SIZE, pfn++) {
 		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
 
@@ -670,6 +686,8 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	}
 
 out_unlock:
+	address_cache = address;
+	do_split_cache = do_split;
 	spin_unlock(&pgd_lock);
 
 	return do_split;
-- 
2.7.4

