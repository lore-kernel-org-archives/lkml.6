Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDHD0z (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 23:26:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49042 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752463AbeDHD0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 23:26:54 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove unneeded F2FS_PROJINHERIT_FL
Date: Sun, 8 Apr 2018 11:25:53 +0800
Message-ID: <20180408032553.23203-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now F2FS_FL_USER_VISIBLE and F2FS_FL_USER_MODIFIABLE has included
F2FS_PROJINHERIT_FL, so remove unneeded F2FS_PROJINHERIT_FL when
using visible/modifiable flag macro.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82a01f0aaa33..3fd485395f9d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -686,7 +686,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
 	}
 
-	flags = fi->i_flags & (F2FS_FL_USER_VISIBLE | F2FS_PROJINHERIT_FL);
+	flags = fi->i_flags & F2FS_FL_USER_VISIBLE;
 	if (flags & F2FS_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (flags & F2FS_COMPR_FL)
@@ -1606,8 +1606,8 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 		if (!capable(CAP_LINUX_IMMUTABLE))
 			return -EPERM;
 
-	flags = flags & (F2FS_FL_USER_MODIFIABLE | F2FS_PROJINHERIT_FL);
-	flags |= oldflags & ~(F2FS_FL_USER_MODIFIABLE | F2FS_PROJINHERIT_FL);
+	flags = flags & F2FS_FL_USER_MODIFIABLE;
+	flags |= oldflags & ~F2FS_FL_USER_MODIFIABLE;
 	fi->i_flags = flags;
 
 	if (fi->i_flags & F2FS_PROJINHERIT_FL)
@@ -2649,7 +2649,7 @@ static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
 
 	memset(&fa, 0, sizeof(struct fsxattr));
 	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
-				(F2FS_FL_USER_VISIBLE | F2FS_PROJINHERIT_FL));
+				F2FS_FL_USER_VISIBLE);
 
 	if (f2fs_sb_has_project_quota(inode->i_sb))
 		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
-- 
2.15.0.55.gc2ece9dc4de6
