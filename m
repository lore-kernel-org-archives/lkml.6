Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7AEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4BB21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216553;
	bh=bQV+XlmnlGUFmqW3DbyhUFtsfEKOWlD0JK/WIQAUS+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SK24jWsZzlAmTQjl3c84WCKnzn/LL7WVUXzKdb3Bw3PIWOPGYzAz3sHMaCaCXV5js
	 1wZMPjlb5hYNVkZZOu6O831DtLd4i0K+i62WIHTVPLbZLii/aZT3qcJZmCOefxpWxA
	 uLiTYYDON5S47KVoNbijfRmBwcD9XG5O+g2MsIeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbfAKOWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731713AbfAKOTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC0021783;
        Fri, 11 Jan 2019 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216361;
        bh=bQV+XlmnlGUFmqW3DbyhUFtsfEKOWlD0JK/WIQAUS+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTpAm5tYuAff7wBwh9gbA80PB9nc5PrXyKFPCLDmgKUJAiRSH6KvzCrw6//MTNx13
         bOdFdLQmkDEOHSS08CkxoptmvxuQPqPM11Dm4KSPDiW6JvR9TVWzSzccgeKOULW5sT
         DBnd4Z88+LX7CL6xFPYIp0rhnDPVK1tGlG0NSpqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lin <ming.l@ssi.samsung.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.4 72/88] block: dont deal with discard limit in blkdev_issue_discard()
Date:   Fri, 11 Jan 2019 15:08:41 +0100
Message-Id: <20190111131058.120784730@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 744889b7cbb56a64f957e65ade7cb65fe3f35714 upstream.

blk_queue_split() does respect this limit via bio splitting, so no
need to do that in blkdev_issue_discard(), then we can align to
normal bio submit(bio_add_page() & submit_bio()).

More importantly, this patch fixes one issue introduced in a22c4d7e34402cc
("block: re-add discard_granularity and alignment checks"), in which
zero discard bio may be generated in case of zero alignment.

Fixes: a22c4d7e34402ccdf3 ("block: re-add discard_granularity and alignment checks")
Cc: stable@vger.kernel.org
Cc: Ming Lin <ming.l@ssi.samsung.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Xiao Ni <xni@redhat.com>
Tested-by: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-lib.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -43,8 +43,6 @@ int blkdev_issue_discard(struct block_de
 	DECLARE_COMPLETION_ONSTACK(wait);
 	struct request_queue *q = bdev_get_queue(bdev);
 	int type = REQ_WRITE | REQ_DISCARD;
-	unsigned int granularity;
-	int alignment;
 	struct bio_batch bb;
 	struct bio *bio;
 	int ret = 0;
@@ -56,10 +54,6 @@ int blkdev_issue_discard(struct block_de
 	if (!blk_queue_discard(q))
 		return -EOPNOTSUPP;
 
-	/* Zero-sector (unknown) and one-sector granularities are the same.  */
-	granularity = max(q->limits.discard_granularity >> 9, 1U);
-	alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
-
 	if (flags & BLKDEV_DISCARD_SECURE) {
 		if (!blk_queue_secdiscard(q))
 			return -EOPNOTSUPP;
@@ -72,8 +66,8 @@ int blkdev_issue_discard(struct block_de
 
 	blk_start_plug(&plug);
 	while (nr_sects) {
-		unsigned int req_sects;
-		sector_t end_sect, tmp;
+		unsigned int req_sects = nr_sects;
+		sector_t end_sect;
 
 		bio = bio_alloc(gfp_mask, 1);
 		if (!bio) {
@@ -81,28 +75,10 @@ int blkdev_issue_discard(struct block_de
 			break;
 		}
 
-		/*
-		 * Issue in chunks of the user defined max discard setting,
-		 * ensuring that bi_size doesn't overflow
-		 */
-		req_sects = min_t(sector_t, nr_sects,
-					q->limits.max_discard_sectors);
 		if (req_sects > UINT_MAX >> 9)
 			req_sects = UINT_MAX >> 9;
 
-		/*
-		 * If splitting a request, and the next starting sector would be
-		 * misaligned, stop the discard at the previous aligned sector.
-		 */
 		end_sect = sector + req_sects;
-		tmp = end_sect;
-		if (req_sects < nr_sects &&
-		    sector_div(tmp, granularity) != alignment) {
-			end_sect = end_sect - alignment;
-			sector_div(end_sect, granularity);
-			end_sect = end_sect * granularity + alignment;
-			req_sects = end_sect - sector;
-		}
 
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_end_io = bio_batch_end_io;


