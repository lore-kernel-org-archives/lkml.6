Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12137C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B762083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B762083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeGZMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:02:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729107AbeGZMCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:02:08 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9BFF9D74B8A0B;
        Thu, 26 Jul 2018 18:45:49 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Thu, 26 Jul 2018 18:45:42 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: avoid race between zero_range and background GC
Date:   Thu, 26 Jul 2018 18:45:36 +0800
Message-ID: <20180726104536.114340-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thread A				Background GC
- f2fs_zero_range
 - truncate_pagecache_range
					- gc_data_segment
					 - get_read_data_page
					  - move_data_page
					   - set_page_dirty
					   - set_cold_data
 - f2fs_do_zero_range
  - dn->data_blkaddr = NEW_ADDR;
  - f2fs_set_data_blkaddr

Actually, we don't need to set dirty & checked flag on the page, since
all valid data in the page should be zeroed by zero_range().

Use i_gc_rwsem[WRITE] to avoid such race condition.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 267ec3794e1e..7bd2412a8c37 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1309,6 +1309,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
 	if (ret)
@@ -1389,6 +1390,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	}
 out_sem:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	return ret;
 }
-- 
2.18.0.rc1

