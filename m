Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D6AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9629F2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQE3FOTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9629F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934313AbeFQCPT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:15:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933724AbeFQCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I3UYxOubL92+FRQCHMpYAsogvmB5EZGLLIeZ/JtzqLA=; b=EQE3FOTEF9wQtH0fGRuJdRy51
        Uppi47EMy2yO6d1DXQSRTcumVl3sFNX19HANo1Cu7IQ0IAWyYJHftsWZnn+HAiIU8aCxQXSbMMuA8
        7XjgOUnwjnyUYpEDOHi617u44LKBvG/ztdbIsKnrWe0r7YC1vruDTnmjlyfXq4fDrLLonktNGKVIf
        YEdiywJWQkhWRAmmRqHIVcUTNw5qT4y1hSJszTPwy9OUzqMqieGmNYuQkT6Z66jkfT8ySLWJEv1GG
        /lLTyO9SmDpLtoHSMVdlKPVxxFZnqpWz0RFIifkzMLJ9hC3H5YtHao+vTnWHoJ8WsXhiHteRjcXik
        UFAmXRh+g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN01-0001JB-4u; Sun, 17 Jun 2018 02:01:01 +0000
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
Subject: [PATCH v14 32/74] page cache: Convert delete_batch to XArray
Date:   Sat, 16 Jun 2018 19:00:10 -0700
Message-Id: <20180617020052.4759-33-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function from page_cache_tree_delete_batch to just
page_cache_delete_batch.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/filemap.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4204d9df003b..025077bc82be 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -272,7 +272,7 @@ void delete_from_page_cache(struct page *page)
 EXPORT_SYMBOL(delete_from_page_cache);
 
 /*
- * page_cache_tree_delete_batch - delete several pages from page cache
+ * page_cache_delete_batch - delete several pages from page cache
  * @mapping: the mapping to which pages belong
  * @pvec: pagevec with pages to delete
  *
@@ -285,23 +285,18 @@ EXPORT_SYMBOL(delete_from_page_cache);
  *
  * The function expects the i_pages lock to be held.
  */
-static void
-page_cache_tree_delete_batch(struct address_space *mapping,
+static void page_cache_delete_batch(struct address_space *mapping,
 			     struct pagevec *pvec)
 {
-	struct radix_tree_iter iter;
-	void **slot;
+	XA_STATE(xas, &mapping->i_pages, pvec->pages[0]->index);
 	int total_pages = 0;
 	int i = 0, tail_pages = 0;
 	struct page *page;
-	pgoff_t start;
 
-	start = pvec->pages[0]->index;
-	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
+	mapping_set_update(&xas, mapping);
+	xas_for_each(&xas, page, ULONG_MAX) {
 		if (i >= pagevec_count(pvec) && !tail_pages)
 			break;
-		page = radix_tree_deref_slot_protected(slot,
-						       &mapping->i_pages.xa_lock);
 		if (xa_is_value(page))
 			continue;
 		if (!tail_pages) {
@@ -310,8 +305,11 @@ page_cache_tree_delete_batch(struct address_space *mapping,
 			 * have our pages locked so they are protected from
 			 * being removed.
 			 */
-			if (page != pvec->pages[i])
+			if (page != pvec->pages[i]) {
+				VM_BUG_ON_PAGE(page->index >
+						pvec->pages[i]->index, page);
 				continue;
+			}
 			WARN_ON_ONCE(!PageLocked(page));
 			if (PageTransHuge(page) && !PageHuge(page))
 				tail_pages = HPAGE_PMD_NR - 1;
@@ -322,11 +320,11 @@ page_cache_tree_delete_batch(struct address_space *mapping,
 			 */
 			i++;
 		} else {
+			VM_BUG_ON_PAGE(page->index + HPAGE_PMD_NR - tail_pages
+					!= pvec->pages[i]->index, page);
 			tail_pages--;
 		}
-		radix_tree_clear_tags(&mapping->i_pages, iter.node, slot);
-		__radix_tree_replace(&mapping->i_pages, iter.node, slot, NULL,
-				workingset_lookup_update(mapping));
+		xas_store(&xas, NULL);
 		total_pages++;
 	}
 	mapping->nrpages -= total_pages;
@@ -347,7 +345,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 
 		unaccount_page_cache_page(mapping, pvec->pages[i]);
 	}
-	page_cache_tree_delete_batch(mapping, pvec);
+	page_cache_delete_batch(mapping, pvec);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
 	for (i = 0; i < pagevec_count(pvec); i++)
-- 
2.17.1

