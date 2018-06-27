Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FD6C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C79C26059
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C79C26059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965267AbeF0MsM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:48:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965129AbeF0MsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:48:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 245B670206;
        Wed, 27 Jun 2018 12:48:09 +0000 (UTC)
Received: from localhost (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E121D1C5B9;
        Wed, 27 Jun 2018 12:48:00 +0000 (UTC)
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
Subject: [PATCH V7 11/24] block: introduce bio_for_each_bvec()
Date:   Wed, 27 Jun 2018 20:45:35 +0800
Message-Id: <20180627124548.3456-12-ming.lei@redhat.com>
In-Reply-To: <20180627124548.3456-1-ming.lei@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 12:48:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 12:48:09 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is used for iterating over multipage bvec for bio
splitting/merge,

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h  | 34 +++++++++++++++++++++++++++++++---
 include/linux/bvec.h | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 21d07858ddef..551444bd9795 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -80,6 +80,9 @@
 #define bio_data_dir(bio) \
 	(op_is_write(bio_op(bio)) ? WRITE : READ)
 
+#define bio_iter_mp_iovec(bio, iter)				\
+	mp_bvec_iter_bvec((bio)->bi_io_vec, (iter))
+
 /*
  * Check whether this bio carries any data or not. A NULL bio is allowed.
  */
@@ -165,8 +168,8 @@ static inline bool bio_full(struct bio *bio)
 #define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
-static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
-				    unsigned bytes)
+static inline void __bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
+				      unsigned bytes, bool mp)
 {
 	iter->bi_sector += bytes >> 9;
 
@@ -174,11 +177,26 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 		iter->bi_size -= bytes;
 		iter->bi_done += bytes;
 	} else {
-		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+		if (!mp)
+			bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+		else
+			mp_bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
 	}
 }
 
+static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
+				    unsigned bytes)
+{
+	__bio_advance_iter(bio, iter, bytes, false);
+}
+
+static inline void bio_advance_mp_iter(struct bio *bio, struct bvec_iter *iter,
+				       unsigned bytes)
+{
+	__bio_advance_iter(bio, iter, bytes, true);
+}
+
 static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
 		unsigned int bytes)
 {
@@ -202,6 +220,16 @@ static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
+#define __bio_for_each_bvec(bvl, bio, iter, start)		\
+	for (iter = (start);						\
+	     (iter).bi_size &&						\
+		((bvl = bio_iter_mp_iovec((bio), (iter))), 1);	\
+	     bio_advance_mp_iter((bio), &(iter), (bvl).bv_len))
+
+/* returns one real segment(multipage bvec) each time */
+#define bio_for_each_bvec(bvl, bio, iter)			\
+	__bio_for_each_bvec(bvl, bio, iter, (bio)->bi_iter)
+
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
 static inline unsigned bio_segments(struct bio *bio)
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 03a12fbb90d8..417d44cf1e82 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -126,8 +126,16 @@ struct bvec_iter {
 	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
 })
 
-static inline bool bvec_iter_advance(const struct bio_vec *bv,
-		struct bvec_iter *iter, unsigned bytes)
+#define mp_bvec_iter_bvec(bvec, iter)				\
+((struct bio_vec) {							\
+	.bv_page	= mp_bvec_iter_page((bvec), (iter)),	\
+	.bv_len		= mp_bvec_iter_len((bvec), (iter)),	\
+	.bv_offset	= mp_bvec_iter_offset((bvec), (iter)),	\
+})
+
+static inline bool __bvec_iter_advance(const struct bio_vec *bv,
+				       struct bvec_iter *iter,
+				       unsigned bytes, bool mp)
 {
 	if (WARN_ONCE(bytes > iter->bi_size,
 		     "Attempted to advance past end of bvec iter\n")) {
@@ -136,8 +144,14 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	}
 
 	while (bytes) {
-		unsigned iter_len = bvec_iter_len(bv, *iter);
-		unsigned len = min(bytes, iter_len);
+		unsigned len;
+
+		if (mp)
+			len = mp_bvec_iter_len(bv, *iter);
+		else
+			len = bvec_iter_len(bv, *iter);
+
+		len = min(bytes, len);
 
 		bytes -= len;
 		iter->bi_size -= len;
@@ -176,6 +190,20 @@ static inline bool bvec_iter_rewind(const struct bio_vec *bv,
 	return true;
 }
 
+static inline bool bvec_iter_advance(const struct bio_vec *bv,
+				     struct bvec_iter *iter,
+				     unsigned bytes)
+{
+	return __bvec_iter_advance(bv, iter, bytes, false);
+}
+
+static inline bool mp_bvec_iter_advance(const struct bio_vec *bv,
+					struct bvec_iter *iter,
+					unsigned bytes)
+{
+	return __bvec_iter_advance(bv, iter, bytes, true);
+}
+
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
-- 
2.9.5

