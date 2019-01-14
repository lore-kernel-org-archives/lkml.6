Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC89C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC2D2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfANLmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:42:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfANLmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:42:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F9AB23C4E5189FF304F;
        Mon, 14 Jan 2019 19:42:10 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.204)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 14 Jan 2019 19:42:00
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 3/5] staging: erofs: remove unneeded inode_operations
Date:   Mon, 14 Jan 2019 19:40:24 +0800
Message-ID: <20190114114026.11728-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190114114026.11728-1-gaoxiang25@huawei.com>
References: <20190114114026.11728-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, EROFS uses generic iops when xattr is off,
it seems unnecessary and a lot of extra code is there.
Let's follow what other filesystems do instead.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/inode.c    | 38 ++++++++++++------------------------
 drivers/staging/erofs/internal.h | 42 +++++++++++++++++-----------------------
 drivers/staging/erofs/namei.c    |  4 ----
 drivers/staging/erofs/xattr.h    |  4 ----
 4 files changed, 30 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index f99954dbfdb5..4f04f7c38cf2 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -184,32 +184,18 @@ static int fill_inode(struct inode *inode, int isdir)
 	if (!err) {
 		/* setup the new inode */
 		if (S_ISREG(inode->i_mode)) {
-#ifdef CONFIG_EROFS_FS_XATTR
-			inode->i_op = &erofs_generic_xattr_iops;
-#endif
+			inode->i_op = &erofs_generic_iops;
 			inode->i_fop = &generic_ro_fops;
 		} else if (S_ISDIR(inode->i_mode)) {
-			inode->i_op =
-#ifdef CONFIG_EROFS_FS_XATTR
-				&erofs_dir_xattr_iops;
-#else
-				&erofs_dir_iops;
-#endif
+			inode->i_op = &erofs_dir_iops;
 			inode->i_fop = &erofs_dir_fops;
 		} else if (S_ISLNK(inode->i_mode)) {
 			/* by default, page_get_link is used for symlink */
-			inode->i_op =
-#ifdef CONFIG_EROFS_FS_XATTR
-				&erofs_symlink_xattr_iops,
-#else
-				&page_symlink_inode_operations;
-#endif
+			inode->i_op = &erofs_symlink_iops;
 			inode_nohighmem(inode);
 		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
-#ifdef CONFIG_EROFS_FS_XATTR
-			inode->i_op = &erofs_special_inode_operations;
-#endif
+			inode->i_op = &erofs_generic_iops;
 			init_special_inode(inode, inode->i_mode, inode->i_rdev);
 		} else {
 			err = -EIO;
@@ -297,23 +283,23 @@ struct inode *erofs_iget(struct super_block *sb,
 	return inode;
 }
 
+const struct inode_operations erofs_generic_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
-const struct inode_operations erofs_generic_xattr_iops = {
 	.listxattr = erofs_listxattr,
+#endif
 };
 
-const struct inode_operations erofs_symlink_xattr_iops = {
+const struct inode_operations erofs_symlink_iops = {
 	.get_link = page_get_link,
+#ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
+#endif
 };
 
-const struct inode_operations erofs_special_inode_operations = {
-	.listxattr = erofs_listxattr,
-};
-
-const struct inode_operations erofs_fast_symlink_xattr_iops = {
+const struct inode_operations erofs_fast_symlink_iops = {
 	.get_link = simple_get_link,
+#ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
-};
 #endif
+};
 
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 192f4028d85d..ae4f2555f497 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -414,8 +414,6 @@ static inline bool is_inode_layout_inline(struct inode *inode)
 }
 
 extern const struct super_operations erofs_sops;
-extern const struct inode_operations erofs_dir_iops;
-extern const struct file_operations erofs_dir_fops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -559,37 +557,33 @@ static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
 extern struct inode *erofs_iget(struct super_block *sb,
 	erofs_nid_t nid, bool dir);
 
-/* dir.c */
-int erofs_namei(struct inode *dir, struct qstr *name,
-	erofs_nid_t *nid, unsigned *d_type);
-
-#ifdef CONFIG_EROFS_FS_XATTR
-/* xattr.c */
-extern const struct xattr_handler *erofs_xattr_handlers[];
-
-/* symlink and special inode */
-extern const struct inode_operations erofs_symlink_xattr_iops;
-extern const struct inode_operations erofs_fast_symlink_xattr_iops;
-extern const struct inode_operations erofs_special_inode_operations;
-#endif
+extern const struct inode_operations erofs_generic_iops;
+extern const struct inode_operations erofs_symlink_iops;
+extern const struct inode_operations erofs_fast_symlink_iops;
 
 static inline void set_inode_fast_symlink(struct inode *inode)
 {
-#ifdef CONFIG_EROFS_FS_XATTR
-	inode->i_op = &erofs_fast_symlink_xattr_iops;
-#else
-	inode->i_op = &simple_symlink_inode_operations;
-#endif
+	inode->i_op = &erofs_fast_symlink_iops;
 }
 
 static inline bool is_inode_fast_symlink(struct inode *inode)
 {
+	return inode->i_op == &erofs_fast_symlink_iops;
+}
+
+/* namei.c */
+extern const struct inode_operations erofs_dir_iops;
+
+int erofs_namei(struct inode *dir, struct qstr *name,
+		erofs_nid_t *nid, unsigned int *d_type);
+
+/* dir.c */
+extern const struct file_operations erofs_dir_fops;
+
 #ifdef CONFIG_EROFS_FS_XATTR
-	return inode->i_op == &erofs_fast_symlink_xattr_iops;
-#else
-	return inode->i_op == &simple_symlink_inode_operations;
+/* xattr.c */
+extern const struct xattr_handler *erofs_xattr_handlers[];
 #endif
-}
 
 static inline void *erofs_vmap(struct page **pages, unsigned int count)
 {
diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index 5596c52e246d..7fed1f996ab0 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -235,10 +235,6 @@ static struct dentry *erofs_lookup(struct inode *dir,
 
 const struct inode_operations erofs_dir_iops = {
 	.lookup = erofs_lookup,
-};
-
-const struct inode_operations erofs_dir_xattr_iops = {
-	.lookup = erofs_lookup,
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 0c7379282fc5..810fc947701d 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -68,10 +68,6 @@ static const struct xattr_handler *xattr_handler_map[] = {
 }
 
 #ifdef CONFIG_EROFS_FS_XATTR
-
-extern const struct inode_operations erofs_generic_xattr_iops;
-extern const struct inode_operations erofs_dir_xattr_iops;
-
 int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
 #else
-- 
2.14.4

