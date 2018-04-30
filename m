Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbeD3Q6C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:58:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20729 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755107AbeD3Q56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:57:58 -0400
X-IronPort-AV: E=Sophos;i="5.49,346,1520870400";
   d="scan'208";a="173714670"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-abi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH 2/2] fs: Add aio priority support for block_dev
Date: Mon, 30 Apr 2018 09:57:40 -0700
Message-Id: <20180430165740.2842-3-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180430165740.2842-1-adam.manzanares@wdc.com>
References: <20180430165740.2842-1-adam.manzanares@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

When the IOCB_IOPRIO flag is set because the user supplied iocb
has the RWF_IOPRIO flag is set then we set the priority value of
the kiocb from the iocb.

When a bio is created for an aio request by the block dev we set the
priority value of the bio to the user supplied value.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 fs/aio.c       | 9 +++++++++
 fs/block_dev.c | 1 +
 2 files changed, 10 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 88d7927ffbc6..47591f9e7ba3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1603,6 +1603,15 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		goto out_put_req;
 	}
 
+	if (req->common.ki_flags & IOCB_IOPRIO)
+		/*
+		 * The IOCB_IOPRIO flag is set when the user supplied iocb
+		 * aio_rw_flag field has the RWF_IOPRIO flag set. If so,
+		 * aio_reqprio is interpreted as a I/O scheduling class and
+		 * priority.
+		 */
+		req->common.ki_ioprio = iocb->aio_reqprio;
+
 	ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
 	if (unlikely(ret)) {
 		pr_debug("EFAULT: aio_key\n");
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e27065..da1e94d2bb75 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -355,6 +355,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
+		bio->bi_ioprio = iocb->ki_ioprio;
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
-- 
2.15.1
