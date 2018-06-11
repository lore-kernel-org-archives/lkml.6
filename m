Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AHJmMIaEHls1GwAAmS7hNA
	; Mon, 11 Jun 2018 14:17:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 12B7F607BB; Mon, 11 Jun 2018 14:17:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ThsXXNtl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 967326074D;
	Mon, 11 Jun 2018 14:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 967326074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934069AbeFKORE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:17:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933542AbeFKOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yMvq9C+7xk7yZk7cjnEEnp5fI210x4S9onkG7brkez0=; b=ThsXXNtlY6IPV9ZR2YAl6K5Se
        FWn+hSURSdwUDmvX687LlqYlpCYeDLRmJFEqYpl8rJWTB4p0VmOJB7eEzFXKCPk6gzyCwpaO3ZlR0
        y3HUAt5NymLtJS5WL5WLoTi+Radwl4xIl5HfTZrxo37DBUorH7WcUX8St4Gufw+iTEHOZ8x5xE48t
        DAwBik0HH1MUJxycWDptrDFGu0n1SjFgO/UyccSBBWG7NVTHitCpARsVe+les9eecAIYOaPi8nlta
        jTgJ3dMPYcKQQaL6QKYF0cJV8bFYr/NXEgIMQCWQf0+dmOMJ+1GxfBYM1Ac7sScmBFKASCjzkGJdt
        iVzBqw4Ow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTG-0004nz-3G; Mon, 11 Jun 2018 14:06:58 +0000
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
Subject: [PATCH v13 41/72] mm: Convert huge_memory to XArray
Date: Mon, 11 Jun 2018 07:06:08 -0700
Message-Id: <20180611140639.17215-42-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Quite a straightforward conversion.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/huge_memory.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d43394fadbfd..1dfa4542fed9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2439,13 +2439,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	ClearPageCompound(head);
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
-		/* Additional pin to radix tree of swap cache */
+		/* Additional pin to swap cache */
 		if (PageSwapCache(head))
 			page_ref_add(head, 2);
 		else
 			page_ref_inc(head);
 	} else {
-		/* Additional pin to radix tree */
+		/* Additional pin to page cache */
 		page_ref_add(head, 2);
 		xa_unlock(&head->mapping->i_pages);
 	}
@@ -2557,7 +2557,7 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 {
 	int extra_pins;
 
-	/* Additional pins from radix tree */
+	/* Additional pins from page cache */
 	if (PageAnon(page))
 		extra_pins = PageSwapCache(page) ? HPAGE_PMD_NR : 0;
 	else
@@ -2653,17 +2653,14 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	spin_lock_irqsave(zone_lru_lock(page_zone(head)), flags);
 
 	if (mapping) {
-		void **pslot;
+		XA_STATE(xas, &mapping->i_pages, page_index(head));
 
-		xa_lock(&mapping->i_pages);
-		pslot = radix_tree_lookup_slot(&mapping->i_pages,
-				page_index(head));
 		/*
-		 * Check if the head page is present in radix tree.
+		 * Check if the head page is present in page cache.
 		 * We assume all tail are present too, if head is there.
 		 */
-		if (radix_tree_deref_slot_protected(pslot,
-					&mapping->i_pages.xa_lock) != head)
+		xa_lock(&mapping->i_pages);
+		if (xas_load(&xas) != head)
 			goto fail;
 	}
 
-- 
2.17.1
