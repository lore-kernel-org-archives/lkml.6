Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C947218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfAYMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:02:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfAYMCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:02:45 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7A07DF85E9AB144316E9;
        Fri, 25 Jan 2019 20:02:42 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.214)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 25 Jan 2019 20:02:34
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/2] staging: erofs: complete POSIX ACL support
Date:   Fri, 25 Jan 2019 20:01:04 +0800
Message-ID: <20190125120104.15604-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190125115103.47250-1-gaoxiang25@huawei.com>
References: <20190125115103.47250-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add .get_acl() to read the file's acl
from its xattrs to make POSIX ACL usable.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 This [PATCH 2/2] currently hasn't tested, please ignore temporarily...
 I will test it asap...

Thanks,
Gao Xiang

 drivers/staging/erofs/inode.c |  3 +++
 drivers/staging/erofs/namei.c |  1 +
 drivers/staging/erofs/xattr.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/staging/erofs/xattr.h |  6 ++++++
 4 files changed, 50 insertions(+)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 4f04f7c38cf2..924b8dfc7a8f 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -287,6 +287,7 @@ const struct inode_operations erofs_generic_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
+	.get_acl = erofs_get_acl,
 };
 
 const struct inode_operations erofs_symlink_iops = {
@@ -294,6 +295,7 @@ const struct inode_operations erofs_symlink_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
+	.get_acl = erofs_get_acl,
 };
 
 const struct inode_operations erofs_fast_symlink_iops = {
@@ -301,5 +303,6 @@ const struct inode_operations erofs_fast_symlink_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
+	.get_acl = erofs_get_acl,
 };
 
diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index 7fed1f996ab0..b1752adc5934 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -238,5 +238,6 @@ const struct inode_operations erofs_dir_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
+	.get_acl = erofs_get_acl,
 };
 
diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index eca65df46133..ee66ebffbb93 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -644,3 +644,43 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	return shared_listxattr(&it);
 }
 
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+struct posix_acl *erofs_get_acl(struct inode *inode, int type)
+{
+	struct posix_acl *acl;
+	int ea_prefix, rc;
+	char *ea_name;
+	char *value = NULL;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		ea_prefix = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS;
+		ea_name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+	case ACL_TYPE_DEFAULT:
+		ea_prefix = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT;
+		ea_name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	rc = erofs_getxattr(inode, ea_prefix, ea_name, NULL, 0);
+	if (rc > 0) {
+		value = kvmalloc(rc, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		rc = erofs_getxattr(inode, ea_prefix, ea_name, value, rc);
+	}
+
+	if (rc == -ENOATTR)
+		acl = NULL;
+	else if (rc < 0)
+		acl = ERR_PTR(rc);
+	else
+		acl = posix_acl_from_xattr(&init_user_ns, value, rc);
+	kvfree(value);
+	return acl;
+}
+#endif
+
diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 634dae9aaa0b..35ba5ac2139a 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -87,5 +87,11 @@ static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
 }
 #endif
 
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+struct posix_acl *erofs_get_acl(struct inode *inode, int type);
+#else
+#define erofs_get_acl	(NULL)
+#endif
+
 #endif
 
-- 
2.14.4

