Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id q/NuGnqDHlurFAAAmS7hNA
	; Mon, 11 Jun 2018 14:14:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DA292607BB; Mon, 11 Jun 2018 14:14:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LJNjD8aU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 60EE960791;
	Mon, 11 Jun 2018 14:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60EE960791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933880AbeFKOLd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:11:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933628AbeFKOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YZEZhtidxbERQmqpIgTJPIyTZV3rzcBKGQfijbq6eAo=; b=LJNjD8aUGTWjXHythh3JGMmev
        DadDkFu9xiNsI+UxD/Dsb82sgXExm0x9/32u8bsG8kwv4EwcoWDD842fiRDgilchWtqkHQU/8vjSr
        3OmSUKv0EUDPaWYsOTbizx8iQyTE02XtMS3ZlzT8KhtjEbjeMyhwANJd8YXmv1GfldWlRqBWMuABn
        y2BKT6VL3/YvsLoYABSGRcSlYKCPzgnsZxe9m2SXmgO2kBq9KtmegYM0Ajg49E4j3SH3Zrmu/4Zvs
        eWUms6flEVIJlQbeZZ5VzfYmet+roI8W6iiFGi4kD4NT4peqWhHo5mLGg6mqL2SXafXxpQLkB2jYc
        UAFgq/gfg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTU-00051x-6G; Mon, 11 Jun 2018 14:07:12 +0000
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
Subject: [PATCH v13 64/72] dax: Convert dax_layout_busy_page to XArray
Date: Mon, 11 Jun 2018 07:06:31 -0700
Message-Id: <20180611140639.17215-65-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Instead of using a pagevec, just use the XArray iterators.  Add a
conditional rescheduling point which probably should have been there in
the original.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/dax.c | 57 +++++++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1c9b736147d3..b8ed7bf32ba1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -621,11 +621,10 @@ static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
  */
 struct page *dax_layout_busy_page(struct address_space *mapping)
 {
-	pgoff_t	indices[PAGEVEC_SIZE];
+	XA_STATE(xas, &mapping->i_pages, 0);
+	void *entry;
+	unsigned int scanned = 0;
 	struct page *page = NULL;
-	struct pagevec pvec;
-	pgoff_t	index, end;
-	unsigned i;
 
 	/*
 	 * In the 'limited' case get_user_pages() for dax is disabled.
@@ -636,13 +635,9 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
 		return NULL;
 
-	pagevec_init(&pvec);
-	index = 0;
-	end = -1;
-
 	/*
 	 * If we race get_user_pages_fast() here either we'll see the
-	 * elevated page count in the pagevec_lookup and wait, or
+	 * elevated page count in the iteration and wait, or
 	 * get_user_pages_fast() will see that the page it took a reference
 	 * against is no longer mapped in the page tables and bail to the
 	 * get_user_pages() slow path.  The slow path is protected by
@@ -654,36 +649,26 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	 */
 	unmap_mapping_range(mapping, 0, 0, 1);
 
-	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE),
-				indices)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *pvec_ent = pvec.pages[i];
-			void *entry;
-
-			index = indices[i];
-			if (index >= end)
-				break;
-
-			if (!xa_is_value(pvec_ent))
-				continue;
-
-			xa_lock_irq(&mapping->i_pages);
-			entry = get_unlocked_mapping_entry(mapping, index, NULL);
-			if (entry)
-				page = dax_busy_page(entry);
-			put_unlocked_mapping_entry(mapping, index, entry);
-			xa_unlock_irq(&mapping->i_pages);
-			if (page)
-				break;
-		}
-		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
-		index++;
-
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, ULONG_MAX) {
+		if (!xa_is_value(entry))
+			continue;
+		if (unlikely(dax_is_locked(entry)))
+			entry = get_unlocked_entry(&xas);
+		if (entry)
+			page = dax_busy_page(entry);
+		put_unlocked_entry(&xas, entry);
 		if (page)
 			break;
+		if (++scanned % XA_CHECK_SCHED)
+			continue;
+
+		xas_pause(&xas);
+		xas_unlock_irq(&xas);
+		cond_resched();
+		xas_lock_irq(&xas);
 	}
+	xas_unlock_irq(&xas);
 	return page;
 }
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
-- 
2.17.1
