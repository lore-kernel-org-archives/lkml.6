Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id stMSAkvJG1tHPQAAmS7hNA
	; Sat, 09 Jun 2018 12:34:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EB730607BB; Sat,  9 Jun 2018 12:34:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 50A146032D;
	Sat,  9 Jun 2018 12:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50A146032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753546AbeFIMeP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:34:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753248AbeFIMeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2536B401EF22;
        Sat,  9 Jun 2018 12:34:12 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36DE01116709;
        Sat,  9 Jun 2018 12:34:02 +0000 (UTC)
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
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 18/30] block: convert to bio_for_each_chunk_segment_all()
Date: Sat,  9 Jun 2018 20:30:02 +0800
Message-Id: <20180609123014.8861-19-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 09 Jun 2018 12:34:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 09 Jun 2018 12:34:12 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have to convert to bio_for_each_chunk_segment_all() for iterating page by
page.

bio_for_each_segment_all() can't be used any more after multipage bvec is
enabled.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c         | 27 ++++++++++++++++++---------
 block/blk-zoned.c   |  5 +++--
 block/bounce.c      |  6 ++++--
 include/linux/bio.h |  3 ++-
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 60219f82ddab..276fc35ec559 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1146,8 +1146,9 @@ static int bio_copy_from_iter(struct bio *bio, struct iov_iter *iter)
 {
 	int i;
 	struct bio_vec *bvec;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		ssize_t ret;
 
 		ret = copy_page_from_iter(bvec->bv_page,
@@ -1177,8 +1178,9 @@ static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
 {
 	int i;
 	struct bio_vec *bvec;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		ssize_t ret;
 
 		ret = copy_page_to_iter(bvec->bv_page,
@@ -1200,8 +1202,9 @@ void bio_free_pages(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i)
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer)
 		__free_page(bvec->bv_page);
 }
 EXPORT_SYMBOL(bio_free_pages);
@@ -1367,6 +1370,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	struct bio *bio;
 	int ret;
 	struct bio_vec *bvec;
+	struct bvec_chunk_iter citer;
 
 	if (!iov_iter_count(iter))
 		return ERR_PTR(-EINVAL);
@@ -1440,7 +1444,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	return bio;
 
  out_unmap:
-	bio_for_each_segment_all(bvec, bio, j) {
+	bio_for_each_chunk_segment_all(bvec, bio, j, citer) {
 		put_page(bvec->bv_page);
 	}
 	bio_put(bio);
@@ -1451,11 +1455,12 @@ static void __bio_unmap_user(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
 	/*
 	 * make sure we dirty pages we wrote to
 	 */
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		if (bio_data_dir(bio) == READ)
 			set_page_dirty_lock(bvec->bv_page);
 
@@ -1547,8 +1552,9 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 	char *p = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
 		p += bvec->bv_len;
 	}
@@ -1657,8 +1663,9 @@ void bio_set_pages_dirty(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		if (!PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
 	}
@@ -1669,8 +1676,9 @@ static void bio_release_pages(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i)
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer)
 		put_page(bvec->bv_page);
 }
 
@@ -1717,8 +1725,9 @@ void bio_check_pages_dirty(struct bio *bio)
 	struct bio_vec *bvec;
 	unsigned long flags;
 	int i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
 			goto defer;
 	}
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3d08dc84db16..9223666c845d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -123,6 +123,7 @@ int blkdev_report_zones(struct block_device *bdev,
 	unsigned int ofst;
 	void *addr;
 	int ret;
+	struct bvec_chunk_iter citer;
 
 	if (!q)
 		return -ENXIO;
@@ -190,7 +191,7 @@ int blkdev_report_zones(struct block_device *bdev,
 	n = 0;
 	nz = 0;
 	nr_rep = 0;
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_chunk_segment_all(bv, bio, i, citer) {
 
 		if (!bv->bv_page)
 			break;
@@ -223,7 +224,7 @@ int blkdev_report_zones(struct block_device *bdev,
 
 	*nr_zones = nz;
 out:
-	bio_for_each_segment_all(bv, bio, i)
+	bio_for_each_chunk_segment_all(bv, bio, i, citer)
 		__free_page(bv->bv_page);
 	bio_put(bio);
 
diff --git a/block/bounce.c b/block/bounce.c
index fd31347b7836..c6af0bd29ec9 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -146,11 +146,12 @@ static void bounce_end_io(struct bio *bio, mempool_t *pool)
 	struct bio_vec *bvec, orig_vec;
 	int i;
 	struct bvec_iter orig_iter = bio_orig->bi_iter;
+	struct bvec_chunk_iter citer;
 
 	/*
 	 * free up bounce indirect pages used
 	 */
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_chunk_segment_all(bvec, bio, i, citer) {
 		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
 		if (bvec->bv_page != orig_vec.bv_page) {
 			dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
@@ -206,6 +207,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	bool bounce = false;
 	int sectors = 0;
 	bool passthrough = bio_is_passthrough(*bio_orig);
+	struct bvec_chunk_iter citer;
 
 	bio_for_each_segment(from, *bio_orig, iter) {
 		if (i++ < BIO_MAX_PAGES)
@@ -225,7 +227,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	bio = bio_clone_bioset(*bio_orig, GFP_NOIO, passthrough ? NULL :
 			&bounce_bio_set);
 
-	bio_for_each_segment_all(to, bio, i) {
+	bio_for_each_chunk_segment_all(to, bio, i, citer) {
 		struct page *page = to->bv_page;
 
 		if (page_to_pfn(page) <= q->limits.bounce_pfn)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f21384be9b51..c22b8be961ce 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -374,10 +374,11 @@ static inline unsigned bio_pages_all(struct bio *bio)
 {
 	unsigned i;
 	struct bio_vec *bv;
+	struct bvec_chunk_iter citer;
 
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 
-	bio_for_each_segment_all(bv, bio, i)
+	bio_for_each_chunk_segment_all(bv, bio, i, citer)
 		;
 	return i;
 }
-- 
2.9.5
