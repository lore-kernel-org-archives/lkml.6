Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B91420657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfAQISS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:18:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbfAQISS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:18:18 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E521F326D8204A3BC4F3;
        Thu, 17 Jan 2019 16:18:14 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 16:18:05 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <phillip@squashfs.org.uk>, <linux-kernel@vger.kernel.org>
CC:     <houtao1@huawei.com>, <zhaohongjiang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] squashfs: fix mtime underflow on 64 bit system
Date:   Thu, 17 Jan 2019 16:21:48 +0800
Message-ID: <20190117082148.129347-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we change the file mtime to 1969, mksquashfs and mount,
the atime/mtime of this file will be underflow. The reason is
treating timestamps with the high bit set as positive
times(before 1970), which should be set as negative times
just like on 32 bit system. After this, the poissble range
of timestamps will be 1901-2038(prev is 1970-2106) on 64
bit system.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/squashfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index e9793b1e49a5..03a6ef77a2d2 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -72,7 +72,7 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	i_uid_write(inode, i_uid);
 	i_gid_write(inode, i_gid);
 	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
-	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
+	inode->i_mtime.tv_sec = (signed int)le32_to_cpu(sqsh_ino->mtime);
 	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
 	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec;
 	inode->i_mode = le16_to_cpu(sqsh_ino->mode);
--
2.16.2.dirty

