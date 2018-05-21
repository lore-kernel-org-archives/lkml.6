Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeEUQDq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:03:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59151 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbeEUQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:02:29 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520870400";
   d="scan'208";a="79445400"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: tglx@linutronix.de, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, jack@suse.cz, darrick.wong@oracle.com,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v5 4/5] fs: blkdev set bio prio from kiocb prio
Date: Mon, 21 May 2018 09:01:46 -0700
Message-Id: <20180521160147.2372-5-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180521160147.2372-1-adam.manzanares@wdc.com>
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

Now that kiocb has an ioprio field copy this over to the bio when it is
created from the kiocb.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 fs/block_dev.c | 1 +
 1 file changed, 1 insertion(+)

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
