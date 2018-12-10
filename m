Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033AB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033AB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeLJRNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E5313082193;
        Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C74AE605C9;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C7F5022427C; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 48/52] virtio-fs: pass version table pointer to fuse
Date:   Mon, 10 Dec 2018 12:13:14 -0500
Message-Id: <20181210171318.16998-49-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h    | 12 ++++++++++++
 fs/fuse/inode.c     | 10 ++++++++++
 fs/fuse/virtio_fs.c |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 30c7b4b56200..8a2604606d51 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -100,6 +100,12 @@ struct fuse_mount_data {
 
 	/* fuse_dev pointer to fill in, should contain NULL on entry */
 	void **fudptr;
+
+	/* version table length in bytes */
+	size_t vertab_len;
+
+	/* version table kernel address */
+	void *vertab_kaddr;
 };
 
 /* One forget request */
@@ -898,6 +904,12 @@ struct fuse_conn {
 	struct list_head free_ranges;
 
 	unsigned long nr_ranges;
+
+	/** Size of version table */
+	uint64_t version_table_size;
+
+	/** Shared version entry for each active inode */
+	s64 *version_table;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4d2d623e607f..1ab4df442390 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -52,6 +52,7 @@ MODULE_PARM_DESC(max_user_congthresh,
  "unprivileged user can set");
 
 #define FUSE_SUPER_MAGIC 0x65735546
+#define VERSION_TABLE_MAGIC 0x7265566465726853
 
 #define FUSE_DEFAULT_BLKSIZE 512
 
@@ -1215,6 +1216,15 @@ int fuse_fill_super_common(struct super_block *sb,
 	fuse_conn_init(fc, sb->s_user_ns, mount_data->dax_dev,
 			mount_data->fiq_ops, mount_data->fiq_priv);
 	fc->release = fuse_free_conn;
+	fc->version_table_size = mount_data->vertab_len / sizeof(s64);
+	fc->version_table = mount_data->vertab_kaddr;
+
+	if (fc->version_table[0] != VERSION_TABLE_MAGIC) {
+		pr_warn("bad version table magic: 0x%16llx\n",
+			fc->version_table[0]);
+		fc->version_table_size = 0;
+		fc->version_table = NULL;
+	}
 
 	if (mount_data->dax_dev) {
 		err = fuse_dax_mem_range_init(fc, mount_data->dax_dev);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 7d5b23455639..88b00055589b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1246,6 +1246,8 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
 	d.fiq_priv = fs;
 	d.fudptr = (void **)&fs->vqs[2].fud;
 	d.destroy = true; /* Send destroy request on unmount */
+	d.vertab_len = fs->vertab_len;
+	d.vertab_kaddr = fs->vertab_kaddr;
 	err = fuse_fill_super_common(sb, &d);
 
 	if (err < 0)
-- 
2.13.6

