Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F8BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458BD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458BD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeLJRSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B494284B1;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99D4E60158;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5A9CA224260; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 22/52] Create a list of free memory ranges
Date:   Mon, 10 Dec 2018 12:12:48 -0500
Message-Id: <20181210171318.16998-23-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Divide the dax memory range into fixed size ranges (2MB for now) and put
them in a list. This will track free ranges. Once an inode requires a
free range, we will take one from here and put it in interval-tree
of ranges assigned to inode.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h    | 14 +++++++++
 fs/fuse/inode.c     | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/virtio_fs.c |  2 ++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b9880be690bd..f0775d76e31f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -46,6 +46,10 @@
 /** Number of page pointers embedded in fuse_req */
 #define FUSE_REQ_INLINE_PAGES 1
 
+/* Default memory range size, 2MB */
+#define FUSE_DAX_MEM_RANGE_SZ	(2*1024*1024)
+#define FUSE_DAX_MEM_RANGE_PAGES	(FUSE_DAX_MEM_RANGE_SZ/PAGE_SIZE)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -83,6 +87,9 @@ struct fuse_forget_link {
 
 /** Translation information for file offsets to DAX window offsets */
 struct fuse_dax_mapping {
+	/* Will connect in fc->free_ranges to keep track of free memory */
+	struct list_head list;
+
        /** Position in DAX window */
        u64 window_offset;
 
@@ -816,6 +823,13 @@ struct fuse_conn {
 
 	/** DAX device, non-NULL if DAX is supported */
 	struct dax_device *dax_dev;
+
+	/*
+	 * DAX Window Free Ranges. TODO: This might not be best place to store
+	 * this free list
+	 */
+	unsigned long nr_free_ranges;
+	struct list_head free_ranges;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d2afce377fd4..403360e352d8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -22,6 +22,8 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/dax.h>
+#include <linux/pfn_t.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -607,6 +609,69 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 	fpq->connected = 1;
 }
 
+static void fuse_free_dax_mem_ranges(struct list_head *mem_list)
+{
+	struct fuse_dax_mapping *range, *temp;
+
+	/* Free All allocated elements */
+	list_for_each_entry_safe(range, temp, mem_list, list) {
+		list_del(&range->list);
+		kfree(range);
+	}
+}
+
+static int fuse_dax_mem_range_init(struct fuse_conn *fc,
+				   struct dax_device *dax_dev)
+{
+	long nr_pages, nr_ranges;
+	void *kaddr;
+	pfn_t pfn;
+	struct fuse_dax_mapping *range;
+	LIST_HEAD(mem_ranges);
+	phys_addr_t phys_addr;
+	int ret = 0, id;
+	size_t dax_size = -1;
+	unsigned long allocated_ranges = 0, i;
+
+	id = dax_read_lock();
+	nr_pages = dax_direct_access(dax_dev, 0, PHYS_PFN(dax_size), &kaddr,
+					&pfn);
+	dax_read_unlock(id);
+	if (nr_pages < 0) {
+		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
+		return nr_pages;
+	}
+
+	phys_addr = pfn_t_to_phys(pfn);
+	nr_ranges = nr_pages/FUSE_DAX_MEM_RANGE_PAGES;
+	printk("fuse_dax_mem_range_init(): dax mapped %ld pages. nr_ranges=%ld\n", nr_pages, nr_ranges);
+
+	for (i = 0; i < nr_ranges; i++) {
+		range = kzalloc(sizeof(struct fuse_dax_mapping), GFP_KERNEL);
+		if (!range) {
+			pr_debug("memory allocation for mem_range failed.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
+		/* TODO: This offset only works if virtio-fs driver is not
+		 * having some memory hidden at the beginning. This needs
+		 * better handling
+		 */
+		range->window_offset = i * FUSE_DAX_MEM_RANGE_SZ;
+		range->length = FUSE_DAX_MEM_RANGE_SZ;
+		list_add_tail(&range->list, &mem_ranges);
+		allocated_ranges++;
+	}
+
+	list_replace_init(&mem_ranges, &fc->free_ranges);
+	fc->nr_free_ranges = allocated_ranges;
+	return 0;
+out_err:
+	/* Free All allocated elements */
+	fuse_free_dax_mem_ranges(&mem_ranges);
+	return ret;
+}
+
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 			struct dax_device *dax_dev,
 			const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
@@ -636,6 +701,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->dax_dev = dax_dev;
 	fc->user_ns = get_user_ns(user_ns);
+	INIT_LIST_HEAD(&fc->free_ranges);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -644,6 +710,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		if (fc->destroy_req)
 			fuse_request_free(fc->destroy_req);
+		if (fc->dax_dev)
+			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		put_pid_ns(fc->pid_ns);
 		put_user_ns(fc->user_ns);
 		fc->release(fc);
@@ -1136,9 +1204,17 @@ int fuse_fill_super_common(struct super_block *sb,
 	fuse_conn_init(fc, sb->s_user_ns, dax_dev, fiq_ops, fiq_priv);
 	fc->release = fuse_free_conn;
 
+	if (dax_dev) {
+		err = fuse_dax_mem_range_init(fc, dax_dev);
+		if (err) {
+			pr_debug("fuse_dax_mem_range_init() returned %d\n", err);
+			goto err_put_conn;
+		}
+	}
+
 	fud = fuse_dev_alloc(fc);
 	if (!fud)
-		goto err_put_conn;
+		goto err_free_ranges;
 
 	fc->dev = sb->s_dev;
 	fc->sb = sb;
@@ -1211,6 +1287,9 @@ int fuse_fill_super_common(struct super_block *sb,
 	dput(root_dentry);
  err_dev_free:
 	fuse_dev_free(fud);
+ err_free_ranges:
+	if (dax_dev)
+		fuse_free_dax_mem_ranges(&fc->free_ranges);
  err_put_conn:
 	fuse_conn_put(fc);
 	sb->s_fs_info = NULL;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ef1469b38a6d..c79c9a885253 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -451,6 +451,8 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	phys_addr_t offset = PFN_PHYS(pgoff);
 	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
 
+	pr_debug("virtio_fs_direct_access(): called. nr_pages=%ld max_nr_pages=%ld\n", nr_pages, max_nr_pages);
+
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-- 
2.13.6

