Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE3121905
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ciruHumi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfBLSe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:34:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBLSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xphOz71CSP7JJWioqIigJHYoCO6ko8c/CWaiEwIWqns=; b=ciruHumimmlvGR28oM1geFKwt
        MENmPAs9E5HoE/i7BxYQafjjBEF0I3M/gB4kl7GV4Ww5nhShUm8As5+3QkZwB2fQkI43WSVls8cX7
        i5VR+m8NKrXuHbJilw6ZtS6zFwZpQSssZy9V1lch2kd1XlBnEaqGLtSDdDkzO5U/2LsIQemtAot7p
        h/oUrMXjL+LRk0DxUr0AKZPJSVOiGT6MOPDTtlvegm/hm+ng8EfLZYq7F3gHjr0G36gLfHekwiMye
        nOl24+uYfpNdsOwLyti41BAc8OwCR3THqGKe/TX0Ke/1rtHoqG0xUIFTZLfmgv1BX9J/MR2cDQzKg
        YuyxF7WJg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtctU-0006o0-92; Tue, 12 Feb 2019 18:34:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A . Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v2] page cache: Store only head pages in i_pages
Date:   Tue, 12 Feb 2019 10:34:54 -0800
Message-Id: <20190212183454.26062-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transparent Huge Pages are currently stored in i_pages as pointers to
consecutive subpages.  This patch changes that to storing consecutive
pointers to the head page in preparation for storing huge pages more
efficiently in i_pages.

Large parts of this are "inspired" by Kirill's patch
https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
v2: Rebase on top of linux-next 20190212
    Fixed a missing s/head/page/ in filemap_map_pages
    Include missing calls to xas_store() in __split_huge_page

 include/linux/pagemap.h |  9 ++++
 mm/filemap.c            | 99 +++++++++++++----------------------------
 mm/huge_memory.c        |  3 ++
 mm/khugepaged.c         |  4 +-
 mm/shmem.c              |  2 +-
 mm/swap_state.c         |  2 +-
 6 files changed, 46 insertions(+), 73 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcf909d0de5f..7d58e4e0b68e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -333,6 +333,15 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+static inline struct page *find_subpage(struct page *page, pgoff_t offset)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	VM_BUG_ON_PAGE(page->index > offset, page);
+	VM_BUG_ON_PAGE(page->index + (1 << compound_order(page)) <= offset,
+			page);
+	return page - page->index + offset;
+}
+
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
diff --git a/mm/filemap.c b/mm/filemap.c
index 5673672fd444..ee28028c4323 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1491,7 +1491,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
-	struct page *head, *page;
+	struct page *page;
 
 	rcu_read_lock();
 repeat:
@@ -1506,25 +1506,19 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 	if (!page || xa_is_value(page))
 		goto out;
 
-	head = compound_head(page);
-	if (!page_cache_get_speculative(head))
-		goto repeat;
-
-	/* The page was split under us? */
-	if (compound_head(page) != head) {
-		put_page(head);
+	if (!page_cache_get_speculative(page))
 		goto repeat;
-	}
 
 	/*
-	 * Has the page moved?
+	 * Has the page moved or been split?
 	 * This is part of the lockless pagecache protocol. See
 	 * include/linux/pagemap.h for details.
 	 */
 	if (unlikely(page != xas_reload(&xas))) {
-		put_page(head);
+		put_page(page);
 		goto repeat;
 	}
+	page = find_subpage(page, offset);
 out:
 	rcu_read_unlock();
 
@@ -1706,7 +1700,6 @@ unsigned find_get_entries(struct address_space *mapping,
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, ULONG_MAX) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/*
@@ -1717,17 +1710,13 @@ unsigned find_get_entries(struct address_space *mapping,
 		if (xa_is_value(page))
 			goto export;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
+		page = find_subpage(page, xas.xa_index);
 
 export:
 		indices[ret] = xas.xa_index;
@@ -1736,7 +1725,7 @@ unsigned find_get_entries(struct address_space *mapping,
 			break;
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -1778,33 +1767,27 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/* Skip over shadow, swap and DAX entries */
 		if (xa_is_value(page))
 			continue;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = page;
