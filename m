Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933050AbeCMLd7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:33:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933037AbeCMLd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:33:57 -0400
From: sunqiuyang <sunqiuyang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC: <sunqiuyang@huawei.com>
Subject: [PATCH 1/1] f2fs: release locks before return in f2fs_ioc_gc_range()
Date: Tue, 13 Mar 2018 19:42:50 +0800
Message-ID: <20180313114250.29211-1-sunqiuyang@huawei.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiuyang Sun <sunqiuyang@huawei.com>

Currently, we will leave the kernel with locks still held when the gc_range
is invalid. This patch fixes the bug.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c4c27e6..ee88058 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2059,8 +2059,10 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 		return ret;
 
 	end = range.start + range.len;
-	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi))
-		return -EINVAL;
+	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi)) {
+		ret = -EINVAL;
+		goto out;
+	}
 do_more:
 	if (!range.sync) {
 		if (!mutex_trylock(&sbi->gc_mutex)) {
-- 
2.5.0
