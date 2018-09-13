Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE81C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FC4204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FC4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbeIMTGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:06:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbeIMTGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:06:10 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F18B2D10;
        Thu, 13 Sep 2018 13:56:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 089/197] f2fs: fix avoid race between truncate and background GC
Date:   Thu, 13 Sep 2018 15:30:38 +0200
Message-Id: <20180913131845.090273910@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit a33c150237a20d97a174243bc658c86502f9d370 ]

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |    4 ++++
 fs/f2fs/file.c |   37 +++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2149,8 +2149,12 @@ static void f2fs_write_failed(struct add
 
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
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -782,22 +782,26 @@ int f2fs_setattr(struct dentry *dentry,
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
@@ -944,13 +948,18 @@ static int punch_hole(struct inode *inod
 
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


