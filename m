Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbeEHGG3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:06:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754118AbeEHGG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:06:27 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to let checkpoint guarantee atomic page persistence
Date: Tue, 8 May 2018 14:06:03 +0800
Message-ID: <20180508060603.33865-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. thread A: commit_inmem_pages submit data into block layer, but
haven't waited it writeback.
2. thread A: commit_inmem_pages update related node.
3. thread B: do checkpoint, flush all nodes to disk.
4. SPOR

Then, atomic file becomes corrupted since nodes is flushed before data.

This patch fixes to treat atomic page as checkpoint guaranteed one,
then in checkpoint, we can make sure all atomic page can be writebacked
with metadata of atomic file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 778b23fce4fa..734be00fab3a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -45,6 +45,8 @@ static bool __is_cp_guaranteed(struct page *page)
 	if (inode->i_ino == F2FS_META_INO(sbi) ||
 			inode->i_ino ==  F2FS_NODE_INO(sbi) ||
 			S_ISDIR(inode->i_mode) ||
+			(S_ISREG(inode->i_mode) &&
+			is_inode_flag_set(inode, FI_ATOMIC_FILE)) ||
 			is_cold_data(page))
 		return true;
 	return false;
-- 
2.17.0.391.g1f1cddd558b5
