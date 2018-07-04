Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF3AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CA02150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CA02150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeGDKFT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:05:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58062 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932997AbeGDKFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:05:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FBDBF34775C3;
        Wed,  4 Jul 2018 18:05:12 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.382.0; Wed, 4 Jul 2018 18:04:52 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: try grabbing node page lock aggressively in sync scenario
Date:   Wed, 4 Jul 2018 18:04:10 +0800
Message-ID: <20180704100410.20777-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In synchronous scenario, like in checkpoint(), we are going to flush
dirty node pages to device synchronously, we can easily failed
writebacking node page due to trylock_page() failure, especially in
condition of intensive lock competition, which can cause long latency
of checkpoint(). So let's use lock_page() in synchronous scenario to
avoid this issue.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index eeee582cee32..237d19eb13b5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1651,7 +1651,9 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 						!is_cold_node(page)))
 				continue;
 lock_node:
-			if (!trylock_page(page))
+			if (wbc->sync_mode == WB_SYNC_ALL)
+				lock_page(page);
+			else if (!trylock_page(page))
 				continue;
 
 			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
-- 
2.18.0.rc1

