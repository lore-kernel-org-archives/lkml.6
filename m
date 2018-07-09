Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D613C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417A6208E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417A6208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeGIE4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:56:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754428AbeGIEyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBn-0003fx-Pk; Mon, 09 Jul 2018 04:54:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 19/27] cxl_getfile(): switch to alloc_file_pseudo()
Date:   Mon,  9 Jul 2018 05:54:09 +0100
Message-Id: <20180709045417.13988-19-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/misc/cxl/api.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 146a12fe6cb8..e0b9c00aecde 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -67,10 +67,8 @@ static struct file *cxl_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags)
 {
-	struct qstr this;
-	struct path path;
 	struct file *file;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	int rc;
 
 	/* strongly inspired by anon_inode_getfile() */
@@ -91,22 +89,11 @@ static struct file *cxl_getfile(const char *name,
 		goto err_fs;
 	}
 
-	file = ERR_PTR(-ENOMEM);
-	this.name = name;
-	this.len = strlen(name);
-	this.hash = 0;
-	path.dentry = d_alloc_pseudo(cxl_vfs_mount->mnt_sb, &this);
-	if (!path.dentry)
+	file = alloc_file_pseudo(inode, cxl_vfs_mount, name,
+				 OPEN_FMODE(flags), fops);
+	if (IS_ERR(file))
 		goto err_inode;
 
-	path.mnt = mntget(cxl_vfs_mount);
-	d_instantiate(path.dentry, inode);
-
-	file = alloc_file(&path, OPEN_FMODE(flags) | FMODE_OPENED, fops);
-	if (IS_ERR(file)) {
-		path_put(&path);
-		goto err_fs;
-	}
 	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = priv;
 
-- 
2.11.0

