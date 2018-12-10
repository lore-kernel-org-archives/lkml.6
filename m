Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1232082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1232082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeLJRN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbeLJRNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D831368E7;
        Mon, 10 Dec 2018 17:13:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 734325C221;
        Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 167CE223BE8; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 05/52] virtio_fs: get mount working
Date:   Mon, 10 Dec 2018 12:12:31 -0500
Message-Id: <20181210171318.16998-6-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 10 Dec 2018 17:13:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Provide definitions of ->mount and  ->kill_sb. This is still WIP.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/fuse_i.h    |   9 ++++
 fs/fuse/inode.c     |  12 ++++-
 fs/fuse/virtio_fs.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 146 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b5b8b194f77..4fea75c92a7c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -59,10 +59,12 @@ extern unsigned max_user_congthresh;
 /** Mount options */
 struct fuse_mount_data {
 	int fd;
+	const char *tag; /* lifetime: .fill_super() data argument */
 	unsigned rootmode;
 	kuid_t user_id;
 	kgid_t group_id;
 	unsigned fd_present:1;
+	unsigned tag_present:1;
 	unsigned rootmode_present:1;
 	unsigned user_id_present:1;
 	unsigned group_id_present:1;
@@ -1002,6 +1004,13 @@ int fuse_fill_super_common(struct super_block *sb,
 			   void **fudptr);
 
 /**
+ * Disassociate fuse connection from superblock and kill the superblock
+ *
+ * Calls kill_anon_super(), use with do not use with bdev mounts.
+ */
+void fuse_kill_sb_anon(struct super_block *sb);
+
+/**
  * Add connection to control filesystem
  */
 int fuse_ctl_add_conn(struct fuse_conn *fc);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f13133f0ebd1..65fd59fc1e81 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -431,6 +431,7 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 enum {
 	OPT_FD,
+	OPT_TAG,
 	OPT_ROOTMODE,
 	OPT_USER_ID,
 	OPT_GROUP_ID,
@@ -443,6 +444,7 @@ enum {
 
 static const match_table_t tokens = {
 	{OPT_FD,			"fd=%u"},
+	{OPT_TAG,			"tag=%s"},
 	{OPT_ROOTMODE,			"rootmode=%o"},
 	{OPT_USER_ID,			"user_id=%u"},
 	{OPT_GROUP_ID,			"group_id=%u"},
@@ -489,6 +491,11 @@ int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 			d->fd_present = 1;
 			break;
 
+		case OPT_TAG:
+			d->tag = args[0].from;
+			d->tag_present = 1;
+			break;
+
 		case OPT_ROOTMODE:
 			if (match_octal(&args[0], &value))
 				return 0;
@@ -1204,7 +1211,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	err = -EINVAL;
 	if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
 		goto err;
-	if (!d.fd_present)
+	if (!d.fd_present || d.tag_present)
 		goto err;
 
 	file = fget(d.fd);
@@ -1249,11 +1256,12 @@ static void fuse_sb_destroy(struct super_block *sb)
 	}
 }
 
-static void fuse_kill_sb_anon(struct super_block *sb)
+void fuse_kill_sb_anon(struct super_block *sb)
 {
 	fuse_sb_destroy(sb);
 	kill_anon_super(sb);
 }
+EXPORT_SYMBOL_GPL(fuse_kill_sb_anon);
 
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index aac9c3c42827..8cdeb02f3778 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_fs.h>
+#include "fuse_i.h"
 
 /* List of virtio-fs device instances and a lock for the list */
 static DEFINE_MUTEX(virtio_fs_mutex);
@@ -17,6 +18,8 @@ static LIST_HEAD(virtio_fs_instances);
 struct virtio_fs {
 	struct list_head list; /* on virtio_fs_instances */
 	char *tag;
+	struct fuse_dev **fud; /* 1:1 mapping with request queues */
+	unsigned int num_queues;
 };
 
 /* Add a new instance to the list or return -EEXIST if tag name exists*/
@@ -42,6 +45,46 @@ static int virtio_fs_add_instance(struct virtio_fs *fs)
 	return 0;
 }
 
+/* Return the virtio_fs with a given tag, or NULL */
+static struct virtio_fs *virtio_fs_find_instance(const char *tag)
+{
+	struct virtio_fs *fs;
+
+	mutex_lock(&virtio_fs_mutex);
+
+	list_for_each_entry(fs, &virtio_fs_instances, list) {
+		if (strcmp(fs->tag, tag) == 0)
+			goto found;
+	}
+
+	fs = NULL; /* not found */
+
+found:
+	mutex_unlock(&virtio_fs_mutex);
+
+	return fs;
+}
+
+static void virtio_fs_free_devs(struct virtio_fs *fs)
+{
+	unsigned int i;
+
+	/* TODO lock */
+
+	if (!fs->fud)
+		return;
+
+	for (i = 0; i < fs->num_queues; i++) {
+		struct fuse_dev *fud = fs->fud[i];
+
+		if (fud)
+			fuse_dev_free(fud); /* TODO need to quiesce/end_requests/decrement dev_count */
+	}
+
+	kfree(fs->fud);
+	fs->fud = NULL;
+}
+
 /* Read filesystem name from virtio config into fs->tag (must kfree()). */
 static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
 {
@@ -76,6 +119,13 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 		return -ENOMEM;
 	vdev->priv = fs;
 
+	virtio_cread(vdev, struct virtio_fs_config, num_queues,
+		     &fs->num_queues);
+	if (fs->num_queues == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = virtio_fs_read_tag(vdev, fs);
 	if (ret < 0)
 		goto out;
@@ -95,6 +145,8 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs = vdev->priv;
 
+	virtio_fs_free_devs(fs);
+
 	vdev->config->reset(vdev);
 
 	mutex_lock(&virtio_fs_mutex);
@@ -138,11 +190,84 @@ static struct virtio_driver virtio_fs_driver = {
 #endif
 };
 
+static int virtio_fs_fill_super(struct super_block *sb, void *data,
+				int silent)
+{
+	struct fuse_mount_data d;
+	struct fuse_conn *fc;
+	struct virtio_fs *fs;
+	int is_bdev = sb->s_bdev != NULL;
+	unsigned int i;
+	int err;
+
+	err = -EINVAL;
+	if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
+		goto err;
+	if (d.fd_present) {
+		printk(KERN_ERR "virtio-fs: fd option cannot be used\n");
+		goto err;
+	}
+	if (!d.tag_present) {
+		printk(KERN_ERR "virtio-fs: missing tag option\n");
+		goto err;
+	}
+
+	fs = virtio_fs_find_instance(d.tag);
+	if (!fs) {
+		printk(KERN_ERR "virtio-fs: tag not found\n");
+		err = -ENOENT;
+		goto err;
+	}
+
+	/* TODO lock */
+	if (fs->fud) {
+		printk(KERN_ERR "virtio-fs: device already in use\n");
+		err = -EBUSY;
+		goto err;
+	}
+	fs->fud = kcalloc(fs->num_queues, sizeof(fs->fud[0]), GFP_KERNEL);
+	if (!fs->fud) {
+		err = -ENOMEM;
+		goto err_fud;
+	}
+
+	err = fuse_fill_super_common(sb, &d, (void **)&fs->fud[0]);
+	if (err < 0)
+		goto err_fud;
+
+	fc = fs->fud[0]->fc;
+
+	/* Allocate remaining fuse_devs */
+	err = -ENOMEM;
+	/* TODO take fuse_mutex around this loop? */
+	for (i = 1; i < fs->num_queues; i++) {
+		fs->fud[i] = fuse_dev_alloc(fc);
+		if (!fs->fud[i]) {
+			/* TODO */
+		}
+		atomic_inc(&fc->dev_count);
+	}
+
+	return 0;
+
+err_fud:
+	virtio_fs_free_devs(fs);
+err:
+	return err;
+}
+
+static struct dentry *virtio_fs_mount(struct file_system_type *fs_type,
+				      int flags, const char *dev_name,
+				      void *raw_data)
+{
+	return mount_nodev(fs_type, flags, raw_data, virtio_fs_fill_super);
+}
+
 static struct file_system_type virtio_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= KBUILD_MODNAME,
-	.mount		= NULL,
-	.kill_sb	= NULL,
+	.mount		= virtio_fs_mount,
+	.kill_sb	= fuse_kill_sb_anon,
 };
 
 static int __init virtio_fs_init(void)
-- 
2.13.6

