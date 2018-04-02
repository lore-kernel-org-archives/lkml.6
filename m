Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754376AbeDBKZs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:25:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752751AbeDBKZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:25:47 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to show encrypt flag in FS_IOC_GETFLAGS
Date: Mon, 2 Apr 2018 18:24:46 +0800
Message-ID: <20180402102446.32832-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes to show encrypt flag in FS_IOC_GETFLAGS like ext4 does.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8068b015ece5..271fadadaa36 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1584,8 +1584,13 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	unsigned int flags = fi->i_flags &
-			(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
+	unsigned int flags = fi->i_flags;
+
+	if (file_is_encrypt(inode))
+		flags |= FS_ENCRYPT_FL;
+
+	flags &= FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL;
+
 	return put_user(flags, (int __user *)arg);
 }
 
-- 
2.15.0.55.gc2ece9dc4de6
