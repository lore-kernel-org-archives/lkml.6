Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeDYLia (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752413AbeDYLi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:38:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F139B21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix potential overflow
Date: Wed, 25 Apr 2018 19:38:17 +0800
Message-Id: <20180425113817.18189-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

In build_sit_entries(), if valid_blocks in SIT block is smaller than
valid_blocks in journal, for below calculation:

sbi->discard_blks += old_valid_blocks - se->valid_blocks;

There will be two times potential overflow:
- old_valid_blocks - se->valid_blocks will overflow, and be a very
large number.
- sbi->discard_blks += result will overflow again, comes out a correct
result accidently.

Anyway, it should be fixed.

Fixes: d600af236da5 ("f2fs: avoid unneeded loop in build_sit_entries")
Fixes: 1f43e2ad7bff ("f2fs: introduce CP_TRIMMED_FLAG to avoid unneeded discard")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a55647f61232..49fce2b56017 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3692,14 +3692,17 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 			} else {
 				memcpy(se->discard_map, se->cur_valid_map,
 							SIT_VBLOCK_MAP_SIZE);
-				sbi->discard_blks += old_valid_blocks -
-							se->valid_blocks;
+				sbi->discard_blks += old_valid_blocks;
+				sbi->discard_blks -= se->valid_blocks;
 			}
 		}
 
-		if (sbi->segs_per_sec > 1)
+		if (sbi->segs_per_sec > 1) {
 			get_sec_entry(sbi, start)->valid_blocks +=
-				se->valid_blocks - old_valid_blocks;
+							se->valid_blocks;
+			get_sec_entry(sbi, start)->valid_blocks -=
+							old_valid_blocks;
+		}
 	}
 	up_read(&curseg->journal_rwsem);
 
-- 
2.16.2.17.g38e79b1fd
