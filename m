Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeBZJyl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:54:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:52627 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbeBZJyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:54:36 -0500
From: Nikolay Borisov <nborisov@suse.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] direct-io: Minor cleanups in do_blockdev_direct_IO
Date: Mon, 26 Feb 2018 11:54:30 +0200
Message-Id: <1519638870-17756-1-git-send-email-nborisov@suse.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already get the block counts and the calculate the end block at the
beginning of the function. Let's use the local variables for consistency and
readability. No functional changes

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
---
Andrew, 

Sending to you since this has been languishing on the mailing for quite some 
time. The patch has been reviewed here:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1460544.html

fs/direct-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index a8131087aa1c..a73448a501c2 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1200,7 +1200,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	}
 
 	/* watch out for a 0 len io from a tricksy fs */
-	if (iov_iter_rw(iter) == READ && !iov_iter_count(iter))
+	if (iov_iter_rw(iter) == READ && !count)
 		return 0;
 
 	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
@@ -1316,8 +1316,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	dio->should_dirty = (iter->type == ITER_IOVEC);
 	sdio.iter = iter;
-	sdio.final_block_in_request =
-		(offset + iov_iter_count(iter)) >> blkbits;
+	sdio.final_block_in_request = end >> blkbits;
 
 	/*
 	 * In case of non-aligned buffers, we may need 2 more
-- 
2.7.4
