Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F175AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD23420891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ekXbeFxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD23420891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934800AbeFQCEf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:04:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934460AbeFQCBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tEOFzlT+od5bOh/ypS1B0w/JWs8F+t7+Bb3rIKpKXVE=; b=ekXbeFxcrWCKvvU7zDX+ol38A
        43Vty+N9h9n1RbL4ER3Q/jb6kwujjlJHYpCpdPn5B3WypBVhOWL8tXiycJtM+OZb5xo/M2/DqX220
        sWc0nLMkzFG/VPkuCxy8afGjp90uN18FEy5nRfbcCksC5hv38VuMbm2R+PUdAGbf/GTX54h3XmPmE
        4CiiLUtYjWBuDBz4MLwwuI+Jk8LXEsF2g7PjxZ1bGWCHkPeHnmrnK7HbH14z81GDsi0FmGOfoAmkU
        vhm9hD9ANSvnO9vdJ2pUoqjUzv2KP5vwzfYW/+wFvOgjFhBAge/7aqbMtibL5Sk9O0Q7ak/ZMPPlZ
        cCQPQ2LKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN0X-0001e8-70; Sun, 17 Jun 2018 02:01:33 +0000
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
Subject: [PATCH v14 65/74] dax: Convert dax_layout_busy_page to XArray
Date:   Sat, 16 Jun 2018 19:00:43 -0700
Message-Id: <20180617020052.4759-66-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a pagevec, just use the XArray iterators.  Add a
conditional rescheduling point which probably should have been there in
the original.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 fs/dax.c | 57 +++++++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 71181f4bb1d3..7b80b17cba50 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -697,11 +697,10 @@ static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
  */
 struct page *dax_layout_busy_page(struct address_space *mapping)
 {
-	pgoff_t	indices[PAGEVEC_SIZE];
+	XA_STATE(xas, &mapping->i_pages, 0);
+	void *entry;
+	unsigned int scanned = 0;
 	struct page *page = NULL;
-	struct pagevec pvec;
-	pgoff_t	index, end;
-	unsigned i;
 
 	/*
 	 * In the 'limited' case get_user_pages() for dax is disabled.
@@ -712,13 +711,9 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
 		return NULL;
 
-	pagevec_init(&pvec);
-	index = 0;
-	end = -1;
-
 	/*
 	 * If we race get_user_pages_fast() here either we'll see the
-	 * elevated page count in the pagevec_lookup and wait, or
+	 * elevated page count in the iteration and wait, or
 	 * get_user_pages_fast() will see that the page it took a reference
 	 * against is no longer mapped in the page tables and bail to the
 	 * get_user_pages() slow path.  The slow path is protected by
@@ -730,36 +725,26 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	 */
 	unmap_mapping_range(mapping, 0, 0, 1);
 
-	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE),
-				indices)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *pvec_ent = pvec.pages[i];
-			void *entry;
-
-			index = indices[i];
-			if (index >= end)
-				break;
-
-			if (!xa_is_value(pvec_ent))
-				continue;
-
-			xa_lock_irq(&mapping->i_pages);
-			entry = get_unlocked_mapping_entry(mapping, index, NULL);
-			if (entry)
-				page = dax_busy_page(entry);
-			put_unlocked_mapping_entry(mapping, index, entry);
-			xa_unlock_irq(&mapping->i_pages);
-			if (page)
-				break;
-		}
-		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
-		index++;
-
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, ULONG_MAX) {
+		if (!xa_is_value(entry))
+			continue;
+		if (unlikely(dax_is_locked(entry)))
+			entry = get_unlocked_entry(&xas);
+		if (entry)
+			page = dax_busy_page(entry);
+		put_unlocked_entry(&xas, entry);
 		if (page)
 			break;
+		if (++scanned % XA_CHECK_SCHED)
+			continue;
+
+		xas_pause(&xas);
+		xas_unlock_irq(&xas);
+		cond_resched();
+		xas_lock_irq(&xas);
 	}
+	xas_unlock_irq(&xas);
 	return page;
 }
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
-- 
2.17.1

