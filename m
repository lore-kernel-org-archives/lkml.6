Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aguYCfnIG1sCOwAAmS7hNA
	; Sat, 09 Jun 2018 12:33:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C399B607A4; Sat,  9 Jun 2018 12:33:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 474C5602FC;
	Sat,  9 Jun 2018 12:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 474C5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753521AbeFIMdl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:33:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753263AbeFIMdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:33:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 563C5BB42D;
        Sat,  9 Jun 2018 12:33:38 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B94D210C6D4;
        Sat,  9 Jun 2018 12:33:29 +0000 (UTC)
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
Subject: [PATCH V6 15/30] block: introduce bio_clone_chunk_bioset()
Date: Sat,  9 Jun 2018 20:29:59 +0800
Message-Id: <20180609123014.8861-16-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 09 Jun 2018 12:33:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 09 Jun 2018 12:33:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one use case(DM) which requires to clone bio chunk by
chunk, so introduce this API.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c         | 56 +++++++++++++++++++++++++++++++++++++++--------------
 include/linux/bio.h |  1 +
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index cb0f46e2752b..60219f82ddab 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -644,21 +644,13 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
-/**
- * 	bio_clone_bioset - clone a bio
- * 	@bio_src: bio to clone
- *	@gfp_mask: allocation priority
- *	@bs: bio_set to allocate from
- *
- *	Clone bio. Caller will own the returned bio, but not the actual data it
- *	points to. Reference count of returned bio will be one.
- */
-struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
-			     struct bio_set *bs)
+static struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
+				      struct bio_set *bs, bool seg)
 {
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	struct bio *bio;
+	int nr_vecs = seg ? bio_segments(bio_src) : bio_chunks(bio_src);
 
 	/*
 	 * Pre immutable biovecs, __bio_clone() used to just do a memcpy from
@@ -682,7 +674,7 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	 *    __bio_clone_fast() anyways.
 	 */
 
-	bio = bio_alloc_bioset(gfp_mask, bio_segments(bio_src), bs);
+	bio = bio_alloc_bioset(gfp_mask, nr_vecs, bs);
 	if (!bio)
 		return NULL;
 	bio->bi_disk		= bio_src->bi_disk;
@@ -700,8 +692,13 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
 		break;
 	default:
-		bio_for_each_segment(bv, bio_src, iter)
-			bio->bi_io_vec[bio->bi_vcnt++] = bv;
+		if (seg) {
+			bio_for_each_segment(bv, bio_src, iter)
+				bio->bi_io_vec[bio->bi_vcnt++] = bv;
+		} else {
+			bio_for_each_chunk(bv, bio_src, iter)
+				bio->bi_io_vec[bio->bi_vcnt++] = bv;
+		}
 		break;
 	}
 
@@ -719,9 +716,40 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 
 	return bio;
 }
+
+/**
+ * 	bio_clone_bioset - clone a bio
+ * 	@bio_src: bio to clone
+ *	@gfp_mask: allocation priority
+ *	@bs: bio_set to allocate from
+ *
+ *	Clone bio. Caller will own the returned bio, but not the actual data it
+ *	points to. Reference count of returned bio will be one.
+ */
+struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
+			     struct bio_set *bs)
+{
+	return __bio_clone_bioset(bio_src, gfp_mask, bs, true);
+}
 EXPORT_SYMBOL(bio_clone_bioset);
 
 /**
+ * 	bio_clone_seg_bioset - clone a bio segment by segment
+ * 	@bio_src: bio to clone
+ *	@gfp_mask: allocation priority
+ *	@bs: bio_set to allocate from
+ *
+ *	Clone bio. Caller will own the returned bio, but not the actual data it
+ *	points to. Reference count of returned bio will be one.
+ */
+struct bio *bio_clone_chunk_bioset(struct bio *bio_src, gfp_t gfp_mask,
+				   struct bio_set *bs)
+{
+	return __bio_clone_bioset(bio_src, gfp_mask, bs, false);
+}
+EXPORT_SYMBOL(bio_clone_chunk_bioset);
+
+/**
  *	bio_add_pc_page	-	attempt to add page to bio
  *	@q: the target queue
  *	@bio: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 13fd7bc30390..0fa1035dde38 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -483,6 +483,7 @@ extern void bio_put(struct bio *);
 extern void __bio_clone_fast(struct bio *, struct bio *);
 extern struct bio *bio_clone_fast(struct bio *, gfp_t, struct bio_set *);
 extern struct bio *bio_clone_bioset(struct bio *, gfp_t, struct bio_set *bs);
+extern struct bio *bio_clone_chunk_bioset(struct bio *, gfp_t, struct bio_set *bs);
 
 extern struct bio_set fs_bio_set;
 
-- 
2.9.5
