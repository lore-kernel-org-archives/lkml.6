Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F4A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F4A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeLJRTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:19:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FB8E3154866;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C72D2605CF;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 76162224267; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 28/52] Do fallocate() to grow file before mapping for file growing writes
Date:   Mon, 10 Dec 2018 12:12:54 -0500
Message-Id: <20181210171318.16998-29-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How to handle file growing writes. For now, this patch does fallocate() to
grow file and then map it using dax. We need to figure out what's the best
way to handle it.

This patch does fallocate() and setup mapping operations in
fuse_dax_write_iter(), instead of iomap_begin(). I don't have access to file
pointer needed to send a message to fuse daemon in iomap_begin().

Dave Chinner has expressed concers with this approach as this is not
atomic. If guest crashes after falloc() but before data was written,
user will think that filesystem lost its data. So this is still an
outstanding issue.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 94ad76382a6f..41d773ba2c72 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -28,6 +28,9 @@ INTERVAL_TREE_DEFINE(struct fuse_dax_mapping,
                      rb, __u64, __subtree_last,
                      START, LAST, static inline, fuse_dax_interval_tree);
 
+static long __fuse_file_fallocate(struct file *file, int mode,
+					loff_t offset, loff_t length);
+
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 			  int opcode, struct fuse_open_out *outargp)
 {
@@ -1819,6 +1822,22 @@ static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* TODO file_update_time() but we don't want metadata I/O */
 
 	/* TODO handle growing the file */
+	/* Grow file here if need be. iomap_begin() does not have access
+	 * to file pointer
+	 */
+	if (iov_iter_rw(from) == WRITE &&
+	    ((iocb->ki_pos + iov_iter_count(from)) > i_size_read(inode))) {
+		ret = __fuse_file_fallocate(iocb->ki_filp, 0, iocb->ki_pos,
+						iov_iter_count(from));
+		if (ret < 0) {
+			printk("fallocate(offset=0x%llx length=0x%lx)"
+			" failed. err=%ld\n", iocb->ki_pos,
+			iov_iter_count(from), ret);
+			goto out;
+		}
+		pr_debug("fallocate(offset=0x%llx length=0x%lx)"
+		" succeed. ret=%ld\n", iocb->ki_pos, iov_iter_count(from), ret);
+	}
 
 	ret = dax_iomap_rw(iocb, from, &fuse_iomap_ops);
 
@@ -3331,8 +3350,12 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
-static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
-				loff_t length)
+/*
+ * This variant does not take any inode lock and if locking is required,
+ * caller is supposed to hold lock
+ */
+static long __fuse_file_fallocate(struct file *file, int mode,
+					loff_t offset, loff_t length)
 {
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
@@ -3346,8 +3369,6 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.mode = mode
 	};
 	int err;
-	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
-			   (mode & FALLOC_FL_PUNCH_HOLE);
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
@@ -3355,17 +3376,13 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (fc->no_fallocate)
 		return -EOPNOTSUPP;
 
-	if (lock_inode) {
-		inode_lock(inode);
-		if (mode & FALLOC_FL_PUNCH_HOLE) {
-			loff_t endbyte = offset + length - 1;
-			err = filemap_write_and_wait_range(inode->i_mapping,
-							   offset, endbyte);
-			if (err)
-				goto out;
-
-			fuse_sync_writes(inode);
-		}
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		loff_t endbyte = offset + length - 1;
+		err = filemap_write_and_wait_range(inode->i_mapping, offset,
+							endbyte);
+		if (err)
+			goto out;
+		fuse_sync_writes(inode);
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE))
@@ -3401,9 +3418,31 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (!(mode & FALLOC_FL_KEEP_SIZE))
 		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
+	return err;
+}
+
+static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
+				loff_t length)
+{
+	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file_inode(file);
+	struct fuse_conn *fc = ff->fc;
+	int err;
+	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
+			   (mode & FALLOC_FL_PUNCH_HOLE);
+
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+		return -EOPNOTSUPP;
+
+	if (fc->no_fallocate)
+		return -EOPNOTSUPP;
+
 	if (lock_inode)
-		inode_unlock(inode);
+		inode_lock(inode);
 
+	err = __fuse_file_fallocate(file, mode, offset, length);
+	if (lock_inode)
+		inode_unlock(inode);
 	return err;
 }
 
-- 
2.13.6

