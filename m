Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755870AbeEaRWG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755837AbeEaRWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:22:03 -0400
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: run fstrim asynchronously if runtime discard is on
Date: Thu, 31 May 2018 10:22:01 -0700
Message-Id: <20180531172201.8729-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to wait for whole bunch of discard candidates in fstrim, since
runtime discard will issue them in idle time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bef74d628f66..b1e58b10425f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2439,9 +2439,18 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
 	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
-	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
+
+	/*
+	 * We filed discard candidates, but actually we don't need to wait for
+	 * all of them, since they'll be issued in idle time along with runtime
+	 * discard option. User configuration looks like using runtime discard
+	 * or periodic fstrim instead of it.
+	 */
+	if (!test_opt(sbi, DISCARD)) {
+		trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
-	range->len = F2FS_BLK_TO_BYTES(trimmed);
+		range->len = F2FS_BLK_TO_BYTES(trimmed);
+	}
 out:
 	return err;
 }
-- 
2.17.0.441.gb46fe60e1d-goog
