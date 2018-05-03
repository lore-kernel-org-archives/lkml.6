Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeECJxn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:53:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44769 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:53:41 -0400
X-Google-Smtp-Source: AB8JxZqpsiaXwE5e0QTCTmcAtSJWtTy7Q8UjledbPv6SYhIZ2mfOcDzeUKcdhTM8fe80619X4lSvaw==
From: SeongJae Park <sj38.park@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH] brd: Mark as non-rotational
Date: Thu,  3 May 2018 18:53:26 +0900
Message-Id: <20180503095326.7414-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit sets QUEUE_FLAG_NONROT and clears up QUEUE_FLAG_ADD_RANDOM
to mark the ramdisks as non-rotational device.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 drivers/block/brd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 66cb0f857f64..39c5b90cc187 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -402,6 +402,10 @@ static struct brd_device *brd_alloc(int i)
 	set_capacity(disk, rd_size * 2);
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
 
+	/* Tell the block layer that this is not a rotational device */
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
+
 	return brd;
 
 out_free_queue:
-- 
2.13.0
