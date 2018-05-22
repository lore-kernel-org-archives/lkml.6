Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeEVRyW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:54:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22290 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbeEVRwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:52:33 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="175448569"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: mingo@kernel.org, tglx@linutronix.de, kstewart@linuxfoundation.org,
        peterz@infradead.org, pombredanne@nexb.com, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v7 5/5] fs: iomap dio set bio prio from kiocb prio
Date: Tue, 22 May 2018 10:52:21 -0700
Message-Id: <20180522175221.2391-6-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180522175221.2391-1-adam.manzanares@wdc.com>
References: <20180522175221.2391-1-adam.manzanares@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

Now that kiocb has an ioprio field copy this over to the bio when it is
created from the kiocb during direct IO.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index afd163586aa0..65aae194aeca 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -919,6 +919,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_iter.bi_sector =
 			(iomap->addr + pos - iomap->offset) >> 9;
 		bio->bi_write_hint = dio->iocb->ki_hint;
+		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-- 
2.15.1
