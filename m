Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0476DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC79B2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC79B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeLJRVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:21:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbeLJRNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19FBE308213A;
        Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75E236012B;
        Mon, 10 Dec 2018 17:13:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1280E223BBA; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 04/52] fuse: extract fuse_fill_super_common()
Date:   Mon, 10 Dec 2018 12:12:30 -0500
Message-Id: <20181210171318.16998-5-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

fuse_fill_super() includes code to process the fd= option and link the
struct fuse_dev to the fd's struct file.  In virtio-fs there is no file
descriptor because /dev/fuse is not used.

This patch extracts fuse_fill_super_common() so that both classic fuse
and virtio-fs can share the code to initialize a mount.

parse_fuse_opt() is also extracted so that the fuse_fill_super_common()
caller has access to the mount options.  This allows classic fuse to
handle the fd= option outside fuse_fill_super_common().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/fuse_i.h |  32 +++++++++++++++++
 fs/fuse/inode.c  | 102 +++++++++++++++++++++++++++----------------------------
 2 files changed, 83 insertions(+), 51 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e9f712e81c7d..9b5b8b194f77 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -56,6 +56,22 @@ extern struct mutex fuse_mutex;
 extern unsigned max_user_bgreq;
 extern unsigned max_user_congthresh;
 
+/** Mount options */
+struct fuse_mount_data {
+	int fd;
+	unsigned rootmode;
+	kuid_t user_id;
+	kgid_t group_id;
+	unsigned fd_present:1;
+	unsigned rootmode_present:1;
+	unsigned user_id_present:1;
+	unsigned group_id_present:1;
+	unsigned default_permissions:1;
+	unsigned allow_other:1;
+	unsigned max_read;
+	unsigned blksize;
+};
+
 /* One forget request */
 struct fuse_forget_link {
 	struct fuse_forget_one forget_one;
@@ -970,6 +986,22 @@ struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
 
 /**
+ * Parse a mount options string
+ */
+int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
+				struct user_namespace *user_ns);
+
+/**
+ * Fill in superblock and initialize fuse connection
+ * @sb: partially-initialized superblock to fill in
+ * @mount_data: mount parameters
+ * @fudptr: fuse_dev pointer to fill in, should contain NULL on entry
+ */
+int fuse_fill_super_common(struct super_block *sb,
+			   struct fuse_mount_data *mount_data,
+			   void **fudptr);
+
+/**
  * Add connection to control filesystem
  */
 int fuse_ctl_add_conn(struct fuse_conn *fc);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d08cd8bf7705..f13133f0ebd1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -59,21 +59,6 @@ MODULE_PARM_DESC(max_user_congthresh,
 /** Congestion starts at 75% of maximum */
 #define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
 
-struct fuse_mount_data {
-	int fd;
-	unsigned rootmode;
-	kuid_t user_id;
-	kgid_t group_id;
-	unsigned fd_present:1;
-	unsigned rootmode_present:1;
-	unsigned user_id_present:1;
-	unsigned group_id_present:1;
-	unsigned default_permissions:1;
-	unsigned allow_other:1;
-	unsigned max_read;
-	unsigned blksize;
-};
-
 struct fuse_forget_link *fuse_alloc_forget(void)
 {
 	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
@@ -479,7 +464,7 @@ static int fuse_match_uint(substring_t *s, unsigned int *res)
 	return err;
 }
 
-static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
+int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 			  struct user_namespace *user_ns)
 {
 	char *p;
@@ -556,12 +541,13 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 		}
 	}
 
