Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB6AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D283B207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D283B207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeJXQf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:35:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727512AbeJXQf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:35:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CEFBCEA933F0;
        Wed, 24 Oct 2018 16:08:53 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 24 Oct 2018
 16:08:45 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] f2fs: fix count of seg_freed to make sec_freed correct
Date:   Wed, 24 Oct 2018 16:08:30 +0800
Message-ID: <1540368510-14270-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
References: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sbi->segs_per_sec > 1, and if some segno has 0 valid blocks before
gc starts, do_garbage_collect will skip counting seg_freed++, and this
will cause seg_freed < sbi->segs_per_sec and finally skip sec_freed++.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241f..57841e9 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1130,9 +1130,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					GET_SUM_BLOCK(sbi, segno));
 		f2fs_put_page(sum_page, 0);
 
-		if (get_valid_blocks(sbi, segno, false) == 0 ||
-				!PageUptodate(sum_page) ||
-				unlikely(f2fs_cp_error(sbi)))
+		if (get_valid_blocks(sbi, segno, false) == 0)
+			goto freed;
+		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
 			goto next;
 
 		sum = page_address(sum_page);
@@ -1160,6 +1160,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		stat_inc_seg_count(sbi, type, gc_type);
 
+freed:
 		if (gc_type == FG_GC &&
 				get_valid_blocks(sbi, segno, false) == 0)
 			seg_freed++;
-- 
1.8.5.2

