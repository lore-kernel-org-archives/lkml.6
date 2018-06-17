Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0DE2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fUJuk191"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0DE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757157AbeFQCNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:13:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933836AbeFQCBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=keiyQrUpDRQWhnPR71wImrRvTU39XDZFBkYm3gi9ueg=; b=fUJuk191WhD8ndwVMTXFXBIvc
        TrNSarfuBi1/KYtAvBkX8nTh/iikC8TeVwXc77JV9ypWlubpdKVSVWvzmvu5eO10NhMekkcOFMck0
        5tJn7sXI6h5584T7idd0kFMwPdwoX5gBqwLsX3nZfsxN9CPdrGHQo+WsayfBOEar5Z8SLEk/4rjOT
        E/wOyKnrAgqVw3pNcHCN2FmajuxqIAt4vwkVD16+i5rwvl4HzbCf0Onfqwl/zixVsuFJgowCcFoJw
        4kb1aArbPihlNY88smgowM/ZtYTW7rUpPl3TzX6Vh0x/zlWV+fejSTPU/kb8IwTgGaWesztBU88jW
        7qygF5kSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN02-0001K2-Rk; Sun, 17 Jun 2018 02:01:02 +0000
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
Subject: [PATCH v14 35/74] mm: Convert page-writeback to XArray
Date:   Sat, 16 Jun 2018 19:00:13 -0700
Message-Id: <20180617020052.4759-36-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Includes moving mapping_tagged() to fs.h as a static inline, and
changing it to return bool.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/fs.h  | 17 ++++++-----
 mm/page-writeback.c | 72 ++++++++++++++++-----------------------------
 2 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f1716ce5ff6f..3fe2d7607d65 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -476,15 +476,18 @@ struct block_device {
 	struct mutex		bd_fsfreeze_mutex;
 } __randomize_layout;
 
+/* XArray tags, for tagging dirty and writeback pages in the pagecache. */
+#define PAGECACHE_TAG_DIRTY	XA_TAG_0
+#define PAGECACHE_TAG_WRITEBACK	XA_TAG_1
+#define PAGECACHE_TAG_TOWRITE	XA_TAG_2
+
 /*
- * Radix-tree tags, for tagging dirty and writeback pages within the pagecache
- * radix trees
+ * Returns true if any of the pages in the mapping are marked with the tag.
  */
