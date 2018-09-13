Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9876FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B4620652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B4620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeIMTMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:12:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbeIMTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:12:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34CC1D20;
        Thu, 13 Sep 2018 14:02:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, nixiaoming <nixiaoming@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 117/197] selinux: cleanup dentry and inodes on error in selinuxfs
Date:   Thu, 13 Sep 2018 15:31:06 +0200
Message-Id: <20180913131846.229231657@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: nixiaoming <nixiaoming@huawei.com>

[ Upstream commit 7e4237faa7213c1cc1d0aa65a44c67ba4729ce9f ]

If the resource requested by d_alloc_name is not added to the linked
list through d_add, then dput needs to be called to release the
subsequent abnormal branch to avoid resource leakage.

Add missing dput to selinuxfs.c

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
[PM: tweak the subject line]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/selinuxfs.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1365,13 +1365,18 @@ static int sel_make_bools(struct selinux
 
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
@@ -1586,8 +1591,10 @@ static int sel_make_avc_files(struct den
 			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
-		if (!inode)
+		if (!inode) {
+			dput(dentry);
 			return -ENOMEM;
+		}
 
 		inode->i_fop = files[i].ops;
 		inode->i_ino = ++fsi->last_ino;
@@ -1632,8 +1639,10 @@ static int sel_make_initcon_files(struct
 			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-		if (!inode)
+		if (!inode) {
+			dput(dentry);
 			return -ENOMEM;
+		}
 
 		inode->i_fop = &sel_initcon_ops;
 		inode->i_ino = i|SEL_INITCON_INO_OFFSET;
@@ -1733,8 +1742,10 @@ static int sel_make_perm_files(char *obj
 
 		rc = -ENOMEM;
 		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-		if (!inode)
+		if (!inode) {
+			dput(dentry);
 			goto out;
+		}
 
 		inode->i_fop = &sel_perm_ops;
 		/* i+1 since perm values are 1-indexed */
@@ -1763,8 +1774,10 @@ static int sel_make_class_dir_entries(ch
 		return -ENOMEM;
 
 	inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		return -ENOMEM;
+	}
 
 	inode->i_fop = &sel_class_ops;
 	inode->i_ino = sel_class_to_ino(index);
@@ -1838,8 +1851,10 @@ static int sel_make_policycap(struct sel
 			return -ENOMEM;
 
 		inode = sel_make_inode(fsi->sb, S_IFREG | 0444);
-		if (inode == NULL)
+		if (inode == NULL) {
+			dput(dentry);
 			return -ENOMEM;
+		}
 
 		inode->i_fop = &sel_policycap_ops;
 		inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
@@ -1932,8 +1947,10 @@ static int sel_fill_super(struct super_b
 
 	ret = -ENOMEM;
 	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		goto err;
+	}
 
 	inode->i_ino = ++fsi->last_ino;
 	isec = (struct inode_security_struct *)inode->i_security;


