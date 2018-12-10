Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B41C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EC620851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EC620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeLJRSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:18:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92710C049593;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D07E6012B;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4F1EB224247; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 19/52] virito-fs: Make dax optional
Date:   Mon, 10 Dec 2018 12:12:45 -0500
Message-Id: <20181210171318.16998-20-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a 'dax' option and only enable dax when it's on.

Also show "dax" in mount options if filesystem was mounted with dax
enabled.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h    | 1 +
 fs/fuse/inode.c     | 8 ++++++++
 fs/fuse/virtio_fs.c | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b5a6a12e67d6..345abe9b022f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -70,6 +70,7 @@ struct fuse_mount_data {
 	unsigned group_id_present:1;
 	unsigned default_permissions:1;
 	unsigned allow_other:1;
+	unsigned dax:1;
 	unsigned max_read;
 	unsigned blksize;
 };
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 10e4a39318c4..d2afce377fd4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -439,6 +439,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_DAX,
 	OPT_ERR
 };
 
@@ -452,6 +453,7 @@ static const match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_BLKSIZE,			"blksize=%u"},
+	{OPT_DAX,			"dax"},
 	{OPT_ERR,			NULL}
 };
 
@@ -543,6 +545,10 @@ int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 			d->blksize = value;
 			break;
 
+		case OPT_DAX:
+			d->dax = 1;
+			break;
+
 		default:
 			return 0;
 		}
@@ -571,6 +577,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 		seq_printf(m, ",blksize=%lu", sb->s_blocksize);
+	if (fc->dax_dev)
+		seq_printf(m, ",dax");
 	return 0;
 }
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 55bac1465536..e4d5e0cd41ba 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1050,7 +1050,7 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
 	/* TODO this sends FUSE_INIT and could cause hiprio or notifications
 	 * virtqueue races since they haven't been set up yet!
 	 */
-	err = fuse_fill_super_common(sb, &d, fs->dax_dev,
+	err = fuse_fill_super_common(sb, &d, d.dax ? fs->dax_dev : NULL,
 				     &virtio_fs_fiq_ops, fs,
 				     (void **)&fs->vqs[2].fud);
 	if (err < 0)
-- 
2.13.6

