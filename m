Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF558ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BF0208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuHT+6mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BF0208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbeKIHtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732089AbeKIHrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:35 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 002232089F;
        Thu,  8 Nov 2018 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715004;
        bh=xAaC0PX3DpXt1VbrktvX3gWRg9i5jqNAw5Ooi3sASUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuHT+6mFMOo6Nle7vFW3exPyUUc5sQ+DzVtfYmo2HpOkU87rNXIGWQI3WnUOQDst/
         0XBaqHYc67RUNWblPLl87PUalZO929Kd4Yv+ZYz6meOLdIXvD0CekzlIXiGSxIdUJi
         Ipq37k/evgUTGAhSrKxDIjEG3VFx75k0CIOo/ouk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lin <ming.l@ssi.samsung.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 23/34] block: dont deal with discard limit in blkdev_issue_discard()
Date:   Thu,  8 Nov 2018 13:52:52 -0800
Message-Id: <20181108215140.348449135@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
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


