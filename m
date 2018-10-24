Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E922C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5232207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5232207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeJXQiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:38:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726797AbeJXQiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:38:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65607F211CB7D;
        Wed, 24 Oct 2018 16:11:07 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 24 Oct 2018
 16:10:57 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: only flush the single temp bio cache which owns the target page
Date:   Wed, 24 Oct 2018 16:10:51 +0800
Message-ID: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
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
 fs/f2fs/data.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 106f116..04ebbad 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -374,7 +374,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 
 static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
 						struct page *page, nid_t ino,
-						enum page_type type)
+						enum page_type type, enum temp_type *owner)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	enum temp_type temp;
@@ -392,6 +392,10 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (ret || btype == META)
 			break;
 	}
+	if (!ret || (!inode && !page && !ino))
+		*owner = NR_TEMP_TYPE;
+	else
+		*owner = temp;
 	return ret;
 }
 
@@ -421,9 +425,14 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 {
 	enum temp_type temp;
 
-	if (!force && !has_merged_page(sbi, inode, page, ino, type))
+	if (!force && !has_merged_page(sbi, inode, page, ino, type, &temp))
 		return;
 
+	if (!force && temp != NR_TEMP_TYPE) {
+		__f2fs_submit_merged_write(sbi, type, temp);
+		return;
+	}
+
 	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
 
 		__f2fs_submit_merged_write(sbi, type, temp);
-- 
1.8.5.2

