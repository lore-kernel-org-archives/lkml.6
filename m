Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C57C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CB820851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CB820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeLJRNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbeLJRNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 350383001FD2;
        Mon, 10 Dec 2018 17:13:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 088775C238;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8CD3122426D; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 34/52] fuse: Add logic to free up a memory range
Date:   Mon, 10 Dec 2018 12:13:00 -0500
Message-Id: <20181210171318.16998-35-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 10 Dec 2018 17:13:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add logic to free up a busy memory range. Freed memory range will be
returned to free pool. Add a worker which can be started to select
and free some busy memory ranges.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c   | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h |  10 ++++
 fs/fuse/inode.c  |   2 +
 3 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 73068289f62e..17becdff3014 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -272,7 +272,15 @@ static int fuse_setup_one_mapping(struct inode *inode,
 
 	pr_debug("fuse_setup_one_mapping() succeeded. offset=0x%llx err=%zd\n", offset, err);
 
-	/* TODO: What locking is required here. For now, using fc->lock */
+	/*
+	 * We don't take a refernce on inode. inode is valid right now and
+	 * when inode is going away, cleanup logic should first cleanup
+	 * dmap entries.
+	 *
+	 * TODO: Do we need to ensure that we are holding inode lock
+	 * as well.
+	 */
+	dmap->inode = inode;
 	dmap->start = offset;
 	dmap->end = offset + FUSE_DAX_MEM_RANGE_SZ - 1;
 	/* Protected by fi->i_dmap_sem */
@@ -347,6 +355,8 @@ void fuse_removemapping(struct inode *inode)
 			continue;
 		}
 
+		dmap->inode = NULL;
+
 		/* Add it back to free ranges list */
 		free_dax_mapping(fc, dmap);
 	}
