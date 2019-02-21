Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D44C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91270214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBUE7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:59:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfBUE7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:59:35 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7271FFAC21B84052042C;
        Thu, 21 Feb 2019 12:59:31 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.212)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 21 Feb 2019 12:59:24
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: no need to take page lock in readdir
Date:   Thu, 21 Feb 2019 12:57:35 +0800
Message-ID: <20190221045735.45419-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFS will take inode_lock for readdir, therefore no need to
take page lock in readdir at all just as the majority of
other generic filesystems.

This patch improves concurrency since .iterate_shared
was introduced to VFS years ago.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

 personally tend to use read_mapping_page here, but it seems
 that f2fs has some remaining customized code since it was
 merged into Linux, use f2fs_find_data_page instead.

 fs/f2fs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ecc3a4e2be96..64602bc1e092 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -873,7 +873,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 			page_cache_sync_readahead(inode->i_mapping, ra, file, n,
 				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
 
-		dentry_page = f2fs_get_lock_data_page(inode, n, false);
+		dentry_page = f2fs_find_data_page(inode, n);
 		if (IS_ERR(dentry_page)) {
 			err = PTR_ERR(dentry_page);
 			if (err == -ENOENT) {
@@ -891,11 +891,11 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		err = f2fs_fill_dentries(ctx, &d,
 				n * NR_DENTRY_IN_BLOCK, &fstr);
 		if (err) {
-			f2fs_put_page(dentry_page, 1);
+			f2fs_put_page(dentry_page, 0);
 			break;
 		}
 
-		f2fs_put_page(dentry_page, 1);
+		f2fs_put_page(dentry_page, 0);
 	}
 out_free:
 	fscrypt_fname_free_buffer(&fstr);
-- 
2.14.4

