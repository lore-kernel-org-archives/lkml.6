Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCFEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D700C2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D700C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeI1WHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbeI1WHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so2676393wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W5sFQvzdZ2D7QPxU4NxcA/2Bv4FtyjjRa5bKpjgE5qc=;
        b=lCPdwMGz3IBNy670l3ag+AI2LKTm99qhRyD/E2gLKmCyidQXmEiUNQ0QoEJoj1nyEJ
         e1z4E+XEodExTUkwLYQQ92qZPLOwFmm6SsahCAIL8W8LQo+Xz1+tdfKd7Rf8ALq21vad
         VYEUiTF6t52sd9Ih+UCQF/14YMWNrVvaztBlcZSw+WNmMO8yqvM8atK67l30+5uggTrS
         K8lkLp2WHWrG1oK5rYDcby2LbTOMPjFcSmlHGJtCapfT2C6iMJcapi5lIRqKIS2y5b50
         xmcVQe6H0OnMlyqHDo9UsziPfWYbN+jH1WU0N/2FXgoE0oignpOwU6LD2fpUygSJQ8Tj
         d4/A==
X-Gm-Message-State: ABuFfojnKsflPP/+pjyltDdJAZ8cWWHficJioW+7S4HU9cvjCBoegdWt
        G9vNk3CWWPVq8fNnF5AAenpfq1eJbgQ=
X-Google-Smtp-Source: ACcGV62m4weswIVxK5F2q4dWVZAMK+d2VOh7ttjqj3A8FANwxqGc4q0SHWLGpiie40g+G2Ejn1xZUw==
X-Received: by 2002:a1c:e4c3:: with SMTP id b186-v6mr2174110wmh.116.1538149361122;
        Fri, 28 Sep 2018 08:42:41 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:40 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] fuse: split out readdir.c
Date:   Fri, 28 Sep 2018 17:42:26 +0200
Message-Id: <20180928154234.19270-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directory reading code is about to grow larger, so split it out from dir.c
into a new source file.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/Makefile  |   2 +-
 fs/fuse/dir.c     | 259 +-----------------------------------------------------
 fs/fuse/fuse_i.h  |  12 +++
 fs/fuse/readdir.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 274 insertions(+), 258 deletions(-)
 create mode 100644 fs/fuse/readdir.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 60da84a86dab..f7b807bc1027 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -5,4 +5,4 @@
 obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
 
-fuse-objs := dev.o dir.o file.o inode.o control.o xattr.o acl.o
+fuse-objs := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0979609d6eba..3a333b0ea9ad 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -16,22 +16,6 @@
 #include <linux/xattr.h>
 #include <linux/posix_acl.h>
 
-static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
-{
-	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct fuse_inode *fi = get_fuse_inode(dir);
-
-	if (!fc->do_readdirplus)
-		return false;
-	if (!fc->readdirplus_auto)
-		return true;
-	if (test_and_clear_bit(FUSE_I_ADVISE_RDPLUS, &fi->state))
-		return true;
-	if (ctx->pos == 0)
-		return true;
-	return false;
-}
-
 static void fuse_advise_use_readdirplus(struct inode *dir)
 {
 	struct fuse_inode *fi = get_fuse_inode(dir);
@@ -80,8 +64,7 @@ static u64 time_to_jiffies(u64 sec, u32 nsec)
  * Set dentry and possibly attribute timeouts from the lookup/mk*
  * replies
  */
-static void fuse_change_entry_timeout(struct dentry *entry,
-				      struct fuse_entry_out *o)
+void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o)
 {
 	fuse_dentry_settime(entry,
 		time_to_jiffies(o->entry_valid, o->entry_valid_nsec));
@@ -92,7 +75,7 @@ static u64 attr_timeout(struct fuse_attr_out *o)
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
 }
 
-static u64 entry_attr_timeout(struct fuse_entry_out *o)
+u64 entry_attr_timeout(struct fuse_entry_out *o)
 {
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
 }
@@ -262,11 +245,6 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	goto out;
 }
 
