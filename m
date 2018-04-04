Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeDDJgw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:36:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750812AbeDDJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:36:51 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove redundant block plug
Date: Wed, 4 Apr 2018 17:35:13 +0800
Message-ID: <20180404093513.86775-1-yuchao0@huawei.com>
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

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fa8f7cf1498f..5ecf1e355a97 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2943,9 +2943,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			inode_unlock(inode);
 			return err;
 		}
-		blk_start_plug(&plug);
+
 		ret = __generic_file_write_iter(iocb, from);
-		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
 		if (ret > 0)
-- 
2.15.0.55.gc2ece9dc4de6
