Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pNl4O+byG1vpXwAAmS7hNA
	; Sat, 09 Jun 2018 15:34:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 15E45608C1; Sat,  9 Jun 2018 15:34:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoYvma/U"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6F7BD606FA;
	Sat,  9 Jun 2018 15:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F7BD606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbeFIPee (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753767AbeFIPeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:34:31 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8552A208A4;
        Sat,  9 Jun 2018 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558471;
        bh=oX1CxPfIF3THFsBTNaktBwtV1nF4wxN+vioCU2xQ2QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PoYvma/Ukt9vFkniL5LBMjFCHPRE6b80JdDkwvAaL/zALjhh+/kIWMrikkS6gfXvx
         ElOtUeNjwFH5/mTvzhAeMgA9wYI4W8jvJgQ2C4eeRJgouldzxdu/XQjA0/Ug5AGguo
         esQy+uEj5dQdX28srNBQf1bmfiMC7B21nCNsNsHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 02/41] scsi: sd_zbc: Avoid that resetting a zone fails sporadically
Date: Sat,  9 Jun 2018 17:29:34 +0200
Message-Id: <20180609152926.534377413@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit ccce20fc7968d546fb1e8e147bf5cdc8afc4278a upstream.

Since SCSI scanning occurs asynchronously, since sd_revalidate_disk() is
called from sd_probe_async() and since sd_revalidate_disk() calls
sd_zbc_read_zones() it can happen that sd_zbc_read_zones() is called
concurrently with blkdev_report_zones() and/or blkdev_reset_zones().  That can
cause these functions to fail with -EIO because sd_zbc_read_zones() e.g. sets
q->nr_zones to zero before restoring it to the actual value, even if no drive
characteristics have changed.  Avoid that this can happen by making the
following changes:

- Protect the code that updates zone information with blk_queue_enter()
  and blk_queue_exit().
- Modify sd_zbc_setup_seq_zones_bitmap() and sd_zbc_setup() such that
  these functions do not modify struct scsi_disk before all zone
  information has been obtained.