-static int invalid_nodeid(u64 nodeid)
-{
-	return !nodeid || nodeid == FUSE_ROOT_ID;
-}
-
 static int fuse_dentry_init(struct dentry *dentry)
 {
 	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
@@ -1165,239 +1143,6 @@ static int fuse_permission(struct inode *inode, int mask)
 	return err;
 }
 
-static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
-			 struct dir_context *ctx)
-{
-	while (nbytes >= FUSE_NAME_OFFSET) {
-		struct fuse_dirent *dirent = (struct fuse_dirent *) buf;
-		size_t reclen = FUSE_DIRENT_SIZE(dirent);
-		if (!dirent->namelen || dirent->namelen > FUSE_NAME_MAX)
-			return -EIO;
-		if (reclen > nbytes)
-			break;
-		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
-			return -EIO;
-
-		if (!dir_emit(ctx, dirent->name, dirent->namelen,
-			       dirent->ino, dirent->type))
-			break;
-
-		buf += reclen;
-		nbytes -= reclen;
-		ctx->pos = dirent->off;
-	}
-
-	return 0;
-}
-
-static int fuse_direntplus_link(struct file *file,
-				struct fuse_direntplus *direntplus,
-				u64 attr_version)
-{
-	struct fuse_entry_out *o = &direntplus->entry_out;
-	struct fuse_dirent *dirent = &direntplus->dirent;
-	struct dentry *parent = file->f_path.dentry;
-	struct qstr name = QSTR_INIT(dirent->name, dirent->namelen);
-	struct dentry *dentry;
-	struct dentry *alias;
-	struct inode *dir = d_inode(parent);
-	struct fuse_conn *fc;
-	struct inode *inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-
-	if (!o->nodeid) {
-		/*
-		 * Unlike in the case of fuse_lookup, zero nodeid does not mean
-		 * ENOENT. Instead, it only means the userspace filesystem did
-		 * not want to return attributes/handle for this entry.
-		 *
-		 * So do nothing.
-		 */
-		return 0;
-	}
-
-	if (name.name[0] == '.') {
-		/*
-		 * We could potentially refresh the attributes of the directory
-		 * and its parent?
-		 */
-		if (name.len == 1)
-			return 0;
-		if (name.name[1] == '.' && name.len == 2)
-			return 0;
-	}
-
-	if (invalid_nodeid(o->nodeid))
-		return -EIO;
-	if (!fuse_valid_type(o->attr.mode))
-		return -EIO;
-
-	fc = get_fuse_conn(dir);
-
-	name.hash = full_name_hash(parent, name.name, name.len);
-	dentry = d_lookup(parent, &name);
-	if (!dentry) {
-retry:
-		dentry = d_alloc_parallel(parent, &name, &wq);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-	}
-	if (!d_in_lookup(dentry)) {
-		struct fuse_inode *fi;
-		inode = d_inode(dentry);
-		if (!inode ||
-		    get_node_id(inode) != o->nodeid ||
-		    ((o->attr.mode ^ inode->i_mode) & S_IFMT)) {
-			d_invalidate(dentry);
-			dput(dentry);
-			goto retry;
-		}
-		if (is_bad_inode(inode)) {
-			dput(dentry);
-			return -EIO;
-		}
-
-		fi = get_fuse_inode(inode);
-		spin_lock(&fc->lock);
-		fi->nlookup++;
-		spin_unlock(&fc->lock);
-
-		forget_all_cached_acls(inode);
-		fuse_change_attributes(inode, &o->attr,
-				       entry_attr_timeout(o),
-				       attr_version);
-		/*
-		 * The other branch comes via fuse_iget()
-		 * which bumps nlookup inside
-		 */
-	} else {
-		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
-				  &o->attr, entry_attr_timeout(o),
-				  attr_version);
-		if (!inode)
-			inode = ERR_PTR(-ENOMEM);
-
-		alias = d_splice_alias(inode, dentry);
-		d_lookup_done(dentry);
-		if (alias) {
-			dput(dentry);
-			dentry = alias;
-		}
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-	}
-	if (fc->readdirplus_auto)
-		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
-	fuse_change_entry_timeout(dentry, o);
-
-	dput(dentry);
-	return 0;
-}
-
-static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
-			     struct dir_context *ctx, u64 attr_version)
-{
-	struct fuse_direntplus *direntplus;
-	struct fuse_dirent *dirent;
-	size_t reclen;
-	int over = 0;
-	int ret;
-
-	while (nbytes >= FUSE_NAME_OFFSET_DIRENTPLUS) {
-		direntplus = (struct fuse_direntplus *) buf;
-		dirent = &direntplus->dirent;
-		reclen = FUSE_DIRENTPLUS_SIZE(direntplus);
-
-		if (!dirent->namelen || dirent->namelen > FUSE_NAME_MAX)
-			return -EIO;
-		if (reclen > nbytes)
-			break;
-		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
-			return -EIO;
-
-		if (!over) {
-			/* We fill entries into dstbuf only as much as
-			   it can hold. But we still continue iterating
-			   over remaining entries to link them. If not,
-			   we need to send a FORGET for each of those
-			   which we did not link.
-			*/
-			over = !dir_emit(ctx, dirent->name, dirent->namelen,
-				       dirent->ino, dirent->type);
-			if (!over)
-				ctx->pos = dirent->off;
-		}
-
-		buf += reclen;
-		nbytes -= reclen;
-
-		ret = fuse_direntplus_link(file, direntplus, attr_version);
-		if (ret)
-			fuse_force_forget(file, direntplus->entry_out.nodeid);
-	}
-
-	return 0;
-}
-
-static int fuse_readdir(struct file *file, struct dir_context *ctx)
-{
-	int plus, err;
-	size_t nbytes;
-	struct page *page;
-	struct inode *inode = file_inode(file);
-	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req;
-	u64 attr_version = 0;
-	bool locked;
-
-	if (is_bad_inode(inode))
-		return -EIO;
-
-	req = fuse_get_req(fc, 1);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	page = alloc_page(GFP_KERNEL);
-	if (!page) {
-		fuse_put_request(fc, req);
-		return -ENOMEM;
-	}
-
-	plus = fuse_use_readdirplus(inode, ctx);
-	req->out.argpages = 1;
-	req->num_pages = 1;
-	req->pages[0] = page;
-	req->page_descs[0].length = PAGE_SIZE;
-	if (plus) {
-		attr_version = fuse_get_attr_version(fc);
-		fuse_read_fill(req, file, ctx->pos, PAGE_SIZE,
-			       FUSE_READDIRPLUS);
-	} else {
-		fuse_read_fill(req, file, ctx->pos, PAGE_SIZE,
-			       FUSE_READDIR);
-	}
-	locked = fuse_lock_inode(inode);
-	fuse_request_send(fc, req);
-	fuse_unlock_inode(inode, locked);
-	nbytes = req->out.args[0].size;
-	err = req->out.h.error;
-	fuse_put_request(fc, req);
-	if (!err) {
-		if (plus) {
-			err = parse_dirplusfile(page_address(page), nbytes,
-						file, ctx,
-						attr_version);
-		} else {
-			err = parse_dirfile(page_address(page), nbytes, file,
-					    ctx);
-		}
-	}
-
-	__free_page(page);
-	fuse_invalidate_atime(inode);
-	return err;
-}
-
 static const char *fuse_get_link(struct dentry *dentry,
 				 struct inode *inode,
 				 struct delayed_call *done)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f78e9614bb5f..5e01ea3d137d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -697,6 +697,11 @@ static inline u64 get_node_id(struct inode *inode)
 	return get_fuse_inode(inode)->nodeid;
 }
 
