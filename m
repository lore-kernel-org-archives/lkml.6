Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D864C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560FC20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560FC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeKFOyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:54:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:2531 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbeKFOyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:54:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 21:30:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,470,1534834800"; 
   d="scan'208";a="88880351"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2018 21:30:36 -0800
Date:   Tue, 6 Nov 2018 13:30:37 +0800
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
Subject: [PATCH v2 2/2] mm/page_alloc: use a single function to free page
Message-ID: <20181106053037.GD6203@intel.com>
References: <20181105085820.6341-1-aaron.lu@intel.com>
 <20181105085820.6341-2-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105085820.6341-2-aaron.lu@intel.com>
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
v2: move comments close to code as suggested by Dave.

 mm/page_alloc.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91a9a6af41a2..4faf6b7bf225 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4425,9 +4425,17 @@ unsigned long get_zeroed_page(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(get_zeroed_page);
 
-void __free_pages(struct page *page, unsigned int order)
+static inline void free_the_page(struct page *page, unsigned int order, int nr)
 {
-	if (put_page_testzero(page)) {
+	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
+
+	/*
+	 * Free a page by reducing its ref count by @nr.
+	 * If its refcount reaches 0, then according to its order:
+	 * order0: send to PCP;
+	 * high order: directly send to Buddy.
+	 */
+	if (page_ref_sub_and_test(page, nr)) {
 		if (order == 0)
 			free_unref_page(page);
 		else
@@ -4435,6 +4443,10 @@ void __free_pages(struct page *page, unsigned int order)
 	}
 }
 
+void __free_pages(struct page *page, unsigned int order)
+{
+	free_the_page(page, order, 1);
+}
 EXPORT_SYMBOL(__free_pages);
 
 void free_pages(unsigned long addr, unsigned int order)
@@ -4481,16 +4493,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 
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
 
@@ -4555,14 +4558,7 @@ void page_frag_free(void *addr)
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

