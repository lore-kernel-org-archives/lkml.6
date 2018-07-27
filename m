Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF82C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCED720862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCED720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbeG0S4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:56:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388999AbeG0S4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62119805A530;
        Fri, 27 Jul 2018 17:33:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 893361C5B9;
        Fri, 27 Jul 2018 17:33:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/38] hugetlbfs: Convert to fs_context [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:33:51 +0100
Message-ID: <153271283107.9458.15462668270844547177.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:33:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:33:52 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the hugetlbfs to use the fs_context during mount.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/hugetlbfs/inode.c |  392 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 232 insertions(+), 160 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 76fb8eb2bea8..d1fb9311d18a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -27,7 +27,7 @@
 #include <linux/backing-dev.h>
 #include <linux/hugetlb.h>
 #include <linux/pagevec.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
 #include <linux/dnotify.h>
@@ -45,11 +45,17 @@ const struct file_operations hugetlbfs_file_operations;
 static const struct inode_operations hugetlbfs_dir_inode_operations;
 static const struct inode_operations hugetlbfs_inode_operations;
 
-struct hugetlbfs_config {
+enum hugetlbfs_size_type { NO_SIZE, SIZE_STD, SIZE_PERCENT };
+
+struct hugetlbfs_fs_context {
 	struct hstate		*hstate;
+	unsigned long long	max_size_opt;
+	unsigned long long	min_size_opt;
 	long			max_hpages;
 	long			nr_inodes;
 	long			min_hpages;
+	enum hugetlbfs_size_type max_val_type;
+	enum hugetlbfs_size_type min_val_type;
 	kuid_t			uid;
 	kgid_t			gid;
 	umode_t			mode;
@@ -57,22 +63,44 @@ struct hugetlbfs_config {
 
 int sysctl_hugetlb_shm_group;
 
-enum {
-	Opt_size, Opt_nr_inodes,
-	Opt_mode, Opt_uid, Opt_gid,
-	Opt_pagesize, Opt_min_size,
-	Opt_err,
+enum hugetlb_param {
+	Opt_gid,
+	Opt_min_size,
+	Opt_mode,
+	Opt_nr_inodes,
+	Opt_pagesize,
+	Opt_size,
+	Opt_uid,
+	nr__hugetlb_params
+};
+
+static const struct fs_parameter_spec hugetlb_param_specs[nr__hugetlb_params] = {
+	[Opt_gid]	= { fs_param_is_u32 },
+	[Opt_min_size]	= { fs_param_is_string },
+	[Opt_mode]	= { fs_param_is_u32 },
+	[Opt_nr_inodes]	= { fs_param_is_string },
+	[Opt_pagesize]	= { fs_param_is_string },
+	[Opt_size]	= { fs_param_is_string },
+	[Opt_uid]	= { fs_param_is_u32 },
+};
+
+static const struct constant_table hugetlb_param_keys[] = {
+	{ "gid",	Opt_gid },
+	{ "min_size",	Opt_min_size },
+	{ "mode",	Opt_mode },
+	{ "nr_inodes",	Opt_nr_inodes },
+	{ "pagesize",	Opt_pagesize },
+	{ "size",	Opt_size },
+	{ "uid",	Opt_uid },
 };
 
-static const match_table_t tokens = {
-	{Opt_size,	"size=%s"},
-	{Opt_nr_inodes,	"nr_inodes=%s"},
-	{Opt_mode,	"mode=%o"},
-	{Opt_uid,	"uid=%u"},
-	{Opt_gid,	"gid=%u"},
-	{Opt_pagesize,	"pagesize=%s"},
-	{Opt_min_size,	"min_size=%s"},
-	{Opt_err,	NULL},
+static const struct fs_parameter_description hugetlb_fs_parameters = {
+	.name		= "hugetlbfs",
+	.nr_params	= nr__hugetlb_params,
+	.nr_keys	= ARRAY_SIZE(hugetlb_param_keys),
+	.keys		= hugetlb_param_keys,
+	.specs		= hugetlb_param_specs,
+	.no_source	= true,
 };
 
 #ifdef CONFIG_NUMA
@@ -708,16 +736,16 @@ static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
 }
 
 static struct inode *hugetlbfs_get_root(struct super_block *sb,
-					struct hugetlbfs_config *config)
+					struct hugetlbfs_fs_context *ctx)
 {
 	struct inode *inode;
 
 	inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_mode = S_IFDIR | config->mode;
-		inode->i_uid = config->uid;
-		inode->i_gid = config->gid;
+		inode->i_mode = S_IFDIR | ctx->mode;
+		inode->i_uid = ctx->uid;
+		inode->i_gid = ctx->gid;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_op = &hugetlbfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
@@ -1081,8 +1109,6 @@ static const struct super_operations hugetlbfs_ops = {
 	.show_options	= hugetlbfs_show_options,
 };
 
-enum hugetlbfs_size_type { NO_SIZE, SIZE_STD, SIZE_PERCENT };
-
 /*
  * Convert size option passed from command line to number of huge pages
  * in the pool specified by hstate.  Size option could be in bytes
@@ -1105,171 +1131,153 @@ hugetlbfs_size_to_hpages(struct hstate *h, unsigned long long size_opt,
 	return size_opt;
 }
 
-static int
-hugetlbfs_parse_options(char *options, struct hugetlbfs_config *pconfig)
+/*
+ * Parse one mount parameter.
+ */
+static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p, *rest;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	unsigned long long max_size_opt = 0, min_size_opt = 0;
-	enum hugetlbfs_size_type max_val_type = NO_SIZE, min_val_type = NO_SIZE;
+	struct hugetlbfs_fs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	char *rest;
+	unsigned long ps;
+	int ret;
+
+	ret = fs_parse(fc, &hugetlb_fs_parameters, param, &result);
+	if (ret < 0)
+		return ret;
 
-	if (!options)
+	switch (result.key) {
+	case Opt_uid:
+		ctx->uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(ctx->uid))
+			goto bad_val;
 		return 0;
 
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
+	case Opt_gid:
+		ctx->gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(ctx->gid))
+			goto bad_val;
+		return 0;
 
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(&args[0], &option))
- 				goto bad_val;
-			pconfig->uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(pconfig->uid))
-				goto bad_val;
-			break;
+	case Opt_mode:
+		ctx->mode = result.uint_32 & 01777U;
+		return 0;
 
-		case Opt_gid:
-			if (match_int(&args[0], &option))
- 				goto bad_val;
-			pconfig->gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(pconfig->gid))
-				goto bad_val;
-			break;
+	case Opt_size:
+		/* memparse() will accept a K/M/G without a digit */
+		if (!isdigit(param->string[0]))
+			goto bad_val;
+		ctx->max_size_opt = memparse(param->string, &rest);
+		ctx->max_val_type = SIZE_STD;
+		if (*rest == '%')
+			ctx->max_val_type = SIZE_PERCENT;
+		return 0;
 
-		case Opt_mode:
-			if (match_octal(&args[0], &option))
- 				goto bad_val;
-			pconfig->mode = option & 01777U;
-			break;
+	case Opt_nr_inodes:
+		/* memparse() will accept a K/M/G without a digit */
+		if (!isdigit(param->string[0]))
+			goto bad_val;
+		ctx->nr_inodes = memparse(param->string, &rest);
+		return 0;
 
-		case Opt_size: {
-			/* memparse() will accept a K/M/G without a digit */
-			if (!isdigit(*args[0].from))
-				goto bad_val;
-			max_size_opt = memparse(args[0].from, &rest);
-			max_val_type = SIZE_STD;
-			if (*rest == '%')
-				max_val_type = SIZE_PERCENT;
-			break;
+	case Opt_pagesize:
+		ps = memparse(param->string, &rest);
+		ctx->hstate = size_to_hstate(ps);
+		if (!ctx->hstate) {
+			pr_err("Unsupported page size %lu MB\n", ps >> 20);
+			return -EINVAL;
 		}
+		return 0;
 
-		case Opt_nr_inodes:
-			/* memparse() will accept a K/M/G without a digit */
-			if (!isdigit(*args[0].from))
-				goto bad_val;
-			pconfig->nr_inodes = memparse(args[0].from, &rest);
-			break;
+	case Opt_min_size:
+		/* memparse() will accept a K/M/G without a digit */
+		if (!isdigit(param->string[0]))
+			goto bad_val;
+		ctx->min_size_opt = memparse(param->string, &rest);
+		ctx->min_val_type = SIZE_STD;
+		if (*rest == '%')
+			ctx->min_val_type = SIZE_PERCENT;
+		return 0;
 
-		case Opt_pagesize: {
-			unsigned long ps;
-			ps = memparse(args[0].from, &rest);
-			pconfig->hstate = size_to_hstate(ps);
-			if (!pconfig->hstate) {
-				pr_err("Unsupported page size %lu MB\n",
-					ps >> 20);
-				return -EINVAL;
-			}
-			break;
-		}
+	default:
+		return -EINVAL;
+	}
 
-		case Opt_min_size: {
-			/* memparse() will accept a K/M/G without a digit */
-			if (!isdigit(*args[0].from))
-				goto bad_val;
-			min_size_opt = memparse(args[0].from, &rest);
-			min_val_type = SIZE_STD;
-			if (*rest == '%')
-				min_val_type = SIZE_PERCENT;
-			break;
-		}
+bad_val:
+	invalf(fc, "hugetlbfs: Bad value '%s' for mount option '%s'\n",
+	       param->string, param->key);
+	return -EINVAL;
+}
 
