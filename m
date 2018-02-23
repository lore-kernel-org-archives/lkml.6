Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeBWLph (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:45:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:52828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbeBWLpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:45:34 -0500
From: Nikolay Borisov <nborisov@suse.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, rgoldwyn@suse.de,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] direct-io: Remove unused DIO_ASYNC_EXTEND flag
Date: Fri, 23 Feb 2018 13:45:28 +0200
Message-Id: <1519386329-2734-1-git-send-email-nborisov@suse.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag was added by 6039257378e4 ("direct-io: add flag to allow aio
writes beyond i_size") to support XFS. However, with the rework of
XFS' DIO's path to use iomap in acdda3aae146 ("xfs: use iomap_dio_rw")
it became redundant. So let's remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/direct-io.c     | 3 +--
 include/linux/fs.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index a0ca9e48e993..99a81c49bce9 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1252,8 +1252,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	if (is_sync_kiocb(iocb))
 		dio->is_async = false;
-	else if (!(dio->flags & DIO_ASYNC_EXTEND) &&
-		 iov_iter_rw(iter) == WRITE && end > i_size_read(inode))
+	else if (iov_iter_rw(iter) == WRITE && end > i_size_read(inode))
 		dio->is_async = false;
 	else
 		dio->is_async = true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..260c233e7375 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2977,9 +2977,6 @@ enum {
 	/* filesystem does not support filling holes */
 	DIO_SKIP_HOLES	= 0x02,
 
-	/* filesystem can handle aio writes beyond i_size */
-	DIO_ASYNC_EXTEND = 0x04,
-
 	/* inode/fs/bdev does not need truncate protection */
 	DIO_SKIP_DIO_COUNT = 0x08,
 };
-- 
2.7.4
