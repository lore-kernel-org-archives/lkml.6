Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F59C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E6D2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E6D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbeG0Lhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:37:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41991 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731136AbeG0Lhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:37:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B2EC9E99E5C8A;
        Fri, 27 Jul 2018 18:16:18 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Fri, 27 Jul 2018 18:15:23 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] f2fs: don't keep meta pages used for block migration
Date:   Fri, 27 Jul 2018 18:15:13 +0800
Message-ID: <20180727101516.41403-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For migration of encrypted inode's block, we load data of encrypted block
into meta inode's page cache, after checkpoint, those all intermediate
pages should be clean, and no one will read them again, so let's just
release them for more memory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 12bebb8fa13d..67834d0ca422 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1499,6 +1499,14 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	commit_checkpoint(sbi, ckpt, start_blk);
 	wait_on_all_pages_writeback(sbi);
 
+	/*
+	 * invalidate intermediate page cache borrowed from meta inode
+	 * which are used for migration of encrypted inode's blocks.
+	 */
+	if (f2fs_sb_has_encrypt(sbi->sb))
+		invalidate_mapping_pages(META_MAPPING(sbi),
+				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1);
+
 	f2fs_release_ino_entry(sbi, false);
 
 	f2fs_reset_fsync_node_info(sbi);
-- 
2.18.0.rc1

