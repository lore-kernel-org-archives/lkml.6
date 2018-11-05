Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138D720862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138D720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeKESRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:17:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:46184 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKESRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:17:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 00:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="103471781"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2018 00:58:24 -0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Pawe=C5=82=20Staszewski?= <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 2/2] mm/page_alloc: use a single function to free page
Date:   Mon,  5 Nov 2018 16:58:20 +0800
Message-Id: <20181105085820.6341-2-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181105085820.6341-1-aaron.lu@intel.com>
References: <20181105085820.6341-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have multiple places of freeing a page, most of them doing similar
things and a common function can be used to reduce code duplicate.

It also avoids bug fixed in one function and left in another.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 mm/page_alloc.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91a9a6af41a2..2b330296e92a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4425,9 +4425,17 @@ unsigned long get_zeroed_page(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(get_zeroed_page);
 
-void __free_pages(struct page *page, unsigned int order)
+/*
+ * Free a page by reducing its ref count by @nr.
+ * If its refcount reaches 0, then according to its order:
+ * order0: send to PCP;
+ * high order: directly send to Buddy.
+ */
+static inline void free_the_page(struct page *page, unsigned int order, int nr)
 {
-	if (put_page_testzero(page)) {
+	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
+
+	if (page_ref_sub_and_test(page, nr)) {
 		if (order == 0)
 			free_unref_page(page);
 		else
@@ -4435,6 +4443,11 @@ void __free_pages(struct page *page, unsigned int order)
 	}
 }
 
+void __free_pages(struct page *page, unsigned int order)
+{
+	free_the_page(page, order, 1);
+}
+
 EXPORT_SYMBOL(__free_pages);
 
 void free_pages(unsigned long addr, unsigned int order)
@@ -4481,16 +4494,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 
 void __page_frag_cache_drain(struct page *page, unsigned int count)
 {
-	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
-
-	if (page_ref_sub_and_test(page, count)) {
-		unsigned int order = compound_order(page);
-
-		if (order == 0)
-			free_unref_page(page);
-		else
-			__free_pages_ok(page, order);
-	}
+	free_the_page(page, compound_order(page), count);
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
@@ -4555,14 +4559,7 @@ void page_frag_free(void *addr)
 {
 	struct page *page = virt_to_head_page(addr);
 
-	if (unlikely(put_page_testzero(page))) {
-		unsigned int order = compound_order(page);
-
-		if (order == 0)
-			free_unref_page(page);
-		else
-			__free_pages_ok(page, order);
-	}
+	free_the_page(page, compound_order(page), 1);
 }
 EXPORT_SYMBOL(page_frag_free);
 
-- 
2.17.2

