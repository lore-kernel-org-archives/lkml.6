Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeERGWG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:22:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERGWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:22:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7783C6055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From: Sahitya Tummala <stummala@codeaurora.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v3] f2fs: Fix deadlock in shutdown ioctl
Date: Fri, 18 May 2018 11:51:52 +0530
Message-Id: <1526624512-32241-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_ioc_shutdown() ioctl gets stuck in the below path
when issued with F2FS_GOING_DOWN_FULLSYNC option.

__switch_to+0x90/0xc4
percpu_down_write+0x8c/0xc0
freeze_super+0xec/0x1e4
freeze_bdev+0xc4/0xcc
f2fs_ioctl+0xc0c/0x1ce0
f2fs_compat_ioctl+0x98/0x1f0

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6b94f19..5d99fd1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1851,9 +1851,11 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	if (get_user(in, (__u32 __user *)arg))
 		return -EFAULT;
 
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
+	if (in != F2FS_GOING_DOWN_FULLSYNC) {
+		ret = mnt_want_write_file(filp);
+		if (ret)
+			return ret;
+	}
 
 	switch (in) {
 	case F2FS_GOING_DOWN_FULLSYNC:
@@ -1894,7 +1896,8 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	f2fs_update_time(sbi, REQ_TIME);
 out:
-	mnt_drop_write_file(filp);
+	if (in != F2FS_GOING_DOWN_FULLSYNC)
+		mnt_drop_write_file(filp);
 	return ret;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
