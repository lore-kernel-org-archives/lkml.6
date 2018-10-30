Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5092C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A9620827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gBOQqkDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A9620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeJaICK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:02:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40688 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbeJaICJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:02:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id o14-v6so6399746pgv.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c4zZNrFqTbcbGzWoE2ofhWPIl6q01gLvGD3sNL54Djw=;
        b=gBOQqkDdb5psZ47oq0yObJq3+E5newa37J1ai0VgVcy+Cu4LDbTO2aX+baiX2S8qza
         p3L6qepzuLYpdVJxWQB0Ju5H0KWi1rV3m4c+w3q2tzZLaA4CBOCW2PFmsCmrdpmH0AJX
         y6b/LBjD1dN4d4Hh99sJORQWNLFCyAY+vB6Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c4zZNrFqTbcbGzWoE2ofhWPIl6q01gLvGD3sNL54Djw=;
        b=tPtaLm5elRcJRSYpdrhteGKPpvY/1Zw0rLXI6gaFTueBeD5fhFNu1+JRwNotGHMCUE
         6n4HzsSrVrqYdMvCVOoil4eG/ZbX3+u+SDL1dKBxKErx5tdVMz8vXBds5PRQhGUdmJGL
         LACdAuRPiWMNhM+132om4wkyUNz9BhvaGaHNGKat+CRu3voJeqf9Gja5+OFfNZ2mog+G
         Rz2aoCX3Z2gWVGUtIA/R/F122D9dj7PEHqxSPFxvLRM7CHOVq7vJFOWK6k1VttxSjhgC
         VtxFpCDpQGoLm7BuTZORHXaa/W/sxZfxe9Bcp8f3B9sqFV2JE6a6Q5pwnuwQYNhd8o/Q
         dWCw==
X-Gm-Message-State: AGRZ1gKqcIXXYumxcUPOeid4GA1l9G8UL/zQlnozYlH0TSgpuCjwLf5S
        imqkMX/vAO+RvMPzSSImI+SMDWUAXgE=
X-Google-Smtp-Source: AJdET5euFY9NlkbBIvSUaOh5TifG726vulH/AflNaH9yPOzOLtxWePbmAno1+zThbmx/3sD0Lk+3uA==
X-Received: by 2002:a62:8a91:: with SMTP id o17-v6mr705259pfk.184.1540940801239;
        Tue, 30 Oct 2018 16:06:41 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id z15-v6sm27953490pfn.170.2018.10.30.16.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 16:06:40 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] loop: Better discard support for block devices
Date:   Tue, 30 Oct 2018 16:06:24 -0700
Message-Id: <20181030230624.61834-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181030230624.61834-1-evgreen@chromium.org>
References: <20181030230624.61834-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the backing device for a loop device is a block device,
then mirror the discard properties of the underlying block
device into the loop device. While in there, differentiate
between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
different for block devices, but which the loop device had
just been lumping together.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/block/loop.c | 61 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28990fc94841a..176e65101c4ef 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 	return ret;
 }
 
-static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
+static int lo_discard(struct loop_device *lo, struct request *rq,
+		int mode, loff_t pos)
 {
-	/*
-	 * We use punch hole to reclaim the free space used by the
-	 * image a.k.a. discard. However we do not support discard if
-	 * encryption is enabled, because it may give an attacker
-	 * useful information.
-	 */
 	struct file *file = lo->lo_backing_file;
-	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+	struct request_queue *q = lo->lo_queue;
 	int ret;
 
-	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
+	if (!blk_queue_discard(q)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -603,8 +598,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_FLUSH:
 		return lo_req_flush(lo, rq);
 	case REQ_OP_DISCARD:
+		return lo_discard(lo, rq,
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
+
 	case REQ_OP_WRITE_ZEROES:
-		return lo_discard(lo, rq, pos);
+		return lo_discard(lo, rq,
+			FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
+
 	case REQ_OP_WRITE:
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
@@ -859,6 +859,25 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
+	struct request_queue *backingq;
+
+	/*
+	 * If the backing device is a block device, mirror its discard
+	 * capabilities.
+	 */
+	if (S_ISBLK(inode->i_mode)) {
+		backingq = bdev_get_queue(inode->i_bdev);
+		blk_queue_max_discard_sectors(q,
+			backingq->limits.max_discard_sectors);
+
+		blk_queue_max_write_zeroes_sectors(q,
+			backingq->limits.max_write_zeroes_sectors);
+
+		q->limits.discard_granularity =
+			backingq->limits.discard_granularity;
+
+		q->limits.discard_alignment =
+			backingq->limits.discard_alignment;
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -866,22 +885,24 @@ static void loop_config_discard(struct loop_device *lo)
 	 * encryption is enabled, because it may give an attacker
 	 * useful information.
 	 */
-	if ((!file->f_op->fallocate) ||
-	    lo->lo_encrypt_key_size) {
+	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
-		return;
-	}
 
-	q->limits.discard_granularity = inode->i_sb->s_blocksize;
-	q->limits.discard_alignment = 0;
+	} else {
+		q->limits.discard_granularity = inode->i_sb->s_blocksize;
+		q->limits.discard_alignment = 0;
+
+		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
+		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+	}
 
-	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
-	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	if (q->limits.max_discard_sectors || q->limits.max_write_zeroes_sectors)
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 }
 
 static void loop_unprepare_queue(struct loop_device *lo)
-- 
2.16.4

