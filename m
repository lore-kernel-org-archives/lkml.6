Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9501C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CC721780
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2HFjPSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CC721780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404377AbeKLIXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404230AbeKLIXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:17 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34130223D8;
        Sun, 11 Nov 2018 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975599;
        bh=Tu0RLrj9JOdw6tYqu3uhTpWIUcYg7XFSpeUqOPIglvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2HFjPSI+dDT/QRDb1LpnQg6OZZMVVDeV9G3QmyWy6psy9HHBOs6uq8G/AJpBoDGx
         0uQuQY533RQ1bB03wc0RGYvYFSbHOVrO0UtvnbIGp08VWmwzS2KyHDPLLyZgdHjtiQ
         8fUedGlO6fB915crE2Ztd/N8BofkTbFjT0zPAwhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 175/222] dm zoned: fix various dmz_get_mblock() issues
Date:   Sun, 11 Nov 2018 14:24:32 -0800
Message-Id: <20181111221702.772484468@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit 3d4e738311327bc4ba1d55fbe2f1da3de4a475f9 upstream.

dmz_fetch_mblock() called from dmz_get_mblock() has a race since the
allocation of the new metadata block descriptor and its insertion in
the cache rbtree with the READING state is not atomic. Two different
contexts requesting the same block may end up each adding two different
descriptors of the same block to the cache.

Another problem for this function is that the BIO for processing the
block read is allocated after the metadata block descriptor is inserted
in the cache rbtree. If the BIO allocation fails, the metadata block
descriptor is freed without first being removed from the rbtree.

Fix the first problem by checking again if the requested block is not in
the cache right before inserting the newly allocated descriptor,
atomically under the mblk_lock spinlock. The second problem is fixed by
simply allocating the BIO before inserting the new block in the cache.

Finally, since dmz_fetch_mblock() also increments a block reference
counter, rename the function to dmz_get_mblock_slow(). To be symmetric
and clear, also rename dmz_lookup_mblock() to dmz_get_mblock_fast() and
increment the block reference counter directly in that function rather
than in dmz_get_mblock().

Fixes: 3b1a94c88b79 ("dm zoned: drive-managed zoned block device target")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-zoned-metadata.c |   66 ++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 24 deletions(-)

--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -339,10 +339,11 @@ static void dmz_insert_mblock(struct dmz
 }
 
 /*
- * Lookup a metadata block in the rbtree.
+ * Lookup a metadata block in the rbtree. If the block is found, increment
+ * its reference count.
  */
-static struct dmz_mblock *dmz_lookup_mblock(struct dmz_metadata *zmd,
-					    sector_t mblk_no)
+static struct dmz_mblock *dmz_get_mblock_fast(struct dmz_metadata *zmd,
+					      sector_t mblk_no)
 {
 	struct rb_root *root = &zmd->mblk_rbtree;
 	struct rb_node *node = root->rb_node;
@@ -350,8 +351,17 @@ static struct dmz_mblock *dmz_lookup_mbl
 
 	while (node) {
 		mblk = container_of(node, struct dmz_mblock, node);
-		if (mblk->no == mblk_no)
+		if (mblk->no == mblk_no) {
+			/*
+			 * If this is the first reference to the block,
+			 * remove it from the LRU list.
+			 */
+			mblk->ref++;
+			if (mblk->ref == 1 &&
+			    !test_bit(DMZ_META_DIRTY, &mblk->state))
+				list_del_init(&mblk->link);
 			return mblk;
+		}
 		node = (mblk->no < mblk_no) ? node->rb_left : node->rb_right;
 	}
 
@@ -382,32 +392,47 @@ static void dmz_mblock_bio_end_io(struct
 }
 
 /*
- * Read a metadata block from disk.
+ * Read an uncached metadata block from disk and add it to the cache.
  */
-static struct dmz_mblock *dmz_fetch_mblock(struct dmz_metadata *zmd,
-					   sector_t mblk_no)
+static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
+					      sector_t mblk_no)
 {
-	struct dmz_mblock *mblk;
+	struct dmz_mblock *mblk, *m;
 	sector_t block = zmd->sb[zmd->mblk_primary].block + mblk_no;
 	struct bio *bio;
 
-	/* Get block and insert it */
+	/* Get a new block and a BIO to read it */
 	mblk = dmz_alloc_mblock(zmd, mblk_no);
 	if (!mblk)
 		return NULL;
 
-	spin_lock(&zmd->mblk_lock);
-	mblk->ref++;
-	set_bit(DMZ_META_READING, &mblk->state);
-	dmz_insert_mblock(zmd, mblk);
-	spin_unlock(&zmd->mblk_lock);
-
 	bio = bio_alloc(GFP_NOIO, 1);
 	if (!bio) {
 		dmz_free_mblock(zmd, mblk);
 		return NULL;
 	}
 
+	spin_lock(&zmd->mblk_lock);
+
+	/*
+	 * Make sure that another context did not start reading
+	 * the block already.
+	 */
+	m = dmz_get_mblock_fast(zmd, mblk_no);
+	if (m) {
+		spin_unlock(&zmd->mblk_lock);
+		dmz_free_mblock(zmd, mblk);
+		bio_put(bio);
+		return m;
+	}
+
+	mblk->ref++;
+	set_bit(DMZ_META_READING, &mblk->state);
+	dmz_insert_mblock(zmd, mblk);
+
+	spin_unlock(&zmd->mblk_lock);
+
+	/* Submit read BIO */
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
 	bio_set_dev(bio, zmd->dev->bdev);
 	bio->bi_private = mblk;
@@ -509,19 +534,12 @@ static struct dmz_mblock *dmz_get_mblock
 
 	/* Check rbtree */
 	spin_lock(&zmd->mblk_lock);
-	mblk = dmz_lookup_mblock(zmd, mblk_no);
-	if (mblk) {
-		/* Cache hit: remove block from LRU list */
-		mblk->ref++;
-		if (mblk->ref == 1 &&
-		    !test_bit(DMZ_META_DIRTY, &mblk->state))
-			list_del_init(&mblk->link);
-	}
+	mblk = dmz_get_mblock_fast(zmd, mblk_no);
 	spin_unlock(&zmd->mblk_lock);
 
 	if (!mblk) {
 		/* Cache miss: read the block from disk */
-		mblk = dmz_fetch_mblock(zmd, mblk_no);
+		mblk = dmz_get_mblock_slow(zmd, mblk_no);
 		if (!mblk)
 			return ERR_PTR(-ENOMEM);
 	}


