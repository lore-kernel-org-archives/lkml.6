Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757259AbeEJNVU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:21:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756948AbeEJNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:21:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 044DE60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From: Sahitya Tummala <stummala@codeaurora.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: Fix deadlock in shutdown ioctl
Date: Thu, 10 May 2018 18:50:44 +0530
Message-Id: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_ioc_shutdown() ioctl gets stuck in the below path
when going down with full sync (F2FS_GOING_DOWN_FULLSYNC)
option.

__switch_to+0x90/0xc4
percpu_down_write+0x8c/0xc0
freeze_super+0xec/0x1e4
freeze_bdev+0xc4/0xcc
f2fs_ioctl+0xc0c/0x1ce0
f2fs_compat_ioctl+0x98/0x1f0

Fix this by not holding write access during this ioctl.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/file.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b926df7..2c2e61b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1835,10 +1835,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	if (get_user(in, (__u32 __user *)arg))
 		return -EFAULT;
 
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
-
 	switch (in) {
 	case F2FS_GOING_DOWN_FULLSYNC:
 		sb = freeze_bdev(sb->s_bdev);
@@ -1878,7 +1874,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	f2fs_update_time(sbi, REQ_TIME);
 out:
-	mnt_drop_write_file(filp);
 	return ret;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
