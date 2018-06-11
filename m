Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Mec+HtCDHluRFwAAmS7hNA
	; Mon, 11 Jun 2018 14:14:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A1B51607E4; Mon, 11 Jun 2018 14:14:57 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K9IZIMan"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2BAA060351;
	Mon, 11 Jun 2018 14:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BAA060351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934022AbeFKOOz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:14:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933588AbeFKOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p6NnmI89u0sq1FU15L+NpkGefGHhKJMhHQetKgwT18I=; b=K9IZIManm8qnl8VgceF/LH0sE
        /TEB0rGfI7w/GjS50xYkL8QnUx/M1GRU+kQhbvu8pFpQm9Rvf2P/bl5U4stjs0x9T0PV3qPqcEt1U
        yPEqiURARaAtIWWiGU1uICNlSofinMRaghWmX5dUXrOl+iaivI83KdlY91+vF9IHaF9D8JuH3o8vE
        IwL8gKdyjIBfDdNaT5Z3nuBWbm3WIl8kAb0s/qTvhG+oL9rIr8Npn6v4QHUtlmDFIn/av8UlMx8z/
        0pbQuqo2lLrba0JnCGBz0D/ULrmR74/IvSfhkXhtulXLLeJZzGNXGTdfzW0gG3RfkpH3cMm3fHQ2X
        noVVn9ktQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTJ-0004qG-Jl; Mon, 11 Jun 2018 14:07:01 +0000
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
Subject: [PATCH v13 46/72] shmem: Convert shmem_radix_tree_replace to XArray
Date: Mon, 11 Jun 2018 07:06:13 -0700
Message-Id: <20180611140639.17215-47-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Rename shmem_radix_tree_replace() to shmem_replace_entry() and
convert it to use the XArray API.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/shmem.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3b03ede3515c..2b8720d32e7a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -321,24 +321,20 @@ void shmem_uncharge(struct inode *inode, long pages)
 }
 
 /*
- * Replace item expected in radix tree by a new item, while holding tree lock.
+ * Replace item expected in xarray by a new item, while holding xa_lock.
  */
-static int shmem_radix_tree_replace(struct address_space *mapping,
+static int shmem_replace_entry(struct address_space *mapping,
 			pgoff_t index, void *expected, void *replacement)
 {
-	struct radix_tree_node *node;
-	void __rcu **pslot;
+	XA_STATE(xas, &mapping->i_pages, index);
 	void *item;
 
 	VM_BUG_ON(!expected);
 	VM_BUG_ON(!replacement);
-	item = __radix_tree_lookup(&mapping->i_pages, index, &node, &pslot);
-	if (!item)
-		return -ENOENT;
+	item = xas_load(&xas);
 	if (item != expected)
 		return -ENOENT;
-	__radix_tree_replace(&mapping->i_pages, node, pslot,
-			     replacement, NULL);
+	xas_store(&xas, replacement);
 	return 0;
 }
 
@@ -623,8 +619,7 @@ static int shmem_add_to_page_cache(struct page *page,
 	} else if (!expected) {
 		error = radix_tree_insert(&mapping->i_pages, index, page);
 	} else {
-		error = shmem_radix_tree_replace(mapping, index, expected,
-								 page);
+		error = shmem_replace_entry(mapping, index, expected, page);
 	}
 
 	if (!error) {
@@ -653,7 +648,7 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	VM_BUG_ON_PAGE(PageCompound(page), page);
 
 	xa_lock_irq(&mapping->i_pages);
-	error = shmem_radix_tree_replace(mapping, page->index, page, radswap);
+	error = shmem_replace_entry(mapping, page->index, page, radswap);
 	page->mapping = NULL;
 	mapping->nrpages--;
 	__dec_node_page_state(page, NR_FILE_PAGES);
@@ -1577,8 +1572,7 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 	 * a nice clean interface for us to replace oldpage by newpage there.
 	 */
 	xa_lock_irq(&swap_mapping->i_pages);
-	error = shmem_radix_tree_replace(swap_mapping, swap_index, oldpage,
-								   newpage);
+	error = shmem_replace_entry(swap_mapping, swap_index, oldpage, newpage);
 	if (!error) {
 		__inc_node_page_state(newpage, NR_FILE_PAGES);
 		__dec_node_page_state(oldpage, NR_FILE_PAGES);
-- 
2.17.1
