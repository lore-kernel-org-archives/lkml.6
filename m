Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1j/TNTCDHlsBEQAAmS7hNA
	; Mon, 11 Jun 2018 14:12:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C29BC6089E; Mon, 11 Jun 2018 14:12:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BAdkMUBW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68B5860351;
	Mon, 11 Jun 2018 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68B5860351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933978AbeFKOLp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:11:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933608AbeFKOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sMEe5HP+nzzouXdOXrYTxqJXjywXPmaQ9Qzg2IJzEoQ=; b=BAdkMUBWwoPl4SbrSwOFcauPR
        1k5+zQNA7G3io1pMKMht6mSNi23R8hpLQWPacMuNGi+mTu0n0/g5nYmpSULVJdqkYSgHwTLWp0f6n
        R2C28uyfYVJhC3V8wL43WAGOs4HXaMAMb5Tc4jLRtkGAhFiVDYNFJRq/0NS6bX+zMzjQj7X3XH8uK
        GMBDBaiWA7wuQissHUEVQxz16XpY/BMNXOY3Vf9sdjg8UcKlWHf1zKWWxpsSDPuVHq/511migTF2o
        qVrcrSLJYGQORjoGMkt5vQM1TlPATNpZ+j1OwLx8e97jC0kzfUbBfFOO2jqQI2MK9DSzT/YFSEmCi
        1fnn6nOpQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTM-0004uG-DR; Mon, 11 Jun 2018 14:07:04 +0000
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
Subject: [PATCH v13 51/72] shmem: Convert shmem_free_swap to XArray
Date: Mon, 11 Jun 2018 07:06:18 -0700
Message-Id: <20180611140639.17215-52-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Since we are conditionally storing NULL in the XArray, we do not need
to allocate memory and the GFP flags will be unused.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 09452ca79220..9dbbdd5dee30 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -653,7 +653,7 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 }
 
 /*
- * Remove swap entry from radix tree, free the swap and its page cache.
+ * Remove swap entry from page cache, free the swap and its page cache.
  */
 static int shmem_free_swap(struct address_space *mapping,
 			   pgoff_t index, void *radswap)
@@ -661,7 +661,7 @@ static int shmem_free_swap(struct address_space *mapping,
 	void *old;
 
 	xa_lock_irq(&mapping->i_pages);
-	old = radix_tree_delete_item(&mapping->i_pages, index, radswap);
+	old = __xa_cmpxchg(&mapping->i_pages, index, radswap, NULL, 0);
 	xa_unlock_irq(&mapping->i_pages);
 	if (old != radswap)
 		return -ENOENT;
-- 
2.17.1
