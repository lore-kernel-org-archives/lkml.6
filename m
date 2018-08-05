Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35409C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF7121888
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0novPEVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF7121888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeHERKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeHERKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:10:12 -0400
Received: from localhost.localdomain (unknown [49.77.238.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF43621885;
        Sun,  5 Aug 2018 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533481518;
        bh=2hEFIvEtwX7SkoJ+rX/3ZOWeZ3DNR37ztxvYsKfiDcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=0novPEVe+VOh+8mtgEL0OqxpM0mX3kTe//IR0AazqJipMqq8X01XbupApqoXE9S7j
         CSN1UdyBs7LkArQY5Mgh1gvF6t8oathId8B0NphdQy9Y6kDNW70NxambyVK0svBMYy
         6D/Q4zBwu92ny4tTITm85iyylDm+1cGs8BTAyO8M=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 3/4] f2fs: fix avoid race between truncate and background GC
Date:   Sun,  5 Aug 2018 23:04:25 +0800
Message-Id: <20180805150425.9433-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Thread A				Background GC
- f2fs_setattr isize to 0
 - truncate_setsize
					- gc_data_segment
					 - f2fs_get_read_data_page page #0
					  - set_page_dirty
					  - set_cold_data
 - f2fs_truncate

- f2fs_setattr isize to 4k
- read 4k <--- hit data in cached page #0

Above race condition can cause read out invalid data in a truncated
page, fix it by i_gc_rwsem[WRITE] lock.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- decrease i_gc_rwsem lock coverage.
 fs/f2fs/data.c |  4 ++++
 fs/f2fs/file.c | 37 +++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1e6cc68fb7c4..45f043ee48bd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2199,8 +2199,12 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 
 	if (to > i_size) {
 		down_write(&F2FS_I(inode)->i_mmap_sem);
+		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
 		truncate_pagecache(inode, i_size);
 		f2fs_truncate_blocks(inode, i_size, true);
+
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		up_write(&F2FS_I(inode)->i_mmap_sem);
 	}
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bcffb3b608ed..84f9d15788d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -796,22 +796,26 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		if (attr->ia_size <= i_size_read(inode)) {
-			down_write(&F2FS_I(inode)->i_mmap_sem);
-			truncate_setsize(inode, attr->ia_size);
+		bool to_smaller = (attr->ia_size <= i_size_read(inode));
+
+		down_write(&F2FS_I(inode)->i_mmap_sem);
+		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
+		truncate_setsize(inode, attr->ia_size);
+
+		if (to_smaller)
 			err = f2fs_truncate(inode);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
-			if (err)
-				return err;
-		} else {
-			/*
-			 * do not trim all blocks after i_size if target size is
-			 * larger than i_size.
-			 */
-			down_write(&F2FS_I(inode)->i_mmap_sem);
-			truncate_setsize(inode, attr->ia_size);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+		/*
+		 * do not trim all blocks after i_size if target size is
+		 * larger than i_size.
+		 */
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		up_write(&F2FS_I(inode)->i_mmap_sem);
+
+		if (err)
+			return err;
 
+		if (!to_smaller) {
 			/* should convert inline inode here */
 			if (!f2fs_may_inline_data(inode)) {
 				err = f2fs_convert_inline_inode(inode);
@@ -958,13 +962,18 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 			blk_start = (loff_t)pg_start << PAGE_SHIFT;
 			blk_end = (loff_t)pg_end << PAGE_SHIFT;
+
 			down_write(&F2FS_I(inode)->i_mmap_sem);
+			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
 			truncate_inode_pages_range(mapping, blk_start,
 					blk_end - 1);
 
 			f2fs_lock_op(sbi);
 			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
 			f2fs_unlock_op(sbi);
+
+			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			up_write(&F2FS_I(inode)->i_mmap_sem);
 		}
 	}
-- 
2.18.0

