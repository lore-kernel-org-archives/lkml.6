Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeDHDfk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 23:35:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57846 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751387AbeDHDfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 23:35:39 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: remove redundant block plug
Date: Sun, 8 Apr 2018 11:34:39 +0800
Message-ID: <20180408033439.24830-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For buffered IO, we don't need to use block plug to cache bio,
for direct IO, generic f2fs_direct_IO has already added block
plug, so let's remove redundant one in .write_iter.

As Yunlei described in his patch:

-f2fs_file_write_iter
  -blk_start_plug
    -__generic_file_write_iter
	...
	  -do_blockdev_direct_IO
	    -blk_start_plug
		...
	    -blk_finish_plug
	...
  -blk_finish_plug

which may conduct performance decrease in our platform

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7b8fb31086c3..cb315d23c56f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2886,7 +2886,6 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct blk_plug plug;
 	ssize_t ret;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
@@ -2931,9 +2930,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 				return err;
 			}
 		}
-		blk_start_plug(&plug);
 		ret = __generic_file_write_iter(iocb, from);
-		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
 		/* if we couldn't write data, we should deallocate blocks. */
-- 
2.15.0.55.gc2ece9dc4de6
