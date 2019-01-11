Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3205BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE15E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217210;
	bh=mDNOadCWfP7e+pNl5Djfj4yeC05OAuFb+ThgN1A+38s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uogXB11dbpl9hfSAhJ8lFgmPHGt04qB2XxL1+Vaot1BQl0e1bL+Wbw620Mn2fwt4Y
	 9V7GkKJS66sJ5HWBpCT1UnfWfja32kxYm891WCR+V9BBwjQrsJJe3Bx4vrxwMEid0Y
	 t/96hypsC4p7EHW0mt6w07YiS0+iCfp+v6ol0fv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbfAKOd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389604AbfAKOdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D4C204EC;
        Fri, 11 Jan 2019 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217200;
        bh=mDNOadCWfP7e+pNl5Djfj4yeC05OAuFb+ThgN1A+38s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/wXMnhyQ2AY4ZNRM+QmFQaG3yNTagvMXuKf5/OOl8ctE1aGQsT5iF6nwHaREZjlD
         i6ZBBIPljLLFuecvEEYr/9N4tc6MCTc+bx79TyVwfhQKlnNJEN+Dyo2bW066nseSk6
         X7L3lDj9XMW0J+gUT6fddyP6xYuu7jCGfcqaCG2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 080/105] dm zoned: Fix target BIO completion handling
Date:   Fri, 11 Jan 2019 15:14:51 +0100
Message-Id: <20190111131109.710499521@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit d57f9da890696af1484f4a47f7f123560197865a upstream.

struct bioctx includes the ref refcount_t to track the number of I/O
fragments used to process a target BIO as well as ensure that the zone
of the BIO is kept in the active state throughout the lifetime of the
BIO. However, since decrementing of this reference count is done in the
target .end_io method, the function bio_endio() must be called multiple
times for read and write target BIOs, which causes problems with the
value of the __bi_remaining struct bio field for chained BIOs (e.g. the
clone BIO passed by dm core is large and splits into fragments by the
block layer), resulting in incorrect values and inconsistencies with the
BIO_CHAIN flag setting. This is turn triggers the BUG_ON() call:

BUG_ON(atomic_read(&bio->__bi_remaining) <= 0);

in bio_remaining_done() called from bio_endio().

Fix this ensuring that bio_endio() is called only once for any target
BIO by always using internal clone BIOs for processing any read or
write target BIO. This allows reference counting using the target BIO
context counter to trigger the target BIO completion bio_endio() call
once all data, metadata and other zone work triggered by the BIO
complete.

Overall, this simplifies the code too as the target .end_io becomes
unnecessary and differences between read and write BIO issuing and
completion processing disappear.

Fixes: 3b1a94c88b79 ("dm zoned: drive-managed zoned block device target")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-zoned-target.c |  122 +++++++++++++------------------------------
 1 file changed, 38 insertions(+), 84 deletions(-)

--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -20,7 +20,6 @@ struct dmz_bioctx {
 	struct dm_zone		*zone;
 	struct bio		*bio;
 	atomic_t		ref;
-	blk_status_t		status;
 };
 
 /*
@@ -78,65 +77,66 @@ static inline void dmz_bio_endio(struct
 {
 	struct dmz_bioctx *bioctx = dm_per_bio_data(bio, sizeof(struct dmz_bioctx));
 
-	if (bioctx->status == BLK_STS_OK && status != BLK_STS_OK)
-		bioctx->status = status;
-	bio_endio(bio);
+	if (status != BLK_STS_OK && bio->bi_status == BLK_STS_OK)
+		bio->bi_status = status;
+
+	if (atomic_dec_and_test(&bioctx->ref)) {
+		struct dm_zone *zone = bioctx->zone;
+
+		if (zone) {
+			if (bio->bi_status != BLK_STS_OK &&
+			    bio_op(bio) == REQ_OP_WRITE &&
+			    dmz_is_seq(zone))
+				set_bit(DMZ_SEQ_WRITE_ERR, &zone->flags);
+			dmz_deactivate_zone(zone);
+		}
+		bio_endio(bio);
+	}
 }
 
 /*
- * Partial clone read BIO completion callback. This terminates the
+ * Completion callback for an internally cloned target BIO. This terminates the
  * target BIO when there are no more references to its context.
  */
