Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeEDJVS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:21:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751124AbeEDJVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:21:13 -0400
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs-tools: fix the sector_size to default value
Date: Fri, 4 May 2018 17:20:45 +0800
Message-ID: <1525425645-127945-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs-tools uses ioctl BLKSSZGET to get sector_size, however, this ioctl
will return a value which may be larger than 512 (according to the value
of q->limits.logical_block_size), then this will be inconsistent with
the start_sector, since start_sector is got from ioctl HDIO_GETGEO and
is always in 512 size unit for a sector. To fix this problem, just set
the sector_size to the default value 512.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 lib/libf2fs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 102e579..e160f2a 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -768,7 +768,6 @@ void get_kernel_uname_version(__u8 *version)
 int get_device_info(int i)
 {
 	int32_t fd = 0;
-	uint32_t sector_size;
 #ifndef BLKGETSIZE64
 	uint32_t total_sectors;
 #endif
@@ -822,12 +821,6 @@ int get_device_info(int i)
 	} else if (S_ISREG(stat_buf->st_mode)) {
 		dev->total_sectors = stat_buf->st_size / dev->sector_size;
 	} else if (S_ISBLK(stat_buf->st_mode)) {
-#ifdef BLKSSZGET
-		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
-			MSG(0, "\tError: Using the default sector size\n");
-		else if (dev->sector_size < sector_size)
-			dev->sector_size = sector_size;
-#endif
 #ifdef BLKGETSIZE64
 		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
 			MSG(0, "\tError: Cannot get the device size\n");
-- 
1.8.5.2
