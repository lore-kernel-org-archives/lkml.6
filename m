Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59445C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C6F21888
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyVmZvwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C6F21888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeHERIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeHERII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:08:08 -0400
Received: from localhost.localdomain (unknown [49.77.238.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0085521885;
        Sun,  5 Aug 2018 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533481396;
        bh=/jMPMEXJtcrvTphQV50JbS85kjAtlJEXvumdph8WMgw=;
        h=From:To:Cc:Subject:Date:From;
        b=hyVmZvwmMZdC549N3WH2nJK+pKNZYQFnSX50TCctXc6IpQLV12pheb/BfQTXGGIUT
         J884ErqG6XrC+LAh52ZHGQiZkGSUNbn4BKmgb8Xs9JL8U1gIAORFttvY7D3vftZbQM
         m9up0/9Rtg0HqaiQur1uy2cU9p/cRs0qiN1DvY7E=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: avoid race between zero_range and background GC
Date:   Sun,  5 Aug 2018 23:02:22 +0800
Message-Id: <20180805150222.9261-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

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
v2:
- decrease i_gc_rwsem lock coverage.
 fs/f2fs/file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 606c5a215542..bcffb3b608ed 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1311,8 +1311,6 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		goto out_sem;
 
-	truncate_pagecache_range(inode, offset, offset + len - 1);
-
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
 
@@ -1342,12 +1340,19 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			unsigned int end_offset;
 			pgoff_t end;
 
+			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
+			truncate_pagecache_range(inode,
+				(loff_t)index << PAGE_SHIFT,
+				((loff_t)pg_end << PAGE_SHIFT) - 1);
+
 			f2fs_lock_op(sbi);
 
 			set_new_dnode(&dn, inode, NULL, NULL, 0);
 			ret = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 			if (ret) {
 				f2fs_unlock_op(sbi);
+				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 				goto out;
 			}
 
@@ -1356,7 +1361,9 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 
 			ret = f2fs_do_zero_range(&dn, index, end);
 			f2fs_put_dnode(&dn);
+
 			f2fs_unlock_op(sbi);
+			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 			f2fs_balance_fs(sbi, dn.node_changed);
 
-- 
2.18.0