+static inline int invalid_nodeid(u64 nodeid)
+{
+	return !nodeid || nodeid == FUSE_ROOT_ID;
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
@@ -873,6 +878,9 @@ void fuse_invalidate_entry_cache(struct dentry *entry);
 
 void fuse_invalidate_atime(struct inode *inode);
 
+u64 entry_attr_timeout(struct fuse_entry_out *o);
+void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o);
+
 /**
  * Acquire reference to fuse_conn
  */
@@ -992,4 +1000,8 @@ struct posix_acl;
 struct posix_acl *fuse_get_acl(struct inode *inode, int type);
 int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 
+
+/* readdir.c */
+int fuse_readdir(struct file *file, struct dir_context *ctx);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
new file mode 100644
index 000000000000..3e100e00e21e
--- /dev/null
+++ b/fs/fuse/readdir.c
@@ -0,0 +1,259 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2018  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU GPL.
+  See the file COPYING.
+*/
+
+
+#include "fuse_i.h"
+#include <linux/posix_acl.h>
+
+static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
+{
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	struct fuse_inode *fi = get_fuse_inode(dir);
+
+	if (!fc->do_readdirplus)
+		return false;
+	if (!fc->readdirplus_auto)
+		return true;
+	if (test_and_clear_bit(FUSE_I_ADVISE_RDPLUS, &fi->state))
+		return true;
+	if (ctx->pos == 0)
+		return true;
+	return false;
+}
+
+static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
+			 struct dir_context *ctx)
+{
+	while (nbytes >= FUSE_NAME_OFFSET) {
+		struct fuse_dirent *dirent = (struct fuse_dirent *) buf;
+		size_t reclen = FUSE_DIRENT_SIZE(dirent);
+		if (!dirent->namelen || dirent->namelen > FUSE_NAME_MAX)
+			return -EIO;
+		if (reclen > nbytes)
+			break;
+		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+			return -EIO;
+
+		if (!dir_emit(ctx, dirent->name, dirent->namelen,
+			       dirent->ino, dirent->type))
+			break;
+
+		buf += reclen;
+		nbytes -= reclen;
+		ctx->pos = dirent->off;
+	}
+
+	return 0;
+}
+
+static int fuse_direntplus_link(struct file *file,
+				struct fuse_direntplus *direntplus,
+				u64 attr_version)
+{
+	struct fuse_entry_out *o = &direntplus->entry_out;
+	struct fuse_dirent *dirent = &direntplus->dirent;
+	struct dentry *parent = file->f_path.dentry;
+	struct qstr name = QSTR_INIT(dirent->name, dirent->namelen);
+	struct dentry *dentry;
+	struct dentry *alias;
+	struct inode *dir = d_inode(parent);
+	struct fuse_conn *fc;
+	struct inode *inode;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+
+	if (!o->nodeid) {
+		/*
+		 * Unlike in the case of fuse_lookup, zero nodeid does not mean
+		 * ENOENT. Instead, it only means the userspace filesystem did
+		 * not want to return attributes/handle for this entry.
+		 *
+		 * So do nothing.
+		 */
+		return 0;
+	}
+
+	if (name.name[0] == '.') {
+		/*
+		 * We could potentially refresh the attributes of the directory
+		 * and its parent?
+		 */
+		if (name.len == 1)
+			return 0;
+		if (name.name[1] == '.' && name.len == 2)
+			return 0;
+	}
+
+	if (invalid_nodeid(o->nodeid))
+		return -EIO;
+	if (!fuse_valid_type(o->attr.mode))
+		return -EIO;
+
+	fc = get_fuse_conn(dir);
+
+	name.hash = full_name_hash(parent, name.name, name.len);
+	dentry = d_lookup(parent, &name);
+	if (!dentry) {
+retry:
+		dentry = d_alloc_parallel(parent, &name, &wq);
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
+	}
+	if (!d_in_lookup(dentry)) {
+		struct fuse_inode *fi;
+		inode = d_inode(dentry);
+		if (!inode ||
+		    get_node_id(inode) != o->nodeid ||
+		    ((o->attr.mode ^ inode->i_mode) & S_IFMT)) {
+			d_invalidate(dentry);
+			dput(dentry);
+			goto retry;
+		}
+		if (is_bad_inode(inode)) {
+			dput(dentry);
+			return -EIO;
+		}
+
+		fi = get_fuse_inode(inode);
+		spin_lock(&fc->lock);
+		fi->nlookup++;
+		spin_unlock(&fc->lock);
+
+		forget_all_cached_acls(inode);
+		fuse_change_attributes(inode, &o->attr,
+				       entry_attr_timeout(o),
+				       attr_version);
+		/*
+		 * The other branch comes via fuse_iget()
+		 * which bumps nlookup inside
+		 */
+	} else {
+		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
+				  &o->attr, entry_attr_timeout(o),
+				  attr_version);
+		if (!inode)
+			inode = ERR_PTR(-ENOMEM);
+
+		alias = d_splice_alias(inode, dentry);
+		d_lookup_done(dentry);
+		if (alias) {
+			dput(dentry);
+			dentry = alias;
+		}
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
+	}
+	if (fc->readdirplus_auto)
+		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
+	fuse_change_entry_timeout(dentry, o);
+
+	dput(dentry);
+	return 0;
+}
+
+static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
+			     struct dir_context *ctx, u64 attr_version)
+{
+	struct fuse_direntplus *direntplus;
+	struct fuse_dirent *dirent;
+	size_t reclen;
+	int over = 0;
+	int ret;
+
+	while (nbytes >= FUSE_NAME_OFFSET_DIRENTPLUS) {
+		direntplus = (struct fuse_direntplus *) buf;
+		dirent = &direntplus->dirent;
+		reclen = FUSE_DIRENTPLUS_SIZE(direntplus);
+
+		if (!dirent->namelen || dirent->namelen > FUSE_NAME_MAX)
+			return -EIO;
+		if (reclen > nbytes)
+			break;
+		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+			return -EIO;
+
+		if (!over) {
+			/* We fill entries into dstbuf only as much as
+			   it can hold. But we still continue iterating
+			   over remaining entries to link them. If not,
+			   we need to send a FORGET for each of those
+			   which we did not link.
+			*/
+			over = !dir_emit(ctx, dirent->name, dirent->namelen,
+				       dirent->ino, dirent->type);
+			if (!over)
+				ctx->pos = dirent->off;
+		}
+
+		buf += reclen;
+		nbytes -= reclen;
+
+		ret = fuse_direntplus_link(file, direntplus, attr_version);
+		if (ret)
+			fuse_force_forget(file, direntplus->entry_out.nodeid);
+	}
+
+	return 0;
+}
+
+int fuse_readdir(struct file *file, struct dir_context *ctx)
+{
+	int plus, err;
+	size_t nbytes;
+	struct page *page;
+	struct inode *inode = file_inode(file);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	u64 attr_version = 0;
+	bool locked;
+
+	if (is_bad_inode(inode))
+		return -EIO;
+
+	req = fuse_get_req(fc, 1);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page) {
+		fuse_put_request(fc, req);
+		return -ENOMEM;
+	}
+
+	plus = fuse_use_readdirplus(inode, ctx);
+	req->out.argpages = 1;
+	req->num_pages = 1;
+	req->pages[0] = page;
+	req->page_descs[0].length = PAGE_SIZE;
+	if (plus) {
+		attr_version = fuse_get_attr_version(fc);
+		fuse_read_fill(req, file, ctx->pos, PAGE_SIZE,
+			       FUSE_READDIRPLUS);
+	} else {
+		fuse_read_fill(req, file, ctx->pos, PAGE_SIZE,
+			       FUSE_READDIR);
+	}
+	locked = fuse_lock_inode(inode);
+	fuse_request_send(fc, req);
+	fuse_unlock_inode(inode, locked);
+	nbytes = req->out.args[0].size;
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err) {
+		if (plus) {
+			err = parse_dirplusfile(page_address(page), nbytes,
+						file, ctx, attr_version);
+		} else {
+			err = parse_dirfile(page_address(page), nbytes, file,
+					    ctx);
+		}
+	}
+
+	__free_page(page);
+	fuse_invalidate_atime(inode);
+	return err;
+}
-- 
2.14.3

