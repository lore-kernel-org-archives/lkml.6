Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeDYJjL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:39:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751452AbeDYJjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:39:00 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: introduce release_discard_addr() for cleanup
Date: Wed, 25 Apr 2018 17:38:29 +0800
Message-ID: <20180425093831.124591-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce release_discard_addr() to include common codes for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9e0c6babacec..d5627195aa8e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1609,16 +1609,20 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 	return false;
 }
 
+void release_discard_addr(struct discard_entry *entry)
+{
+	list_del(&entry->list);
+	kmem_cache_free(discard_entry_slab, entry);
+}
+
 void release_discard_addrs(struct f2fs_sb_info *sbi)
 {
 	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
 	struct discard_entry *entry, *this;
 
 	/* drop caches */
-	list_for_each_entry_safe(entry, this, head, list) {
-		list_del(&entry->list);
-		kmem_cache_free(discard_entry_slab, entry);
-	}
+	list_for_each_entry_safe(entry, this, head, list)
+		release_discard_addr(entry);
 }
 
 /*
@@ -1718,9 +1722,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (cur_pos < sbi->blocks_per_seg)
 			goto find_next;
 
-		list_del(&entry->list);
+		release_discard_addr(entry);
 		dcc->nr_discards -= total_len;
-		kmem_cache_free(discard_entry_slab, entry);
 	}
 
 	wake_up_discard_thread(sbi, false);
-- 
2.15.0.55.gc2ece9dc4de6
