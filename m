Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0CFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3D52086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pZujEGhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3D52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbeFQCBR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:01:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933880AbeFQCBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e0wudOUZYJQwjzypX+j3m1ttkDOvGtdncskdRKp75uA=; b=pZujEGhrlBP43V7+vrMNtARcd
        /lzpkm3Fq+C7N0XfgP4VK3L7Lb6VX3KFlDbjv29p2g0vQ4kC+MRAahvvwdoTd+auz1D1KgvKLNITQ
        EPuvLRbN6WH6FVMD2azUI/dsJ4IJiNbFzAQVU6N1cmL90gH9U6fhmELwBIUv1IBj4EWO4kWa7uWmz
        0kXK2mnRY9d3hcR3J9GqcqNhudr6TagHW2ETrfTH2e2dftnCL48ylVHM+yHNbqYBXF0alZLZvcLL+
        4LWF7zpeK+6AB/FJomuMxpOoM4wsyoOo0NkpSUM5l5VZProabnDao5OkoOhCHnxyyXKouXtYAFGYP
        erodrUtdw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN04-0001La-Oa; Sun, 17 Jun 2018 02:01:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v14 38/74] mm: Convert add_to_swap_cache to XArray
Date:   Sat, 16 Jun 2018 19:00:16 -0700
Message-Id: <20180617020052.4759-39-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine __add_to_swap_cache and add_to_swap_cache into one function
since there is no more need to preload.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/swap_state.c | 93 +++++++++++++++----------------------------------
 1 file changed, 29 insertions(+), 64 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index dc312559f7df..ca18407a79aa 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -107,14 +107,15 @@ void show_swap_cache_info(void)
 }
 
 /*
- * __add_to_swap_cache resembles add_to_page_cache_locked on swapper_space,
+ * add_to_swap_cache resembles add_to_page_cache_locked on swapper_space,
  * but sets SwapCache flag and private instead of mapping and index.
  */
-int __add_to_swap_cache(struct page *page, swp_entry_t entry)
+int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 {
-	int error, i, nr = hpage_nr_pages(page);
-	struct address_space *address_space;
+	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swp_offset(entry);
+	XA_STATE(xas, &address_space->i_pages, idx);
+	unsigned long i, nr = 1UL << compound_order(page);
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
@@ -123,50 +124,30 @@ int __add_to_swap_cache(struct page *page, swp_entry_t entry)
 	page_ref_add(page, nr);
 	SetPageSwapCache(page);
 
-	address_space = swap_address_space(entry);
-	xa_lock_irq(&address_space->i_pages);
-	for (i = 0; i < nr; i++) {
-		set_page_private(page + i, entry.val + i);
-		error = radix_tree_insert(&address_space->i_pages,
-					  idx + i, page + i);
-		if (unlikely(error))
-			break;
-	}
-	if (likely(!error)) {
+	do {
+		xas_lock_irq(&xas);
+		xas_create_range(&xas, idx + nr - 1);
+		if (xas_error(&xas))
+			goto unlock;
+		for (i = 0; i < nr; i++) {
+			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
+			set_page_private(page + i, entry.val + i);
+			xas_store(&xas, page + i);
+			xas_next(&xas);
+		}
 		address_space->nrpages += nr;
 		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
 		ADD_CACHE_INFO(add_total, nr);
-	} else {
-		/*
-		 * Only the context which have set SWAP_HAS_CACHE flag
-		 * would call add_to_swap_cache().
-		 * So add_to_swap_cache() doesn't returns -EEXIST.
-		 */
-		VM_BUG_ON(error == -EEXIST);
-		set_page_private(page + i, 0UL);
-		while (i--) {
-			radix_tree_delete(&address_space->i_pages, idx + i);
-			set_page_private(page + i, 0UL);
-		}
-		ClearPageSwapCache(page);
-		page_ref_sub(page, nr);
-	}
-	xa_unlock_irq(&address_space->i_pages);
+unlock:
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp));
 
-	return error;
-}
-
-
-int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp_mask)
-{
-	int error;
+	if (!xas_error(&xas))
+		return 0;
 
-	error = radix_tree_maybe_preload_order(gfp_mask, compound_order(page));
-	if (!error) {
-		error = __add_to_swap_cache(page, entry);
-		radix_tree_preload_end();
-	}
-	return error;
+	ClearPageSwapCache(page);
+	page_ref_sub(page, nr);
+	return xas_error(&xas);
 }
 
 /*
@@ -217,7 +198,7 @@ int add_to_swap(struct page *page)
 		return 0;
 
 	/*
-	 * Radix-tree node allocations from PF_MEMALLOC contexts could
+	 * XArray node allocations from PF_MEMALLOC contexts could
 	 * completely exhaust the page allocator. __GFP_NOMEMALLOC
 	 * stops emergency reserves from being allocated.
 	 *
@@ -229,7 +210,6 @@ int add_to_swap(struct page *page)
 	 */
 	err = add_to_swap_cache(page, entry,
 			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
-	/* -ENOMEM radix-tree allocation failure */
 	if (err)
 		/*
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
@@ -423,19 +403,11 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				break;		/* Out of memory */
 		}
 
-		/*
-		 * call radix_tree_preload() while we can wait.
-		 */
-		err = radix_tree_maybe_preload(gfp_mask & GFP_KERNEL);
-		if (err)
-			break;
-
 		/*
 		 * Swap entry may have been freed since our caller observed it.
 		 */
 		err = swapcache_prepare(entry);
 		if (err == -EEXIST) {
-			radix_tree_preload_end();
 			/*
 			 * We might race against get_swap_page() and stumble
 			 * across a SWAP_HAS_CACHE swap_map entry whose page
@@ -443,26 +415,19 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			 */
 			cond_resched();
 			continue;
-		}
-		if (err) {		/* swp entry is obsolete ? */
-			radix_tree_preload_end();
+		} else if (err)		/* swp entry is obsolete ? */
 			break;
-		}
 
-		/* May fail (-ENOMEM) if radix-tree node allocation failed. */
+		/* May fail (-ENOMEM) if XArray node allocation failed. */
 		__SetPageLocked(new_page);
 		__SetPageSwapBacked(new_page);
-		err = __add_to_swap_cache(new_page, entry);
+		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
 		if (likely(!err)) {
-			radix_tree_preload_end();
-			/*
-			 * Initiate read into locked page and return.
-			 */
+			/* Initiate read into locked page */
 			lru_cache_add_anon(new_page);
 			*new_page_allocated = true;
 			return new_page;
 		}
-		radix_tree_preload_end();
 		__ClearPageLocked(new_page);
 		/*
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
-- 
2.17.1

