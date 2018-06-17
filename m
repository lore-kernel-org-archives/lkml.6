Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7793BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3481620895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aAQmFyx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3481620895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934023AbeFQCRu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:17:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933663AbeFQCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=swEIFSIKt2NvfdWOTUWTQV6Qzybb5fYEWm8H1x1L5ac=; b=aAQmFyx0cVjTXqtePBlN/Gge1
        6GAqypN2Sd/9jLth3wwwkxuXRtSKKxfGDSJxHjw7XruOko4f2+J0aQEazFxZbT9st3pkFvQLjdS5O
        Uk8iT+UyZGL2vvJgRvMNeJOih+Olkwe0ZNKGxWm42YfgBEXYLL+Ma3PKpwudp432g9+I4RYJqK+Rh
        ShFqf+Mwx7QTpycJl7TivE24r6HwkGfGeKRQP82noTMR4vc4FBRZ7+njOGBaBtiXX9Myku4R08p+7
        jzlcpj59lkspt2+2QvIHBLvky5rchFeVlmSuULPcfE4kugcNx4j+dd/kEeomdvqXgUTOhmgR/EyOe
        4DdD+SVBA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN00-0001Io-Gy; Sun, 17 Jun 2018 02:01:00 +0000
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
Subject: [PATCH v14 29/74] page cache: Convert find_get_entries_tag to XArray
Date:   Sat, 16 Jun 2018 19:00:07 -0700
Message-Id: <20180617020052.4759-30-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly shorter and simpler code.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/pagemap.h |  2 +-
 mm/filemap.c            | 54 ++++++++++++++++++-----------------------
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a6d635fefb01..442977811b59 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -373,7 +373,7 @@ static inline unsigned find_get_pages_tag(struct address_space *mapping,
 					nr_pages, pages);
 }
 unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
-			int tag, unsigned int nr_entries,
+			xa_tag_t tag, unsigned int nr_entries,
 			struct page **entries, pgoff_t *indices);
 
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
diff --git a/mm/filemap.c b/mm/filemap.c
index 83328635edaa..67f04bcdf9ef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1866,57 +1866,51 @@ EXPORT_SYMBOL(find_get_pages_range_tag);
  * @tag.
  */
 unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
-			int tag, unsigned int nr_entries,
+			xa_tag_t tag, unsigned int nr_entries,
 			struct page **entries, pgoff_t *indices)
 {
-	void **slot;
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct page *page;
 	unsigned int ret = 0;
-	struct radix_tree_iter iter;
 
 	if (!nr_entries)
 		return 0;
 
 	rcu_read_lock();
-	radix_tree_for_each_tagged(slot, &mapping->i_pages, &iter, start, tag) {
-		struct page *head, *page;
-repeat:
-		page = radix_tree_deref_slot(slot);
-		if (unlikely(!page))
+	xas_for_each_tagged(&xas, page, ULONG_MAX, tag) {
+		struct page *head;
+		if (xas_retry(&xas, page))
 			continue;
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				slot = radix_tree_iter_retry(&iter);
-				continue;
-			}
-
-			/*
-			 * A shadow entry of a recently evicted page, a swap
-			 * entry from shmem/tmpfs or a DAX entry.  Return it
-			 * without attempting to raise page count.
-			 */
+		/*
+		 * A shadow entry of a recently evicted page, a swap
+		 * entry from shmem/tmpfs or a DAX entry.  Return it
+		 * without attempting to raise page count.
+		 */
+		if (xa_is_value(page))
 			goto export;
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
+
 export:
-		indices[ret] = iter.index;
+		indices[ret] = xas.xa_index;
 		entries[ret] = page;
 		if (++ret == nr_entries)
 			break;
+		continue;
+put_page:
+		put_page(head);
+retry:
+		xas_reset(&xas);
 	}
 	rcu_read_unlock();
 	return ret;
-- 
2.17.1

