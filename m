Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeEUQD0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:03:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27273 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeEUQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:02:30 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520870400";
   d="scan'208";a="79445409"
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
Subject: [PATCH v5 5/5] fs: iomap dio set bio prio from kiocb prio
Date: Mon, 21 May 2018 09:01:47 -0700
Message-Id: <20180521160147.2372-6-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180521160147.2372-1-adam.manzanares@wdc.com>
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

Now that kiocb has an ioprio field copy this over to the bio when it is
created from the kiocb during direct IO.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
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
