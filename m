Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C01C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5118420851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5118420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeLJRQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:16:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728403AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E94497AE95;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4632600D7;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B56C3224279; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 45/52] virtio: Free fuse devices on umount
Date:   Mon, 10 Dec 2018 12:13:11 -0500
Message-Id: <20181210171318.16998-46-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When unmounting the fs close all the fuse devices.
This includes making sure the daemon gets a FUSE_DESTROY to
tell it.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 fs/fuse/fuse_i.h    |  1 +
 fs/fuse/inode.c     |  3 ++-
 fs/fuse/virtio_fs.c | 13 ++++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7b2db87c6ead..30c7b4b56200 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -85,6 +85,7 @@ struct fuse_mount_data {
 	unsigned default_permissions:1;
 	unsigned allow_other:1;
 	unsigned dax:1;
+	unsigned destroy:1;
 	unsigned max_read;
 	unsigned blksize;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 178ac3171564..4d2d623e607f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1263,7 +1263,7 @@ int fuse_fill_super_common(struct super_block *sb,
 		goto err_put_root;
 	__set_bit(FR_BACKGROUND, &init_req->flags);
 
-	if (is_bdev) {
+	if (mount_data->destroy) {
 		fc->destroy_req = fuse_request_alloc(0);
 		if (!fc->destroy_req)
 			goto err_free_init_req;
@@ -1339,6 +1339,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	d.fiq_ops = &fuse_dev_fiq_ops;
 	d.fiq_priv = NULL;
 	d.fudptr = &file->private_data;
+	d.destroy = is_bdev;
 	err = fuse_fill_super_common(sb, &d);
 
 err_fput:
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f436f5b3f85c..c71bc47395b4 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1128,6 +1128,7 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
 	d.fiq_ops = &virtio_fs_fiq_ops;
 	d.fiq_priv = fs;
 	d.fudptr = (void **)&fs->vqs[2].fud;
+	d.destroy = true; /* Send destroy request on unmount */
 	err = fuse_fill_super_common(sb, &d);
 
 	if (err < 0)
@@ -1160,6 +1161,16 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
 	return err;
 }
 
+static void virtio_kill_sb(struct super_block *sb)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	fuse_kill_sb_anon(sb);
+	if (fc) {
+		struct virtio_fs *vfs = fc->iq.priv;
+		virtio_fs_free_devs(vfs);
+	}
+}
+
 static struct dentry *virtio_fs_mount(struct file_system_type *fs_type,
 				      int flags, const char *dev_name,
 				      void *raw_data)
@@ -1171,7 +1182,7 @@ static struct file_system_type virtio_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= KBUILD_MODNAME,
 	.mount		= virtio_fs_mount,
-	.kill_sb	= fuse_kill_sb_anon,
+	.kill_sb	= virtio_kill_sb,
 };
 
 static int __init virtio_fs_init(void)
-- 
2.13.6

