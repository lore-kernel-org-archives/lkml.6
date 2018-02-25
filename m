Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeBYPmh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 10:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751815AbeBYPmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 10:42:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837DA21777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to set KEEP_SIZE bit in f2fs_zero_range
Date: Sun, 25 Feb 2018 23:38:21 +0800
Message-Id: <20180225153821.3292-1-chao@kernel.org>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

As Jayashree Mohan reported:

A simple workload to reproduce this would be :
1. create foo
2. Write (8K - 16K)  // foo size = 16K now
3. fsync()
4. falloc zero_range , keep_size (4202496 - 4210688) // foo size must be 16K
5. fdatasync()
Crash now

On recovery, we see that the file size is 4210688 and not 16K, which
violates the semantics of keep_size flag. We have a test case to
reproduce this using CrashMonkey on 4.15 kernel. Try this out by
simply running :
 ./c_harness -f /dev/sda -d /dev/cow_ram0 -t f2fs -e 102400  -P -v
 tests/generic_468_zero.so

The root cause is that we miss to set KEEP_SIZE bit correctly in zero_range
when zeroing block cross EOF with FALLOC_FL_KEEP_SIZE, let's fix this
missing case.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f64bcd0a7f73..6a202e5a6386 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1348,8 +1348,12 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	}
 
 out:
-	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size)
-		f2fs_i_size_write(inode, new_size);
+	if (new_size > i_size_read(inode)) {
+		if (mode & FALLOC_FL_KEEP_SIZE)
+			file_set_keep_isize(inode);
+		else
+			f2fs_i_size_write(inode, new_size);
+	}
 out_sem:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 
-- 
2.14.1.145.gb3622a4ee
