Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737220866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfAPCzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:55:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727883AbfAPCzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:55:18 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91D187845E147E63F13F;
        Wed, 16 Jan 2019 10:55:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 10:54:57 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <arve@android.com>,
        <tkjos@android.com>, <maco@android.com>, <joel@joelfernandes.org>,
        <christian@brauner.io>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] binderfs: fix error return code in binderfs_fill_super()
Date:   Wed, 16 Jan 2019 03:01:04 +0000
Message-ID: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code -ENOMEM from the new_inode() and
d_make_root() error handling cases instead of 0, as done elsewhere in
this function.

Fixes: 3ad20fe393b3 ("binder: implement binderfs")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/android/binderfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 9518e2e..2bf4b2b 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -519,8 +519,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = info;
 
 	inode = new_inode(sb);
-	if (!inode)
+	if (!inode) {
+		ret = -ENOMEM;
 		goto err_without_dentry;
+	}
 
 	inode->i_ino = FIRST_INODE;
 	inode->i_fop = &simple_dir_operations;
@@ -530,8 +532,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	set_nlink(inode, 2);
 
 	sb->s_root = d_make_root(inode);
-	if (!sb->s_root)
+	if (!sb->s_root) {
+		ret = -ENOMEM;
 		goto err_without_dentry;
+	}
 
 	ret = binderfs_binder_ctl_create(sb);
 	if (ret)



