Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA0AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419C620880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419C620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbeGWPMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:12:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388099AbeGWPMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:12:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88111EE27A07;
        Mon, 23 Jul 2018 22:10:40 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Mon, 23 Jul 2018
 22:10:32 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] f2fs: clear victim_secmap when section has full valid blocks
Date:   Mon, 23 Jul 2018 22:10:18 +0800
Message-ID: <1532355022-163029-2-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, f2fs only clears victim_secmap when it finds out
that the section has no valid blocks at all, but forgets to clear the
victim_secmap when the whole section has full valid blocks.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cfff7cf..255bff5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -776,7 +776,9 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
 			dirty_i->nr_dirty[t]--;
 
-		if (get_valid_blocks(sbi, segno, true) == 0)
+		if (get_valid_blocks(sbi, segno, true) == 0 ||
+			get_valid_blocks(sbi, segno, true) ==
+			(sbi->segs_per_sec << sbi->log_blocks_per_seg))
 			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
 						dirty_i->victim_secmap);
 	}
-- 
1.8.5.2

