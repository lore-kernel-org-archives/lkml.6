Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6249C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5EB21784
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5EB21784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbeHCSsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:48:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36148 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeHCSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:48:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fldIJ-0005VI-PC; Fri, 03 Aug 2018 16:51:15 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] hpfs: fix an inode leak in lookup, switch to d_splice_alias()
Date:   Fri,  3 Aug 2018 17:51:15 +0100
Message-Id: <20180803165115.21094-6-viro@ZenIV.linux.org.uk>
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
 fs/hpfs/dir.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index c83ece7facc5..d85230c84ef2 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -244,6 +244,7 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	result = iget_locked(dir->i_sb, ino);
 	if (!result) {
 		hpfs_error(dir->i_sb, "hpfs_lookup: can't get inode");
+		result = ERR_PTR(-ENOMEM);
 		goto bail1;
 	}
 	if (result->i_state & I_NEW) {
@@ -266,6 +267,8 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 
 	if (de->has_acl || de->has_xtd_perm) if (!sb_rdonly(dir->i_sb)) {
 		hpfs_error(result->i_sb, "ACLs or XPERM found. This is probably HPFS386. This driver doesn't support it now. Send me some info on these structures");
+		iput(result);
+		result = ERR_PTR(-EINVAL);
 		goto bail1;
 	}
 
@@ -301,29 +304,17 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 		}
 	}
 
+bail1:
 	hpfs_brelse4(&qbh);
 
 	/*
 	 * Made it.
 	 */
 
-	end:
-	end_add:
+end:
+end_add:
 	hpfs_unlock(dir->i_sb);
-	d_add(dentry, result);
-	return NULL;
-
-	/*
-	 * Didn't.
-	 */
-	bail1:
-	
-	hpfs_brelse4(&qbh);
-	
-	/*bail:*/
-
-	hpfs_unlock(dir->i_sb);
-	return ERR_PTR(-ENOENT);
+	return d_splice_alias(result, dentry);
 }
 
 const struct file_operations hpfs_dir_ops =
-- 
2.11.0

