Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2028C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BB1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfBSCdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:33:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfBSCdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:33:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A25D871B3D2D341E3F47;
        Tue, 19 Feb 2019 10:33:41 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.201)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 19 Feb 2019 10:33:34
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: silence VM_WARN_ON_ONCE in mempool_alloc
Date:   Tue, 19 Feb 2019 10:31:52 +0800
Message-ID: <20190219023152.37863-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that __GFP_ZERO is not supported for mempool_alloc,
which also documented in the mempool_alloc comments.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f91d8630c9a2..83c14b31aaba 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -299,9 +299,10 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 		for (; start < F2FS_IO_SIZE(sbi); start++) {
 			struct page *page =
 				mempool_alloc(sbi->write_io_dummy,
-					GFP_NOIO | __GFP_ZERO | __GFP_NOFAIL);
+					      GFP_NOIO | __GFP_NOFAIL);
 			f2fs_bug_on(sbi, !page);
 
+			zero_user_segment(page, 0, PAGE_SIZE);
 			SetPagePrivate(page);
 			set_page_private(page, (unsigned long)DUMMY_WRITTEN_PAGE);
 			lock_page(page);
-- 
2.14.4

