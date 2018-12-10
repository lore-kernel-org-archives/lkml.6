Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496BFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186C32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186C32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeLJRPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:15:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbeLJRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4B7B3001FCD;
        Mon, 10 Dec 2018 17:13:41 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B87BF608E6;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 88A6122426C; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 33/52] fuse, dax: Take ->i_mmap_sem lock during dax page fault
Date:   Mon, 10 Dec 2018 12:12:59 -0500
Message-Id: <20181210171318.16998-34-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 10 Dec 2018 17:13:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need some kind of locking mechanism here. Normal file systems like
ext4 and xfs seems to take their own semaphore to protect agains
truncate while fault is going on.

We have additional requirement to protect against fuse dax memory range
reclaim. When a range has been selected for reclaim, we need to make sure
no other read/write/fault can try to access that memory range while
reclaim is in progress. Once reclaim is complete, lock will be released
and read/write/fault will trigger allocation of fresh dax range.

Taking inode_lock() is not an option in fault path as lockdep complains
about circular dependencies. So define a new fuse_inode->i_mmap_sem.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c    |  2 ++
 fs/fuse/file.c   | 17 +++++++++++++----
 fs/fuse/fuse_i.h |  7 +++++++
 fs/fuse/inode.c  |  1 +
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b7e6e421f6bb..8aa4ff82ea7a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1553,8 +1553,10 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	 */
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache(inode, outarg.attr.size);
 		invalidate_inode_pages2(inode->i_mapping);
+		up_write(&fi->i_mmap_sem);
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index eb12776f5ff6..73068289f62e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2523,13 +2523,20 @@ static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 	if (write)
 		sb_start_pagefault(sb);
 
-	/* TODO inode semaphore to protect faults vs truncate */
-
+	/*
+	 * We need to serialize against not only truncate but also against
+	 * fuse dax memory range reclaim. While a range is being reclaimed,
+	 * we do not want any read/write/mmap to make progress and try
+	 * to populate page cache or access memory we are trying to free.
+	 */
+	down_read(&get_fuse_inode(inode)->i_mmap_sem);
 	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 
+	up_read(&get_fuse_inode(inode)->i_mmap_sem);
+
 	if (write)
 		sb_end_pagefault(sb);
 
@@ -3476,9 +3483,11 @@ static long __fuse_file_fallocate(struct file *file, int mode,
 			file_update_time(file);
 	}
 
-	if (mode & FALLOC_FL_PUNCH_HOLE)
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache_range(inode, offset, offset + length - 1);
-
+		down_write(&fi->i_mmap_sem);
+	}
 	fuse_invalidate_attr(inode);
 
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e32b0059493b..280f717deb57 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -211,6 +211,13 @@ struct fuse_inode {
 	 */
 	struct rw_semaphore i_dmap_sem;
 
+	/**
+	 * Can't take inode lock in fault path (leads to circular dependency).
+	 * So take this in fuse dax fault path to make sure truncate and
+	 * punch hole etc. can't make progress in parallel.
+	 */
+	struct rw_semaphore i_mmap_sem;
+
 	/** Sorted rb tree of struct fuse_dax_mapping elements */
 	struct rb_root_cached dmap_tree;
 	unsigned long nr_dmaps;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 234b9c0c80ab..59fc5a7a18fc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -85,6 +85,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	fi->nr_dmaps = 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_dmap_sem);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget) {
-- 
2.13.6

