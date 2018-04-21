Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeDUJyR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 05:54:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750987AbeDUJyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 05:54:15 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to detect failure of dquot_initialize
Date: Sat, 21 Apr 2018 17:53:52 +0800
Message-ID: <20180421095352.15175-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dquot_initialize() can fail due to any exception inside quota subsystem,
f2fs needs to be aware of it, and return correct return value to caller.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a94531671217..5d710f7f2684 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2581,7 +2581,9 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 	}
 	f2fs_put_page(ipage, 1);
 
-	dquot_initialize(inode);
+	err = dquot_initialize(inode);
+	if (err)
+		goto out_unlock;
 
 	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
 	if (!IS_ERR(transfer_to[PRJQUOTA])) {
-- 
2.15.0.55.gc2ece9dc4de6
