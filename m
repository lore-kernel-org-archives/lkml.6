Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pmdZHw+CHlt6BAAAmS7hNA
	; Mon, 11 Jun 2018 14:08:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B73E7607E7; Mon, 11 Jun 2018 14:08:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h11/Wzvm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 392106074D;
	Mon, 11 Jun 2018 14:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 392106074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933664AbeFKOHT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:07:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933617AbeFKOHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uFo/5SSJuJU2uEENvH3dxtsPOTxtY7hbgSaYCUX4Usk=; b=h11/WzvmVYmTtHuxhP/vXbtHq
        dKADqvsRxXl3BJUcHv4IJ4p53cP8HUWx0xJoRetj5/5VCDmt8hVU0HdVm2kcwAwPzg+En+wCwWxKi
        uJWkUFzGDnYeIV+1jDwQWRefnU02Yi/t19Tj3ZzGTNxpPqOKSIrzDzy9Pve8abGtDfy0Q6aM2zLk+
        K6MQc5B7k+R+t4QjA8KqHzfR41NDaHt2R6qQLftliEQ98cbP+/72kTpi79eovTAl38RsebkSL37LT
        DXDqeC+ty1LaJ1XDDrBO3EEA9zVYHYoNeDoIEJhtbS+i4uzf2n0lnS6kVMZI6WZN99pnPfPmvGwfL
        xYyZMRotg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTO-0004vy-Fc; Mon, 11 Jun 2018 14:07:06 +0000
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
Subject: [PATCH v13 54/72] memfd: Convert memfd_tag_pins to XArray
Date: Mon, 11 Jun 2018 07:06:21 -0700
Message-Id: <20180611140639.17215-55-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Switch to a batch-processing model like memfd_wait_for_pins() and
use the xa_state previously set up by memfd_wait_for_pins().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memfd.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index e7d6be725b7a..636de8d5c7c3 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -28,37 +28,29 @@
 #define MEMFD_TAG_PINNED        PAGECACHE_TAG_TOWRITE
 #define LAST_SCAN               4       /* about 150ms max */
 
-static void memfd_tag_pins(struct address_space *mapping)
+static void memfd_tag_pins(struct xa_state *xas)
 {
-	struct radix_tree_iter iter;
-	void __rcu **slot;
-	pgoff_t start;
 	struct page *page;
+	unsigned int tagged = 0;
 
 	lru_add_drain();
-	start = 0;
-	rcu_read_lock();
-
-	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
-		page = radix_tree_deref_slot(slot);
-		if (!page || radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				slot = radix_tree_iter_retry(&iter);
-				continue;
-			}
-		} else if (page_count(page) - page_mapcount(page) > 1) {
-			xa_lock_irq(&mapping->i_pages);
-			radix_tree_tag_set(&mapping->i_pages, iter.index,
-					   MEMFD_TAG_PINNED);
-			xa_unlock_irq(&mapping->i_pages);
-		}
 
-		if (need_resched()) {
-			slot = radix_tree_iter_resume(slot, &iter);
-			cond_resched_rcu();
-		}
+	xas_lock_irq(xas);
+	xas_for_each(xas, page, ULONG_MAX) {
+		if (xa_is_value(page))
+			continue;
+		if (page_count(page) - page_mapcount(page) > 1)
+			xas_set_tag(xas, MEMFD_TAG_PINNED);
+
+		if (++tagged % XA_CHECK_SCHED)
+			continue;
+
+		xas_pause(xas);
+		xas_unlock_irq(xas);
+		cond_resched();
+		xas_lock_irq(xas);
 	}
-	rcu_read_unlock();
+	xas_unlock_irq(xas);
 }
 
 /*
@@ -76,7 +68,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 	struct page *page;
 	int error, scan;
 
-	memfd_tag_pins(mapping);
+	memfd_tag_pins(&xas);
 
 	error = 0;
 	for (scan = 0; scan <= LAST_SCAN; scan++) {
-- 
2.17.1
