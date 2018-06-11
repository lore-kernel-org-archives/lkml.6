Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id z5wdEJqCHls/DAAAmS7hNA
	; Mon, 11 Jun 2018 14:09:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E6BD1607E7; Mon, 11 Jun 2018 14:09:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OW50G6uv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4056560791;
	Mon, 11 Jun 2018 14:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4056560791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933877AbeFKOJu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:09:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933634AbeFKOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9kvEcFed1e0NqjRoLrLQEEJ3vX9NUobzEC8Ag4KiSOc=; b=OW50G6uvHRsxuqJTjyI8nNYin
        UHqOFwcsToQPa2GiU1bI6lXroVAtNuttUkYwp7wZca32mHiFfToDFujy4T0847Eca36va9QBKmyWo
        nXSV82qoydhw5KkMtmS+5io/qfI7sP2HtcP5Q4cVp7vL5OoQQYEevMDrxfJr8khf+BzynuIDnLYkT
        B6dU4WdZypnIRw6NaTBJsQN+Jbil0GcljNuYqgQ7CnwC6IfN47MLlsVStTzG5uhVbTnrP30MQVNf9
        1iizoexkH/WPHpUinEmE44f20HUMsV+lehv7JdEhUKGp6KUSp//Xg2evu0iODUy/OF53U33YKOCba
        eJ1e5aGQw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTV-00053T-96; Mon, 11 Jun 2018 14:07:13 +0000
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
Subject: [PATCH v13 66/72] dax: Convert dax writeback to XArray
Date: Mon, 11 Jun 2018 07:06:33 -0700
Message-Id: <20180611140639.17215-67-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Use XArray iteration instead of a pagevec.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/dax.c | 129 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 61 insertions(+), 68 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 0566a150c458..f35913b8c5bb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -897,11 +897,9 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 	i_mmap_unlock_read(mapping);
 }
 
