Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E858EC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8492088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8492088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeG1MHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 08:07:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727861AbeG1MHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 08:07:15 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BA4D0AFDC7F1A;
        Sat, 28 Jul 2018 18:41:06 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Sat, 28 Jul 2018 18:41:01 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: print node block address
Date:   Sat, 28 Jul 2018 18:40:59 +0800
Message-ID: <20180728104059.12396-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print block address of unreachable node id in fsck_verify() for better
debugging.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index bb1da0305f2c..20a569228516 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2507,7 +2507,11 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < fsck->nr_nat_entries; i++) {
 		if (f2fs_test_bit(i, fsck->nat_area_bitmap) != 0) {
-			printf("NID[0x%x] is unreachable\n", i);
+			struct node_info ni;
+
+			get_node_info(sbi, i, &ni);
+			printf("NID[0x%x] is unreachable, blkaddr:0x%x\n",
+							i, ni.blk_addr);
 			nr_unref_nid++;
 		}
 	}
-- 
2.18.0.rc1

