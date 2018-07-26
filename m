Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E663C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50B020891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50B020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbeGZNmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:42:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9725 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730599AbeGZNmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:42:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6FD2DA1C47EC8;
        Thu, 26 Jul 2018 20:25:35 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:25:28 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>
Subject: [PATCH 10/25] staging: erofs: support special inode
Date:   Thu, 26 Jul 2018 20:21:53 +0800
Message-ID: <1532607728-103372-11-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patch adds to support special inode, such as block dev, char,
socket, pipe inode.

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/inode.c    | 36 ++++++++++++++++++++++++++++++++++--
 drivers/staging/erofs/internal.h |  1 +
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 15ed919..c011811 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -34,8 +34,18 @@ static int read_inode(struct inode *inode, void *data)
 		vi->inode_isize = sizeof(struct erofs_inode_v2);
 		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
 
-		vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
 		inode->i_mode = le16_to_cpu(v2->i_mode);
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+						S_ISLNK(inode->i_mode)) {
+			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
+		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+			inode->i_rdev =
+				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
+		} else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+			inode->i_rdev = 0;
+		} else {
+			return -EIO;
+		}
 
 		i_uid_write(inode, le32_to_cpu(v2->i_uid));
 		i_gid_write(inode, le32_to_cpu(v2->i_gid));
@@ -54,8 +64,18 @@ static int read_inode(struct inode *inode, void *data)
 		vi->inode_isize = sizeof(struct erofs_inode_v1);
 		vi->xattr_isize = ondisk_xattr_ibody_size(v1->i_xattr_icount);
 
-		vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
 		inode->i_mode = le16_to_cpu(v1->i_mode);
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+						S_ISLNK(inode->i_mode)) {
+			vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+			inode->i_rdev =
+				new_decode_dev(le32_to_cpu(v1->i_u.rdev));
+		} else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+			inode->i_rdev = 0;
+		} else {
+			return -EIO;
+		}
 
 		i_uid_write(inode, le16_to_cpu(v1->i_uid));
 		i_gid_write(inode, le16_to_cpu(v1->i_gid));
@@ -173,6 +193,12 @@ static int fill_inode(struct inode *inode, int isdir)
 				&page_symlink_inode_operations;
 #endif
 			inode_nohighmem(inode);
+		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+#ifdef CONFIG_EROFS_FS_XATTR
+			inode->i_op = &erofs_special_inode_operations;
+#endif
+			init_special_inode(inode, inode->i_mode, inode->i_rdev);
 		} else {
 			err = -EIO;
 			goto out_unlock;
@@ -232,6 +258,12 @@ struct inode *erofs_iget(struct super_block *sb,
 };
 #endif
 
+const struct inode_operations erofs_special_inode_operations = {
+#ifdef CONFIG_EROFS_FS_XATTR
+	.listxattr = erofs_listxattr,
+#endif
+};
+
 #ifdef CONFIG_EROFS_FS_XATTR
 const struct inode_operations erofs_fast_symlink_xattr_iops = {
 	.get_link = simple_get_link,
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 8a8caf0..5862705 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -252,6 +252,7 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 #ifdef CONFIG_EROFS_FS_XATTR
 extern const struct inode_operations erofs_symlink_xattr_iops;
 extern const struct inode_operations erofs_fast_symlink_xattr_iops;
+extern const struct inode_operations erofs_special_inode_operations;
 #endif
 
 static inline void set_inode_fast_symlink(struct inode *inode)
-- 
1.9.1

