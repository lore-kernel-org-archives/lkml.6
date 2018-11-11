Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78705C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC83216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx1kw0W6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC83216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbeKLITX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387716AbeKLITW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:22 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F48321104;
        Sun, 11 Nov 2018 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975366;
        bh=xAaC0PX3DpXt1VbrktvX3gWRg9i5jqNAw5Ooi3sASUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tx1kw0W6zKCIlKAZ6o2pk/8rCqaitJorqvUMkcwkak9y4Ti7ZhFxiXdrrRA3yoQC5
         NcbCaDWC3bpBcdmImQcf72Ut3tBHUCRzLxf8VHj2Jb8hWu9xvscL99BluEMtEOLVSM
         o/u6aC4zWjOWyfR9o6DPs2qmOaBM987S05aL/v/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lin <ming.l@ssi.samsung.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 014/350] block: dont deal with discard limit in blkdev_issue_discard()
Date:   Sun, 11 Nov 2018 14:17:58 -0800
Message-Id: <20181111221707.768683952@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-lib.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -29,9 +29,7 @@ int __blkdev_issue_discard(struct block_
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
-	unsigned int granularity;
 	unsigned int op;
-	int alignment;
 	sector_t bs_mask;
 
 	if (!q)
@@ -54,38 +52,16 @@ int __blkdev_issue_discard(struct block_
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
 
-	/* Zero-sector (unknown) and one-sector granularities are the same.  */
-	granularity = max(q->limits.discard_granularity >> 9, 1U);
-	alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
-
 	while (nr_sects) {
-		unsigned int req_sects;
-		sector_t end_sect, tmp;
+		unsigned int req_sects = nr_sects;
+		sector_t end_sect;
 
-		/*
-		 * Issue in chunks of the user defined max discard setting,
-		 * ensuring that bi_size doesn't overflow
-		 */
-		req_sects = min_t(sector_t, nr_sects,
-					q->limits.max_discard_sectors);
 		if (!req_sects)
 			goto fail;
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
 
 		bio = next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;