-	if (!d->fd_present || !d->rootmode_present ||
-	    !d->user_id_present || !d->group_id_present)
+	if (!d->rootmode_present || !d->user_id_present ||
+	    !d->group_id_present)
 		return 0;
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(parse_fuse_opt);
 
 static int fuse_show_options(struct seq_file *m, struct dentry *root)
 {
@@ -1072,13 +1058,13 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static int fuse_fill_super(struct super_block *sb, void *data, int silent)
+int fuse_fill_super_common(struct super_block *sb,
+			   struct fuse_mount_data *mount_data,
+			   void **fudptr)
 {
 	struct fuse_dev *fud;
 	struct fuse_conn *fc;
 	struct inode *root;
-	struct fuse_mount_data d;
-	struct file *file;
 	struct dentry *root_dentry;
 	struct fuse_req *init_req;
 	int err;
@@ -1090,13 +1076,10 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
 
-	if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
-		goto err;
-
 	if (is_bdev) {
 #ifdef CONFIG_BLOCK
 		err = -EINVAL;
-		if (!sb_set_blocksize(sb, d.blksize))
+		if (!sb_set_blocksize(sb, mount_data->blksize))
 			goto err;
 #endif
 	} else {
@@ -1113,19 +1096,6 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 
-	file = fget(d.fd);
-	err = -EINVAL;
-	if (!file)
-		goto err;
-
-	/*
-	 * Require mount to happen from the same user namespace which
-	 * opened /dev/fuse to prevent potential attacks.
-	 */
-	if (file->f_op != &fuse_dev_operations ||
-	    file->f_cred->user_ns != sb->s_user_ns)
-		goto err_fput;
-
 	/*
 	 * If we are not in the initial user namespace posix
 	 * acls must be translated.
@@ -1136,7 +1106,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
 	err = -ENOMEM;
 	if (!fc)
-		goto err_fput;
+		goto err;
 
 	fuse_conn_init(fc, sb->s_user_ns);
 	fc->release = fuse_free_conn;
@@ -1156,18 +1126,18 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 		fc->dont_mask = 1;
 	sb->s_flags |= SB_POSIXACL;
 
-	fc->default_permissions = d.default_permissions;
-	fc->allow_other = d.allow_other;
-	fc->user_id = d.user_id;
-	fc->group_id = d.group_id;
-	fc->max_read = max_t(unsigned, 4096, d.max_read);
+	fc->default_permissions = mount_data->default_permissions;
+	fc->allow_other = mount_data->allow_other;
+	fc->user_id = mount_data->user_id;
+	fc->group_id = mount_data->group_id;
+	fc->max_read = max_t(unsigned, 4096, mount_data->max_read);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
 
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, d.rootmode);
+	root = fuse_get_root_inode(sb, mount_data->rootmode);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
@@ -1188,7 +1158,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (file->private_data)
+	if (*fudptr)
 		goto err_unlock;
 
 	err = fuse_ctl_add_conn(fc);
@@ -1197,13 +1167,12 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	file->private_data = fud;
+	*fudptr = fud;
 	/*
 	 * mutex_unlock() provides the necessary memory barrier for
-	 * file->private_data to be visible on all CPUs after this
+	 * *fudptr to be visible on all CPUs after this
 	 */
 	mutex_unlock(&fuse_mutex);
-	fput(file);
 
 	fuse_send_init(fc, init_req);
 
@@ -1220,11 +1189,42 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
  err_put_conn:
 	fuse_conn_put(fc);
 	sb->s_fs_info = NULL;
- err_fput:
-	fput(file);
  err:
 	return err;
 }
+EXPORT_SYMBOL_GPL(fuse_fill_super_common);
+
+static int fuse_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct fuse_mount_data d;
+	struct file *file;
+	int is_bdev = sb->s_bdev != NULL;
+	int err;
+
+	err = -EINVAL;
+	if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
+		goto err;
+	if (!d.fd_present)
+		goto err;
+
+	file = fget(d.fd);
+	if (!file)
+		goto err;
+
+	/*
+	 * Require mount to happen from the same user namespace which
+	 * opened /dev/fuse to prevent potential attacks.
+	 */
+	if ((file->f_op != &fuse_dev_operations) ||
+	    (file->f_cred->user_ns != sb->s_user_ns))
+		goto err_fput;
+
+	err = fuse_fill_super_common(sb, &d, &file->private_data);
+err_fput:
+	fput(file);
+err:
+	return err;
+}
 
 static struct dentry *fuse_mount(struct file_system_type *fs_type,
 		       int flags, const char *dev_name,
-- 
2.13.6

