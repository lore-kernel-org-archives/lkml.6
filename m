Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD123C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDA52083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDA52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbeKFU4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:56:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:57053 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbeKFU4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:56:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 03:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="247384839"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2018 03:31:49 -0800
Date:   Tue, 6 Nov 2018 19:31:49 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?UGF3ZcWC?= Staszewski <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH v3 2/2] mm/page_alloc: use a single function to free page
Message-ID: <20181106113149.GC24198@intel.com>
References: <20181105085820.6341-1-aaron.lu@intel.com>
 <20181105085820.6341-2-aaron.lu@intel.com>
 <20181106053037.GD6203@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106053037.GD6203@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have multiple places of freeing a page, most of them doing similar
things and a common function can be used to reduce code duplicate.

It also avoids bug fixed in one function but left in another.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
v3: Vlastimil mentioned the possible performance loss by using
    page_ref_sub_and_test(page, 1) for put_page_testzero(page), since
    we aren't sure so be safe by keeping page ref decreasing code as
    is, only move freeing page part to a common function.

 mm/page_alloc.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91a9a6af41a2..431a03aa96f8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4425,16 +4425,19 @@ unsigned long get_zeroed_page(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(get_zeroed_page);
 
-void __free_pages(struct page *page, unsigned int order)
+static inline void free_the_page(struct page *page, unsigned int order)
 {
-	if (put_page_testzero(page)) {
-		if (order == 0)
-			free_unref_page(page);
-		else
-			__free_pages_ok(page, order);
-	}
+	if (order == 0)
+		free_unref_page(page);
+	else
+		__free_pages_ok(page, order);
 }
 
+void __free_pages(struct page *page, unsigned int order)
+{
+	if (put_page_testzero(page))
+		free_the_page(page, order);
+}
 EXPORT_SYMBOL(__free_pages);
 
 void free_pages(unsigned long addr, unsigned int order)
@@ -4483,14 +4486,8 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 {
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
 
-	if (page_ref_sub_and_test(page, count)) {
-		unsigned int order = compound_order(page);
-
-		if (order == 0)
-			free_unref_page(page);
-		else
-			__free_pages_ok(page, order);
-	}
+	if (page_ref_sub_and_test(page, count))
+		free_the_page(page, compound_order(page));
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
@@ -4555,14 +4552,8 @@ void page_frag_free(void *addr)
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
+	if (unlikely(put_page_testzero(page)))
+		free_the_page(page, compound_order(page));
 }
 EXPORT_SYMBOL(page_frag_free);
 
-- 
2.17.2

