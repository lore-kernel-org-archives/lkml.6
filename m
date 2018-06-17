Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAE520895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OrrRtMm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAE520895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934611AbeFQCSa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:18:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933530AbeFQCBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IhOnC9qrQIRQCbXcJfzozkcu7sXEUwfUNWOWmL6r87o=; b=OrrRtMm3fhw+EDcD+NaUdg5DV
        eAUVbpQHxEEqG+pVwEQLXzz6FZQv8Aiz/6/Qvcb33AGqW8NaQZIXQ3VwklGkXWxmHy8ES9GmUhKl4
        NtYR9RFGGX/A2eB6XXnN5OW7MKaoZ92ACW2/BYAn5fuqMdAcJT2KXkMvHokicvzdPT8kFY94cbC5i
        llSY+pAuTlceOVQGaWWLTnmFYiUBmPR+ddJQeERZ/5AUIuxZQFUhAJfRI6+Y8BAE+INKZ+L/V0LKH
        8JO7aKYd9MAeeVpvbL4ZkF0oXx94GA0DweD4WWW1pUrn7RdBil+4WtfCqkXZaCIfu4hHQTMznUWqM
        c8yrOeoXQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUMzz-0001IG-NB; Sun, 17 Jun 2018 02:00:59 +0000
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
Subject: [PATCH v14 25/74] page cache: Convert find_get_entries to XArray
Date:   Sat, 16 Jun 2018 19:00:03 -0700
Message-Id: <20180617020052.4759-26-willy@infradead.org>
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
 mm/filemap.c | 51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6db3d35ff5f6..b49290131e85 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1578,53 +1578,48 @@ unsigned find_get_entries(struct address_space *mapping,
 			  pgoff_t start, unsigned int nr_entries,
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
-	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
-		struct page *head, *page;
-repeat:
-		page = radix_tree_deref_slot(slot);
-		if (unlikely(!page))
+	xas_for_each(&xas, page, ULONG_MAX) {
+		struct page *head;
+		if (xas_retry(&xas, page))
 			continue;
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				slot = radix_tree_iter_retry(&iter);
-				continue;
-			}
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

