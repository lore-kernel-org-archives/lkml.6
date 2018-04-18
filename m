Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeDRJpW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:45:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38426 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751830AbeDRJpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:45:21 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: fix return value in f2fs_ioc_commit_atomic_write
Date: Wed, 18 Apr 2018 17:45:02 +0800
Message-ID: <20180418094505.98888-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
In-Reply-To: <20180418094505.98888-1-yuchao0@huawei.com>
References: <20180418094505.98888-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_ioc_commit_atomic_write, if file is volatile, return -EINVAL to
indicate that commit failure.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 408471bf4799..7c90ded5a431 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1726,8 +1726,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 
-	if (f2fs_is_volatile_file(inode))
+	if (f2fs_is_volatile_file(inode)) {
+		ret = -EINVAL;
 		goto err_out;
+	}
 
 	if (f2fs_is_atomic_file(inode)) {
 		ret = commit_inmem_pages(inode);
-- 
2.15.0.55.gc2ece9dc4de6
