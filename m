Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9251BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607562083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607562083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388801AbeGJSdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388788AbeGJSdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 674C8CED;
        Tue, 10 Jul 2018 18:32:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Janne Huttunen <janne.huttunen@nokia.com>
Subject: [PATCH 4.14 29/53] block: factor out __blkdev_issue_zero_pages()
Date:   Tue, 10 Jul 2018 20:25:05 +0200
Message-Id: <20180710182500.527754529@linuxfoundation.org>
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

commit 425a4dba7953e35ffd096771973add6d2f40d2ed upstream.

blkdev_issue_zeroout() will use this in !BLKDEV_ZERO_NOFALLBACK case.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-lib.c |   63 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -275,6 +275,40 @@ static unsigned int __blkdev_sectors_to_
 	return min(pages, (sector_t)BIO_MAX_PAGES);
 }
 
+static int __blkdev_issue_zero_pages(struct block_device *bdev,
+		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio = *biop;
+	int bi_size = 0;
+	unsigned int sz;
+
+	if (!q)
+		return -ENXIO;
+
+	while (nr_sects != 0) {
+		bio = next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
+			       gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+		bio_set_dev(bio, bdev);
+		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+
+		while (nr_sects != 0) {
+			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
+			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz, 0);
+			nr_sects -= bi_size >> 9;
+			sector += bi_size >> 9;
+			if (bi_size < sz)
+				break;
+		}
+		cond_resched();
+	}
+
+	*biop = bio;
+	return 0;
+}
+
 /**
  * __blkdev_issue_zeroout - generate number of zero filed write bios
  * @bdev:	blockdev to issue
@@ -305,9 +339,6 @@ int __blkdev_issue_zeroout(struct block_
 		unsigned flags)
 {
 	int ret;
-	int bi_size = 0;
-	struct bio *bio = *biop;
-	unsigned int sz;
 	sector_t bs_mask;
 
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
@@ -317,30 +348,10 @@ int __blkdev_issue_zeroout(struct block_
 	ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
 			biop, flags);
 	if (ret != -EOPNOTSUPP || (flags & BLKDEV_ZERO_NOFALLBACK))
-		goto out;
-
-	ret = 0;
-	while (nr_sects != 0) {
-		bio = next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
-			       gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		return ret;
 
-		while (nr_sects != 0) {
-			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
-			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz, 0);
-			nr_sects -= bi_size >> 9;
-			sector += bi_size >> 9;
-			if (bi_size < sz)
-				break;
-		}
-		cond_resched();
-	}
-
-	*biop = bio;
-out:
-	return ret;
+	return __blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp_mask,
+					 biop);
 }
 EXPORT_SYMBOL(__blkdev_issue_zeroout);
 


