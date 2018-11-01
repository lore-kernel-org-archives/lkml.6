Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244A620657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244A620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeKBGxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:53:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58252 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeKBGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:53:53 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gIKpu-0008JJ-43
        for linux-kernel@vger.kernel.org; Thu, 01 Nov 2018 21:49:06 +0000
Received: by mail-io1-f71.google.com with SMTP id q22-v6so2561329iog.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqO+O/aNpZPwRvx4yB9/pL17OMe9OsdTMxTohpBwNEc=;
        b=rURW5yCm5EB6e9japAXXavp/qQn8kffMePBUSCJxGUvVrDJzZTTnpnxOuP9/ikXed6
         Zq3M7MHHB8HundItq15pWQJ/DkI+dknONCM3qCJy9761NG15zIrdAD46zhI3S9jM9DGN
         vwI/O4B3fjW+Nz9iWKkcGyXaABlNkqHRQqJyA0cCP39JmjUghjcNY+UaAIsXCTBbmckj
         p/dGX+VnPbESt0t5CzjA1gHTNJKX8uKRoUjt7cBlwPONQUB/uVCPTUh8m2yP1sAyn+w0
         /feOMfIqXhkXRmZpcfz4LJ4/jxysydq+Fqk2oj6EKvpm8Idz1EoxsEbEJVJzHfFh39mZ
         xRRA==
X-Gm-Message-State: AGRZ1gLHV7emK9Un0kO5hKPPy2paXQ+8MMwvJaktjPKCN8dLifUWxxAZ
        +4WRETSqdUO93hquDl9TlHK53JjC2IyDGXELg6+/9GPX5NMiAGwcibLRA83cS1Wk2ofUObU/O34
        LOA0MSqLhKvVhOKwpfKCpLhw1tY7Vpt4EQl79p9pjpg==
X-Received: by 2002:a5e:980f:: with SMTP id s15-v6mr6702572ioj.87.1541108944830;
        Thu, 01 Nov 2018 14:49:04 -0700 (PDT)
X-Google-Smtp-Source: AJdET5ePUeRP/Exu0eFfpjFT6LSRHDYkH5G6cJyaQ+egHUuzEBr7b+uaZWetTlGcUMc0BptAWoumag==
X-Received: by 2002:a5e:980f:: with SMTP id s15-v6mr6702555ioj.87.1541108944308;
        Thu, 01 Nov 2018 14:49:04 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:7c8b:4047:a2ef:69cd])
        by smtp.gmail.com with ESMTPSA id z9-v6sm9648532iom.12.2018.11.01.14.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 14:49:03 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [RFC PATCH 2/6] shiftfs: map inodes to lower fs inodes instead of dentries
Date:   Thu,  1 Nov 2018 16:48:52 -0500
Message-Id: <20181101214856.4563-3-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101214856.4563-1-seth.forshee@canonical.com>
References: <20181101214856.4563-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since shiftfs inodes map to dentries in the lower fs, two links
to the same lowerfs inode create separate inodes in shiftfs. This
causes problems for inotify, as a watch on one of these files in
shiftfs will not see changes made to the underlying inode via the
other file.

Fix this by updating shiftfs to map its inodes to corresponding
inodes in the lower fs. Inodes are cached using the pointer to
the lower fs inode as the hash value. This fixes a second inotify
problem whereby a watch is set on an inode, the dentry is evicted
from the cache, and events on a new dentry are not reported back
to the watch original inode.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/shiftfs.c | 105 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 79 insertions(+), 26 deletions(-)

