Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91994C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4820426059
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4820426059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934489AbeF0MsX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:48:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965129AbeF0MsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:48:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B28D8182D2E;
        Wed, 27 Jun 2018 12:48:20 +0000 (UTC)
Received: from localhost (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8175F2156888;
        Wed, 27 Jun 2018 12:48:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 12/24] block: use bio_for_each_bvec() to compute multipage bvec count
Date:   Wed, 27 Jun 2018 20:45:36 +0800
Message-Id: <20180627124548.3456-13-ming.lei@redhat.com>
In-Reply-To: <20180627124548.3456-1-ming.lei@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 27 Jun 2018 12:48:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 27 Jun 2018 12:48:20 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly it is more efficient to use bio_for_each_bvec() in both
blk_bio_segment_split() and __blk_recalc_rq_segments() to compute how many
multipage bvecs there are in the bio.

Secondaly once bio_for_each_bvec() is used, the bvec may need to
be splitted because its length can be very longer than max segment size,
so we have to split the big bvec into several segments.

Thirdly during splitting multipage bvec into segments, max segment number
may be reached, then the bio need to be splitted when this happens.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 14 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index aaec38cc37b8..bf1dceb9656a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -97,6 +97,62 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 	return sectors;
 }
 
+/*
+ * Split the bvec @bv into segments, and update all kinds of
+ * variables.
+ */
+static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
+		unsigned *nsegs, unsigned *last_seg_size,
+		unsigned *front_seg_size, unsigned *sectors)
+{
+	bool need_split = false;
+	unsigned len = bv->bv_len;
+	unsigned total_len = 0;
+	unsigned new_nsegs = 0, seg_size = 0;
+
+	if ((*nsegs >= queue_max_segments(q)) || !len)
+		return need_split;
+
+	/*
+	 * Multipage bvec may be too big to hold in one segment,
+	 * so the current bvec has to be splitted as multiple
+	 * segments.
+	 */
+	while (new_nsegs + *nsegs < queue_max_segments(q)) {
+		seg_size = min(queue_max_segment_size(q), len);
+
+		new_nsegs++;
+		total_len += seg_size;
+		len -= seg_size;
+
+		if ((queue_virt_boundary(q) && ((bv->bv_offset +
+		    total_len) & queue_virt_boundary(q))) || !len)
+			break;
+	}
+
+	/* split in the middle of the bvec */
+	if (len)
+		need_split = true;
+
+	/* update front segment size */
+	if (!*nsegs) {
+		unsigned first_seg_size = seg_size;
+
+		if (new_nsegs > 1)
+			first_seg_size = queue_max_segment_size(q);
+		if (*front_seg_size < first_seg_size)
+			*front_seg_size = first_seg_size;
+	}
+
+	/* update other varibles */
+	*last_seg_size = seg_size;
+	*nsegs += new_nsegs;
+	if (sectors)
+		*sectors += total_len >> 9;
+
+	return need_split;
+}
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
@@ -110,7 +166,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	struct bio *new = NULL;
 	const unsigned max_sectors = get_max_io_size(q, bio);
 
-	bio_for_each_segment(bv, bio, iter) {
+	bio_for_each_bvec(bv, bio, iter) {
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
@@ -125,8 +181,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			 */
 			if (nsegs < queue_max_segments(q) &&
 			    sectors < max_sectors) {
-				nsegs++;
-				sectors = max_sectors;
+				/* split in the middle of bvec */
+				bv.bv_len = (max_sectors - sectors) << 9;
+				bvec_split_segs(q, &bv, &nsegs,
+						&seg_size,
+						&front_seg_size,
+						&sectors);
 			}
 			goto split;
 		}
@@ -153,11 +213,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		if (nsegs == 1 && seg_size > front_seg_size)
 			front_seg_size = seg_size;
 
-		nsegs++;
 		bvprv = bv;
 		bvprvp = &bvprv;
-		seg_size = bv.bv_len;
-		sectors += bv.bv_len >> 9;
+
+		if (bvec_split_segs(q, &bv, &nsegs, &seg_size,
+					&front_seg_size, &sectors))
+			goto split;
 
 	}
 
@@ -235,6 +296,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	struct bio_vec bv, bvprv = { NULL };
 	int cluster, prev = 0;
 	unsigned int seg_size, nr_phys_segs;
+	unsigned front_seg_size = bio->bi_seg_front_size;
 	struct bio *fbio, *bbio;
 	struct bvec_iter iter;
 
@@ -255,7 +317,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	seg_size = 0;
 	nr_phys_segs = 0;
 	for_each_bio(bio) {
-		bio_for_each_segment(bv, bio, iter) {
+		bio_for_each_bvec(bv, bio, iter) {
 			/*
 			 * If SG merging is disabled, each bio vector is
 			 * a segment
@@ -277,20 +339,20 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 				continue;
 			}
 new_segment:
-			if (nr_phys_segs == 1 && seg_size >
-			    fbio->bi_seg_front_size)
-				fbio->bi_seg_front_size = seg_size;
+			if (nr_phys_segs == 1 && seg_size > front_seg_size)
+				front_seg_size = seg_size;
 
-			nr_phys_segs++;
 			bvprv = bv;
 			prev = 1;
-			seg_size = bv.bv_len;
+			bvec_split_segs(q, &bv, &nr_phys_segs, &seg_size,
+					&front_seg_size, NULL);
 		}
 		bbio = bio;
 	}
 
-	if (nr_phys_segs == 1 && seg_size > fbio->bi_seg_front_size)
-		fbio->bi_seg_front_size = seg_size;
+	if (nr_phys_segs == 1 && seg_size > front_seg_size)
+		front_seg_size = seg_size;
+	fbio->bi_seg_front_size = front_seg_size;
 	if (seg_size > bbio->bi_seg_back_size)
 		bbio->bi_seg_back_size = seg_size;
 
-- 
2.9.5

