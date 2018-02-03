Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeBCCsN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 21:48:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46331 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751963AbeBCCsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 21:48:07 -0500
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] f2fs: enable to gc page whose inode already atomic commit
Date: Sat, 3 Feb 2018 10:47:47 +0800
Message-ID: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.107.193.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If inode has already started to atomic commit, then set_page_dirty will
not mix the gc pages with the inmem atomic pages, so the page can be
gced safely.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/data.c | 5 ++---
 fs/f2fs/gc.c   | 6 ++++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7435830..edafcb6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1580,14 +1580,13 @@ bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (S_ISDIR(inode->i_mode))
 		return true;
-	if (f2fs_is_atomic_file(inode))
-		return true;
 	if (fio) {
 		if (is_cold_data(fio->page))
 			return true;
 		if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
 			return true;
-	}
+	} else if (f2fs_is_atomic_file(inode))
+		return true;
 	return false;
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d93fd..84ab3ff 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -622,7 +622,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode) &&
+		!f2fs_is_commit_atomic_write(inode))
 		goto out;
 
 	if (f2fs_is_pinned_file(inode)) {
@@ -729,7 +730,8 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode) &&
+		!f2fs_is_commit_atomic_write(inode))
 		goto out;
 	if (f2fs_is_pinned_file(inode)) {
 		if (gc_type == FG_GC)
-- 
1.8.5.2