@@ -3694,3 +3704,139 @@ void fuse_init_file_inode(struct inode *inode)
 		inode->i_data.a_ops = &fuse_dax_file_aops;
 	}
 }
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
+	ret = filemap_fdatawrite_range(inode->i_mapping, dmap->start, dmap->end);
+	if (ret) {
+		printk("filemap_fdatawrite_range() failed. err=%d start=0x%llx,"
+			" end=0x%llx\n", ret, dmap->start, dmap->end);
+		return ret;
+	}
+
+	ret = invalidate_inode_pages2_range(inode->i_mapping,
+					dmap->start >> PAGE_SHIFT,
+					dmap->end >> PAGE_SHIFT);
+	/* TODO: What to do if above fails? For now,
+	 * leave the range in place.
+	 */
+	if (ret) {
+		printk("invalidate_inode_pages2_range() failed err=%d\n", ret);
+		return ret;
+	}
+
+	/* Remove dax mapping from inode interval tree now */
+	fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
+	fi->nr_dmaps--;
+
+	/* Cleanup dmap entry and add back to free list */
+	spin_lock(&fc->lock);
+	list_del_init(&dmap->busy_list);
+	WARN_ON(fc->nr_busy_ranges == 0);
+	fc->nr_busy_ranges--;
+	dmap->inode = NULL;
+	dmap->start = dmap->end = 0;
+	__free_dax_mapping(fc, dmap);
+	spin_unlock(&fc->lock);
+
+	pr_debug("fuse: freed memory range window_offset=0x%llx,"
+				" length=0x%llx\n", dmap->window_offset,
+				dmap->length);
+
+	return ret;
+}
+
+/*
+ * Free a range of memory.
+ * Locking.
+ * 1. Take inode->i_rwsem to prever further read/write.
+ * 2. Take fuse_inode->i_mmap_sem to block dax faults.
+ * 3. Take fuse_inode->i_dmap_sem to protect interval tree. It might not
+ *    be strictly necessary as lock 1 and 2 seem sufficient.
+ */
+int fuse_dax_free_one_mapping(struct fuse_conn *fc, struct inode *inode,
+				u64 dmap_start)
+{
+	int ret;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	inode_lock(inode);
+	down_write(&fi->i_mmap_sem);
+	down_write(&fi->i_dmap_sem);
+	ret = fuse_dax_free_one_mapping_locked(fc, inode, dmap_start);
+	up_write(&fi->i_dmap_sem);
+	up_write(&fi->i_mmap_sem);
+	inode_unlock(inode);
+	return ret;
+}
+
+int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
+{
+	struct fuse_dax_mapping *dmap, *pos;
+	int ret, i;
+	u64 dmap_start = 0, window_offset = 0;
+	struct inode *inode = NULL;
+
+	/* Pick first busy range and free it for now*/
+	for (i = 0; i < nr_to_free; i++) {
+		dmap = NULL;
+		spin_lock(&fc->lock);
+
+		list_for_each_entry(pos, &fc->busy_ranges, busy_list) {
+			dmap = pos;
+			inode = igrab(dmap->inode);
+			/*
+			 * This inode is going away. That will free
+			 * up all the ranges anyway, continue to
+			 * next range.
+			 */
+			if (!inode)
+				continue;
+			dmap_start = dmap->start;
+			window_offset = dmap->window_offset;
+			break;
+		}
+		spin_unlock(&fc->lock);
+		if (!dmap)
+			return 0;
+
+		ret = fuse_dax_free_one_mapping(fc, inode, dmap_start);
+		iput(inode);
+		if (ret) {
+			printk("%s(window_offset=0x%llx) failed. err=%d\n",
+				__func__, window_offset, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+/* TODO: This probably should go in inode.c */
+void fuse_dax_free_mem_worker(struct work_struct *work)
+{
+	int ret;
+	struct fuse_conn *fc = container_of(work, struct fuse_conn,
+						dax_free_work.work);
+	pr_debug("fuse: Worker to free memory called.\n");
+	pr_debug("fuse: Worker to free memory called. nr_free_ranges=%lu"
+		 " nr_busy_ranges=%lu\n", fc->nr_free_ranges,
+		 fc->nr_busy_ranges);
+	ret = fuse_dax_free_memory(fc, FUSE_DAX_RECLAIM_CHUNK);
+	if (ret)
+		pr_debug("fuse: fuse_dax_free_memory() failed with err=%d\n", ret);
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 280f717deb57..383deaf0ecf1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -50,6 +50,9 @@
 #define FUSE_DAX_MEM_RANGE_SZ	(2*1024*1024)
 #define FUSE_DAX_MEM_RANGE_PAGES	(FUSE_DAX_MEM_RANGE_SZ/PAGE_SIZE)
 
+/* Number of ranges reclaimer will try to free in one invocation */
+#define FUSE_DAX_RECLAIM_CHUNK		(10)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -102,6 +105,9 @@ struct fuse_forget_link {
 
 /** Translation information for file offsets to DAX window offsets */
 struct fuse_dax_mapping {
+	/* Pointer to inode where this memory range is mapped */
+	struct inode *inode;
+
 	/* Will connect in fc->free_ranges to keep track of free memory */
 	struct list_head list;
 
@@ -870,6 +876,9 @@ struct fuse_conn {
 	unsigned long nr_busy_ranges;
 	struct list_head busy_ranges;
 
+	/* Worker to free up memory ranges */
+	struct delayed_work dax_free_work;
+
 	/*
 	 * DAX Window Free Ranges. TODO: This might not be best place to store
 	 * this free list
@@ -1244,6 +1253,7 @@ unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args);
  * Get the next unique ID for a request
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
+void fuse_dax_free_mem_worker(struct work_struct *work);
 void fuse_removemapping(struct inode *inode);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 59fc5a7a18fc..44f7bc44e319 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -713,6 +713,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->user_ns = get_user_ns(user_ns);
 	INIT_LIST_HEAD(&fc->free_ranges);
 	INIT_LIST_HEAD(&fc->busy_ranges);
+	INIT_DELAYED_WORK(&fc->dax_free_work, fuse_dax_free_mem_worker);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -721,6 +722,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		if (fc->destroy_req)
 			fuse_request_free(fc->destroy_req);
+		flush_delayed_work(&fc->dax_free_work);
 		if (fc->dax_dev)
 			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		put_pid_ns(fc->pid_ns);
-- 
2.13.6

