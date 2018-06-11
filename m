Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UCojNc+DHluHFwAAmS7hNA
	; Mon, 11 Jun 2018 14:15:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9A5AC607A4; Mon, 11 Jun 2018 14:15:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P6SXzgnI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 333DD60351;
	Mon, 11 Jun 2018 14:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 333DD60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934003AbeFKOOx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:14:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933589AbeFKOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0csFvUP++HIsjyS093eVt+iU23F6aEPdiKSGAjZkOUY=; b=P6SXzgnIPyKH0In6/65wJy+BI
        s045Y6AKyw0/S44kF49VUZiNW+U3TZ60CGj1gs279C8eRh5m4Y3G47QZWxH0Clzvp41zpqBHHkwvU
        sorI37jMVLQBywKZ+wSnZegKPigORWPP1nsv/xCqAaQK3NBX9Bg0f/fqlfucpXV6F9fvC+SdWkC+o
        OrlRG0O5McB7n5KX8AXugk+v1uhG+2LRtmMYFoRTp+/ay1NI07kqx8NEw6AUx5LbHBwAgRqcVxGXu
        7XgykXDdpJaMGaXZRb4xHTR/tO4muxutNLTWWsZ4TxjgYi24I71+DbDm72DmHa23uWIhorDEJTfs/
        TYVuGxYvA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTK-0004qd-8A; Mon, 11 Jun 2018 14:07:02 +0000
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
Subject: [PATCH v13 47/72] shmem: Convert shmem_confirm_swap to XArray
Date: Mon, 11 Jun 2018 07:06:14 -0700
Message-Id: <20180611140639.17215-48-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

xa_load has its own RCU locking, so we can eliminate it here.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/shmem.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2b8720d32e7a..479e4a8e6d68 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -348,12 +348,7 @@ static int shmem_replace_entry(struct address_space *mapping,
 static bool shmem_confirm_swap(struct address_space *mapping,
 			       pgoff_t index, swp_entry_t swap)
 {
-	void *item;
-
-	rcu_read_lock();
-	item = radix_tree_lookup(&mapping->i_pages, index);
-	rcu_read_unlock();
-	return item == swp_to_radix_entry(swap);
+	return xa_load(&mapping->i_pages, index) == swp_to_radix_entry(swap);
 }
 
 /*
-- 
2.17.1
