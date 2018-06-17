Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B47C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226E02086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hWK1Br71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226E02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934849AbeFQCH6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:07:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933996AbeFQCBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jlPJjd97phkgtLpaFqwtKpwhcV6aMOInwpP/oXccAJE=; b=hWK1Br71IXraKoB6WwcincedS
        yWb6z9VzFKd2qCNUwYvcUCz/ZkBSH3pTmCnZcM8VhWwzsurZVKs/y2ioqp/4693fTfYXgfz+vx944
        NsdOdcv1YLUgbu+EArt8hB3HROEw8AxJYF6mGcNneDhanlqjsiXRiE2OlmSZQ0pwAj0XqLys/X3Nr
        tKf7bEjnqsaTxWaNYMRXXWoJz3BSU4R8+p3JPT/Z7eMsY9lV/N0jg0rwr4DQ8aMW7ByQeQF63ysQn
        7qnYe+4ERWy1PNu7PqKEeli0cpvPhFfeHduHsbbrR99rf86PZNRIUfNNETuJb7IaIR4DuBEKt+9Wq
        BXCNe+gLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN0A-0001PJ-Jz; Sun, 17 Jun 2018 02:01:10 +0000
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
Subject: [PATCH v14 52/74] shmem: Convert shmem_free_swap to XArray
Date:   Sat, 16 Jun 2018 19:00:30 -0700
Message-Id: <20180617020052.4759-53-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are conditionally storing NULL in the XArray, we do not need
to allocate memory and the GFP flags will be unused.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
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