-static void dmz_read_bio_end_io(struct bio *bio)
+static void dmz_clone_endio(struct bio *clone)
 {
-	struct dmz_bioctx *bioctx = bio->bi_private;
-	blk_status_t status = bio->bi_status;
+	struct dmz_bioctx *bioctx = clone->bi_private;
+	blk_status_t status = clone->bi_status;
 
-	bio_put(bio);
+	bio_put(clone);
 	dmz_bio_endio(bioctx->bio, status);
 }
 
 /*
- * Issue a BIO to a zone. The BIO may only partially process the
+ * Issue a clone of a target BIO. The clone may only partially process the
  * original target BIO.
  */
-static int dmz_submit_read_bio(struct dmz_target *dmz, struct dm_zone *zone,
-			       struct bio *bio, sector_t chunk_block,
-			       unsigned int nr_blocks)
+static int dmz_submit_bio(struct dmz_target *dmz, struct dm_zone *zone,
+			  struct bio *bio, sector_t chunk_block,
+			  unsigned int nr_blocks)
 {
 	struct dmz_bioctx *bioctx = dm_per_bio_data(bio, sizeof(struct dmz_bioctx));
-	sector_t sector;
 	struct bio *clone;
 
-	/* BIO remap sector */
-	sector = dmz_start_sect(dmz->metadata, zone) + dmz_blk2sect(chunk_block);
-
-	/* If the read is not partial, there is no need to clone the BIO */
-	if (nr_blocks == dmz_bio_blocks(bio)) {
-		/* Setup and submit the BIO */
-		bio->bi_iter.bi_sector = sector;
-		atomic_inc(&bioctx->ref);
-		generic_make_request(bio);
-		return 0;
-	}
-
-	/* Partial BIO: we need to clone the BIO */
 	clone = bio_clone_fast(bio, GFP_NOIO, dmz->bio_set);
 	if (!clone)
 		return -ENOMEM;
 
-	/* Setup the clone */
-	clone->bi_iter.bi_sector = sector;
+	bio_set_dev(clone, dmz->dev->bdev);
+	clone->bi_iter.bi_sector =
+		dmz_start_sect(dmz->metadata, zone) + dmz_blk2sect(chunk_block);
 	clone->bi_iter.bi_size = dmz_blk2sect(nr_blocks) << SECTOR_SHIFT;
-	clone->bi_end_io = dmz_read_bio_end_io;
+	clone->bi_end_io = dmz_clone_endio;
 	clone->bi_private = bioctx;
 
 	bio_advance(bio, clone->bi_iter.bi_size);
 
-	/* Submit the clone */
 	atomic_inc(&bioctx->ref);
 	generic_make_request(clone);
 
+	if (bio_op(bio) == REQ_OP_WRITE && dmz_is_seq(zone))
+		zone->wp_block += nr_blocks;
+
 	return 0;
 }
 
