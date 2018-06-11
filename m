Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rJX/I1mFHlsJLAAAmS7hNA
	; Mon, 11 Jun 2018 14:21:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7BE0360791; Mon, 11 Jun 2018 14:21:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+qP97fL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DA307600D0;
	Mon, 11 Jun 2018 14:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA307600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934274AbeFKOUd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:20:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933496AbeFKOGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8pITuBd92w2lO7mrY9ySljX/Vx0Xpt19doJAFI5Uh7I=; b=r+qP97fLcA4hOGqyFa1JFrKje
        Rrhpcky6kdox/NIe1AAqdadXAS5WuNomlVJH2iHlhBenB0nOx0MdOy1NB3YdJY/Hig7XJZlH6Ac2l
        H6CbX5grqFUfVEsudvOfn/VzDyV6NWk3eh9vTYxAPvuRsvRpwjc5Y8aFiGpXHiUjwZ7stYSJZ7DHt
        i/j6L1GZ58FPT/59mI84N0gecY+oQpXVpLVfsJvFUBjme0CI44EfnYXRhayhulMXIJEpdLvDkw3ib
        i20bCJ/H4EJb0jvpvjxknbsEsS3tgZkyFvMBwVve+m+gMPoj8B7+lf3ea0UWCSe3hqFBewMuX7dMn
        GGCtLdCqA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNT8-0004gY-GE; Mon, 11 Jun 2018 14:06:50 +0000
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
Subject: [PATCH v13 26/72] page cache: Convert find_get_pages_contig to XArray
Date: Mon, 11 Jun 2018 07:05:53 -0700
Message-Id: <20180611140639.17215-27-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

There's no direct replacement for radix_tree_for_each_contig()
in the XArray API as it's an unusual thing to do.  Instead,
open-code a loop using xas_next().  This removes the only user of
radix_tree_for_each_contig() so delete the iterator from the API and
the test suite code for it.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 .clang-format                          |  1 -
 include/linux/radix-tree.h             | 17 ---------
 mm/filemap.c                           | 53 +++++++++++---------------
 tools/testing/radix-tree/regression3.c | 23 -----------
 4 files changed, 22 insertions(+), 72 deletions(-)

diff --git a/.clang-format b/.clang-format
index faffc0d5af4e..c1de31c6875e 100644
--- a/.clang-format
+++ b/.clang-format
@@ -323,7 +323,6 @@ ForEachMacros:
   - 'protocol_for_each_card'
   - 'protocol_for_each_dev'
   - 'queue_for_each_hw_ctx'
-  - 'radix_tree_for_each_contig'
   - 'radix_tree_for_each_slot'
   - 'radix_tree_for_each_tagged'
   - 'rbtree_postorder_for_each_entry_safe'
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 4b6f685309fc..eefa0b099dd5 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -522,23 +522,6 @@ static __always_inline void __rcu **radix_tree_next_slot(void __rcu **slot,
 	     slot || (slot = radix_tree_next_chunk(root, iter, 0)) ;	\
 	     slot = radix_tree_next_slot(slot, iter, 0))
 
