Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB57C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97D320881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97D320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbeG2Xg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:36:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51572 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeG2Xg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto6-0003VX-E9; Sun, 29 Jul 2018 22:04:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 06/16] udf: switch to discard_new_inode()
Date:   Sun, 29 Jul 2018 23:04:43 +0100
Message-Id: <20180729220453.13431-6-viro@ZenIV.linux.org.uk>
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
 fs/udf/namei.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index c586026508db..061d049c2620 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -608,8 +608,7 @@ static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
 	if (unlikely(!fi)) {
 		inode_dec_link_count(inode);
-		unlock_new_inode(inode);
-		iput(inode);
+		discard_new_inode(inode);
 		return err;
 	}
 	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
@@ -700,8 +699,7 @@ static int udf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	fi = udf_add_entry(inode, NULL, &fibh, &cfi, &err);
 	if (!fi) {
 		inode_dec_link_count(inode);
-		unlock_new_inode(inode);
-		iput(inode);
+		discard_new_inode(inode);
 		goto out;
 	}
 	set_nlink(inode, 2);
@@ -719,8 +717,7 @@ static int udf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (!fi) {
 		clear_nlink(inode);
 		mark_inode_dirty(inode);
-		unlock_new_inode(inode);
-		iput(inode);
+		discard_new_inode(inode);
 		goto out;
 	}
 	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
@@ -1047,8 +1044,7 @@ static int udf_symlink(struct inode *dir, struct dentry *dentry,
 out_no_entry:
 	up_write(&iinfo->i_data_sem);
 	inode_dec_link_count(inode);
-	unlock_new_inode(inode);
-	iput(inode);
+	discard_new_inode(inode);
 	goto out;
 }
 
-- 
2.11.0

