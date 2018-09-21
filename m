Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B210C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C245C21566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C245C21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbeIUWYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390575AbeIUWYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F046309534F;
        Fri, 21 Sep 2018 16:34:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AD6730A6A95;
        Fri, 21 Sep 2018 16:34:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 33/34] afs: Use fs_context to pass parameters over automount
 [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     "Eric W. Biederman" <ebiederm@redhat.com>,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:34:35 +0100
Message-ID: <153754767536.17872.13487342115810911095.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 21 Sep 2018 16:34:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alter the AFS automounting code to create and modify an fs_context struct
when parameterising a new mount triggered by an AFS mountpoint rather than
constructing device name and option strings.

Also remove the cell=, vol= and rwpath options as they are then redundant.
The reason they existed is because the 'device name' may be derived
literally from a mountpoint object in the filesystem, so default cell and
parent-type information needed to be passed in by some other method from
the automount routines.  The vol= option didn't end up being used.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric W. Biederman <ebiederm@redhat.com>
---

 fs/afs/internal.h |    1 
 fs/afs/mntpt.c    |  148 +++++++++++++++++++++++++++--------------------------
 fs/afs/super.c    |   43 +--------------
 3 files changed, 78 insertions(+), 114 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 22d428052500..7a603398b69e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -36,7 +36,6 @@ struct pagevec;
 struct afs_call;
 
 struct afs_fs_context {
-	bool			rwpath;		/* T if the parent should be considered R/W */
 	bool			force;		/* T to force cell type */
 	bool			autocell;	/* T if set auto mount operation */
 	bool			dyn_root;	/* T if dynamic root */
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index c45aa1776591..16ee515b51c9 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -47,6 +47,8 @@ static DECLARE_DELAYED_WORK(afs_mntpt_expiry_timer, afs_mntpt_expiry_timed_out);
 
 static unsigned long afs_mntpt_expiry_timeout = 10 * 60;
 
+static const char afs_root_volume[] = "root.cell";
+
 /*
  * no valid lookup procedure on this sort of dir
  */
@@ -68,107 +70,107 @@ static int afs_mntpt_open(struct inode *inode, struct file *file)
 }
 
 /*
- * create a vfsmount to be automounted
+ * Set the parameters for the proposed superblock.
  */
-static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
+static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 {
-	struct afs_super_info *as;
-	struct vfsmount *mnt;
-	struct afs_vnode *vnode;
-	struct page *page;
-	char *devname, *options;
-	bool rwpath = false;
+	struct afs_fs_context *ctx = fc->fs_private;
+	struct afs_vnode *vnode = AFS_FS_I(d_inode(mntpt));
+	struct afs_cell *cell;
+	const char *p;
 	int ret;
 
-	_enter("{%pd}", mntpt);
-
-	BUG_ON(!d_inode(mntpt));
-
-	ret = -ENOMEM;
-	devname = (char *) get_zeroed_page(GFP_KERNEL);
-	if (!devname)
-		goto error_no_devname;
-
-	options = (char *) get_zeroed_page(GFP_KERNEL);
-	if (!options)
-		goto error_no_options;
-
-	vnode = AFS_FS_I(d_inode(mntpt));
 	if (test_bit(AFS_VNODE_PSEUDODIR, &vnode->flags)) {
 		/* if the directory is a pseudo directory, use the d_name */
-		static const char afs_root_cell[] = ":root.cell.";
 		unsigned size = mntpt->d_name.len;
 
-		ret = -ENOENT;
-		if (size < 2 || size > AFS_MAXCELLNAME)
-			goto error_no_page;
+		if (size < 2)
+			return -ENOENT;
 
+		p = mntpt->d_name.name;
 		if (mntpt->d_name.name[0] == '.') {
-			devname[0] = '%';
-			memcpy(devname + 1, mntpt->d_name.name + 1, size - 1);
-			memcpy(devname + size, afs_root_cell,
-			       sizeof(afs_root_cell));
-			rwpath = true;
-		} else {
-			devname[0] = '#';
-			memcpy(devname + 1, mntpt->d_name.name, size);
-			memcpy(devname + size + 1, afs_root_cell,
-			       sizeof(afs_root_cell));
+			size--;
+			p++;
+			ctx->type = AFSVL_RWVOL;
+			ctx->force = true;
+		}
+		if (size > AFS_MAXCELLNAME)
+			return -ENAMETOOLONG;
+
+		cell = afs_lookup_cell(ctx->net, p, size, NULL, false);
+		if (IS_ERR(cell)) {
+			pr_err("kAFS: unable to lookup cell '%pd'\n", mntpt);
+			return PTR_ERR(cell);
 		}
+		afs_put_cell(ctx->net, ctx->cell);
+		ctx->cell = cell;
+
+		ctx->volname = afs_root_volume;
+		ctx->volnamesz = sizeof(afs_root_volume) - 1;
 	} else {
 		/* read the contents of the AFS special symlink */
+		struct page *page;
 		loff_t size = i_size_read(d_inode(mntpt));
 		char *buf;
 
-		ret = -EINVAL;
 		if (size > PAGE_SIZE - 1)
-			goto error_no_page;
+			return -EINVAL;
 
 		page = read_mapping_page(d_inode(mntpt)->i_mapping, 0, NULL);
-		if (IS_ERR(page)) {
-			ret = PTR_ERR(page);
-			goto error_no_page;
-		}
+		if (IS_ERR(page))
+			return PTR_ERR(page);
 
-		ret = -EIO;
-		if (PageError(page))
-			goto error;
+		if (PageError(page)) {
+			put_page(page);
+			return -EIO;
+		}
 
-		buf = kmap_atomic(page);
-		memcpy(devname, buf, size);
-		kunmap_atomic(buf);
+		buf = kmap(page);
+		ret = vfs_parse_fs_string(fc, "source", buf, size);
+		kunmap(page);
 		put_page(page);
-		page = NULL;
+		if (ret < 0)
+			return ret;
 	}
 
-	/* work out what options we want */
-	as = AFS_FS_S(mntpt->d_sb);
-	if (as->cell) {
-		memcpy(options, "cell=", 5);
-		strcpy(options + 5, as->cell->name);
-		if ((as->volume && as->volume->type == AFSVL_RWVOL) || rwpath)
-			strcat(options, ",rwpath");
-	}
+	return 0;
+}
 
-	/* try and do the mount */
-	_debug("--- attempting mount %s -o %s ---", devname, options);
-	mnt = vfs_submount(mntpt, &afs_fs_type, devname,
-			   options, strlen(options) + 1);
-	_debug("--- mount result %p ---", mnt);
+/*
+ * create a vfsmount to be automounted
+ */
+static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
+{
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+	int ret;
+
+	BUG_ON(!d_inode(mntpt));
+
+	fc = vfs_new_fs_context(&afs_fs_type, mntpt, 0, 0,
+				FS_CONTEXT_FOR_SUBMOUNT);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	ret = afs_mntpt_set_params(fc, mntpt);
+	if (ret < 0)
+		goto error_fc;
+
+	ret = vfs_get_tree(fc);
+	if (ret < 0)
+		goto error_fc;
+
+	mnt = vfs_create_mount(fc, 0);
+	if (IS_ERR(mnt)) {
+		ret = PTR_ERR(mnt);
+		goto error_fc;
+	}
 
-	free_page((unsigned long) devname);
-	free_page((unsigned long) options);
-	_leave(" = %p", mnt);
+	put_fs_context(fc);
 	return mnt;
 
-error:
-	put_page(page);
-error_no_page:
-	free_page((unsigned long) options);
-error_no_options:
-	free_page((unsigned long) devname);
-error_no_devname:
-	_leave(" = %d", ret);
+error_fc:
+	put_fs_context(fc);
 	return ERR_PTR(ret);
 }
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 8d969fd4af40..944985e0a3c8 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -66,30 +66,21 @@ static atomic_t afs_count_active_inodes;
 
 enum afs_param {
 	Opt_autocell,
-	Opt_cell,
 	Opt_dyn,
-	Opt_rwpath,
 	Opt_source,
-	Opt_vol,
 	nr__afs_params
 };
 
 static const struct fs_parameter_spec afs_param_specs[nr__afs_params] = {
 	[Opt_autocell]	= { fs_param_is_flag },
-	[Opt_cell]	= { fs_param_is_string },
 	[Opt_dyn]	= { fs_param_is_flag },
-	[Opt_rwpath]	= { fs_param_is_flag },
 	[Opt_source]	= { fs_param_is_string },
-	[Opt_vol]	= { fs_param_is_string },
 };
 
 static const char *const afs_param_keys[nr__afs_params] = {
 	[Opt_autocell]	= "autocell",
-	[Opt_cell]	= "cell",
 	[Opt_dyn]	= "dyn",
-	[Opt_rwpath]	= "rwpath",
 	[Opt_source]	= "source",
-	[Opt_vol]	= "vol",
 };
 
 static const struct fs_parameter_description afs_fs_parameters = {
@@ -214,8 +205,8 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
  *
  * This can be one of the following:
  *	"%[cell:]volume[.]"		R/W volume
- *	"#[cell:]volume[.]"		R/O or R/W volume (rwpath=0),
- *					 or R/W (rwpath=1) volume
+ *	"#[cell:]volume[.]"		R/O or R/W volume (R/O parent),
+ *					 or R/W (R/W parent) volume
  *	"%[cell:]volume.readonly"	R/O volume
  *	"#[cell:]volume.readonly"	R/O volume
  *	"%[cell:]volume.backup"		Backup volume
@@ -246,9 +237,7 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 	}
 
 	/* determine the type of volume we're looking for */
-	ctx->type = AFSVL_ROVOL;
-	ctx->force = false;
-	if (ctx->rwpath || name[0] == '%') {
+	if (name[0] == '%') {
 		ctx->type = AFSVL_RWVOL;
 		ctx->force = true;
 	}
@@ -317,7 +306,6 @@ static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct fs_parse_result result;
 	struct afs_fs_context *ctx = fc->fs_private;
-	struct afs_cell *cell;
 	int opt;
 
 	opt = fs_parse(fc, &afs_fs_parameters, param, &result);
@@ -325,21 +313,6 @@ static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		return opt;
 
 	switch (opt) {
-	case Opt_cell:
-		if (param->size <= 0)
-			return -EINVAL;
-		if (param->size > AFS_MAXCELLNAME)
-			return -ENAMETOOLONG;
-
-		rcu_read_lock();
-		cell = afs_lookup_cell_rcu(ctx->net, param->string, param->size);
-		rcu_read_unlock();
-		if (IS_ERR(cell))
-			return PTR_ERR(cell);
-		afs_put_cell(ctx->net, ctx->cell);
-		ctx->cell = cell;
-		break;
-
 	case Opt_source:
 		return afs_parse_source(fc, param);
 
@@ -351,13 +324,6 @@ static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->dyn_root = true;
 		break;
 
-	case Opt_rwpath:
-		ctx->rwpath = true;
-		break;
-
-	case Opt_vol:
-		return invalf(fc, "'vol' param is obsolete");
-
 	default:
 		return -EINVAL;
 	}
@@ -625,9 +591,6 @@ static int afs_init_fs_context(struct fs_context *fc, struct dentry *reference)
 	struct afs_super_info *src_as;
 	struct afs_cell *cell;
 
-	if (current->nsproxy->net_ns != &init_net)
-		return -EINVAL;
-
 	ctx = kzalloc(sizeof(struct afs_fs_context), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;

