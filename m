Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF58ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58976208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58976208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeISLZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:25:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbeISLZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:25:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 529E97C209003;
        Wed, 19 Sep 2018 13:49:28 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 19 Sep
 2018 13:49:21 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Miao Xie" <miaoxie@huawei.com>,
        Du Wei <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 1/6] staging: erofs: remove redundant CONFIG_EROFS_FS_XATTRs
Date:   Wed, 19 Sep 2018 13:49:05 +0800
Message-ID: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some CONFIG_EROFS_FS_XATTR conditions were added because of
the historial Linux kernel compatibility, which are unneeded now.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Hi all,

  These are cleanup patches in Chao's erofs-dev test tree for a while.
  Many of them are trivial.
  In order for all preview patches to keep up with the staging tree,
I resend them now.

Thanks,
Gao Xiang

 drivers/staging/erofs/inode.c    | 6 ------
 drivers/staging/erofs/internal.h | 6 ++----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index c46a8d4..da8693a 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -260,22 +260,16 @@ struct inode *erofs_iget(struct super_block *sb,
 const struct inode_operations erofs_generic_xattr_iops = {
 	.listxattr = erofs_listxattr,
 };
-#endif
 
-#ifdef CONFIG_EROFS_FS_XATTR
 const struct inode_operations erofs_symlink_xattr_iops = {
 	.get_link = page_get_link,
 	.listxattr = erofs_listxattr,
 };
-#endif
 
 const struct inode_operations erofs_special_inode_operations = {
-#ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
-#endif
 };
 
-#ifdef CONFIG_EROFS_FS_XATTR
 const struct inode_operations erofs_fast_symlink_xattr_iops = {
 	.get_link = simple_get_link,
 	.listxattr = erofs_listxattr,
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 0011b9d..cfcc6db 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -507,13 +507,11 @@ extern struct inode *erofs_iget(struct super_block *sb,
 int erofs_namei(struct inode *dir, struct qstr *name,
 	erofs_nid_t *nid, unsigned *d_type);
 
-/* xattr.c */
 #ifdef CONFIG_EROFS_FS_XATTR
+/* xattr.c */
 extern const struct xattr_handler *erofs_xattr_handlers[];
-#endif
 
-/* symlink */
-#ifdef CONFIG_EROFS_FS_XATTR
+/* symlink and special inode */
 extern const struct inode_operations erofs_symlink_xattr_iops;
 extern const struct inode_operations erofs_fast_symlink_xattr_iops;
 extern const struct inode_operations erofs_special_inode_operations;
-- 
1.9.1

