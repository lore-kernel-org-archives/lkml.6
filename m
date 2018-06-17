Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A9CC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B374A2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hBhoTyth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B374A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934623AbeFQCGs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:06:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934107AbeFQCBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3dt1i9NP1EXxETQ4D4nD6mkkx/fkw3evvLQHvoVxbqY=; b=hBhoTythSko0pFY65cmmmSvgH
        k2HXrqUZ3It06bxZLbP7ijoSrRGWitmutjXTJjSfEIh/TXudmVVJCox6fMusITIZRrLbt0BM/toUB
        wQV2ThXABL0BEAUAZxy4SKjGCeKLU/M4k9EBHd1u+G7r0ud03kQYqSAniHfKkfsmx9rfQxWhJ3PVW
        ZfYMttSmUwDZWba0W5tMCQU7tkUNyFbjSmDt3fHI8Ah9GJaEqt9wuHSBUynvZVteNowLlgFFZ/IGA
        lVwubIOV2QQ3nwZu0pXN/riLYUln9uL77TLx7Kd9ODbWvQrW2Q2lk8l6zqGAmtgo2zT1pfO65DeHC
        rIr54DZvg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN0C-0001SF-Af; Sun, 17 Jun 2018 02:01:12 +0000
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
Subject: [PATCH v14 55/74] memfd: Convert memfd_tag_pins to XArray
Date:   Sat, 16 Jun 2018 19:00:33 -0700
Message-Id: <20180617020052.4759-56-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to a batch-processing model like memfd_wait_for_pins() and
use the xa_state previously set up by memfd_wait_for_pins().

Signed-off-by: Matthew Wilcox <willy@infradead.org>
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

