Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeBCJpL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 04:45:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750860AbeBCJpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 04:45:03 -0500
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix to handle looped node chain during recovery
Date: Sat, 3 Feb 2018 17:44:39 +0800
Message-ID: <20180203094439.3913-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no checksum in node block now, so bit-transition from hardware
can make node_footer.next_blkaddr being corrupted w/o any detection,
result in node chain becoming looped one.

For this condition, during recovery, in order to avoid running into dead
loop, let's detect it and just skip out.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b6d1ec620a8c..60dd0cee4820 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -243,6 +243,9 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	struct curseg_info *curseg;
 	struct page *page = NULL;
 	block_t blkaddr;
+	unsigned int loop_cnt = 0;
+	unsigned int free_blocks = sbi->user_block_count -
+					valid_user_blocks(sbi);
 	int err = 0;
 
 	/* get node pages in the current segment */
@@ -295,6 +298,17 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 		if (IS_INODE(page) && is_dent_dnode(page))
 			entry->last_dentry = blkaddr;
 next:
+		/* sanity check in order to detect looped node chain */
+		if (++loop_cnt >= free_blocks ||
+			blkaddr == next_blkaddr_of_node(page)) {
+			f2fs_msg(sbi->sb, KERN_NOTICE,
+				"%s: detect looped node chain, "
+				"blkaddr:%u, next:%u",
+				__func__, blkaddr, next_blkaddr_of_node(page));
+			err = -EINVAL;
+			break;
+		}
+
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 		f2fs_put_page(page, 1);
-- 
2.15.0.55.gc2ece9dc4de6
