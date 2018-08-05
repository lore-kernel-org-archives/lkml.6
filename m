Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14833C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CECE217BD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 09:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CECE217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeHELwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 07:52:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbeHELwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 07:52:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DCF4D72CE2689;
        Sun,  5 Aug 2018 17:47:54 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.174) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Sun, 5 Aug 2018 17:47:46 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <paul@paul-moore.com>, <sds@tycho.nsa.gov>,
        <eparis@parisplace.org>, <jmorris@namei.org>, <serge@hallyn.com>,
        <nixiaoming@huawei.com>
CC:     <selinux@tycho.nsa.gov>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] selinuxfs: Fix the resource leak in the failed branch of sel_make_inode
Date:   Sun, 5 Aug 2018 17:10:36 +0800
Message-ID: <20180805091036.30035-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the resource requested by d_alloc_name is not added to the linked
list through d_add, then dput needs to be called to release the
subsequent abnormal branch to avoid resource leakage.

Add missing dput to selinuxfs.c

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 security/selinux/selinuxfs.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79d3709..0b66d728 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1365,13 +1365,18 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 
 		ret = -ENOMEM;
 		inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
-		if (!inode)
+		if (!inode) {
+			dput(dentry);
 			goto out;
+		}
 
 		ret = -ENAMETOOLONG;
 		len = snprintf(page, PAGE_SIZE, "/%s/%s", BOOL_DIR_NAME, names[i]);
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE) {
+			dput(dentry);
+			iput(inode);
 			goto out;
+		}
 
 		isec = (struct inode_security_struct *)inode->i_security;
 		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
@@ -1586,8 +1591,10 @@ static int sel_make_avc_files(struct dentry *dir)
 			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
-		if (!inode)
+		if (!inode) {
+			dput(dentry);
 			return -ENOMEM;
+		}
 
 		inode->i_fop = files[i].ops;
 		inode->i_ino = ++fsi->last_ino;
@@ -1632,8 +1639,10 @@ static int sel_make_initcon_files(struct dentry *dir)
 			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-		if (!inode)
+		if (!inode) {
+			dput(dentry);
 			return -ENOMEM;
+		}
 
 		inode->i_fop = &sel_initcon_ops;
 		inode->i_ino = i|SEL_INITCON_INO_OFFSET;
@@ -1733,8 +1742,10 @@ static int sel_make_perm_files(char *objclass, int classvalue,
 
 		rc = -ENOMEM;
 		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-		if (!inode)
+		if (!inode) {
+			dput(dentry);
 			goto out;
+		}
 
 		inode->i_fop = &sel_perm_ops;
 		/* i+1 since perm values are 1-indexed */
@@ -1763,8 +1774,10 @@ static int sel_make_class_dir_entries(char *classname, int index,
 		return -ENOMEM;
 
 	inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		return -ENOMEM;
+	}
 
 	inode->i_fop = &sel_class_ops;
 	inode->i_ino = sel_class_to_ino(index);
@@ -1838,8 +1851,10 @@ static int sel_make_policycap(struct selinux_fs_info *fsi)
 			return -ENOMEM;
 
 		inode = sel_make_inode(fsi->sb, S_IFREG | 0444);
-		if (inode == NULL)
+		if (inode == NULL) {
+			dput(dentry);
 			return -ENOMEM;
+		}
 
 		inode->i_fop = &sel_policycap_ops;
 		inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
@@ -1932,8 +1947,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 
 	ret = -ENOMEM;
 	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		goto err;
+	}
 
 	inode->i_ino = ++fsi->last_ino;
 	isec = (struct inode_security_struct *)inode->i_security;
-- 
2.10.1

