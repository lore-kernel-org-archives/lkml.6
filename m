Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3407BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3882177A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3882177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeHCSsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:48:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36142 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHCSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:48:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fldIJ-0005Uz-HL; Fri, 03 Aug 2018 16:51:15 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] afs: switch dynroot lookups to d_splice_alias()
Date:   Fri,  3 Aug 2018 17:51:12 +0100
Message-Id: <20180803165115.21094-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180803165115.21094-1-viro@ZenIV.linux.org.uk>
References: <20180803165115.21094-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/dynroot.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 174e843f0633..40fea59067b3 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -143,7 +143,6 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 {
 	struct afs_vnode *vnode;
 	struct inode *inode;
-	int ret;
 
 	vnode = AFS_FS_I(dir);
 
@@ -161,21 +160,10 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 		return afs_lookup_atcell(dentry);
 
 	inode = afs_try_auto_mntpt(dentry, dir);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		if (ret == -ENOENT) {
-			d_add(dentry, NULL);
-			_leave(" = NULL [negative]");
-			return NULL;
-		}
-		_leave(" = %d [do]", ret);
-		return ERR_PTR(ret);
-	}
+	if (inode == ERR_PTR(-ENOENT))
+		inode = NULL;
 
-	d_add(dentry, inode);
-	_leave(" = 0 { ino=%lu v=%u }",
-	       d_inode(dentry)->i_ino, d_inode(dentry)->i_generation);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 }
 
 const struct inode_operations afs_dynroot_inode_operations = {
-- 
2.11.0