diff --git a/fs/shiftfs.c b/fs/shiftfs.c
index 6028244c2f42..b179a1be7bc1 100644
--- a/fs/shiftfs.c
+++ b/fs/shiftfs.c
@@ -22,6 +22,7 @@ struct shiftfs_super_info {
 
 static struct inode *shiftfs_new_inode(struct super_block *sb, umode_t mode,
 				       struct dentry *dentry);
+static void shiftfs_init_inode(struct inode *inode, umode_t mode);
 
 enum {
 	OPT_MARK,
@@ -278,15 +279,27 @@ static void shiftfs_fill_inode(struct inode *inode, struct dentry *dentry)
 		inode->i_opflags |= IOP_NOFOLLOW;
 
 	inode->i_mapping = reali->i_mapping;
-	inode->i_private = dentry;
+	inode->i_private = reali;
+	set_nlink(inode, reali->i_nlink);
+}
+
+static int shiftfs_inode_test(struct inode *inode, void *data)
+{
+	return inode->i_private == data;
+}
+
+static int shiftfs_inode_set(struct inode *inode, void *data)
+{
+	inode->i_private = data;
+	return 0;
 }
 
 static int shiftfs_make_object(struct inode *dir, struct dentry *dentry,
 			       umode_t mode, const char *symlink,
 			       struct dentry *hardlink, bool excl)
 {
-	struct dentry *real = dir->i_private, *new = dentry->d_fsdata;
-	struct inode *reali = real->d_inode, *newi;
+	struct dentry *new = dentry->d_fsdata;
+	struct inode *reali = dir->i_private, *inode, *newi;
 	const struct inode_operations *iop = reali->i_op;
 	int err;
 	const struct cred *oldcred, *newcred;
@@ -310,9 +323,14 @@ static int shiftfs_make_object(struct inode *dir, struct dentry *dentry,
 		return -EINVAL;
 
 
-	newi = shiftfs_new_inode(dentry->d_sb, mode, NULL);
-	if (!newi)
-		return -ENOMEM;
+	if (hardlink) {
+		inode = d_inode(hardlink);
+		ihold(inode);
+	} else {
+		inode = shiftfs_new_inode(dentry->d_sb, mode, NULL);
+		if (!inode)
+			return -ENOMEM;
+	}
 
 	oldcred = shiftfs_new_creds(&newcred, dentry->d_sb);
 
@@ -341,16 +359,33 @@ static int shiftfs_make_object(struct inode *dir, struct dentry *dentry,
 	if (err)
 		goto out_dput;
 
-	shiftfs_fill_inode(newi, new);
+	if (hardlink) {
+		WARN_ON(inode->i_private != new->d_inode);
+		inc_nlink(inode);
+	} else {
+		shiftfs_fill_inode(inode, new);
+
+		newi = inode_insert5(inode, (unsigned long)new->d_inode,
+				     shiftfs_inode_test, shiftfs_inode_set,
+				     new->d_inode);
+		if (newi != inode) {
+			pr_warn_ratelimited("shiftfs: newly created inode found in cache\n");
+			iput(inode);
+			inode = newi;
+		}
+	}
+
+	if (inode->i_state & I_NEW)
+		unlock_new_inode(inode);
 
-	d_instantiate(dentry, newi);
+	d_instantiate(dentry, inode);
 
 	new = NULL;
-	newi = NULL;
+	inode = NULL;
 
  out_dput:
 	dput(new);
-	iput(newi);
+	iput(inode);
 	inode_unlock(reali);
 
 	return err;
@@ -386,8 +421,8 @@ static int shiftfs_symlink(struct inode *dir, struct dentry *dentry,
 
 static int shiftfs_rm(struct inode *dir, struct dentry *dentry, bool rmdir)
 {
-	struct dentry *real = dir->i_private, *new = dentry->d_fsdata;
-	struct inode *reali = real->d_inode;
+	struct dentry *new = dentry->d_fsdata;
+	struct inode *reali = dir->i_private;
 	int err;
 	const struct cred *oldcred, *newcred;
 
@@ -400,6 +435,13 @@ static int shiftfs_rm(struct inode *dir, struct dentry *dentry, bool rmdir)
 	else
 		err = vfs_unlink(reali, new, NULL);
 
+	if (!err) {
+		if (rmdir)
+			clear_nlink(d_inode(dentry));
+		else
+			drop_nlink(d_inode(dentry));
+	}
+
 	shiftfs_old_creds(oldcred, &newcred);
 	inode_unlock(reali);
 
@@ -420,7 +462,8 @@ static int shiftfs_rename(struct inode *olddir, struct dentry *old,
 			  struct inode *newdir, struct dentry *new,
 			  unsigned int flags)
 {
-	struct dentry *rodd = olddir->i_private, *rndd = newdir->i_private,
+	struct dentry *rodd = old->d_parent->d_fsdata,
+		*rndd = new->d_parent->d_fsdata,
 		*realold = old->d_fsdata,
 		*realnew = new->d_fsdata, *trap;
 	struct inode *realolddir = rodd->d_inode, *realnewdir = rndd->d_inode;
@@ -448,8 +491,8 @@ static int shiftfs_rename(struct inode *olddir, struct dentry *old,
 static struct dentry *shiftfs_lookup(struct inode *dir, struct dentry *dentry,
 				     unsigned int flags)
 {
-	struct dentry *real = dir->i_private, *new;
-	struct inode *reali = real->d_inode, *newi;
+	struct dentry *real = dentry->d_parent->d_fsdata, *new;
+	struct inode *reali = real->d_inode, *newi, *inode;
 	const struct cred *oldcred, *newcred;
 
 	inode_lock(reali);
@@ -463,24 +506,30 @@ static struct dentry *shiftfs_lookup(struct inode *dir, struct dentry *dentry,
 
 	dentry->d_fsdata = new;
 
-	newi = NULL;
-	if (!new->d_inode)
+	inode = NULL;
+	newi = new->d_inode;
+	if (!newi)
 		goto out;
 
-	newi = shiftfs_new_inode(dentry->d_sb, new->d_inode->i_mode, new);
-	if (!newi) {
+	inode = iget5_locked(dentry->d_sb, (unsigned long)newi,
+			     shiftfs_inode_test, shiftfs_inode_set, newi);
+	if (!inode) {
 		dput(new);
 		return ERR_PTR(-ENOMEM);
 	}
+	if (inode->i_state & I_NEW) {
+		shiftfs_init_inode(inode, newi->i_mode);
+		shiftfs_fill_inode(inode, new);
+		unlock_new_inode(inode);
+	}
 
  out:
-	return d_splice_alias(newi, dentry);
+	return d_splice_alias(inode, dentry);
 }
 
 static int shiftfs_permission(struct inode *inode, int mask)
 {
-	struct dentry *real = inode->i_private;
-	struct inode *reali = real->d_inode;
+	struct inode *reali = inode->i_private;
 	const struct inode_operations *iop = reali->i_op;
 	int err;
 	const struct cred *oldcred, *newcred;
@@ -579,6 +628,14 @@ static struct inode *shiftfs_new_inode(struct super_block *sb, umode_t mode,
 	if (!inode)
 		return NULL;
 
+	shiftfs_init_inode(inode, mode);
+	shiftfs_fill_inode(inode, dentry);
+
+	return inode;
+}
+
+static void shiftfs_init_inode(struct inode *inode, umode_t mode)
+{
 	/*
 	 * our inode is completely vestigial.  All lookups, getattr
 	 * and permission checks are done on the underlying inode, so
@@ -591,10 +648,6 @@ static struct inode *shiftfs_new_inode(struct super_block *sb, umode_t mode,
 	inode->i_flags |= S_NOATIME | S_NOCMTIME;
 
 	inode->i_op = &shiftfs_inode_ops;
-
-	shiftfs_fill_inode(inode, dentry);
-
-	return inode;
 }
 
 static int shiftfs_show_options(struct seq_file *m, struct dentry *dentry)
-- 
2.19.1