-		default:
-			pr_err("Bad mount option: \"%s\"\n", p);
-			return -EINVAL;
-			break;
-		}
-	}
+/*
+ * Validate the parsed options.
+ */
+static int hugetlbfs_validate(struct fs_context *fc)
+{
+	struct hugetlbfs_fs_context *ctx = fc->fs_private;
 
 	/*
 	 * Use huge page pool size (in hstate) to convert the size
 	 * options to number of huge pages.  If NO_SIZE, -1 is returned.
 	 */
-	pconfig->max_hpages = hugetlbfs_size_to_hpages(pconfig->hstate,
-						max_size_opt, max_val_type);
-	pconfig->min_hpages = hugetlbfs_size_to_hpages(pconfig->hstate,
-						min_size_opt, min_val_type);
+	ctx->max_hpages = hugetlbfs_size_to_hpages(ctx->hstate,
+						   ctx->max_size_opt,
+						   ctx->max_val_type);
+	ctx->min_hpages = hugetlbfs_size_to_hpages(ctx->hstate,
+						   ctx->min_size_opt,
+						   ctx->min_val_type);
 
 	/*
 	 * If max_size was specified, then min_size must be smaller
 	 */
-	if (max_val_type > NO_SIZE &&
-	    pconfig->min_hpages > pconfig->max_hpages) {
-		pr_err("minimum size can not be greater than maximum size\n");
+	if (ctx->max_val_type > NO_SIZE &&
+	    ctx->min_hpages > ctx->max_hpages) {
+		pr_err("Minimum size can not be greater than maximum size\n");
 		return -EINVAL;
 	}
 
 	return 0;
-
-bad_val:
-	pr_err("Bad value '%s' for mount option '%s'\n", args[0].from, p);
- 	return -EINVAL;
 }
 
 static int
-hugetlbfs_fill_super(struct super_block *sb, void *data, size_t data_size,
-		     int silent)
+hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	int ret;
-	struct hugetlbfs_config config;
+	struct hugetlbfs_fs_context *ctx =
+		fc->fs_private;
 	struct hugetlbfs_sb_info *sbinfo;
 
-	config.max_hpages = -1; /* No limit on size by default */
-	config.nr_inodes = -1; /* No limit on number of inodes by default */
-	config.uid = current_fsuid();
-	config.gid = current_fsgid();
-	config.mode = 0755;
-	config.hstate = &default_hstate;
-	config.min_hpages = -1; /* No default minimum size */
-	ret = hugetlbfs_parse_options(data, &config);
-	if (ret)
-		return ret;
-
 	sbinfo = kmalloc(sizeof(struct hugetlbfs_sb_info), GFP_KERNEL);
 	if (!sbinfo)
 		return -ENOMEM;
 	sb->s_fs_info = sbinfo;
-	sbinfo->hstate = config.hstate;
 	spin_lock_init(&sbinfo->stat_lock);
-	sbinfo->max_inodes = config.nr_inodes;
-	sbinfo->free_inodes = config.nr_inodes;
-	sbinfo->spool = NULL;
-	sbinfo->uid = config.uid;
-	sbinfo->gid = config.gid;
-	sbinfo->mode = config.mode;
+	sbinfo->hstate		= ctx->hstate;
+	sbinfo->max_inodes	= ctx->nr_inodes;
+	sbinfo->free_inodes	= ctx->nr_inodes;
+	sbinfo->spool		= NULL;
+	sbinfo->uid		= ctx->uid;
+	sbinfo->gid		= ctx->gid;
+	sbinfo->mode		= ctx->mode;
 
 	/*
 	 * Allocate and initialize subpool if maximum or minimum size is
 	 * specified.  Any needed reservations (for minimim size) are taken
 	 * taken when the subpool is created.
 	 */
-	if (config.max_hpages != -1 || config.min_hpages != -1) {
-		sbinfo->spool = hugepage_new_subpool(config.hstate,
-							config.max_hpages,
-							config.min_hpages);
+	if (ctx->max_hpages != -1 || ctx->min_hpages != -1) {
+		sbinfo->spool = hugepage_new_subpool(ctx->hstate,
+						     ctx->max_hpages,
+						     ctx->min_hpages);
 		if (!sbinfo->spool)
 			goto out_free;
 	}
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
-	sb->s_blocksize = huge_page_size(config.hstate);
-	sb->s_blocksize_bits = huge_page_shift(config.hstate);
+	sb->s_blocksize = huge_page_size(ctx->hstate);
+	sb->s_blocksize_bits = huge_page_shift(ctx->hstate);
 	sb->s_magic = HUGETLBFS_MAGIC;
 	sb->s_op = &hugetlbfs_ops;
 	sb->s_time_gran = 1;
-	sb->s_root = d_make_root(hugetlbfs_get_root(sb, &config));
+	sb->s_root = d_make_root(hugetlbfs_get_root(sb, ctx));
 	if (!sb->s_root)
 		goto out_free;
 	return 0;
@@ -1279,17 +1287,51 @@ hugetlbfs_fill_super(struct super_block *sb, void *data, size_t data_size,
 	return -ENOMEM;
 }
 
-static struct dentry *hugetlbfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data, size_t data_size)
+static int hugetlbfs_get_tree(struct fs_context *fc)
+{
+	return vfs_get_super(fc, vfs_get_independent_super, hugetlbfs_fill_super);
+}
+
+static void hugetlbfs_fs_context_free(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations hugetlbfs_fs_context_ops = {
+	.free		= hugetlbfs_fs_context_free,
+	.parse_param	= hugetlbfs_parse_param,
+	.validate	= hugetlbfs_validate,
+	.get_tree	= hugetlbfs_get_tree,
+};
+
+static int hugetlbfs_init_fs_context(struct fs_context *fc,
+				     struct dentry *reference)
 {
-	return mount_nodev(fs_type, flags, data, data_size,
-			   hugetlbfs_fill_super);
+	struct hugetlbfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct hugetlbfs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->max_hpages	= -1; /* No limit on size by default */
+	ctx->nr_inodes	= -1; /* No limit on number of inodes by default */
+	ctx->uid	= current_fsuid();
+	ctx->gid	= current_fsgid();
+	ctx->mode	= 0755;
+	ctx->hstate	= &default_hstate;
+	ctx->min_hpages	= -1; /* No default minimum size */
+	ctx->max_val_type = NO_SIZE;
+	ctx->min_val_type = NO_SIZE;
+	fc->fs_private = ctx;
+	fc->ops	= &hugetlbfs_fs_context_ops;
+	return 0;
 }
 
 static struct file_system_type hugetlbfs_fs_type = {
-	.name		= "hugetlbfs",
-	.mount		= hugetlbfs_mount,
-	.kill_sb	= kill_litter_super,
+	.name			= "hugetlbfs",
+	.init_fs_context	= hugetlbfs_init_fs_context,
+	.parameters		= &hugetlb_fs_parameters,
+	.kill_sb		= kill_litter_super,
 };
 
 static struct vfsmount *hugetlbfs_vfsmount[HUGE_MAX_HSTATE];
@@ -1396,8 +1438,47 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	return file;
 }
 
+static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
+{
+	struct hugetlbfs_fs_context *ctx;
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+	int ret;
+
+	fc = vfs_new_fs_context(&hugetlbfs_fs_type, NULL, 0,
+				FS_CONTEXT_FOR_KERNEL_MOUNT);
+	if (IS_ERR(fc)) {
+		ret = PTR_ERR(fc);
+		goto err;
+	}
+
+	ctx = fc->fs_private;
+	ctx->hstate = h;
+
+	ret = vfs_get_tree(fc);
+	if (ret < 0)
+		goto err_fc;
+
+	mnt = vfs_create_mount(fc, 0);
+	if (IS_ERR(mnt)) {
+		ret = PTR_ERR(mnt);
+		goto err_fc;
+	}
+
+	put_fs_context(fc);
+	return mnt;
+
+err_fc:
+	put_fs_context(fc);
+err:
+	pr_err("Cannot mount internal hugetlbfs for page size %uK",
+	       1U << (h->order + PAGE_SHIFT - 10));
+	return ERR_PTR(ret);
+}
+
 static int __init init_hugetlbfs_fs(void)
 {
+	struct vfsmount *mnt;
 	struct hstate *h;
 	int error;
 	int i;
@@ -1420,25 +1501,16 @@ static int __init init_hugetlbfs_fs(void)
 
 	i = 0;
 	for_each_hstate(h) {
-		char buf[50];
-		unsigned ps_kb = 1U << (h->order + PAGE_SHIFT - 10);
-		int n;
-
-		n = snprintf(buf, sizeof(buf), "pagesize=%uK", ps_kb);
-		hugetlbfs_vfsmount[i] = kern_mount_data(&hugetlbfs_fs_type,
-							buf, n + 1);
-
-		if (IS_ERR(hugetlbfs_vfsmount[i])) {
-			pr_err("Cannot mount internal hugetlbfs for "
-				"page size %uK", ps_kb);
-			error = PTR_ERR(hugetlbfs_vfsmount[i]);
-			hugetlbfs_vfsmount[i] = NULL;
+		mnt = mount_one_hugetlbfs(h);
+		if (IS_ERR(mnt) && i == 0) {
+			error = PTR_ERR(mnt);
+			goto out;
 		}
+		hugetlbfs_vfsmount[i] = mnt;
 		i++;
 	}
-	/* Non default hstates are optional */
-	if (!IS_ERR_OR_NULL(hugetlbfs_vfsmount[default_hstate_idx]))
-		return 0;
+
+	return 0;
 
  out:
 	kmem_cache_destroy(hugetlbfs_inode_cachep);

