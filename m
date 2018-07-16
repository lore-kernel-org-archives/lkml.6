Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20BD20871
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20BD20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeGPKar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:30:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbeGPKar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:30:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C508D39ACEA5A;
        Mon, 16 Jul 2018 18:03:52 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Mon, 16 Jul 2018
 18:03:48 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] f2fs: clear the remaining prefree_map of the section
Date:   Mon, 16 Jul 2018 18:03:41 +0800
Message-ID: <1531735421-73669-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the case when sbi->segs_per_sec > 1 with lfs mode, take
section:segment = 5 for example, if the section prefree_map is
...previous section | current section (1 1 0 1 1) | next section...,
then the start = x, end = x + 1, after start = start_segno +
sbi->segs_per_sec, start = x + 5, then it will skip x + 3 and x + 4, but
their bitmap is still set, which will cause duplicated
f2fs_issue_discard of this same section in the next write_checkpoint, so
fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cfff7cf..5dc1d5cc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1729,6 +1729,15 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 		if (!test_opt(sbi, DISCARD))
 			continue;
 
+		if (test_opt(sbi, LFS) && sbi->segs_per_sec > 1) {
+			start = rounddown(start, sbi->segs_per_sec);
+			i = end;
+			end = roundup(end, sbi->segs_per_sec);
+			while (++i < end)
+				if (test_and_clear_bit(i, prefree_map))
+					dirty_i->nr_dirty[PRE]--;
+		}
+
 		if (force && start >= cpc->trim_start &&
 					(end - 1) <= cpc->trim_end)
 				continue;
-- 
1.8.5.2