-/**
- * radix_tree_for_each_contig - iterate over contiguous slots
- *
- * @slot:	the void** variable for pointer to slot
- * @root:	the struct radix_tree_root pointer
- * @iter:	the struct radix_tree_iter pointer
- * @start:	iteration starting index
- *
- * @slot points to radix tree slot, @iter->index contains its index.
- */
-#define radix_tree_for_each_contig(slot, root, iter, start)		\
-	for (slot = radix_tree_iter_init(iter, start) ;			\
-	     slot || (slot = radix_tree_next_chunk(root, iter,		\
-				RADIX_TREE_ITER_CONTIG)) ;		\
-	     slot = radix_tree_next_slot(slot, iter,			\
-				RADIX_TREE_ITER_CONTIG))
-
 /**
  * radix_tree_for_each_tagged - iterate over tagged slots
  *
diff --git a/mm/filemap.c b/mm/filemap.c
index 019c263bb6be..8a69613fcdf3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1721,57 +1721,43 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 			       unsigned int nr_pages, struct page **pages)
 {
-	struct radix_tree_iter iter;
-	void **slot;
+	XA_STATE(xas, &mapping->i_pages, index);
+	struct page *page;
 	unsigned int ret = 0;
 
 	if (unlikely(!nr_pages))
 		return 0;
 
 	rcu_read_lock();
-	radix_tree_for_each_contig(slot, &mapping->i_pages, &iter, index) {
-		struct page *head, *page;
-repeat:
-		page = radix_tree_deref_slot(slot);
-		/* The hole, there no reason to continue */
-		if (unlikely(!page))
-			break;
-
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				slot = radix_tree_iter_retry(&iter);
-				continue;
-			}
-			/*
-			 * A shadow entry of a recently evicted page,
-			 * or a swap entry from shmem/tmpfs.  Stop
-			 * looking for contiguous pages.
-			 */
+	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
+		struct page *head;
+		if (xas_retry(&xas, page))
+			continue;
+		/*
+		 * If the entry has been swapped out, we can stop looking.
+		 * No current caller is looking for DAX entries.
+		 */
+		if (xa_is_value(page))
 			break;
-		}
 
 		head = compound_head(page);
 		if (!page_cache_get_speculative(head))
-			goto repeat;
+			goto retry;
 
 		/* The page was split under us? */
-		if (compound_head(page) != head) {
-			put_page(head);
-			goto repeat;
-		}
+		if (compound_head(page) != head)
+			goto put_page;
 
 		/* Has the page moved? */
-		if (unlikely(page != *slot)) {
-			put_page(head);
-			goto repeat;
-		}
+		if (unlikely(page != xas_reload(&xas)))
+			goto put_page;
 
 		/*
 		 * must check mapping and index after taking the ref.
 		 * otherwise we can get both false positives and false
 		 * negatives, which is just confusing to the caller.
 		 */
-		if (page->mapping == NULL || page_to_pgoff(page) != iter.index) {
+		if (!page->mapping || page_to_pgoff(page) != xas.xa_index) {
 			put_page(page);
 			break;
 		}
@@ -1779,6 +1765,11 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 		pages[ret] = page;
 		if (++ret == nr_pages)
 			break;
+		continue;
+put_page:
+		put_page(head);
+retry:
+		xas_reset(&xas);
 	}
 	rcu_read_unlock();
 	return ret;
diff --git a/tools/testing/radix-tree/regression3.c b/tools/testing/radix-tree/regression3.c
index ace2543c3eda..9f9a3b280f56 100644
--- a/tools/testing/radix-tree/regression3.c
+++ b/tools/testing/radix-tree/regression3.c
@@ -69,21 +69,6 @@ void regression3_test(void)
 			continue;
 		}
 	}
-	radix_tree_delete(&root, 1);
-
-	first = true;
-	radix_tree_for_each_contig(slot, &root, &iter, 0) {
-		printv(2, "contig %ld %p\n", iter.index, *slot);
-		if (first) {
-			radix_tree_insert(&root, 1, ptr);
-			first = false;
-		}
-		if (radix_tree_deref_retry(*slot)) {
-			printv(2, "retry at %ld\n", iter.index);
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-	}
 
 	radix_tree_for_each_slot(slot, &root, &iter, 0) {
 		printv(2, "slot %ld %p\n", iter.index, *slot);
@@ -93,14 +78,6 @@ void regression3_test(void)
 		}
 	}
 
-	radix_tree_for_each_contig(slot, &root, &iter, 0) {
-		printv(2, "contig %ld %p\n", iter.index, *slot);
-		if (!iter.index) {
-			printv(2, "next at %ld\n", iter.index);
-			slot = radix_tree_iter_resume(slot, &iter);
-		}
-	}
-
 	radix_tree_tag_set(&root, 0, 0);
 	radix_tree_tag_set(&root, 1, 0);
 	radix_tree_for_each_tagged(slot, &root, &iter, 0, 0) {
-- 
2.17.1
