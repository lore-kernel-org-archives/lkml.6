Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65308C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267E72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267E72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeLJRRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:17:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EC0730044D9;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3F26015E;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8FFCE22426F; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 35/52] fuse: Add logic to do direct reclaim of memory
Date:   Mon, 10 Dec 2018 12:13:01 -0500
Message-Id: <20181210171318.16998-36-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be done only from same inode. Also it can be done only for
read/write case and not for fault case. Reason, as of now reclaim requires
holding inode_lock, fuse_inode->i_mmap_sem and fuse_inode->dmap_tree
locks in that order and only read/write path will allow that (and not
fault path).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 17becdff3014..13db83d105ff 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -30,6 +30,8 @@ INTERVAL_TREE_DEFINE(struct fuse_dax_mapping,
 
 static long __fuse_file_fallocate(struct file *file, int mode,
 					loff_t offset, loff_t length);
+static struct fuse_dax_mapping *alloc_dax_mapping_reclaim(struct fuse_conn *fc,
+					struct inode *inode);
 
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 			  int opcode, struct fuse_open_out *outargp)
@@ -1727,7 +1729,12 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 		if (pos >= i_size_read(inode))
 			goto iomap_hole;
 
-		alloc_dmap = alloc_dax_mapping(fc);
+		/* Can't do reclaim in fault path yet due to lock ordering */
+		if (flags & IOMAP_FAULT)
+			alloc_dmap = alloc_dax_mapping(fc);
+		else
+			alloc_dmap = alloc_dax_mapping_reclaim(fc, inode);
+
 		if (!alloc_dmap)
 			return -EBUSY;
 
@@ -3705,24 +3712,14 @@ void fuse_init_file_inode(struct inode *inode)
 	}
 }
 
-int fuse_dax_free_one_mapping_locked(struct fuse_conn *fc, struct inode *inode,
-				u64 dmap_start)
+int fuse_dax_reclaim_dmap_locked(struct fuse_conn *fc, struct inode *inode,
+				struct fuse_dax_mapping *dmap)
 {
 	int ret;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_dax_mapping *dmap;
-
-	WARN_ON(!inode_is_locked(inode));
-
-	/* Find fuse dax mapping at file offset inode. */
-	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, dmap_start,
-							dmap_start);
-
-	/* Range already got cleaned up by somebody else */
-	if (!dmap)
-		return 0;
 
-	ret = filemap_fdatawrite_range(inode->i_mapping, dmap->start, dmap->end);
+	ret = filemap_fdatawrite_range(inode->i_mapping, dmap->start,
+					dmap->end);
 	if (ret) {
 		printk("filemap_fdatawrite_range() failed. err=%d start=0x%llx,"
 			" end=0x%llx\n", ret, dmap->start, dmap->end);
@@ -3743,6 +3740,99 @@ int fuse_dax_free_one_mapping_locked(struct fuse_conn *fc, struct inode *inode,
 	/* Remove dax mapping from inode interval tree now */
 	fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
 	fi->nr_dmaps--;
+	return 0;
+}
+
+/* First first mapping in the tree and free it. */
+struct fuse_dax_mapping *fuse_dax_reclaim_first_mapping_locked(
+				struct fuse_conn *fc, struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	int ret;
+
+	/* Find fuse dax mapping at file offset inode. */
+	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, 0, -1);
+	if (!dmap)
+		return NULL;
+
+	ret = fuse_dax_reclaim_dmap_locked(fc, inode, dmap);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	/* Clean up dmap. Do not add back to free list */
+	spin_lock(&fc->lock);
+	list_del_init(&dmap->busy_list);
+	WARN_ON(fc->nr_busy_ranges == 0);
+	fc->nr_busy_ranges--;
+	dmap->inode = NULL;
+	dmap->start = dmap->end = 0;
+	spin_unlock(&fc->lock);
+
+	pr_debug("fuse: reclaimed memory range window_offset=0x%llx,"
+				" length=0x%llx\n", dmap->window_offset,
+				dmap->length);
+	return dmap;
+}
+
+/*
+ * First first mapping in the tree and free it and return it. Do not add
+ * it back to free pool.
+ *
+ * This is called with inode lock held.
+ */
+struct fuse_dax_mapping *fuse_dax_reclaim_first_mapping(struct fuse_conn *fc,
+					struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+
+	down_write(&fi->i_mmap_sem);
+	down_write(&fi->i_dmap_sem);
+	dmap = fuse_dax_reclaim_first_mapping_locked(fc, inode);
+	up_write(&fi->i_dmap_sem);
+	up_write(&fi->i_mmap_sem);
+	return dmap;
+}
+
+static struct fuse_dax_mapping *alloc_dax_mapping_reclaim(struct fuse_conn *fc,
+					struct inode *inode)
+{
+	struct fuse_dax_mapping *dmap;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	dmap = alloc_dax_mapping(fc);
+	if (dmap)
+		return dmap;
+
+	/* There are no mappings which can be reclaimed */
+	if (!fi->nr_dmaps)
+		return NULL;
+
+	/* Try reclaim a fuse dax memory range */
+	return fuse_dax_reclaim_first_mapping(fc, inode);
+}
+
+int fuse_dax_free_one_mapping_locked(struct fuse_conn *fc, struct inode *inode,
+				u64 dmap_start)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+
+	WARN_ON(!inode_is_locked(inode));
+
+	/* Find fuse dax mapping at file offset inode. */
+	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, dmap_start,
+							dmap_start);
+
+	/* Range already got cleaned up by somebody else */
+	if (!dmap)
+		return 0;
+
+	ret = fuse_dax_reclaim_dmap_locked(fc, inode, dmap);
+	if (ret < 0)
+		return ret;
 
 	/* Cleanup dmap entry and add back to free list */
 	spin_lock(&fc->lock);
@@ -3757,7 +3847,6 @@ int fuse_dax_free_one_mapping_locked(struct fuse_conn *fc, struct inode *inode,
 	pr_debug("fuse: freed memory range window_offset=0x%llx,"
 				" length=0x%llx\n", dmap->window_offset,
 				dmap->length);
-
 	return ret;
 }
 
-- 
2.13.6

