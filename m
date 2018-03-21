Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCUMZt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:25:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41612 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751531AbeCUMZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:25:48 -0400
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: no need to initialize zero value for GFP_F2FS_ZERO
Date: Wed, 21 Mar 2018 20:25:31 +0800
Message-ID: <1521635131-137071-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since f2fs_inode_info is allocated with flag GFP_F2FS_ZERO, so we do not
need to initialize zero value for its member any more.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/super.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0c1fe9b..3a7fa03 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -825,9 +825,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_once((void *) fi);
 
 	/* Initialize f2fs-specific inode info */
-	atomic_set(&fi->dirty_pages, 0);
 	fi->i_current_depth = 1;
-	fi->i_advise = 0;
 	init_rwsem(&fi->i_sem);
 	INIT_LIST_HEAD(&fi->dirty_list);
 	INIT_LIST_HEAD(&fi->gdirty_list);
@@ -839,10 +837,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_xattr_sem);
 
-#ifdef CONFIG_QUOTA
-	memset(&fi->i_dquot, 0, sizeof(fi->i_dquot));
-	fi->i_reserved_quota = 0;
-#endif
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
-- 
1.8.5.2
