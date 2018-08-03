Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56266C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125872177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125872177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeHCSsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:48:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36146 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeHCSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:48:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fldIJ-0005VD-Ml; Fri, 03 Aug 2018 16:51:15 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] afs_try_auto_mntpt(): return NULL instead of ERR_PTR(-ENOENT)
Date:   Fri,  3 Aug 2018 17:51:14 +0100
Message-Id: <20180803165115.21094-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180803165115.21094-1-viro@ZenIV.linux.org.uk>
References: <20180803165115.21094-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

simpler logics in callers that way

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/dir.c     | 2 --
 fs/afs/dynroot.c | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 3099349cedfa..ff6738787fcd 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -865,8 +865,6 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	inode = afs_do_lookup(dir, dentry, key);
 	if (inode == ERR_PTR(-ENOENT)) {
 		inode = afs_try_auto_mntpt(dentry, dir);
-		if (inode == ERR_PTR(-ENOENT))
-			inode = NULL;
 	} else {
 		dentry->d_fsdata =
 			(void *)(unsigned long)dvnode->status.data_version;
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 40fea59067b3..1e27a0171357 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -83,7 +83,7 @@ struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 
 out:
 	_leave("= %d", ret);
-	return ERR_PTR(ret);
+	return ret == -ENOENT ? NULL : ERR_PTR(ret);
 }
 
 /*
@@ -160,9 +160,6 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 		return afs_lookup_atcell(dentry);
 
 	inode = afs_try_auto_mntpt(dentry, dir);
-	if (inode == ERR_PTR(-ENOENT))
-		inode = NULL;
-
 	return d_splice_alias(inode, dentry);
 }
 
-- 
2.11.0

