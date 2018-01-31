Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeAaBbx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:31:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60157 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752080AbeAaBbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:31:52 -0500
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to clear CP_TRIMMED_FLAG
Date: Wed, 31 Jan 2018 09:30:34 +0800
Message-ID: <20180131013034.107225-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once CP_TRIMMED_FLAG is set, after a reboot, we will never issue discard
before LBA becomes invalid again, fix it by clearing the flag in
checkpoint without CP_TRIMMED reason.

Fixes: 1f43e2ad7bff ("f2fs: introduce CP_TRIMMED_FLAG to avoid unneeded discard")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 998fe1d0213b..65becae99b84 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1166,6 +1166,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	if (cpc->reason & CP_TRIMMED)
 		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
 
 	if (cpc->reason & CP_UMOUNT)
 		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
-- 
2.15.0.55.gc2ece9dc4de6