Note: since commit 055f6e18e08f ("block: Make q_usage_counter also track
legacy requests"; kernel v4.15) the request queue freezing mechanism also
affects legacy request queues.

Fixes: 89d947561077 ("sd: Implement support for ZBC devices")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: stable@vger.kernel.org # v4.16
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd_zbc.c |   98 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 35 deletions(-)

--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -423,7 +423,16 @@ static int sd_zbc_check_capacity(struct
 
 #define SD_ZBC_BUF_SIZE 131072
 
-static int sd_zbc_check_zone_size(struct scsi_disk *sdkp)
+/**
+ * sd_zbc_check_zone_size - Check the device zone sizes
+ * @sdkp: Target disk
+ *
+ * Check that all zones of the device are equal. The last zone can however
+ * be smaller. The zone size must also be a power of two number of LBAs.
+ *
+ * Returns the zone size in bytes upon success or an error code upon failure.
+ */
+static s64 sd_zbc_check_zone_size(struct scsi_disk *sdkp)
 {
 	u64 zone_blocks = 0;
 	sector_t block = 0;
@@ -434,8 +443,6 @@ static int sd_zbc_check_zone_size(struct
 	int ret;
 	u8 same;
 
-	sdkp->zone_blocks = 0;
-
 	/* Get a buffer */
 	buf = kmalloc(SD_ZBC_BUF_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -470,16 +477,17 @@ static int sd_zbc_check_zone_size(struct
 
 		/* Parse zone descriptors */
 		while (rec < buf + buf_len) {
-			zone_blocks = get_unaligned_be64(&rec[8]);
-			if (sdkp->zone_blocks == 0) {
-				sdkp->zone_blocks = zone_blocks;
-			} else if (zone_blocks != sdkp->zone_blocks &&
-				   (block + zone_blocks < sdkp->capacity
-				    || zone_blocks > sdkp->zone_blocks)) {
+			u64 this_zone_blocks = get_unaligned_be64(&rec[8]);
+
+			if (zone_blocks == 0) {
+				zone_blocks = this_zone_blocks;
+			} else if (this_zone_blocks != zone_blocks &&
+				   (block + this_zone_blocks < sdkp->capacity
+				    || this_zone_blocks > zone_blocks)) {
 				zone_blocks = 0;
 				goto out;
 			}
-			block += zone_blocks;
+			block += this_zone_blocks;
 			rec += 64;
 		}
 
@@ -492,8 +500,6 @@ static int sd_zbc_check_zone_size(struct
 
 	} while (block < sdkp->capacity);
 
-	zone_blocks = sdkp->zone_blocks;
-
 out:
 	if (!zone_blocks) {
 		if (sdkp->first_scan)
@@ -513,8 +519,7 @@ out:
 				  "Zone size too large\n");
 		ret = -ENODEV;
 	} else {
-		sdkp->zone_blocks = zone_blocks;
-		sdkp->zone_shift = ilog2(zone_blocks);
+		ret = zone_blocks;
 	}
 
 out_free:
@@ -523,23 +528,44 @@ out_free:
 	return ret;
 }
 
-static int sd_zbc_setup(struct scsi_disk *sdkp)
+static int sd_zbc_setup(struct scsi_disk *sdkp, u32 zone_blocks)
 {
+	struct request_queue *q = sdkp->disk->queue;
+	u32 zone_shift = ilog2(zone_blocks);
+	u32 nr_zones;
 
 	/* chunk_sectors indicates the zone size */
-	blk_queue_chunk_sectors(sdkp->disk->queue,
-			logical_to_sectors(sdkp->device, sdkp->zone_blocks));
-	sdkp->zone_shift = ilog2(sdkp->zone_blocks);
-	sdkp->nr_zones = sdkp->capacity >> sdkp->zone_shift;
-	if (sdkp->capacity & (sdkp->zone_blocks - 1))
-		sdkp->nr_zones++;
-
-	if (!sdkp->zones_wlock) {
-		sdkp->zones_wlock = kcalloc(BITS_TO_LONGS(sdkp->nr_zones),
-					    sizeof(unsigned long),
-					    GFP_KERNEL);
-		if (!sdkp->zones_wlock)
-			return -ENOMEM;
+	blk_queue_chunk_sectors(q,
+			logical_to_sectors(sdkp->device, zone_blocks));
+	nr_zones = round_up(sdkp->capacity, zone_blocks) >> zone_shift;
+
+	/*
+	 * Initialize the disk zone write lock bitmap if the number
+	 * of zones changed.
+	 */
+	if (nr_zones != sdkp->nr_zones) {
+		unsigned long *zones_wlock = NULL;
+
+		if (nr_zones) {
+			zones_wlock = kcalloc(BITS_TO_LONGS(nr_zones),
+					      sizeof(unsigned long),
+					      GFP_KERNEL);
+			if (!zones_wlock)
+				return -ENOMEM;
+		}
+
+		blk_mq_freeze_queue(q);
+		sdkp->zone_blocks = zone_blocks;
+		sdkp->zone_shift = zone_shift;
+		sdkp->nr_zones = nr_zones;
+		swap(sdkp->zones_wlock, zones_wlock);
+		blk_mq_unfreeze_queue(q);
+
+		kfree(zones_wlock);
+
+		/* READ16/WRITE16 is mandatory for ZBC disks */
+		sdkp->device->use_16_for_rw = 1;
+		sdkp->device->use_10_for_rw = 0;
 	}
 
 	return 0;
@@ -548,6 +574,7 @@ static int sd_zbc_setup(struct scsi_disk
 int sd_zbc_read_zones(struct scsi_disk *sdkp,
 		      unsigned char *buf)
 {
+	int64_t zone_blocks;
 	int ret;
 
 	if (!sd_is_zoned(sdkp))
@@ -585,19 +612,19 @@ int sd_zbc_read_zones(struct scsi_disk *
 	 * Check zone size: only devices with a constant zone size (except
 	 * an eventual last runt zone) that is a power of 2 are supported.
 	 */
-	ret = sd_zbc_check_zone_size(sdkp);
-	if (ret)
+	zone_blocks = sd_zbc_check_zone_size(sdkp);
+	ret = -EFBIG;
+	if (zone_blocks != (u32)zone_blocks)
+		goto err;
+	ret = zone_blocks;
+	if (ret < 0)
 		goto err;
 
 	/* The drive satisfies the kernel restrictions: set it up */
-	ret = sd_zbc_setup(sdkp);
+	ret = sd_zbc_setup(sdkp, zone_blocks);
 	if (ret)
 		goto err;
 
-	/* READ16/WRITE16 is mandatory for ZBC disks */
-	sdkp->device->use_16_for_rw = 1;
-	sdkp->device->use_10_for_rw = 0;
-
 	return 0;
 
 err:
@@ -610,6 +637,7 @@ void sd_zbc_remove(struct scsi_disk *sdk
 {
 	kfree(sdkp->zones_wlock);
 	sdkp->zones_wlock = NULL;
+	sdkp->nr_zones = 0;
 }
 
 void sd_zbc_print_zones(struct scsi_disk *sdkp)