+		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages) {
 			*start = page->index + 1;
 			goto out;
 		}
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -1849,7 +1832,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 
 	rcu_read_lock();
 	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/*
@@ -1859,24 +1841,19 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 		if (xa_is_value(page))
 			break;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = page;
+		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages)
 			break;
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -1912,7 +1889,6 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 
 	rcu_read_lock();
 	xas_for_each_marked(&xas, page, end, tag) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/*
@@ -1923,26 +1899,21 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		if (xa_is_value(page))
 			continue;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = page;
+		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages) {
 			*index = page->index + 1;
 			goto out;
 		}
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -1991,7 +1962,6 @@ unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
 
 	rcu_read_lock();
 	xas_for_each_marked(&xas, page, ULONG_MAX, tag) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/*
@@ -2002,17 +1972,13 @@ unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
 		if (xa_is_value(page))
 			goto export;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
+		page = find_subpage(page, xas.xa_index);
 
 export:
 		indices[ret] = xas.xa_index;
@@ -2021,7 +1987,7 @@ unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
 			break;
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -2686,7 +2652,7 @@ void filemap_map_pages(struct vm_fault *vmf,
 	pgoff_t last_pgoff = start_pgoff;
 	unsigned long max_idx;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
-	struct page *head, *page;
+	struct page *page;
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_pgoff) {
@@ -2695,24 +2661,19 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (xa_is_value(page))
 			goto next;
 
-		head = compound_head(page);
-
 		/*
 		 * Check for a locked page first, as a speculative
 		 * reference may adversely influence page migration.
 		 */
-		if (PageLocked(head))
+		if (PageLocked(page))
 			goto next;
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto next;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto skip;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto skip;
+		page = find_subpage(page, xas.xa_index);
 
 		if (!PageUptodate(page) ||
 				PageReadahead(page) ||
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d4847026d4b1..7008174c033b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2458,6 +2458,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
 				shmem_uncharge(head->mapping->host, 1);
 			put_page(head + i);
+		} else if (!PageAnon(page)) {
+			__xa_store(&head->mapping->i_pages, head[i].index,
+					head + i, 0);
 		}
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 449044378782..7ba7a1e4fa79 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1374,7 +1374,7 @@ static void collapse_shmem(struct mm_struct *mm,
 				result = SCAN_FAIL;
 				goto xa_locked;
 			}
-			xas_store(&xas, new_page + (index % HPAGE_PMD_NR));
+			xas_store(&xas, new_page);
 			nr_none++;
 			continue;
 		}
@@ -1450,7 +1450,7 @@ static void collapse_shmem(struct mm_struct *mm,
 		list_add_tail(&page->lru, &pagelist);
 
 		/* Finally, replace with the new page. */
-		xas_store(&xas, new_page + (index % HPAGE_PMD_NR));
+		xas_store(&xas, new_page);
 		continue;
 out_unlock:
 		unlock_page(page);
diff --git a/mm/shmem.c b/mm/shmem.c
index c8cdaa012f18..a78d4f05a51f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -614,7 +614,7 @@ static int shmem_add_to_page_cache(struct page *page,
 		if (xas_error(&xas))
 			goto unlock;
 next:
-		xas_store(&xas, page + i);
+		xas_store(&xas, page);
 		if (++i < nr) {
 			xas_next(&xas);
 			goto next;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 85245fdec8d9..c5da342b5dba 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -132,7 +132,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
 			set_page_private(page + i, entry.val + i);
-			xas_store(&xas, page + i);
+			xas_store(&xas, page);
 			xas_next(&xas);
 		}
 		address_space->nrpages += nr;
-- 
2.20.1

