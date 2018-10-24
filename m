Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE5CC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314C207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C314C207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJXUDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:03:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbeJXUDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:03:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E2A253E32EE2;
        Wed, 24 Oct 2018 19:35:58 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 24 Oct 2018
 19:35:50 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] f2fs: only flush the single temp bio cache which owns the target page
Date:   Wed, 24 Oct 2018 19:35:45 +0800
Message-ID: <1540380945-18114-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
References: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, when f2fs finds which temp bio cache owns the target page,
it will flush all the three temp bio caches, but we only need to flush
one single bio cache indeed, which can help to keep bio merged.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 106f116..882e217 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -396,13 +396,17 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
 }
 
 static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
-				enum page_type type, enum temp_type temp)
+				struct inode *inode, struct page *page, nid_t ino,
+				enum page_type type, enum temp_type temp, bool force)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
 
 	down_write(&io->io_rwsem);
 
+	if (!force && !__has_merged_page(io, inode, page, ino))
+		goto out;
+
 	/* change META to META_FLUSH in the checkpoint procedure */
 	if (type >= META_FLUSH) {
 		io->fio.type = META_FLUSH;
@@ -412,6 +416,7 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 	}
 	__submit_merged_bio(io);
+out:
 	up_write(&io->io_rwsem);
 }
 
@@ -426,7 +431,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 
 	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
 
-		__f2fs_submit_merged_write(sbi, type, temp);
+		__f2fs_submit_merged_write(sbi, inode, page, ino, type, temp, force);
 
 		/* TODO: use HOT temp only for meta pages now. */
 		if (type >= META)
-- 
1.8.5.2

