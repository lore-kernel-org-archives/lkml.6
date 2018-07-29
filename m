Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BAFC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6508820881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6508820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeG2Xid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:38:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51588 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeG2Xg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto6-0003Vb-Hl; Sun, 29 Jul 2018 22:04:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 07/16] ext2: make sure that partially set up inodes won't be returned by ext2_iget()
Date:   Sun, 29 Jul 2018 23:04:44 +0100
Message-Id: <20180729220453.13431-7-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext2/ialloc.c | 3 +--
 fs/ext2/namei.c  | 9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 6484199b35d1..5c3d7b7e4975 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -611,8 +611,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 	dquot_drop(inode);
 	inode->i_flags |= S_NOQUOTA;
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	iput(inode);
+	discard_new_inode(inode);
 	return ERR_PTR(err);
 
 fail:
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 152453a91877..0c26dcc5d850 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -45,8 +45,7 @@ static inline int ext2_add_nondir(struct dentry *dentry, struct inode *inode)
 		return 0;
 	}
 	inode_dec_link_count(inode);
-	unlock_new_inode(inode);
-	iput(inode);
+	discard_new_inode(inode);
 	return err;
 }
 
@@ -192,8 +191,7 @@ static int ext2_symlink (struct inode * dir, struct dentry * dentry,
 
 out_fail:
 	inode_dec_link_count(inode);
-	unlock_new_inode(inode);
-	iput (inode);
+	discard_new_inode(inode);
 	goto out;
 }
 
@@ -261,8 +259,7 @@ static int ext2_mkdir(struct inode * dir, struct dentry * dentry, umode_t mode)
 out_fail:
 	inode_dec_link_count(inode);
 	inode_dec_link_count(inode);
-	unlock_new_inode(inode);
-	iput(inode);
+	discard_new_inode(inode);
 out_dir:
 	inode_dec_link_count(dir);
 	goto out;
-- 
2.11.0

