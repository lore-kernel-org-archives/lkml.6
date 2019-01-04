Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863ECC43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6075421872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfADMv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:51:57 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:40264 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfADMv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:51:56 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 0094698837
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:51:54 +0000 (UTC)
Received: (qmail 1701 invoked from network); 4 Jan 2019 12:51:53 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 4 Jan 2019 12:51:53 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 09/25] mm, compaction: Use the page allocator bulk-free helper for lists of pages
Date:   Fri,  4 Jan 2019 12:49:55 +0000
Message-Id: <20190104125011.16071-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

release_pages() is a simpler version of free_unref_page_list() but it
tracks the highest PFN for caching the restart point of the compaction
free scanner. This patch optionally tracks the highest PFN in the core
helper and converts compaction to use it. The performance impact is
limited but it should reduce lock contention slightly in some cases.
The main benefit is removing some partially duplicated code.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/gfp.h |  7 ++++++-
 mm/compaction.c     | 12 +++---------
 mm/page_alloc.c     | 10 +++++++++-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5f5e25fd6149..9e58799b730f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -543,7 +543,12 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 extern void free_unref_page(struct page *page);
-extern void free_unref_page_list(struct list_head *list);
+extern void __free_page_list(struct list_head *list, bool dropref, unsigned long *highest_pfn);
+
+static inline void free_unref_page_list(struct list_head *list)
+{
+	return __free_page_list(list, false, NULL);
+}
 
 struct page_frag_cache;
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
diff --git a/mm/compaction.c b/mm/compaction.c
index 8bf2090231a3..8f0ce44dba41 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -52,16 +52,10 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
 
 static unsigned long release_freepages(struct list_head *freelist)
 {
-	struct page *page, *next;
-	unsigned long high_pfn = 0;
+	unsigned long high_pfn;
 
-	list_for_each_entry_safe(page, next, freelist, lru) {
-		unsigned long pfn = page_to_pfn(page);
-		list_del(&page->lru);
-		__free_page(page);
-		if (pfn > high_pfn)
-			high_pfn = pfn;
-	}
+	__free_page_list(freelist, true, &high_pfn);
+	INIT_LIST_HEAD(freelist);
 
 	return high_pfn;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cde5dac6229a..57ba9d1da519 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2876,18 +2876,26 @@ void free_unref_page(struct page *page)
 /*
  * Free a list of 0-order pages
  */
-void free_unref_page_list(struct list_head *list)
+void __free_page_list(struct list_head *list, bool dropref,
+				unsigned long *highest_pfn)
 {
 	struct page *page, *next;
 	unsigned long flags, pfn;
 	int batch_count = 0;
 
+	if (highest_pfn)
+		*highest_pfn = 0;
+
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
+		if (dropref)
+			WARN_ON_ONCE(!put_page_testzero(page));
 		pfn = page_to_pfn(page);
 		if (!free_unref_page_prepare(page, pfn))
 			list_del(&page->lru);
 		set_page_private(page, pfn);
+		if (highest_pfn && pfn > *highest_pfn)
+			*highest_pfn = pfn;
 	}
 
 	local_irq_save(flags);
-- 
2.16.4

