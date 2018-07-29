Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314DFC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC65120881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC65120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbeG2XhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:37:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51606 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbeG2Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto6-0003W4-R4; Sun, 29 Jul 2018 22:04:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 10/16] kill d_instantiate_no_diralias()
Date:   Sun, 29 Jul 2018 23:04:47 +0100
Message-Id: <20180729220453.13431-10-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The only user is fuse_create_new_entry(), and there it's used to
mitigate the same mkdir/open-by-handle race as in nfs_mkdir().
The same solution applies - unhash the mkdir argument, then
call d_splice_alias() and if that returns a reference to preexisting
alias, dput() and report success.  ->mkdir() argument left unhashed
negative with the preexisting alias moved in the right place is just
fine from the ->mkdir() callers point of view.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 27 ---------------------------
 fs/fuse/dir.c          | 15 +++++++++++----
 include/linux/dcache.h |  1 -
 3 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0e8e5de3c48a..a7d9e7a4c283 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1899,33 +1899,6 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_instantiate_new);
 
-/**
- * d_instantiate_no_diralias - instantiate a non-aliased dentry
- * @entry: dentry to complete
- * @inode: inode to attach to this dentry
- *
- * Fill in inode information in the entry.  If a directory alias is found, then
- * return an error (and drop inode).  Together with d_materialise_unique() this
- * guarantees that a directory inode may never have more than one alias.
- */
-int d_instantiate_no_diralias(struct dentry *entry, struct inode *inode)
-{
-	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
-
-	security_d_instantiate(entry, inode);
-	spin_lock(&inode->i_lock);
-	if (S_ISDIR(inode->i_mode) && !hlist_empty(&inode->i_dentry)) {
-		spin_unlock(&inode->i_lock);
-		iput(inode);
-		return -EBUSY;
-	}
-	__d_instantiate(entry, inode);
-	spin_unlock(&inode->i_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL(d_instantiate_no_diralias);
-
 struct dentry *d_make_root(struct inode *root_inode)
 {
 	struct dentry *res = NULL;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 56231b31f806..4bbae6ac75c3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -539,6 +539,7 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
+	struct dentry *d;
 	int err;
 	struct fuse_forget_link *forget;
 
@@ -570,11 +571,17 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 	}
 	kfree(forget);
 
-	err = d_instantiate_no_diralias(entry, inode);
-	if (err)
-		return err;
+	d_drop(entry);
+	d = d_splice_alias(inode, entry);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
 
-	fuse_change_entry_timeout(entry, &outarg);
+	if (d) {
+		fuse_change_entry_timeout(d, &outarg);
+		dput(d);
+	} else {
+		fuse_change_entry_timeout(entry, &outarg);
+	}
 	fuse_invalidate_attr(dir);
 	return 0;
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 66c6e17e61e5..0b83629a3d8f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -227,7 +227,6 @@ extern void d_instantiate(struct dentry *, struct inode *);
 extern void d_instantiate_new(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_unique(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
-extern int d_instantiate_no_diralias(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
-- 
2.11.0

