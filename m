Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B17205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B17205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeIFRUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:20:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727609AbeIFRUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:20:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E507945ACAF13;
        Thu,  6 Sep 2018 20:44:47 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Thu, 6 Sep 2018 20:44:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to avoid quota inode leak in ->put_super
Date:   Thu, 6 Sep 2018 20:44:36 +0800
Message-ID: <20180906124436.89193-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180906124436.89193-1-yuchao0@huawei.com>
References: <20180906124436.89193-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic/019 reports below error:

 __quota_error: 1160 callbacks suppressed
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 VFS: Busy inodes after unmount of zram1. Self-destruct in 5 seconds.  Have a nice day...

If we failed in below path due to fail to write dquot block, we will miss
to release quota inode, fix it.

- f2fs_put_super
 - f2fs_quota_off_umount
  - f2fs_quota_off
   - f2fs_quota_sync   <-- failed
   - dquot_quota_off   <-- missed to call

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c026aaccf218..328f58647f4c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1900,10 +1900,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
 	for (type = 0; type < MAXQUOTAS; type++) {
 		err = f2fs_quota_off(sb, type);
 		if (err) {
+			int ret = dquot_quota_off(sb, type);
+
 			f2fs_msg(sb, KERN_ERR,
 				"Fail to turn off disk quota "
-				"(type: %d, err: %d), Please "
-				"run fsck to fix it.", type, err);
+				"(type: %d, err: %d, ret:%d), Please "
+				"run fsck to fix it.", type, err, ret);
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 		}
 	}
-- 
2.18.0.rc1

