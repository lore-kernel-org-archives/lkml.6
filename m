Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E962223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E962223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeKMNx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:53:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15091 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbeKMNx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:53:59 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C1D82A6DFD28C;
        Tue, 13 Nov 2018 11:57:44 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 11:57:38 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] f2fs: only flush the single temp bio cache which owns the target page
Date:   Tue, 13 Nov 2018 11:57:32 +0800
Message-ID: <1542081452-66059-1-git-send-email-yunlong.song@huawei.com>
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
 fs/f2fs/data.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e0ffb1..cd8f670 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -372,29 +372,6 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 	return false;
 }
 
-static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
-						struct page *page, nid_t ino,
-						enum page_type type)
-{
-	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	enum temp_type temp;
-	struct f2fs_bio_info *io;
-	bool ret = false;
-
-	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
-		io = sbi->write_io[btype] + temp;
-
-		down_read(&io->io_rwsem);
-		ret = __has_merged_page(io, inode, page, ino);
-		up_read(&io->io_rwsem);
-
-		/* TODO: use HOT temp only for meta pages now. */
-		if (ret || btype == META)
-			break;
-	}
-	return ret;
-}
-
 static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 				enum page_type type, enum temp_type temp)
 {
@@ -420,13 +397,19 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				nid_t ino, enum page_type type, bool force)
 {
 	enum temp_type temp;
-
-	if (!force && !has_merged_page(sbi, inode, page, ino, type))
-		return;
+	bool ret = true;
 
 	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
+		if (!force)	{
+			enum page_type btype = PAGE_TYPE_OF_BIO(type);
+			struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
 
-		__f2fs_submit_merged_write(sbi, type, temp);
+			down_read(&io->io_rwsem);
+			ret = __has_merged_page(io, inode, page, ino);
+			up_read(&io->io_rwsem);
+		}
+		if (ret)
+			__f2fs_submit_merged_write(sbi, type, temp);
 
 		/* TODO: use HOT temp only for meta pages now. */
 		if (type >= META)
-- 
1.8.5.2

