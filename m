Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7DD23C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284FD208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QYhceELy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284FD208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935827AbeFMO5M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:57:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935656AbeFMO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Emy3uXuN0Z1AgRSb7jkmiCl7ZhJK0o2+RUDx+bn8hJU=; b=QYhceELyHdCQfWggBnrFz+BKO
        zoguPujAJrzhZJHveaE/mjKq77jIcF/2IENvMFCPuNSaIPknkNc7Q6B615eHEaYb42l1MhZYAEQlz
        Zp5dh4tQVwRAxRVlIbEGUiFhM5RrPaym8LuOMs8K6lUg2bEM/LSZVvvtQys2N4cSBbu/3NpmCYERF
        BspX8hn3tj0EN54Qcg8Xee1YLvZpSUkh6c8a4+Mq5FH7OiStZe25TQlDAa5wtq/CUpFbhWp+svK30
        DO0e7sXOxl8OfF/j4Gi0Xe84S3dYTMFrPNJB9eg9sBAXhbJDw21Mw9PjI9u+DeszCRGcfb9oearPa
        Bdjl4gjGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT7Cg-0004gr-IN; Wed, 13 Jun 2018 14:56:54 +0000
Date:   Wed, 13 Jun 2018 07:56:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 15/30] block: introduce bio_clone_chunk_bioset()
Message-ID: <20180613145654.GE4693@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-16-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609123014.8861-16-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 08:29:59PM +0800, Ming Lei wrote:
> There is one use case(DM) which requires to clone bio chunk by
> chunk, so introduce this API.

I don't think DM is the special case here.  The special case is the
bounce code that only wants single page bios.  Between that, and the
fact that we only have two callers and one of them is inside the
block layer I would suggest to fold in the following patch to make
bio_clone_bioset clone in multi-page bvecs and make the bounce code
use the low-level interface directly:

diff --git a/block/bio.c b/block/bio.c
index 284085ab97e7..cef45c8d0a19 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -644,13 +644,14 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
-static struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
-				      struct bio_set *bs, bool seg)
+struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
+		struct bio_set *bs, bool single_page_only)
 {
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	struct bio *bio;
-	int nr_vecs = seg ? bio_segments(bio_src) : bio_chunks(bio_src);
+	int nr_vecs = single_page_only ?
+		bio_segments(bio_src) : bio_chunks(bio_src);
 
 	/*
 	 * Pre immutable biovecs, __bio_clone() used to just do a memcpy from
@@ -692,7 +693,7 @@ static struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
 		break;
 	default:
-		if (seg) {
+		if (single_page_only) {
 			bio_for_each_segment(bv, bio_src, iter)
 				bio->bi_io_vec[bio->bi_vcnt++] = bv;
 		} else {
@@ -728,26 +729,10 @@ static struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
  */
 struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 			     struct bio_set *bs)
-{
-	return __bio_clone_bioset(bio_src, gfp_mask, bs, true);
-}
-EXPORT_SYMBOL(bio_clone_bioset);
-
-/**
- * 	bio_clone_seg_bioset - clone a bio segment by segment
- * 	@bio_src: bio to clone
- *	@gfp_mask: allocation priority
- *	@bs: bio_set to allocate from
- *
- *	Clone bio. Caller will own the returned bio, but not the actual data it
- *	points to. Reference count of returned bio will be one.
- */
-struct bio *bio_clone_chunk_bioset(struct bio *bio_src, gfp_t gfp_mask,
-				   struct bio_set *bs)
 {
 	return __bio_clone_bioset(bio_src, gfp_mask, bs, false);
 }
-EXPORT_SYMBOL(bio_clone_chunk_bioset);
+EXPORT_SYMBOL(bio_clone_bioset);
 
 /**
  *	bio_add_pc_page	-	attempt to add page to bio
diff --git a/block/bounce.c b/block/bounce.c
index c6af0bd29ec9..62dab528dc1b 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -224,8 +224,8 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 		generic_make_request(*bio_orig);
 		*bio_orig = bio;
 	}
-	bio = bio_clone_bioset(*bio_orig, GFP_NOIO, passthrough ? NULL :
-			&bounce_bio_set);
+	bio = __bio_clone_bioset(*bio_orig, GFP_NOIO, passthrough ? NULL :
+			&bounce_bio_set, true);
 
 	bio_for_each_chunk_segment_all(to, bio, i, citer) {
 		struct page *page = to->bv_page;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 13ca3574d972..98dff36b89a3 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1582,8 +1582,8 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 				 * the usage of io->orig_bio in dm_remap_zone_report()
 				 * won't be affected by this reassignment.
 				 */
-				struct bio *b = bio_clone_chunk_bioset(bio, GFP_NOIO,
-								       &md->queue->bio_split);
+				struct bio *b = bio_clone_bioset(bio, GFP_NOIO,
+								 &md->queue->bio_split);
 				ci.io->orig_bio = b;
 				bio_advance(bio, (bio_sectors(bio) - ci.sector_count) << 9);
 				bio_chain(b, bio);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 58838dc12d69..5ccafeadbe95 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -486,7 +486,8 @@ extern void bio_put(struct bio *);
 extern void __bio_clone_fast(struct bio *, struct bio *);
 extern struct bio *bio_clone_fast(struct bio *, gfp_t, struct bio_set *);
 extern struct bio *bio_clone_bioset(struct bio *, gfp_t, struct bio_set *bs);
-extern struct bio *bio_clone_chunk_bioset(struct bio *, gfp_t, struct bio_set *bs);
+extern struct bio *__bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
+		struct bio_set *bs, bool single_page_only);
 
 extern struct bio_set fs_bio_set;
 
