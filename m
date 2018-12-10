Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26798C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D6E20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D6E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeLJRPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:15:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbeLJRNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79227804E9;
        Mon, 10 Dec 2018 17:13:38 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18920103BAB3;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AA19D224276; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 42/52] fuse: Wait for memory ranges to become free
Date:   Mon, 10 Dec 2018 12:13:08 -0500
Message-Id: <20181210171318.16998-43-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 10 Dec 2018 17:13:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we run out of memory ranges. So in that case, wait for memory
ranges to become free, instead of returning -EBUSY.

dax fault path is holding fuse_inode->i_mmap_sem and once that is being
held, memory reclaim can't be done. Its not safe to wait while holding
fuse_inode->i_mmap_sem for two reasons.

- Worker thread to free memory might block on fuse_inode->i_mmap_sem as well.
- This inode is holding all the memory and more memory can't be freed.

In both the cases, deadlock will ensue. So return -ENOSPC from iomap_begin()
in fault path if memory can't be allocated. Drop fuse_inode->i_mmap_sem,
and wait for a free range to become available and retry.

read/write path is a different story. We hold inode lock and lock ordering
allows to grab fuse_inode->immap_sem, if needed. That means we can do direct
reclaim in that path. But if there is no memory allocated to this inode,
then direct reclaim will not work and we need to wait for a memory range
to become free. So try following order.

A. Try to get a free range.
B. If not, try direct reclaim.
C. If not, wait for a memory range to become free

Here sleeping with locks held should be fine because in step B, we made
sure this inode is not holding any ranges. That means other inodes are
holding ranges and somebody should be able to free memory. Also, worker
thread does a trylock() on inode lock. That means worker tread will not
wait on this inode and move onto next memory range. Hence above sequence
should be deadlock free.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c   | 60 +++++++++++++++++++++++++++++++++++++++++++-------------
 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/inode.c  |  1 +
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 709747458335..d0942ce0a6c3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -220,6 +220,8 @@ static void __free_dax_mapping(struct fuse_conn *fc,
 {
 	list_add_tail(&dmap->list, &fc->free_ranges);
 	fc->nr_free_ranges++;
+	/* TODO: Wake up only when needed */
+	wake_up(&fc->dax_range_waitq);
 }
 
 static void free_dax_mapping(struct fuse_conn *fc,
@@ -1770,12 +1772,18 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 			goto iomap_hole;
 
 		/* Can't do reclaim in fault path yet due to lock ordering */
-		if (flags & IOMAP_FAULT)
+		if (flags & IOMAP_FAULT) {
 			alloc_dmap = alloc_dax_mapping(fc);
-		else
+			if (!alloc_dmap)
+				return -ENOSPC;
+		} else {
 			alloc_dmap = alloc_dax_mapping_reclaim(fc, inode);
+			if (IS_ERR(alloc_dmap))
+				return PTR_ERR(alloc_dmap);
+		}
 
-		if (!alloc_dmap)
+		/* If we are here, we should have memory allocated */
+		if (WARN_ON(!alloc_dmap))
 			return -EBUSY;
 
 		/*
@@ -2596,14 +2604,24 @@ static ssize_t fuse_file_splice_read(struct file *in, loff_t *ppos,
 static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 			    bool write)
 {
-	int ret;
+	int ret, error = 0;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct super_block *sb = inode->i_sb;
 	pfn_t pfn;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool retry = false;
 
 	if (write)
 		sb_start_pagefault(sb);
 
+retry:
+	if (retry && !(fc->nr_free_ranges > 0)) {
+		ret = -EINTR;
+		if (wait_event_killable_exclusive(fc->dax_range_waitq,
+					(fc->nr_free_ranges > 0)))
+			goto out;
+	}
+
 	/*
 	 * We need to serialize against not only truncate but also against
 	 * fuse dax memory range reclaim. While a range is being reclaimed,
@@ -2611,13 +2629,20 @@ static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 	 * to populate page cache or access memory we are trying to free.
 	 */
 	down_read(&get_fuse_inode(inode)->i_mmap_sem);
-	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
+	ret = dax_iomap_fault(vmf, pe_size, &pfn, &error, &fuse_iomap_ops);
+	if ((ret & VM_FAULT_ERROR) && error == -ENOSPC) {
+		error = 0;
+		retry = true;
+		up_read(&get_fuse_inode(inode)->i_mmap_sem);
+		goto retry;
+	}
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 
 	up_read(&get_fuse_inode(inode)->i_mmap_sem);
 
+out:
 	if (write)
 		sb_end_pagefault(sb);
 
@@ -3828,16 +3853,23 @@ static struct fuse_dax_mapping *alloc_dax_mapping_reclaim(struct fuse_conn *fc,
 	struct fuse_dax_mapping *dmap;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
-	dmap = alloc_dax_mapping(fc);
-	if (dmap)
-		return dmap;
-
-	/* There are no mappings which can be reclaimed */
-	if (!fi->nr_dmaps)
-		return NULL;
+	while(1) {
+		dmap = alloc_dax_mapping(fc);
+		if (dmap)
+			return dmap;
 
-	/* Try reclaim a fuse dax memory range */
-	return fuse_dax_reclaim_first_mapping(fc, inode);
+		if (fi->nr_dmaps)
+			return fuse_dax_reclaim_first_mapping(fc, inode);
+		/*
+		 * There are no mappings which can be reclaimed.
+		 * Wait for one.
+		 */
+		if (!(fc->nr_free_ranges > 0)) {
+			if (wait_event_killable_exclusive(fc->dax_range_waitq,
+					(fc->nr_free_ranges > 0)))
+				return ERR_PTR(-EINTR);
+		}
+	}
 }
 
 int fuse_dax_free_one_mapping_locked(struct fuse_conn *fc, struct inode *inode,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bbefa7c11078..7b2db87c6ead 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -886,6 +886,9 @@ struct fuse_conn {
 	/* Worker to free up memory ranges */
 	struct delayed_work dax_free_work;
 
+	/* Wait queue for a dax range to become free */
+	wait_queue_head_t dax_range_waitq;
+
 	/*
 	 * DAX Window Free Ranges. TODO: This might not be best place to store
 	 * this free list
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d31acb97eede..178ac3171564 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -695,6 +695,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	atomic_set(&fc->dev_count, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	init_waitqueue_head(&fc->reserved_req_waitq);
+	init_waitqueue_head(&fc->dax_range_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
-- 
2.13.6

