Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeE3KLt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:11:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37139 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750718AbeE3KLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:11:47 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to update mtime correctly
Date: Wed, 30 May 2018 18:11:31 +0800
Message-ID: <20180530101131.107083-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
In-Reply-To: <20180530101131.107083-1-yuchao0@huawei.com>
References: <20180530101131.107083-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we change system time to the past, get_mtime() will return a
overflowed time, and SIT_I(sbi)->max_mtime will be udpated
incorrectly, this patch fixes the two issues.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c |  3 ++-
 fs/f2fs/segment.h | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8ef87f6e0fb2..91af3e8c9065 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1821,7 +1821,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 
 	se->valid_blocks = new_vblocks;
 	se->mtime = get_mtime(sbi);
-	SIT_I(sbi)->max_mtime = se->mtime;
+	if (se->mtime > SIT_I(sbi)->max_mtime)
+		SIT_I(sbi)->max_mtime = se->mtime;
 
 	/* Update valid block bitmap */
 	if (del > 0) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index c574131ac7e1..fe4ea82b08aa 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -748,9 +748,17 @@ static inline void set_to_next_sit(struct sit_info *sit_i, unsigned int start)
 static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	time64_t now = ktime_get_real_seconds();
-
-	return sit_i->elapsed_time + now - sit_i->mounted_time;
+	time64_t diff = 0, now = ktime_get_real_seconds();
+
+	if (now >= sit_i->mounted_time) {
+		diff = now - sit_i->mounted_time;
+	} else {
+		/* system time is set to the past */
+		diff = sit_i->mounted_time - now;
+		if (sit_i->elapsed_time >= diff)
+			return sit_i->elapsed_time - diff;
+	}
+	return sit_i->elapsed_time + diff;
 }
 
 static inline void set_summary(struct f2fs_summary *sum, nid_t nid,
-- 
2.17.0.391.g1f1cddd558b5