-#define PAGECACHE_TAG_DIRTY	0
-#define PAGECACHE_TAG_WRITEBACK	1
-#define PAGECACHE_TAG_TOWRITE	2
-
-int mapping_tagged(struct address_space *mapping, int tag);
+static inline bool mapping_tagged(struct address_space *mapping, xa_tag_t tag)
+{
+	return xa_tagged(&mapping->i_pages, tag);
+}
 
 static inline void i_mmap_lock_write(struct address_space *mapping)
 {
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 337c6afb3345..0e502bd13ad9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2098,34 +2098,25 @@ void __init page_writeback_init(void)
  * dirty pages in the file (thus it is important for this function to be quick
  * so that it can tag pages faster than a dirtying process can create them).
  */
-/*
- * We tag pages in batches of WRITEBACK_TAG_BATCH to reduce the i_pages lock
- * latency.
- */
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end)
 {
-#define WRITEBACK_TAG_BATCH 4096
-	unsigned long tagged = 0;
-	struct radix_tree_iter iter;
-	void **slot;
+	XA_STATE(xas, &mapping->i_pages, start);
+	unsigned int tagged = 0;
+	void *page;
 
-	xa_lock_irq(&mapping->i_pages);
-	radix_tree_for_each_tagged(slot, &mapping->i_pages, &iter, start,
-							PAGECACHE_TAG_DIRTY) {
-		if (iter.index > end)
-			break;
-		radix_tree_iter_tag_set(&mapping->i_pages, &iter,
-							PAGECACHE_TAG_TOWRITE);
-		tagged++;
-		if ((tagged % WRITEBACK_TAG_BATCH) != 0)
+	xas_lock_irq(&xas);
+	xas_for_each_tagged(&xas, page, end, PAGECACHE_TAG_DIRTY) {
+		xas_set_tag(&xas, PAGECACHE_TAG_TOWRITE);
+		if (++tagged % XA_CHECK_SCHED)
 			continue;
-		slot = radix_tree_iter_resume(slot, &iter);
-		xa_unlock_irq(&mapping->i_pages);
+
+		xas_pause(&xas);
+		xas_unlock_irq(&xas);
 		cond_resched();
-		xa_lock_irq(&mapping->i_pages);
+		xas_lock_irq(&xas);
 	}
-	xa_unlock_irq(&mapping->i_pages);
+	xas_unlock_irq(&xas);
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
@@ -2165,7 +2156,7 @@ int write_cache_pages(struct address_space *mapping,
 	pgoff_t done_index;
 	int cycled;
 	int range_whole = 0;
-	int tag;
+	xa_tag_t tag;
 
 	pagevec_init(&pvec);
 	if (wbc->range_cyclic) {
@@ -2446,7 +2437,7 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
 
 /*
  * For address_spaces which do not use buffers.  Just tag the page as dirty in
- * its radix tree.
+ * the xarray.
  *
  * This is also used when a single buffer is being dirtied: we want to set the
  * page dirty in that case, but not all the buffers.  This is a "bottom-up"
@@ -2472,7 +2463,7 @@ int __set_page_dirty_nobuffers(struct page *page)
 		BUG_ON(page_mapping(page) != mapping);
 		WARN_ON_ONCE(!PagePrivate(page) && !PageUptodate(page));
 		account_page_dirtied(page, mapping);
-		radix_tree_tag_set(&mapping->i_pages, page_index(page),
+		__xa_set_tag(&mapping->i_pages, page_index(page),
 				   PAGECACHE_TAG_DIRTY);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		unlock_page_memcg(page);
@@ -2635,13 +2626,13 @@ EXPORT_SYMBOL(__cancel_dirty_page);
  * Returns true if the page was previously dirty.
  *
  * This is for preparing to put the page under writeout.  We leave the page
- * tagged as dirty in the radix tree so that a concurrent write-for-sync
+ * tagged as dirty in the xarray so that a concurrent write-for-sync
  * can discover it via a PAGECACHE_TAG_DIRTY walk.  The ->writepage
  * implementation will run either set_page_writeback() or set_page_dirty(),
- * at which stage we bring the page's dirty flag and radix-tree dirty tag
+ * at which stage we bring the page's dirty flag and xarray dirty tag
  * back into sync.
  *
- * This incoherency between the page's dirty flag and radix-tree tag is
+ * This incoherency between the page's dirty flag and xarray tag is
  * unfortunate, but it only exists while the page is locked.
  */
 int clear_page_dirty_for_io(struct page *page)
@@ -2722,7 +2713,7 @@ int test_clear_page_writeback(struct page *page)
 		xa_lock_irqsave(&mapping->i_pages, flags);
 		ret = TestClearPageWriteback(page);
 		if (ret) {
-			radix_tree_tag_clear(&mapping->i_pages, page_index(page),
+			__xa_clear_tag(&mapping->i_pages, page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
 			if (bdi_cap_account_writeback(bdi)) {
 				struct bdi_writeback *wb = inode_to_wb(inode);
@@ -2762,11 +2753,13 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 
 	lock_page_memcg(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
+		XA_STATE(xas, &mapping->i_pages, page_index(page));
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
 
-		xa_lock_irqsave(&mapping->i_pages, flags);
+		xas_lock_irqsave(&xas, flags);
+		xas_load(&xas);
 		ret = TestSetPageWriteback(page);
 		if (!ret) {
 			bool on_wblist;
@@ -2774,8 +2767,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 			on_wblist = mapping_tagged(mapping,
 						   PAGECACHE_TAG_WRITEBACK);
 
-			radix_tree_tag_set(&mapping->i_pages, page_index(page),
-						PAGECACHE_TAG_WRITEBACK);
+			xas_set_tag(&xas, PAGECACHE_TAG_WRITEBACK);
 			if (bdi_cap_account_writeback(bdi))
 				inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
 
@@ -2788,12 +2780,10 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 				sb_mark_inode_writeback(mapping->host);
 		}
 		if (!PageDirty(page))
-			radix_tree_tag_clear(&mapping->i_pages, page_index(page),
-						PAGECACHE_TAG_DIRTY);
+			xas_clear_tag(&xas, PAGECACHE_TAG_DIRTY);
 		if (!keep_write)
-			radix_tree_tag_clear(&mapping->i_pages, page_index(page),
-						PAGECACHE_TAG_TOWRITE);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
+			xas_clear_tag(&xas, PAGECACHE_TAG_TOWRITE);
+		xas_unlock_irqrestore(&xas, flags);
 	} else {
 		ret = TestSetPageWriteback(page);
 	}
@@ -2807,16 +2797,6 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 }
 EXPORT_SYMBOL(__test_set_page_writeback);
 
-/*
- * Return true if any of the pages in the mapping are marked with the
- * passed tag.
- */
-int mapping_tagged(struct address_space *mapping, int tag)
-{
-	return radix_tree_tagged(&mapping->i_pages, tag);
-}
-EXPORT_SYMBOL(mapping_tagged);
-
 /**
  * wait_for_stable_page() - wait for writeback to finish, if necessary.
  * @page:	The page to wait on.
-- 
2.17.1

