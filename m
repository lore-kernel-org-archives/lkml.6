Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A220DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C19820895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="okPB77XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C19820895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936546AbeFQCQS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:16:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933686AbeFQCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AKP5kPHLAsjH4oWHNfWRxP+epB3/+vM9u8ylV5gaNUw=; b=okPB77XZe6XRpnpeP6AUMA+6p
        N32Pu3z6V+C1Xrh8qb/dG65uQhx6HmtgVy2XI7b5XMdBYqh5zDZs0daNiqloNE32jXGhbcPY77SU6
        WNbWLYj+tjB9srSGsmTxwzzilG7mguxPhKuulR/1UrO95bFp5yHTr1ofTpQH9GSWLR4BKoTqCvlgr
        YG0eHLZNqrFDb0zaQRwQahMljnfuwWzotRE8PjGzJiJKc1duoL5yRIQZ8pXhvLUiZcZ1Z1bl6pczS
        lWU654Tymzf7uGG5IpUtbkHR0xISNNZm803fjCLuDJlTHcqvkuBgdXb5H8zviHABUTTtR1nq304w6
        VmKJyvIIg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN00-0001J3-TS; Sun, 17 Jun 2018 02:01:00 +0000
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
Subject: [PATCH v14 31/74] radix tree test suite: Convert regression1 to XArray
Date:   Sat, 16 Jun 2018 19:00:09 -0700
Message-Id: <20180617020052.4759-32-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the page cache lookup is using the XArray, let's convert this
regression test from the radix tree API to the XArray so it's testing
roughly the same thing it was testing before.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 tools/testing/radix-tree/regression1.c | 58 +++++++++-----------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/tools/testing/radix-tree/regression1.c b/tools/testing/radix-tree/regression1.c
index 0aece092f40e..b4a4a7168986 100644
--- a/tools/testing/radix-tree/regression1.c
+++ b/tools/testing/radix-tree/regression1.c
@@ -53,12 +53,12 @@ struct page {
 	unsigned long index;
 };
 
-static struct page *page_alloc(void)
+static struct page *page_alloc(int index)
 {
 	struct page *p;
 	p = malloc(sizeof(struct page));
 	p->count = 1;
-	p->index = 1;
+	p->index = index;
 	pthread_mutex_init(&p->lock, NULL);
 
 	return p;
@@ -80,53 +80,33 @@ static void page_free(struct page *p)
 static unsigned find_get_pages(unsigned long start,
 			    unsigned int nr_pages, struct page **pages)
 {
-	unsigned int i;
-	unsigned int ret;
-	unsigned int nr_found;
+	XA_STATE(xas, &mt_tree, start);
+	struct page *page;
+	unsigned int ret = 0;
 
 	rcu_read_lock();
-restart:
-	nr_found = radix_tree_gang_lookup_slot(&mt_tree,
-				(void ***)pages, NULL, start, nr_pages);
-	ret = 0;
-	for (i = 0; i < nr_found; i++) {
-		struct page *page;
-repeat:
-		page = radix_tree_deref_slot((void **)pages[i]);
-		if (unlikely(!page))
+	xas_for_each(&xas, page, ULONG_MAX) {
+		if (xas_retry(&xas, page))
 			continue;
 
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				/*
-				 * Transient condition which can only trigger
-				 * when entry at index 0 moves out of or back
-				 * to root: none yet gotten, safe to restart.
-				 */
-				assert((start | i) == 0);
-				goto restart;
-			}
-			/*
-			 * No exceptional entries are inserted in this test.
-			 */
-			assert(0);
-		}
-
 		pthread_mutex_lock(&page->lock);
-		if (!page->count) {
-			pthread_mutex_unlock(&page->lock);
-			goto repeat;
-		}
+		if (!page->count)
+			goto unlock;
+
 		/* don't actually update page refcount */
 		pthread_mutex_unlock(&page->lock);
 
 		/* Has the page moved? */
-		if (unlikely(page != *((void **)pages[i]))) {
-			goto repeat;
-		}
+		if (unlikely(page != xas_reload(&xas)))
+			goto put_page;
 
 		pages[ret] = page;
 		ret++;
+		continue;
+unlock:
+		pthread_mutex_unlock(&page->lock);
+put_page:
+		xas_reset(&xas);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -145,12 +125,12 @@ static void *regression1_fn(void *arg)
 		for (j = 0; j < 1000000; j++) {
 			struct page *p;
 
-			p = page_alloc();
+			p = page_alloc(0);
 			pthread_mutex_lock(&mt_lock);
 			radix_tree_insert(&mt_tree, 0, p);
 			pthread_mutex_unlock(&mt_lock);
 
-			p = page_alloc();
+			p = page_alloc(1);
 			pthread_mutex_lock(&mt_lock);
 			radix_tree_insert(&mt_tree, 1, p);
 			pthread_mutex_unlock(&mt_lock);
-- 
2.17.1

