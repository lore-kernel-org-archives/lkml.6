Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2F2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R6Ni4t6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfAaWN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:13:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35982 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfAaWN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:13:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so2129441pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6gcXthu6vb+ihTFEPQTW8BXATfR0X3APAkCL8SfFcdU=;
        b=R6Ni4t6MTpFAucDhvSxJfW+pJRURt8DS/lVpq1DQWhp5L5nA8lSUUWGVrgIqvH6dAD
         gW+CmiknE9tX1GhGspe0U2oOdk2GzUqkLQAxIMrrwjANiOCZpBBw6mUp9Xwf16fZh0Qx
         R4fpxhNg1NZWrubAYgSIZoEJ8L7gaD6lcPac8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gcXthu6vb+ihTFEPQTW8BXATfR0X3APAkCL8SfFcdU=;
        b=QuSNr9D/JlouH9suT/T/Zf8Pxeq7ofQwgpuVqE7muWZdvn++19O0XdCCb4LrZa+ylf
         O0HTp+D2xtCnYXPbJgS7VyrMjH24WWmLZUBOjDs8TEGCfmG+N4fXZxdwe4e4ics+piMu
         DFPFJXkJooU7L84mbCVkJ79GWw30cmqIiZWqqnRWUMnvkpGqaGyQkIhm5A1c46x9qyCo
         9B31ThKipbXQ3mVCpW3saUTGEcXvkvJnoHBjtstpUTOAdNeYlziQZChAaGHUmmuDFnLP
         CA797pPjTOytQ6Tcl9uTAAmtXGjZLyu2h40RzQgGXPJLLCG0v9kf2On/O39uFZsCacvn
         KGRg==
X-Gm-Message-State: AJcUukdsXT5ezIXDIxZ7yCtfHWNs59P3vxzYfiSRZhlXaQ1M77VOqfzF
        ntgtKxESb7ZFWNANb0rQZJdIWg==
X-Google-Smtp-Source: ALg8bN6bjHJeyN+XaFsdg3hkLi0eQSTj5yP6QzAEqSOY1L3X931hxZna7uobS/gzxiJjUm0hhSo96Q==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr33081093pgr.333.1548972837427;
        Thu, 31 Jan 2019 14:13:57 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z10sm7961681pfg.120.2019.01.31.14.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 14:13:56 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Martin K Peterson <martin.peterson@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] loop: Better discard support for block devices
Date:   Thu, 31 Jan 2019 14:13:28 -0800
Message-Id: <20190131221328.85343-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131221328.85343-1-evgreen@chromium.org>
References: <20190131221328.85343-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This change fixes blktest block/003, and removes an extraneous
error print in block/013 when testing on a loop device backed
by a block device that does not support discard.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/block/loop.c | 61 +++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a1ba555e3b92..8c2b6885db56 100644
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
@@ -602,8 +597,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
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
@@ -857,6 +857,25 @@ static void loop_config_discard(struct loop_device *lo)
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
@@ -864,22 +883,24 @@ static void loop_config_discard(struct loop_device *lo)
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
2.20.1

