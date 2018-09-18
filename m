Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C66721471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C66721471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeIRSMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:12:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729501AbeIRSMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:12:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7E35AC0980175;
        Tue, 18 Sep 2018 20:40:04 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 20:39:58 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: avoid GC causing encrypted file corrupted
Date:   Tue, 18 Sep 2018 20:39:53 +0800
Message-ID: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The encrypted file may be corrupted by GC in following case:

Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
segment 2,

Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |

Before page 1 is written back and if segment 2 become a victim, then
page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
during the GC process of Time 2, f2fs should wait for page 1 written back
before reading it, or move_data_block will read a garbage block from
blkaddr B since page is not written back to blkaddr B yet.

Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
ra_data_block to read encrypted block, but it forgets to add
f2fs_wait_on_page_writeback to avoid racing between GC and flush.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a4c1a41..c55fb62 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -641,6 +641,14 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	fio.page = page;
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 
+	/*
+	 * don't cache encrypted data into meta inode until previous dirty
+	 * data were writebacked to avoid racing between GC and flush.
+	 */
+	f2fs_wait_on_page_writeback(page, DATA, true);
+
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+
 	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
 					dn.data_blkaddr,
 					FGP_LOCK | FGP_CREAT, GFP_NOFS);
@@ -723,6 +731,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	 */
 	f2fs_wait_on_page_writeback(page, DATA, true);
 
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+
 	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
 	if (err)
 		goto put_out;
-- 
1.8.5.2