@@ -214,7 +214,7 @@ static int dmz_handle_read(struct dmz_ta
 		if (nr_blocks) {
 			/* Valid blocks found: read them */
 			nr_blocks = min_t(unsigned int, nr_blocks, end_block - chunk_block);
-			ret = dmz_submit_read_bio(dmz, rzone, bio, chunk_block, nr_blocks);
+			ret = dmz_submit_bio(dmz, rzone, bio, chunk_block, nr_blocks);
 			if (ret)
 				return ret;
 			chunk_block += nr_blocks;
@@ -229,25 +229,6 @@ static int dmz_handle_read(struct dmz_ta
 }
 
 /*
- * Issue a write BIO to a zone.
- */
-static void dmz_submit_write_bio(struct dmz_target *dmz, struct dm_zone *zone,
-				 struct bio *bio, sector_t chunk_block,
-				 unsigned int nr_blocks)
-{
-	struct dmz_bioctx *bioctx = dm_per_bio_data(bio, sizeof(struct dmz_bioctx));
-
-	/* Setup and submit the BIO */
-	bio_set_dev(bio, dmz->dev->bdev);
-	bio->bi_iter.bi_sector = dmz_start_sect(dmz->metadata, zone) + dmz_blk2sect(chunk_block);
-	atomic_inc(&bioctx->ref);
-	generic_make_request(bio);
-
-	if (dmz_is_seq(zone))
-		zone->wp_block += nr_blocks;
-}
-
-/*
  * Write blocks directly in a data zone, at the write pointer.
  * If a buffer zone is assigned, invalidate the blocks written
  * in place.
@@ -265,7 +246,9 @@ static int dmz_handle_direct_write(struc
 		return -EROFS;
 
 	/* Submit write */
-	dmz_submit_write_bio(dmz, zone, bio, chunk_block, nr_blocks);
+	ret = dmz_submit_bio(dmz, zone, bio, chunk_block, nr_blocks);
+	if (ret)
+		return ret;
 
 	/*
 	 * Validate the blocks in the data zone and invalidate
@@ -301,7 +284,9 @@ static int dmz_handle_buffered_write(str
 		return -EROFS;
 
 	/* Submit write */
-	dmz_submit_write_bio(dmz, bzone, bio, chunk_block, nr_blocks);
+	ret = dmz_submit_bio(dmz, bzone, bio, chunk_block, nr_blocks);
+	if (ret)
+		return ret;
 
 	/*
 	 * Validate the blocks in the buffer zone
@@ -600,7 +585,6 @@ static int dmz_map(struct dm_target *ti,
 	bioctx->zone = NULL;
 	bioctx->bio = bio;
 	atomic_set(&bioctx->ref, 1);
-	bioctx->status = BLK_STS_OK;
 
 	/* Set the BIO pending in the flush list */
 	if (!nr_sectors && bio_op(bio) == REQ_OP_WRITE) {
@@ -624,35 +608,6 @@ static int dmz_map(struct dm_target *ti,
 }
 
 /*
- * Completed target BIO processing.
- */
-static int dmz_end_io(struct dm_target *ti, struct bio *bio, blk_status_t *error)
-{
-	struct dmz_bioctx *bioctx = dm_per_bio_data(bio, sizeof(struct dmz_bioctx));
-
-	if (bioctx->status == BLK_STS_OK && *error)
-		bioctx->status = *error;
-
-	if (!atomic_dec_and_test(&bioctx->ref))
-		return DM_ENDIO_INCOMPLETE;
-
-	/* Done */
-	bio->bi_status = bioctx->status;
-
-	if (bioctx->zone) {
-		struct dm_zone *zone = bioctx->zone;
-
-		if (*error && bio_op(bio) == REQ_OP_WRITE) {
-			if (dmz_is_seq(zone))
-				set_bit(DMZ_SEQ_WRITE_ERR, &zone->flags);
-		}
-		dmz_deactivate_zone(zone);
-	}
-
-	return DM_ENDIO_DONE;
-}
-
-/*
  * Get zoned device information.
  */
 static int dmz_get_zoned_device(struct dm_target *ti, char *path)
@@ -946,7 +901,6 @@ static struct target_type dmz_type = {
 	.ctr		 = dmz_ctr,
 	.dtr		 = dmz_dtr,
 	.map		 = dmz_map,
-	.end_io		 = dmz_end_io,
 	.io_hints	 = dmz_io_hints,
 	.prepare_ioctl	 = dmz_prepare_ioctl,
 	.postsuspend	 = dmz_suspend,


