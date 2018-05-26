Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031740AbeEZKEG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 06:04:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45714 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031654AbeEZKED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 06:04:03 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to don't trigger writeback during recovery
Date: Sat, 26 May 2018 18:03:34 +0800
Message-ID: <20180526100335.63001-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- f2fs_fill_super
 - recover_fsync_data
  - recover_data
   - del_fsync_inode
    - iput
     - iput_final
      - write_inode_now
       - f2fs_write_inode
        - f2fs_balance_fs
         - f2fs_balance_fs_bg
          - sync_dirty_inodes

With data_flush mount option, during recovery, in order to avoid entering
above writeback flow, let's detect recovery status and do skip in
f2fs_balance_fs_bg.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7dc59ae05e94..76947f2856bf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -486,6 +486,9 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 {
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		return;
+
 	/* try to shrink extent cache when there is no enough memory */
 	if (!available_free_memory(sbi, EXTENT_CACHE))
 		f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);
-- 
2.17.0.391.g1f1cddd558b5
