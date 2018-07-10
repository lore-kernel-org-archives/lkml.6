Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B6A2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B6A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbeGJSdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388788AbeGJSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1E682D0B;
        Tue, 10 Jul 2018 18:32:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Janne Huttunen <janne.huttunen@nokia.com>
Subject: [PATCH 4.14 30/53] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
Date:   Tue, 10 Jul 2018 20:25:06 +0200
Message-Id: <20180710182500.577260792@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
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

From: Ilya Dryomov <idryomov@gmail.com>

commit d5ce4c31d6df518dd8f63bbae20d7423c5018a6c upstream.

sd_config_write_same() ignores ->max_ws_blocks == 0 and resets it to
permit trying WRITE SAME on older SCSI devices, unless ->no_write_same
is set.  Because REQ_OP_WRITE_ZEROES is implemented in terms of WRITE
SAME, blkdev_issue_zeroout() may fail with -EREMOTEIO:

  $ fallocate -zn -l 1k /dev/sdg
  fallocate: fallocate failed: Remote I/O error
  $ fallocate -zn -l 1k /dev/sdg  # OK
  $ fallocate -zn -l 1k /dev/sdg  # OK

The following calls succeed because sd_done() sets ->no_write_same in
response to a sense that would become BLK_STS_TARGET/-EREMOTEIO, causing
__blkdev_issue_zeroout() to fall back to generating ZERO_PAGE bios.

This means blkdev_issue_zeroout() must cope with WRITE ZEROES failing
and fall back to manually zeroing, unless BLKDEV_ZERO_NOFALLBACK is
specified.  For BLKDEV_ZERO_NOFALLBACK case, return -EOPNOTSUPP if
sd_done() has just set ->no_write_same thus indicating lack of offload
support.

Fixes: c20cfc27a473 ("block: stop using blkdev_issue_write_same for zeroing")
Cc: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-lib.c |   45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -322,12 +322,6 @@ static int __blkdev_issue_zero_pages(str
  *  Zero-fill a block range, either using hardware offload or by explicitly
  *  writing zeroes to the device.
  *
- *  Note that this function may fail with -EOPNOTSUPP if the driver signals
- *  zeroing offload support, but the device fails to process the command (for
- *  some devices there is no non-destructive way to verify whether this
- *  operation is actually supported).  In this case the caller should call
- *  retry the call to blkdev_issue_zeroout() and the fallback path will be used.
- *
  *  If a device is using logical block provisioning, the underlying space will
  *  not be released if %flags contains BLKDEV_ZERO_NOUNMAP.
  *
@@ -371,18 +365,49 @@ EXPORT_SYMBOL(__blkdev_issue_zeroout);
 int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned flags)
 {
-	int ret;
-	struct bio *bio = NULL;
+	int ret = 0;
+	sector_t bs_mask;
+	struct bio *bio;
 	struct blk_plug plug;
+	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev);
 
+	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	if ((sector | nr_sects) & bs_mask)
+		return -EINVAL;
+
+retry:
+	bio = NULL;
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
-			&bio, flags);
+	if (try_write_zeroes) {
+		ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects,
+						  gfp_mask, &bio, flags);
+	} else if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
+		ret = __blkdev_issue_zero_pages(bdev, sector, nr_sects,
+						gfp_mask, &bio);
+	} else {
+		/* No zeroing offload support */
+		ret = -EOPNOTSUPP;
+	}
 	if (ret == 0 && bio) {
 		ret = submit_bio_wait(bio);
 		bio_put(bio);
 	}
 	blk_finish_plug(&plug);
+	if (ret && try_write_zeroes) {
+		if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
+			try_write_zeroes = false;
+			goto retry;
+		}
+		if (!bdev_write_zeroes_sectors(bdev)) {
+			/*
+			 * Zeroing offload support was indicated, but the
+			 * device reported ILLEGAL REQUEST (for some devices
+			 * there is no non-destructive way to verify whether
+			 * WRITE ZEROES is actually supported).
+			 */
+			ret = -EOPNOTSUPP;
+		}
+	}
 
 	return ret;
 }


