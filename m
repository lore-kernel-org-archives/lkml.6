Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BBFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21A02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21A02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeLJRPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:15:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbeLJRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38D4C308212C;
        Mon, 10 Dec 2018 17:13:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D2465C1B5;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5DD8E224261; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 23/52] fuse: simplify fuse_fill_super_common() calling
Date:   Mon, 10 Dec 2018 12:12:49 -0500
Message-Id: <20181210171318.16998-24-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 10 Dec 2018 17:13:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

Add more fields to "struct fuse_mount_data" so that less parameters
have to be passed to function fuse_fill_super_common().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h    | 22 +++++++++++++---------
 fs/fuse/inode.c     | 27 ++++++++++++++-------------
 fs/fuse/virtio_fs.c | 10 +++++++---
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f0775d76e31f..fb49ca9d05ac 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -77,6 +77,18 @@ struct fuse_mount_data {
 	unsigned dax:1;
 	unsigned max_read;
 	unsigned blksize;
+
+	/* DAX device, may be NULL */
+	struct dax_device *dax_dev;
+
+	/* fuse input queue operations */
+	const struct fuse_iqueue_ops *fiq_ops;
+
+	/* device-specific state for fuse_iqueue */
+	void *fiq_priv;
+
+	/* fuse_dev pointer to fill in, should contain NULL on entry */
+	void **fudptr;
 };
 
 /* One forget request */
@@ -1073,17 +1085,9 @@ int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
  * Fill in superblock and initialize fuse connection
  * @sb: partially-initialized superblock to fill in
  * @mount_data: mount parameters
- * @dax_dev: DAX device, may be NULL
- * @fiq_ops: fuse input queue operations
- * @fiq_priv: device-specific state for fuse_iqueue
- * @fudptr: fuse_dev pointer to fill in, should contain NULL on entry
  */
 int fuse_fill_super_common(struct super_block *sb,
-			   struct fuse_mount_data *mount_data,
-			   struct dax_device *dax_dev,
-			   const struct fuse_iqueue_ops *fiq_ops,
-			   void *fiq_priv,
-			   void **fudptr);
+			   struct fuse_mount_data *mount_data);
 
 /**
  * Disassociate fuse connection from superblock and kill the superblock
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 403360e352d8..075997977cfd 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1149,11 +1149,7 @@ void fuse_dev_free(struct fuse_dev *fud)
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
 int fuse_fill_super_common(struct super_block *sb,
-			   struct fuse_mount_data *mount_data,
-			   struct dax_device *dax_dev,
-			   const struct fuse_iqueue_ops *fiq_ops,
-			   void *fiq_priv,
-			   void **fudptr)
+			   struct fuse_mount_data *mount_data)
 {
 	struct fuse_dev *fud;
 	struct fuse_conn *fc;
@@ -1201,11 +1197,12 @@ int fuse_fill_super_common(struct super_block *sb,
 	if (!fc)
 		goto err;
 
-	fuse_conn_init(fc, sb->s_user_ns, dax_dev, fiq_ops, fiq_priv);
+	fuse_conn_init(fc, sb->s_user_ns, mount_data->dax_dev,
+			mount_data->fiq_ops, mount_data->fiq_priv);
 	fc->release = fuse_free_conn;
 
-	if (dax_dev) {
-		err = fuse_dax_mem_range_init(fc, dax_dev);
+	if (mount_data->dax_dev) {
+		err = fuse_dax_mem_range_init(fc, mount_data->dax_dev);
 		if (err) {
 			pr_debug("fuse_dax_mem_range_init() returned %d\n", err);
 			goto err_put_conn;
@@ -1259,7 +1256,7 @@ int fuse_fill_super_common(struct super_block *sb,
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (*fudptr)
+	if (*mount_data->fudptr)
 		goto err_unlock;
 
 	err = fuse_ctl_add_conn(fc);
@@ -1268,7 +1265,7 @@ int fuse_fill_super_common(struct super_block *sb,
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	*fudptr = fud;
+	*mount_data->fudptr = fud;
 	/*
 	 * mutex_unlock() provides the necessary memory barrier for
 	 * *fudptr to be visible on all CPUs after this
@@ -1288,7 +1285,7 @@ int fuse_fill_super_common(struct super_block *sb,
  err_dev_free:
 	fuse_dev_free(fud);
  err_free_ranges:
-	if (dax_dev)
+	if (mount_data->dax_dev)
 		fuse_free_dax_mem_ranges(&fc->free_ranges);
  err_put_conn:
 	fuse_conn_put(fc);
@@ -1323,8 +1320,12 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	    (file->f_cred->user_ns != sb->s_user_ns))
 		goto err_fput;
 
-	err = fuse_fill_super_common(sb, &d, NULL, &fuse_dev_fiq_ops, NULL,
-				     &file->private_data);
+	d.dax_dev = NULL;
+	d.fiq_ops = &fuse_dev_fiq_ops;
+	d.fiq_priv = NULL;
+	d.fudptr = &file->private_data;
+	err = fuse_fill_super_common(sb, &d);
+
 err_fput:
 	fput(file);
 err:
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c79c9a885253..98dba3cf9d40 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1053,9 +1053,13 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
 	/* TODO this sends FUSE_INIT and could cause hiprio or notifications
 	 * virtqueue races since they haven't been set up yet!
 	 */
-	err = fuse_fill_super_common(sb, &d, d.dax ? fs->dax_dev : NULL,
-				     &virtio_fs_fiq_ops, fs,
-				     (void **)&fs->vqs[2].fud);
+
+	d.dax_dev = d.dax ? fs->dax_dev : NULL;
+	d.fiq_ops = &virtio_fs_fiq_ops;
+	d.fiq_priv = fs;
+	d.fudptr = (void **)&fs->vqs[2].fud;
+	err = fuse_fill_super_common(sb, &d);
+
 	if (err < 0)
 		goto err_fud;
 
-- 
2.13.6

