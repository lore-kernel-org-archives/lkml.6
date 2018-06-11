Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JSlHFB6EHltpGQAAmS7hNA
	; Mon, 11 Jun 2018 14:16:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 41310607BB; Mon, 11 Jun 2018 14:16:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rLVUaD3g"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 652626074D;
	Mon, 11 Jun 2018 14:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 652626074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934049AbeFKOQh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:16:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933553AbeFKOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ddVaTDTpb2MJfBwmifdy20R28SVzwNbBW7X4KiPMA1c=; b=rLVUaD3gMxIwqJl05rtcZNqif
        2uhS45H5TOSg04UkJ9Zgqk478NCbAxSnizyKN7129Yvvan+90C6N3S7t6McQdTaI8Rhn4bVxrqhvT
        KrWh/ZLWC5MfERERfFYcnqeHO5jqVs1moJ2aZcHbKwSm23Pqmi4ErV99eeanXeYQJ0VzdS/L7RzBB
        hR5mcLH+cSeMQPiK2RN+Su0NE0wsawVMppcFhPG/Llv+KYyWGv5d7a6VB1XvpO9iXQaY/IKXm+CLC
        lWT8v2TEOkLJH1OvFpcNSxcnwRzsaN7IJFGsdQWMDC7dyaXJvRD7uEwsO6UjPoTHDWfSJnbXH0REj
        mpFllJ9Kw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTG-0004oI-II; Mon, 11 Jun 2018 14:06:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>,
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
Subject: [PATCH v13 42/72] mm: Convert collapse_shmem to XArray
Date: Mon, 11 Jun 2018 07:06:09 -0700
Message-Id: <20180611140639.17215-43-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

I found another victim of the radix tree being hard to use.  Because
there was no call to radix_tree_preload(), khugepaged was allocating
radix_tree_nodes using GFP_ATOMIC.

I also converted a local_irq_save()/restore() pair to
disable()/enable().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/khugepaged.c | 158 ++++++++++++++++++++----------------------------
 1 file changed, 65 insertions(+), 93 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d6992ba1f604..43598cc5998b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1287,17 +1287,17 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
  *
  * Basic scheme is simple, details are more complex:
  *  - allocate and freeze a new huge page;
- *  - scan over radix tree replacing old pages the new one
+ *  - scan page cache replacing old pages with the new one
  *    + swap in pages if necessary;
  *    + fill in gaps;
- *    + keep old pages around in case if rollback is required;
- *  - if replacing succeed:
+ *    + keep old pages around in case rollback is required;
+ *  - if replacing succeeds:
  *    + copy data over;
  *    + free old pages;
  *    + unfreeze huge page;
  *  - if replacing failed;
  *    + put all pages back and unfreeze them;
