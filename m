Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeDHMjR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 08:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbeDHMjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 08:39:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1059B21772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: correct return value of f2fs_trim_fs
Date: Sun,  8 Apr 2018 20:39:03 +0800
Message-Id: <20180408123903.16907-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Correct return value in two cases:
- return EINVAL if end boundary is out-of-range.
- return EIO if fs needs off-line check.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7150ab22f968..876dd9a511af 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2435,12 +2435,12 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 		return -EINVAL;
 
 	if (end <= MAIN_BLKADDR(sbi))
-		goto out;
+		return -EINVAL;
 
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"Found FS corruption, run fsck to fix.");
-		goto out;
+		return -EIO;
 	}
 
 	/* start/end segment number in main_area */
-- 
2.16.2.17.g38e79b1fd
