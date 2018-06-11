Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BplqHzqFHlvyKwAAmS7hNA
	; Mon, 11 Jun 2018 14:21:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AECCB607A4; Mon, 11 Jun 2018 14:21:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iEUzAMRf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 390C860351;
	Mon, 11 Jun 2018 14:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 390C860351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934268AbeFKOUb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:20:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933495AbeFKOGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+c+l1NkAi3vmmhzDtUhhMVC9W/oaDCjLLlNg0JM0yu4=; b=iEUzAMRfHgRfvebMaKJqDTGkZ
        AaNbUk3keL7ve5wapSApkl5+mV3v6qoydpMdkJaTheMjI6vELUAdZU7QV/Gsku9Qj5HJqsJuUGUju
        hEOklifUvPIFNxfAV/+BLxaH43R3gguKxR9TGAFhAR3ApsMtoy2g/OJAY81zBLZ7D//mUKx+TJ1nH
        XIOr0bJJG3hKcwutCd9wuDfNpSxB7JPfVuK3fr10xw2Vqzqek7elH9kPmdy1syE0EN9dpT5i0UWZp
        B1EutnH3BwxjpC7Eonj/XQwGsrIyMe+ma6OfxKOHwuY5UHwjd/+0MQAltp2LJz13nU0lI5DfIer38
        dSj+2S0jg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNT7-0004gI-Ul; Mon, 11 Jun 2018 14:06:49 +0000
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
Subject: [PATCH v13 25/72] page cache: Convert find_get_pages_range to XArray
Date: Mon, 11 Jun 2018 07:05:52 -0700
Message-Id: <20180611140639.17215-26-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

The 'end' parameter of the xas_for_each iterator avoids a useless
iteration at the end of the range.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/filemap.c | 52 +++++++++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b49290131e85..019c263bb6be 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1650,64 +1650,50 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			      pgoff_t end, unsigned int nr_pages,
 			      struct page **pages)
 {
-	struct radix_tree_iter iter;
-	void **slot;
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct page *page;
 	unsigned ret = 0;
 
 	if (unlikely(!nr_pages))
 		return 0;
 
 	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, *start) {
-		struct page *head, *page;
-
-		if (iter.index > end)
-			break;
-repeat:
-		page = radix_tree_deref_slot(slot);
-		if (unlikely(!page))
+	xas_for_each(&xas, page, end) {
+		struct page *head;
+		if (xas_retry(&xas, page))
 			continue;
-
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				slot = radix_tree_iter_retry(&iter);
-				continue;
-			}
-			/*
-			 * A shadow entry of a recently evicted page,
-			 * or a swap entry from shmem/tmpfs.  Skip
-			 * over it.
-			 */
+		/* Skip over shadow, swap and DAX entries */
+		if (xa_is_value(page))
 			continue;
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
 
 		pages[ret] = page;
 		if (++ret == nr_pages) {
-			*start = pages[ret - 1]->index + 1;
+			*start = page->index + 1;
 			goto out;
 		}
+		continue;
+put_page:
+		put_page(head);
+retry:
+		xas_reset(&xas);
 	}
 
 	/*
 	 * We come here when there is no page beyond @end. We take care to not
 	 * overflow the index @start as it confuses some of the callers. This
-	 * breaks the iteration when there is page at index -1 but that is
+	 * breaks the iteration when there is a page at index -1 but that is
 	 * already broken anyway.
 	 */
 	if (end == (pgoff_t)-1)
-- 
2.17.1
