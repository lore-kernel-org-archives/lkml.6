Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878C9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD442082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD442082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeLJRQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:16:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77F023002C74;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2321D5D75F;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3A81B223C12; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 14/52] fuse: add fuse_conn->dax_dev field
Date:   Mon, 10 Dec 2018 12:12:40 -0500
Message-Id: <20181210171318.16998-15-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

A struct dax_device instance is a prerequisite for the DAX filesystem
APIs.  Let virtio_fs associate a dax_device with a fuse_conn.  Classic
FUSE and CUSE set the pointer to NULL, disabling DAX.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/cuse.c      | 3 ++-
 fs/fuse/fuse_i.h    | 8 +++++++-
 fs/fuse/inode.c     | 9 ++++++---
 fs/fuse/virtio_fs.c | 3 ++-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 98dc780cbafa..bf8c1c470e8c 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -503,7 +503,8 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 * Limit the cuse channel to requests that can
 	 * be represented in file->f_cred->user_ns.
 	 */
-	fuse_conn_init(&cc->fc, file->f_cred->user_ns, &fuse_dev_fiq_ops, NULL);
+	fuse_conn_init(&cc->fc, file->f_cred->user_ns, NULL, &fuse_dev_fiq_ops,
+					NULL);
 
 	fud = fuse_dev_alloc(&cc->fc);
 	if (!fud) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f463586f2c9e..b5a6a12e67d6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -803,6 +803,9 @@ struct fuse_conn {
 
 	/** List of device instances belonging to this connection */
 	struct list_head devices;
+
+	/** DAX device, non-NULL if DAX is supported */
+	struct dax_device *dax_dev;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
@@ -1025,7 +1028,8 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
  * Initialize fuse_conn
  */
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
+			struct dax_device *dax_dev,
+			const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
 
 /**
  * Release reference to fuse_conn
@@ -1045,12 +1049,14 @@ int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
  * Fill in superblock and initialize fuse connection
  * @sb: partially-initialized superblock to fill in
  * @mount_data: mount parameters
+ * @dax_dev: DAX device, may be NULL
  * @fiq_ops: fuse input queue operations
  * @fiq_priv: device-specific state for fuse_iqueue
  * @fudptr: fuse_dev pointer to fill in, should contain NULL on entry
  */
 int fuse_fill_super_common(struct super_block *sb,
 			   struct fuse_mount_data *mount_data,
+			   struct dax_device *dax_dev,
 			   const struct fuse_iqueue_ops *fiq_ops,
 			   void *fiq_priv,
 			   void **fudptr);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 31bb817575c4..10e4a39318c4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -600,7 +600,8 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 }
 
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
+			struct dax_device *dax_dev,
+			const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
@@ -625,6 +626,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->attr_version = 1;
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
+	fc->dax_dev = dax_dev;
 	fc->user_ns = get_user_ns(user_ns);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
@@ -1072,6 +1074,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_free);
 
 int fuse_fill_super_common(struct super_block *sb,
 			   struct fuse_mount_data *mount_data,
+			   struct dax_device *dax_dev,
 			   const struct fuse_iqueue_ops *fiq_ops,
 			   void *fiq_priv,
 			   void **fudptr)
@@ -1122,7 +1125,7 @@ int fuse_fill_super_common(struct super_block *sb,
 	if (!fc)
 		goto err;
 
-	fuse_conn_init(fc, sb->s_user_ns, fiq_ops, fiq_priv);
+	fuse_conn_init(fc, sb->s_user_ns, dax_dev, fiq_ops, fiq_priv);
 	fc->release = fuse_free_conn;
 
 	fud = fuse_dev_alloc(fc);
@@ -1233,7 +1236,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	    (file->f_cred->user_ns != sb->s_user_ns))
 		goto err_fput;
 
-	err = fuse_fill_super_common(sb, &d, &fuse_dev_fiq_ops, NULL,
+	err = fuse_fill_super_common(sb, &d, NULL, &fuse_dev_fiq_ops, NULL,
 				     &file->private_data);
 err_fput:
 	fput(file);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index fd914f2c6209..ba615ec2603e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -844,7 +844,8 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
 	/* TODO this sends FUSE_INIT and could cause hiprio or notifications
 	 * virtqueue races since they haven't been set up yet!
 	 */
-	err = fuse_fill_super_common(sb, &d, &virtio_fs_fiq_ops, fs,
+	err = fuse_fill_super_common(sb, &d, fs->dax_dev,
+				     &virtio_fs_fiq_ops, fs,
 				     (void **)&fs->vqs[2].fud);
 	if (err < 0)
 		goto err_fud;
-- 
2.13.6

