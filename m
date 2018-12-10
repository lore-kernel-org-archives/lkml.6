Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A23C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592482082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592482082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeLJRQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:16:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91901C049588;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39EA5605CC;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9803B224271; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 37/52] fuse: multiplex cached/direct_io/dax file operations
Date:   Mon, 10 Dec 2018 12:13:03 -0500
Message-Id: <20181210171318.16998-38-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

---
 fs/fuse/file.c     | 91 ++++++++++++++++++++++++++++--------------------------
 fs/splice.c        |  3 +-
 include/linux/fs.h |  2 ++
 3 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1f172d372eeb..6421c94cef46 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -22,8 +22,6 @@
 #include <linux/iomap.h>
 #include <linux/interval_tree_generic.h>
 
-static const struct file_operations fuse_direct_io_file_operations;
-
 INTERVAL_TREE_DEFINE(struct fuse_dax_mapping,
                      rb, __u64, __subtree_last,
                      START, LAST, static inline, fuse_dax_interval_tree);
@@ -381,8 +379,6 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (ff->open_flags & FOPEN_DIRECT_IO)
-		file->f_op = &fuse_direct_io_file_operations;
 	if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 		invalidate_inode_pages2(inode->i_mapping);
 	if (ff->open_flags & FOPEN_NONSEEKABLE)
@@ -1121,11 +1117,23 @@ static int fuse_readpages(struct file *file, struct address_space *mapping,
 	return err;
 }
 
+
+static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
+
 static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file->f_mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		return fuse_direct_read_iter(iocb, to);
+
+	if (IS_DAX(inode))
+		return fuse_dax_read_iter(iocb, to);
+
 	/*
 	 * In auto invalidate mode, always update attributes on read.
 	 * Otherwise, only update if we attempt to read past EOF (to ensure
@@ -1375,9 +1383,14 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
 	return res > 0 ? res : err;
 }
 
+static ssize_t fuse_direct_write_iter(struct kiocb *iocb,
+				      struct iov_iter *from);
+static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
+
 static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
 	struct address_space *mapping = file->f_mapping;
 	ssize_t written = 0;
 	ssize_t written_buffered = 0;
@@ -1385,6 +1398,11 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	loff_t endbyte = 0;
 
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		return fuse_direct_write_iter(iocb, from);
+	if (IS_DAX(inode))
+		return fuse_dax_write_iter(iocb, from);
+
 	if (get_fuse_conn(inode)->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
 		err = fuse_update_attributes(mapping->host, file);
@@ -2517,8 +2535,20 @@ static const struct vm_operations_struct fuse_file_vm_ops = {
 	.page_mkwrite	= fuse_page_mkwrite,
 };
 
+static int fuse_direct_mmap(struct file *file, struct vm_area_struct *vma);
+static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
+
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct fuse_file *ff = file->private_data;
+
+	/* DAX mmap is superior to direct_io mmap */
+	if (IS_DAX(file_inode(file)))
+		return fuse_dax_mmap(file, vma);
+
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		return fuse_direct_mmap(file, vma);
+
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
 		fuse_link_write_file(file);
 
@@ -2538,6 +2568,18 @@ static int fuse_direct_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_mmap(file, vma);
 }
 
+static ssize_t fuse_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe, size_t len,
+				     unsigned int flags)
+{
+	struct fuse_file *ff = in->private_data;
+
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		return default_file_splice_read(in, ppos, pipe, len, flags);
+	else
+		return generic_file_splice_read(in, ppos, pipe, len, flags);
+
+}
 static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 			    bool write)
 {
@@ -3629,13 +3671,13 @@ static const struct file_operations fuse_file_operations = {
 	.read_iter	= fuse_file_read_iter,
 	.write_iter	= fuse_file_write_iter,
 	.mmap		= fuse_file_mmap,
+	.splice_read    = fuse_file_splice_read,
 	.open		= fuse_open,
 	.flush		= fuse_flush,
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
 	.lock		= fuse_file_lock,
 	.flock		= fuse_file_flock,
-	.splice_read	= generic_file_splice_read,
 	.unlocked_ioctl	= fuse_file_ioctl,
 	.compat_ioctl	= fuse_file_compat_ioctl,
 	.poll		= fuse_file_poll,
@@ -3643,42 +3685,6 @@ static const struct file_operations fuse_file_operations = {
 	.copy_file_range = fuse_copy_file_range,
 };
 
-static const struct file_operations fuse_direct_io_file_operations = {
-	.llseek		= fuse_file_llseek,
-	.read_iter	= fuse_direct_read_iter,
-	.write_iter	= fuse_direct_write_iter,
-	.mmap		= fuse_direct_mmap,
-	.open		= fuse_open,
-	.flush		= fuse_flush,
-	.release	= fuse_release,
-	.fsync		= fuse_fsync,
-	.lock		= fuse_file_lock,
-	.flock		= fuse_file_flock,
-	.unlocked_ioctl	= fuse_file_ioctl,
-	.compat_ioctl	= fuse_file_compat_ioctl,
-	.poll		= fuse_file_poll,
-	.fallocate	= fuse_file_fallocate,
-	/* no splice_read */
-};
-
-static const struct file_operations fuse_dax_file_operations = {
-	.llseek		= fuse_file_llseek,
-	.read_iter	= fuse_dax_read_iter,
-	.write_iter	= fuse_dax_write_iter,
-	.mmap		= fuse_dax_mmap,
-	.open		= fuse_open,
-	.flush		= fuse_flush,
-	.release	= fuse_release,
-	.fsync		= fuse_fsync,
-	.lock		= fuse_file_lock,
-	.flock		= fuse_file_flock,
-	.unlocked_ioctl	= fuse_file_ioctl,
-	.compat_ioctl	= fuse_file_compat_ioctl,
-	.poll		= fuse_file_poll,
-	.fallocate	= fuse_file_fallocate,
-	/* no splice_read */
-};
-
 static const struct address_space_operations fuse_file_aops  = {
 	.readpage	= fuse_readpage,
 	.writepage	= fuse_writepage,
@@ -3716,7 +3722,6 @@ void fuse_init_file_inode(struct inode *inode)
 
 	if (fc->dax_dev) {
 		inode->i_flags |= S_DAX;
-		inode->i_fop = &fuse_dax_file_operations;
 		inode->i_data.a_ops = &fuse_dax_file_aops;
 	}
 }
diff --git a/fs/splice.c b/fs/splice.c
index 3553f1956508..93cbb03a70b1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -365,7 +365,7 @@ static ssize_t kernel_readv(struct file *file, const struct kvec *vec,
 	return res;
 }
 
-static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
+ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags)
 {
@@ -429,6 +429,7 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_advance(&to, copied);	/* truncates and discards */
 	return res;
 }
+EXPORT_SYMBOL(default_file_splice_read);
 
 /*
  * Send 'sd->len' bytes to socket from 'sd->file' at position 'sd->pos'
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c95c0807471f..574e63b58a6f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3040,6 +3040,8 @@ extern void block_sync_page(struct page *page);
 /* fs/splice.c */
 extern ssize_t generic_file_splice_read(struct file *, loff_t *,
 		struct pipe_inode_info *, size_t, unsigned int);
+extern ssize_t default_file_splice_read(struct file *, loff_t *,
+		struct pipe_inode_info *, size_t, unsigned int);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 		struct file *, loff_t *, size_t, unsigned int);
 extern ssize_t generic_splice_sendpage(struct pipe_inode_info *pipe,
-- 
2.13.6

