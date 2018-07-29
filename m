Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A28FC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A4320881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A4320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbeG2XhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:37:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51610 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbeG2Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto7-0003WA-0c; Sun, 29 Jul 2018 22:04:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 11/16] jfs: switch to discard_new_inode()
Date:   Sun, 29 Jul 2018 23:04:48 +0100
Message-Id: <20180729220453.13431-11-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

we don't want open-by-handle to pick an in-core inode that
has failed setup halfway through.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/jfs/jfs_inode.c |  8 ++++----
 fs/jfs/namei.c     | 12 ++++--------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
index 5e9b7bb3aabf..96732c24b054 100644
--- a/fs/jfs/jfs_inode.c
+++ b/fs/jfs/jfs_inode.c
@@ -61,8 +61,7 @@ struct inode *ialloc(struct inode *parent, umode_t mode)
 	inode = new_inode(sb);
 	if (!inode) {
 		jfs_warn("ialloc: new_inode returned NULL!");
-		rc = -ENOMEM;
-		goto fail;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	jfs_inode = JFS_IP(inode);
@@ -141,9 +140,10 @@ struct inode *ialloc(struct inode *parent, umode_t mode)
 	dquot_drop(inode);
 	inode->i_flags |= S_NOQUOTA;
 	clear_nlink(inode);
-	unlock_new_inode(inode);
+	discard_new_inode(inode);
+	return ERR_PTR(rc);
+
 fail_put:
 	iput(inode);
-fail:
 	return ERR_PTR(rc);
 }
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 56c3fcbfe80e..14528c0ffe63 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -175,8 +175,7 @@ static int jfs_create(struct inode *dip, struct dentry *dentry, umode_t mode,
 	if (rc) {
 		free_ea_wmap(ip);
 		clear_nlink(ip);
-		unlock_new_inode(ip);
-		iput(ip);
+		discard_new_inode(ip);
 	} else {
 		d_instantiate_new(dentry, ip);
 	}
@@ -309,8 +308,7 @@ static int jfs_mkdir(struct inode *dip, struct dentry *dentry, umode_t mode)
 	if (rc) {
 		free_ea_wmap(ip);
 		clear_nlink(ip);
-		unlock_new_inode(ip);
-		iput(ip);
+		discard_new_inode(ip);
 	} else {
 		d_instantiate_new(dentry, ip);
 	}
@@ -1054,8 +1052,7 @@ static int jfs_symlink(struct inode *dip, struct dentry *dentry,
 	if (rc) {
 		free_ea_wmap(ip);
 		clear_nlink(ip);
-		unlock_new_inode(ip);
-		iput(ip);
+		discard_new_inode(ip);
 	} else {
 		d_instantiate_new(dentry, ip);
 	}
@@ -1441,8 +1438,7 @@ static int jfs_mknod(struct inode *dir, struct dentry *dentry,
 	if (rc) {
 		free_ea_wmap(ip);
 		clear_nlink(ip);
-		unlock_new_inode(ip);
-		iput(ip);
+		discard_new_inode(ip);
 	} else {
 		d_instantiate_new(dentry, ip);
 	}
-- 
2.11.0

