Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sP7XLPiCHlsREQAAmS7hNA
	; Mon, 11 Jun 2018 14:11:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B580607A4; Mon, 11 Jun 2018 14:11:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Voy8qDga"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BA78A60351;
	Mon, 11 Jun 2018 14:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA78A60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbeFKOLm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:11:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933616AbeFKOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oTHiFdNe4Vn6UitekWmDmg9p/jcGgir3VQorWtPf2OU=; b=Voy8qDgaiHz4YuIZATm3+m9j7
        VmoYUsTWRN+oCLYOpbsfoZuvK6VneyZOgM2YrCokdEjf93cHQtIVgby73oscjYMUVTwJPLKkbMu+Y
        zNt3zh/2KJBq/JTnmrU3M10/+qZmD5RegS7dqd4un7dYmw7qraGg0o/YpHHHg2BcBuwPQbAwNOIqZ
        kBgLCBE4UZ+msZFEle9AfKaZlGfsRH2GEkT4zwfj/1EYM+lvcfGy9Jt/UKMmEfftW8HYTuZWuVNoX
        D35yUymwUPu9MoAAXUgPj49FeRr1nJCRtspS0LtgqpinlxDdPBIYXxQNt9EOW6/7cG+cPc5mPr7Yp
        C37CYV7Vg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTN-0004uW-69; Mon, 11 Jun 2018 14:07:05 +0000
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
Subject: [PATCH v13 52/72] shmem: Convert shmem_partial_swap_usage to XArray
Date: Mon, 11 Jun 2018 07:06:19 -0700
Message-Id: <20180611140639.17215-53-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Simpler code because the xarray takes care of things like the limit and
dereferencing the slot.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/shmem.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9dbbdd5dee30..bffb87854852 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -679,29 +679,19 @@ static int shmem_free_swap(struct address_space *mapping,
 unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end)
 {
-	struct radix_tree_iter iter;
-	void __rcu **slot;
+	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
 	unsigned long swapped = 0;
 
 	rcu_read_lock();
-
-	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
-		if (iter.index >= end)
-			break;
-
-		page = radix_tree_deref_slot(slot);
-
-		if (radix_tree_deref_retry(page)) {
-			slot = radix_tree_iter_retry(&iter);
+	xas_for_each(&xas, page, end - 1) {
+		if (xas_retry(&xas, page))
 			continue;
-		}
-
 		if (xa_is_value(page))
 			swapped++;
 
 		if (need_resched()) {
-			slot = radix_tree_iter_resume(slot, &iter);
+			xas_pause(&xas);
 			cond_resched_rcu();
 		}
 	}
-- 
2.17.1