- *    + restore gaps in the radix-tree;
+ *    + restore gaps in the page cache;
  *    + free huge page;
  */
 static void collapse_shmem(struct mm_struct *mm,
@@ -1305,12 +1305,11 @@ static void collapse_shmem(struct mm_struct *mm,
 		struct page **hpage, int node)
 {
 	gfp_t gfp;
-	struct page *page, *new_page, *tmp;
+	struct page *new_page;
 	struct mem_cgroup *memcg;
 	pgoff_t index, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
-	struct radix_tree_iter iter;
-	void **slot;
+	XA_STATE(xas, &mapping->i_pages, start);
 	int nr_none = 0, result = SCAN_SUCCEED;
 
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
@@ -1335,48 +1334,48 @@ static void collapse_shmem(struct mm_struct *mm,
 	__SetPageLocked(new_page);
 	BUG_ON(!page_ref_freeze(new_page, 1));
 
-
 	/*
-	 * At this point the new_page is 'frozen' (page_count() is zero), locked
-	 * and not up-to-date. It's safe to insert it into radix tree, because
-	 * nobody would be able to map it or use it in other way until we
-	 * unfreeze it.
+	 * At this point the new_page is 'frozen' (page_count() is zero),
+	 * locked and not up-to-date. It's safe to insert it into the page
+	 * cache, because nobody would be able to map it or use it in other
+	 * way until we unfreeze it.
 	 */
 
-	index = start;
-	xa_lock_irq(&mapping->i_pages);
-	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
-		int n = min(iter.index, end) - index;
-
-		/*
-		 * Handle holes in the radix tree: charge it from shmem and
-		 * insert relevant subpage of new_page into the radix-tree.
-		 */
-		if (n && !shmem_charge(mapping->host, n)) {
-			result = SCAN_FAIL;
+	/* This will be less messy when we use multi-index entries */
+	do {
+		xas_lock_irq(&xas);
+		xas_create_range(&xas, end - 1);
+		if (!xas_error(&xas))
 			break;
-		}
-		nr_none += n;
-		for (; index < min(iter.index, end); index++) {
-			radix_tree_insert(&mapping->i_pages, index,
-					new_page + (index % HPAGE_PMD_NR));
-		}
+		xas_unlock_irq(&xas);
+		if (!xas_nomem(&xas, GFP_KERNEL))
+			goto out;
+	} while (1);
 
-		/* We are done. */
-		if (index >= end)
-			break;
+	for (index = start; index < end; index++) {
+		struct page *page = xas_next(&xas);
+
+		VM_BUG_ON(index != xas.xa_index);
+		if (!page) {
+			if (!shmem_charge(mapping->host, 1)) {
+				result = SCAN_FAIL;
+				break;
+			}
+			xas_store(&xas, new_page + (index % HPAGE_PMD_NR));
+			nr_none++;
+			continue;
+		}
 
-		page = radix_tree_deref_slot_protected(slot,
-				&mapping->i_pages.xa_lock);
 		if (xa_is_value(page) || !PageUptodate(page)) {
-			xa_unlock_irq(&mapping->i_pages);
+			xas_unlock_irq(&xas);
 			/* swap in or instantiate fallocated page */
 			if (shmem_getpage(mapping->host, index, &page,
 						SGP_NOHUGE)) {
 				result = SCAN_FAIL;
-				goto tree_unlocked;
+				goto xa_unlocked;
 			}
-			xa_lock_irq(&mapping->i_pages);
+			xas_lock_irq(&xas);
+			xas_set(&xas, index);
 		} else if (trylock_page(page)) {
 			get_page(page);
 		} else {
@@ -1396,7 +1395,7 @@ static void collapse_shmem(struct mm_struct *mm,
 			result = SCAN_TRUNCATED;
 			goto out_unlock;
 		}
-		xa_unlock_irq(&mapping->i_pages);
+		xas_unlock_irq(&xas);
 
 		if (isolate_lru_page(page)) {
 			result = SCAN_DEL_PAGE_LRU;
@@ -1406,17 +1405,16 @@ static void collapse_shmem(struct mm_struct *mm,
 		if (page_mapped(page))
 			unmap_mapping_pages(mapping, index, 1, false);
 
-		xa_lock_irq(&mapping->i_pages);
+		xas_lock(&xas);
+		xas_set(&xas, index);
 
-		slot = radix_tree_lookup_slot(&mapping->i_pages, index);
-		VM_BUG_ON_PAGE(page != radix_tree_deref_slot_protected(slot,
-					&mapping->i_pages.xa_lock), page);
+		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
 		VM_BUG_ON_PAGE(page_mapped(page), page);
 
 		/*
 		 * The page is expected to have page_count() == 3:
 		 *  - we hold a pin on it;
-		 *  - one reference from radix tree;
+		 *  - one reference from page cache;
 		 *  - one from isolate_lru_page;
 		 */
 		if (!page_ref_freeze(page, 3)) {
@@ -1431,56 +1429,30 @@ static void collapse_shmem(struct mm_struct *mm,
 		list_add_tail(&page->lru, &pagelist);
 
 		/* Finally, replace with the new page. */
-		radix_tree_replace_slot(&mapping->i_pages, slot,
-				new_page + (index % HPAGE_PMD_NR));
-
-		slot = radix_tree_iter_resume(slot, &iter);
-		index++;
+		xas_store(&xas, new_page + (index % HPAGE_PMD_NR));
 		continue;
 out_lru:
-		xa_unlock_irq(&mapping->i_pages);
+		xas_unlock_irq(&xas);
 		putback_lru_page(page);
 out_isolate_failed:
 		unlock_page(page);
 		put_page(page);
-		goto tree_unlocked;
+		goto xa_unlocked;
 out_unlock:
 		unlock_page(page);
 		put_page(page);
 		break;
 	}
+	xas_unlock_irq(&xas);
 
-	/*
-	 * Handle hole in radix tree at the end of the range.
-	 * This code only triggers if there's nothing in radix tree
-	 * beyond 'end'.
-	 */
-	if (result == SCAN_SUCCEED && index < end) {
-		int n = end - index;
-
-		if (!shmem_charge(mapping->host, n)) {
-			result = SCAN_FAIL;
-			goto tree_locked;
-		}
-
-		for (; index < end; index++) {
-			radix_tree_insert(&mapping->i_pages, index,
-					new_page + (index % HPAGE_PMD_NR));
-		}
-		nr_none += n;
-	}
-
-tree_locked:
-	xa_unlock_irq(&mapping->i_pages);
-tree_unlocked:
-
+xa_unlocked:
 	if (result == SCAN_SUCCEED) {
-		unsigned long flags;
+		struct page *page, *tmp;
 		struct zone *zone = page_zone(new_page);
 
 		/*
-		 * Replacing old pages with new one has succeed, now we need to
-		 * copy the content and free old pages.
+		 * Replacing old pages with new one has succeeded, now we
+		 * need to copy the content and free the old pages.
 		 */
 		list_for_each_entry_safe(page, tmp, &pagelist, lru) {
 			copy_highpage(new_page + (page->index % HPAGE_PMD_NR),
@@ -1494,16 +1466,16 @@ static void collapse_shmem(struct mm_struct *mm,
 			put_page(page);
 		}
 
-		local_irq_save(flags);
+		local_irq_disable();
 		__inc_node_page_state(new_page, NR_SHMEM_THPS);
 		if (nr_none) {
 			__mod_node_page_state(zone->zone_pgdat, NR_FILE_PAGES, nr_none);
 			__mod_node_page_state(zone->zone_pgdat, NR_SHMEM, nr_none);
 		}
-		local_irq_restore(flags);
+		local_irq_enable();
 
 		/*
-		 * Remove pte page tables, so we can re-faulti
+		 * Remove pte page tables, so we can re-fault
 		 * the page as huge.
 		 */
 		retract_page_tables(mapping, start);
@@ -1518,37 +1490,37 @@ static void collapse_shmem(struct mm_struct *mm,
 
 		*hpage = NULL;
 	} else {
-		/* Something went wrong: rollback changes to the radix-tree */
+		struct page *page;
+		/* Something went wrong: roll back page cache changes */
 		shmem_uncharge(mapping->host, nr_none);
-		xa_lock_irq(&mapping->i_pages);
-		radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
-			if (iter.index >= end)
-				break;
+		xas_lock_irq(&xas);
+		xas_set(&xas, start);
+		xas_for_each(&xas, page, end - 1) {
 			page = list_first_entry_or_null(&pagelist,
 					struct page, lru);
-			if (!page || iter.index < page->index) {
+			if (!page || xas.xa_index < page->index) {
 				if (!nr_none)
 					break;
 				nr_none--;
 				/* Put holes back where they were */
-				radix_tree_delete(&mapping->i_pages, iter.index);
+				xas_store(&xas, NULL);
 				continue;
 			}
 
-			VM_BUG_ON_PAGE(page->index != iter.index, page);
+			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
 
 			/* Unfreeze the page. */
 			list_del(&page->lru);
 			page_ref_unfreeze(page, 2);
-			radix_tree_replace_slot(&mapping->i_pages, slot, page);
-			slot = radix_tree_iter_resume(slot, &iter);
-			xa_unlock_irq(&mapping->i_pages);
+			xas_store(&xas, page);
+			xas_pause(&xas);
+			xas_unlock_irq(&xas);
 			putback_lru_page(page);
 			unlock_page(page);
-			xa_lock_irq(&mapping->i_pages);
+			xas_lock_irq(&xas);
 		}
 		VM_BUG_ON(nr_none);
-		xa_unlock_irq(&mapping->i_pages);
+		xas_unlock_irq(&xas);
 
 		/* Unfreeze new_page, caller would take care about freeing it */
 		page_ref_unfreeze(new_page, 1);
-- 
2.17.1
