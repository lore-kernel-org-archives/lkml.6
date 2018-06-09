Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Cg04BITIG1s3NwAAmS7hNA
	; Sat, 09 Jun 2018 12:31:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0A706089E; Sat,  9 Jun 2018 12:30:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56632607A4;
	Sat,  9 Jun 2018 12:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56632607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeFIMa5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:30:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753101AbeFIMay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:30:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9B844022407;
        Sat,  9 Jun 2018 12:30:53 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34B4C200BCEB;
        Sat,  9 Jun 2018 12:30:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 01/30] block: simplify bio_check_pages_dirty
Date: Sat,  9 Jun 2018 20:29:45 +0800
Message-Id: <20180609123014.8861-2-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 09 Jun 2018 12:30:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 09 Jun 2018 12:30:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

bio_check_pages_dirty currently inviolates the invariant that bv_page of
a bio_vec inside bi_vcnt shouldn't be zero, and that is going to become
really annoying with multpath biovecs.  Fortunately there isn't any
all that good reason for it - once we decide to defer freeing the bio
to a workqueue holding onto a few additional pages isn't really an
issue anymore.  So just check if there is a clean page that needs
dirtying in the first path, and do a second pass to free them if there
was none, while the cache is still hot.

Also use the chance to micro-optimize bio_dirty_fn a bit by not saving
irq state - we know we are called from a workqueue.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 56 +++++++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5f7563598b1c..3e7d117c3346 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1647,19 +1647,15 @@ static void bio_release_pages(struct bio *bio)
 	struct bio_vec *bvec;
 	int i;
 
-	bio_for_each_segment_all(bvec, bio, i) {
-		struct page *page = bvec->bv_page;
-
-		if (page)
-			put_page(page);
-	}
+	bio_for_each_segment_all(bvec, bio, i)
+		put_page(bvec->bv_page);
 }
 
 /*
  * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
  * If they are, then fine.  If, however, some pages are clean then they must
  * have been written out during the direct-IO read.  So we take another ref on
- * the BIO and the offending pages and re-dirty the pages in process context.
+ * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO from
  * here on.  It will run one put_page() against each page and will run one
@@ -1677,52 +1673,42 @@ static struct bio *bio_dirty_list;
  */
 static void bio_dirty_fn(struct work_struct *work)
 {
-	unsigned long flags;
-	struct bio *bio;
+	struct bio *bio, *next;
 
-	spin_lock_irqsave(&bio_dirty_lock, flags);
-	bio = bio_dirty_list;
+	spin_lock_irq(&bio_dirty_lock);
+	next = bio_dirty_list;
 	bio_dirty_list = NULL;
-	spin_unlock_irqrestore(&bio_dirty_lock, flags);
+	spin_unlock_irq(&bio_dirty_lock);
 
-	while (bio) {
-		struct bio *next = bio->bi_private;
+	while ((bio = next) != NULL) {
+		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
 		bio_release_pages(bio);
 		bio_put(bio);
-		bio = next;
 	}
 }
 
 void bio_check_pages_dirty(struct bio *bio)
 {
 	struct bio_vec *bvec;
-	int nr_clean_pages = 0;
+	unsigned long flags;
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, i) {
-		struct page *page = bvec->bv_page;
-
-		if (PageDirty(page) || PageCompound(page)) {
-			put_page(page);
-			bvec->bv_page = NULL;
-		} else {
-			nr_clean_pages++;
-		}
+		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+			goto defer;
 	}
 
-	if (nr_clean_pages) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&bio_dirty_lock, flags);
-		bio->bi_private = bio_dirty_list;
-		bio_dirty_list = bio;
-		spin_unlock_irqrestore(&bio_dirty_lock, flags);
-		schedule_work(&bio_dirty_work);
-	} else {
-		bio_put(bio);
-	}
+	bio_release_pages(bio);
+	bio_put(bio);
+	return;
+defer:
+	spin_lock_irqsave(&bio_dirty_lock, flags);
+	bio->bi_private = bio_dirty_list;
+	bio_dirty_list = bio;
+	spin_unlock_irqrestore(&bio_dirty_lock, flags);
+	schedule_work(&bio_dirty_work);
 }
 EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
-- 
2.9.5
