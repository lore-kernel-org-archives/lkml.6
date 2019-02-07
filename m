Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B21EC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191B02175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f9X6RRnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfBGU54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:57:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41564 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfBGU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:57:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so491219pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBOrwufm4FHfjMXGrxdvnQvXb/cSnW3qN7gry5U8GvU=;
        b=f9X6RRnWU4eA2avJU355gF6GI/Ea4SwxPSjHHUW0EWVE9U00Fg5ZwQb343olHBNioU
         E4AOEDxLqvk2ljWLK1uZ5F4lYEDJ9h8+0hPgKjk1RAi0wnQIQZblxnOLgcDl/zzfLP2g
         UBwdc7+e73/Cg7rvbtR01KndlMpZbQFQcBN6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBOrwufm4FHfjMXGrxdvnQvXb/cSnW3qN7gry5U8GvU=;
        b=Eo+D4hkPhKcPUq1dll47jcpWudDtmCze1YDjpiVe0puw4DRlVhBiRFMp0023eIlOor
         3TSbxQYMn+fu6zZZC1DStRpiSfLrBB2kvc1oF2IWf37kogvIhnKt2tnJfPLdcZf6DpYJ
         Rp0dQrEqv1nRSCFmDcgGdMpscbYA3TglYVUp6TZBWP+D6ZAKT7uRB2F6vL2y1tXXx9Ic
         0VkP0xmnW60lOgvYnsVr0CPKCBzFkWM7gE9X1k3FTgXWAGOk6S5ZAqr4BunRuTPwyIrL
         mfQZi0rqwx83K5o8O1a/IAsuyZDiJLATWZsEfbrHr8jObGcPN9JpEy0By9mGt+r91S/J
         mXhw==
X-Gm-Message-State: AHQUAub7YtHP0jqK7K8iVyghbnuBrdaobPQ7uANftqYlIfdMhDo/gTWJ
        /CAU1SjWNZLKZmSLJKDCfESHfw==
X-Google-Smtp-Source: AHgI3IYwkcAxfqEv6G5SK5dqEAswIL+qV42uI6+ChdkYlJm+1lWtnkrnor7/iFCU6Yn5V/wYEjd0zg==
X-Received: by 2002:a62:33c1:: with SMTP id z184mr18085394pfz.104.1549573073203;
        Thu, 07 Feb 2019 12:57:53 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id y9sm27199pfi.74.2019.02.07.12.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 12:57:52 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] loop: Better discard support for block devices
Date:   Thu,  7 Feb 2019 12:57:29 -0800
Message-Id: <20190207205730.199332-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207205730.199332-1-evgreen@chromium.org>
References: <20190207205730.199332-1-evgreen@chromium.org>
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

Changes in v2: None

 drivers/block/loop.c | 61 +++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b6c2d8f3202b..9b1fb2d639f1 100644
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
@@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
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
@@ -854,6 +854,25 @@ static void loop_config_discard(struct loop_device *lo)
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
@@ -861,22 +880,24 @@ static void loop_config_discard(struct loop_device *lo)
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

