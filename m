Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D07DC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAF32190B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeLZNjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:39:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:31975 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbeLZNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="113358929"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2018 05:37:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005Oj-Em; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.703380444@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:57 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Fan Du <fan.du@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 11/21] kvm: allocate page table pages from DRAM
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0001-kvm-allocate-page-table-pages-from-DRAM.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yao Yuan <yuan.yao@intel.com>

Signed-off-by: Yao Yuan <yuan.yao@intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
arch/x86/kvm/mmu.c |   12 +++++++++++-
1 file changed, 11 insertions(+), 1 deletion(-)

--- linux.orig/arch/x86/kvm/mmu.c	2018-12-26 20:54:48.846720344 +0800
+++ linux/arch/x86/kvm/mmu.c	2018-12-26 20:54:48.842719614 +0800
@@ -950,6 +950,16 @@ static void mmu_free_memory_cache(struct
 		kmem_cache_free(cache, mc->objects[--mc->nobjs]);
 }
 
+static unsigned long __get_dram_free_pages(gfp_t gfp_mask)
+{
+       struct page *page;
+
+       page = __alloc_pages(GFP_KERNEL_ACCOUNT, 0, numa_node_id());
+       if (!page)
+	       return 0;
+       return (unsigned long) page_address(page);
+}
+
 static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
 				       int min)
 {
@@ -958,7 +968,7 @@ static int mmu_topup_memory_cache_page(s
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+		page = (void *)__get_dram_free_pages(GFP_KERNEL_ACCOUNT);
 		if (!page)
 			return cache->nobjs >= min ? 0 : -ENOMEM;
 		cache->objects[cache->nobjs++] = page;


