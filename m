Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UlPYMtOFHlvALwAAmS7hNA
	; Mon, 11 Jun 2018 14:23:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C52F0607BB; Mon, 11 Jun 2018 14:23:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QsSqvfde"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4F72C6074D;
	Mon, 11 Jun 2018 14:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F72C6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934229AbeFKOW3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:22:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933501AbeFKOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vztI3PFiV1oRpjbw6Dx7xbzxLIG1vQILFc4ZeoFT7jQ=; b=QsSqvfde7ULwth2/m6sPiXpMt
        IHoKK9JldhZgUv1uX6GqtD/jcVdTFowlPB8z+YoYA/1sR7qNihZCVGzTxrMdjK5t1uXF5dgp0uNfz
        QFte+gkPYdclv+rHvRU70CeK8okGF9zQUn4F6AlTWEcPHfTFX7PZtc8K56PlBSl4pws142u6owaf9
        CHBfIthvND2uMWcRTFy+2B7tiA9f2JeKbbxpdzw8/oleG/HNzlVSucd/p2OAqagyUmYGGtH9CYuoK
        7T+fs7kPfZ6ArfvErXR6DfuKH2BwKUzTyN64LEuinRfIhA5sbx56fwj6KpiT47efgeKRxLm0eMUhA
        meG6MLCvA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTB-0004ic-6u; Mon, 11 Jun 2018 14:06:53 +0000
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
Subject: [PATCH v13 31/72] page cache: Convert delete_batch to XArray
Date: Mon, 11 Jun 2018 07:05:58 -0700
Message-Id: <20180611140639.17215-32-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Rename the function from page_cache_tree_delete_batch to just
page_cache_delete_batch.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
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
