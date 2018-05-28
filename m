Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938764AbeE1MXW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164263AbeE1LBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:01:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 420/496] f2fs: fix to set KEEP_SIZE bit in f2fs_zero_range
Date: Mon, 28 May 2018 12:03:25 +0200
Message-Id: <20180528100337.453517242@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 17cd07ae95073c298af92c1ba14ac58ce84de33b ]

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/file.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1321,8 +1321,12 @@ static int f2fs_zero_range(struct inode
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
 
