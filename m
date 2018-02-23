Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeBWLpg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:45:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:52829 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbeBWLpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:45:34 -0500
From: Nikolay Borisov <nborisov@suse.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, rgoldwyn@suse.de,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] direct-io: Remove unused DIO_SKIP_DIO_COUNT logic
Date: Fri, 23 Feb 2018 13:45:29 +0200
Message-Id: <1519386329-2734-2-git-send-email-nborisov@suse.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519386329-2734-1-git-send-email-nborisov@suse.com>
References: <1519386329-2734-1-git-send-email-nborisov@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag was added by fe0f07d08ee3 ("direct-io: only inc/deci
inode->i_dio_count for file systems") as means to optimise the atomic
modificaiton of the variable for blockdevices. However with the advent
of 542ff7bf18c6 ("block: new direct I/O implementation") it became
unused. So let's remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/direct-io.c     | 6 ++----
 include/linux/fs.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 99a81c49bce9..a8131087aa1c 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -315,8 +315,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 			dio_warn_stale_pagecache(dio->iocb->ki_filp);
 	}
 
-	if (!(dio->flags & DIO_SKIP_DIO_COUNT))
-		inode_dio_end(dio->inode);
+	inode_dio_end(dio->inode);
 
 	if (flags & DIO_COMPLETE_ASYNC) {
 		/*
@@ -1297,8 +1296,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	/*
 	 * Will be decremented at I/O completion time.
 	 */
-	if (!(dio->flags & DIO_SKIP_DIO_COUNT))
-		inode_dio_begin(inode);
+	inode_dio_begin(inode);
 
 	retval = 0;
 	sdio.blkbits = blkbits;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 260c233e7375..9bee267209e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2976,9 +2976,6 @@ enum {
 
 	/* filesystem does not support filling holes */
 	DIO_SKIP_HOLES	= 0x02,
-
-	/* inode/fs/bdev does not need truncate protection */
-	DIO_SKIP_DIO_COUNT = 0x08,
 };
 
 void dio_end_io(struct bio *bio);
-- 
2.7.4
