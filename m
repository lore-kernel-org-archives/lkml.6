Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CoY7NOqEHls4HgAAmS7hNA
	; Mon, 11 Jun 2018 14:20:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D1FC0607BB; Mon, 11 Jun 2018 14:20:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FnvKd5k0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 54AD1600D0;
	Mon, 11 Jun 2018 14:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54AD1600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934300AbeFKOUf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:20:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933493AbeFKOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t6zM/qfm33anwBHTDJRDqef1HwwyX7RB48+ecTyMpRE=; b=FnvKd5k0mRY3tpyDxpW8zkaxy
        Qksjm/1NbQtSQqwZvTLuPVg1DPG0IrxfxWhP6XSrUPD1nW+Ie06qfuhi5qeaUQ6fHRtS/gapSRDJt
        J0L8eNUc0ykFt/OxWaMKcJBLKTZU92R9+qWZlgSkpHd5qnviQBFdlXP6JvLdDCNpv+s4rwhU+XGMf
        m1I4rA+CccFm6egoeLNhJxcSJTq/yI1LV4uB9vKabAbahlyhMKBoiqjbKOQH2Dk5b17WY0Op8rxPG
        LP4Qy3PO5A9uGvrp7rUDfDnzVC/5XDEa34VrqjiOfaVIXeQVgcaEFaGevDcUhuIwTCjSY0EKa4wpY
        ivUTAjmiA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNT7-0004em-17; Mon, 11 Jun 2018 14:06:49 +0000
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
Subject: [PATCH v13 23/72] page cache: Convert find_get_entry to XArray
Date: Mon, 11 Jun 2018 07:05:50 -0700
Message-Id: <20180611140639.17215-24-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Slightly shorter and simpler code.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/filemap.c | 63 +++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7cdb1d4b8117..6db3d35ff5f6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1382,47 +1382,40 @@ EXPORT_SYMBOL(page_cache_prev_gap);
  */
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 {
-	void **pagep;
+	XA_STATE(xas, &mapping->i_pages, offset);
 	struct page *head, *page;
 
 	rcu_read_lock();
 repeat:
-	page = NULL;
-	pagep = radix_tree_lookup_slot(&mapping->i_pages, offset);
-	if (pagep) {
-		page = radix_tree_deref_slot(pagep);
-		if (unlikely(!page))
-			goto out;
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page))
-				goto repeat;
-			/*
-			 * A shadow entry of a recently evicted page,
-			 * or a swap entry from shmem/tmpfs.  Return
-			 * it without attempting to raise page count.
-			 */
-			goto out;
-		}
+	xas_reset(&xas);
+	page = xas_load(&xas);
+	if (xas_retry(&xas, page))
+		goto repeat;
+	/*
+	 * A shadow entry of a recently evicted page, or a swap entry from
+	 * shmem/tmpfs.  Return it without attempting to raise page count.
+	 */
+	if (!page || xa_is_value(page))
+		goto out;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
-			goto repeat;
+	head = compound_head(page);
+	if (!page_cache_get_speculative(head))
+		goto repeat;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head) {
-			put_page(head);
-			goto repeat;
-		}
+	/* The page was split under us? */
+	if (compound_head(page) != head) {
+		put_page(head);
+		goto repeat;
+	}
 
-		/*
-		 * Has the page moved?
-		 * This is part of the lockless pagecache protocol. See
-		 * include/linux/pagemap.h for details.
-		 */
-		if (unlikely(page != *pagep)) {
-			put_page(head);
-			goto repeat;
-		}
+	/*
+	 * Has the page moved?
+	 * This is part of the lockless pagecache protocol. See
+	 * include/linux/pagemap.h for details.
+	 */
+	if (unlikely(page != xas_reload(&xas))) {
+		put_page(head);
+		goto repeat;
 	}
 out:
 	rcu_read_unlock();
@@ -1453,7 +1446,7 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
 
 repeat:
 	page = find_get_entry(mapping, offset);
-	if (page && !radix_tree_exception(page)) {
+	if (page && !xa_is_value(page)) {
 		lock_page(page);
 		/* Has the page been truncated? */
 		if (unlikely(page_mapping(page) != mapping)) {
-- 
2.17.1