-static int dax_writeback_one(struct dax_device *dax_dev,
-		struct address_space *mapping, pgoff_t index, void *entry)
+static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
+		struct address_space *mapping, void *entry)
 {
-	struct radix_tree_root *pages = &mapping->i_pages;
-	void *entry2, **slot;
 	unsigned long pfn;
 	long ret = 0;
 	size_t size;
@@ -913,29 +911,35 @@ static int dax_writeback_one(struct dax_device *dax_dev,
 	if (WARN_ON(!xa_is_value(entry)))
 		return -EIO;
 
-	xa_lock_irq(pages);
-	entry2 = get_unlocked_mapping_entry(mapping, index, &slot);
-	/* Entry got punched out / reallocated? */
-	if (!entry2 || WARN_ON_ONCE(!xa_is_value(entry2)))
-		goto put_unlocked;
-	/*
-	 * Entry got reallocated elsewhere? No need to writeback. We have to
-	 * compare pfns as we must not bail out due to difference in lockbit
-	 * or entry type.
-	 */
-	if (dax_to_pfn(entry2) != dax_to_pfn(entry))
-		goto put_unlocked;
-	if (WARN_ON_ONCE(dax_is_empty_entry(entry) ||
-				dax_is_zero_entry(entry))) {
-		ret = -EIO;
-		goto put_unlocked;
+	if (unlikely(dax_is_locked(entry))) {
+		void *old_entry = entry;
+
+		entry = get_unlocked_entry(xas);
+
+		/* Entry got punched out / reallocated? */
+		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
+			goto put_unlocked;
+		/*
+		 * Entry got reallocated elsewhere? No need to writeback.
+		 * We have to compare pfns as we must not bail out due to
+		 * difference in lockbit or entry type.
+		 */
+		if (dax_to_pfn(old_entry) != dax_to_pfn(entry))
+			goto put_unlocked;
+		if (WARN_ON_ONCE(dax_is_empty_entry(entry) ||
+					dax_is_zero_entry(entry))) {
+			ret = -EIO;
+			goto put_unlocked;
+		}
+
+		/* Another fsync thread may have already done this entry */
+		if (!xas_get_tag(xas, PAGECACHE_TAG_TOWRITE))
+			goto put_unlocked;
 	}
 
-	/* Another fsync thread may have already written back this entry */
-	if (!radix_tree_tag_get(pages, index, PAGECACHE_TAG_TOWRITE))
-		goto put_unlocked;
 	/* Lock the entry to serialize with page faults */
-	entry = lock_slot(mapping, slot);
+	dax_lock_entry(xas, entry);
+
 	/*
 	 * We can clear the tag now but we have to be careful so that concurrent
 	 * dax_writeback_one() calls for the same index cannot finish before we
@@ -943,8 +947,8 @@ static int dax_writeback_one(struct dax_device *dax_dev,
 	 * at the entry only under the i_pages lock and once they do that
 	 * they will see the entry locked and wait for it to unlock.
 	 */
-	radix_tree_tag_clear(pages, index, PAGECACHE_TAG_TOWRITE);
-	xa_unlock_irq(pages);
+	xas_clear_tag(xas, PAGECACHE_TAG_TOWRITE);
+	xas_unlock_irq(xas);
 
 	/*
 	 * Even if dax_writeback_mapping_range() was given a wbc->range_start
@@ -956,7 +960,7 @@ static int dax_writeback_one(struct dax_device *dax_dev,
 	pfn = dax_to_pfn(entry);
 	size = PAGE_SIZE << dax_entry_order(entry);
 
-	dax_entry_mkclean(mapping, index, pfn);
+	dax_entry_mkclean(mapping, xas->xa_index, pfn);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), size);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
@@ -964,16 +968,17 @@ static int dax_writeback_one(struct dax_device *dax_dev,
 	 * the pfn mappings are writeprotected and fault waits for mapping
 	 * entry lock.
 	 */
-	xa_lock_irq(pages);
-	radix_tree_tag_clear(pages, index, PAGECACHE_TAG_DIRTY);
-	xa_unlock_irq(pages);
-	trace_dax_writeback_one(mapping->host, index, size >> PAGE_SHIFT);
-	put_locked_mapping_entry(mapping, index);
+	xas_reset(xas);
+	xas_lock_irq(xas);
+	xas_store(xas, entry);
+	xas_clear_tag(xas, PAGECACHE_TAG_DIRTY);
+
+	trace_dax_writeback_one(mapping->host, xas->xa_index,
+			size >> PAGE_SHIFT);
 	return ret;
 
  put_unlocked:
-	put_unlocked_mapping_entry(mapping, index, entry2);
-	xa_unlock_irq(pages);
+	put_unlocked_entry(xas, entry);
 	return ret;
 }
 
@@ -985,13 +990,13 @@ static int dax_writeback_one(struct dax_device *dax_dev,
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct block_device *bdev, struct writeback_control *wbc)
 {
+	XA_STATE(xas, &mapping->i_pages, wbc->range_start >> PAGE_SHIFT);
 	struct inode *inode = mapping->host;
-	pgoff_t start_index, end_index;
-	pgoff_t indices[PAGEVEC_SIZE];
+	pgoff_t end_index = wbc->range_end >> PAGE_SHIFT;
 	struct dax_device *dax_dev;
-	struct pagevec pvec;
-	bool done = false;
-	int i, ret = 0;
+	void *entry;
+	int ret = 0;
+	unsigned int scanned = 0;
 
 	if (WARN_ON_ONCE(inode->i_blkbits != PAGE_SHIFT))
 		return -EIO;
@@ -1003,41 +1008,29 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 	if (!dax_dev)
 		return -EIO;
 
-	start_index = wbc->range_start >> PAGE_SHIFT;
-	end_index = wbc->range_end >> PAGE_SHIFT;
-
-	trace_dax_writeback_range(inode, start_index, end_index);
-
-	tag_pages_for_writeback(mapping, start_index, end_index);
+	trace_dax_writeback_range(inode, xas.xa_index, end_index);
 
-	pagevec_init(&pvec);
-	while (!done) {
-		pvec.nr = find_get_entries_tag(mapping, start_index,
-				PAGECACHE_TAG_TOWRITE, PAGEVEC_SIZE,
-				pvec.pages, indices);
+	tag_pages_for_writeback(mapping, xas.xa_index, end_index);
 
-		if (pvec.nr == 0)
+	xas_lock_irq(&xas);
+	xas_for_each_tagged(&xas, entry, end_index, PAGECACHE_TAG_TOWRITE) {
+		ret = dax_writeback_one(&xas, dax_dev, mapping, entry);
+		if (ret < 0) {
+			mapping_set_error(mapping, ret);
 			break;
-
-		for (i = 0; i < pvec.nr; i++) {
-			if (indices[i] > end_index) {
-				done = true;
-				break;
-			}
-
-			ret = dax_writeback_one(dax_dev, mapping, indices[i],
-					pvec.pages[i]);
-			if (ret < 0) {
-				mapping_set_error(mapping, ret);
-				goto out;
-			}
 		}
-		start_index = indices[pvec.nr - 1] + 1;
+		if (++scanned % XA_CHECK_SCHED)
+			continue;
+
+		xas_pause(&xas);
+		xas_unlock_irq(&xas);
+		cond_resched();
+		xas_lock_irq(&xas);
 	}
-out:
+	xas_unlock_irq(&xas);
 	put_dax(dax_dev);
-	trace_dax_writeback_range_done(inode, start_index, end_index);
-	return (ret < 0 ? ret : 0);
+	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
-- 
2.17.1
