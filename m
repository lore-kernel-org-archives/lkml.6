Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108FFC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D982081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D982081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJXRvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:51:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbeJXRvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:51:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35C74E85F0396;
        Wed, 24 Oct 2018 17:24:22 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Oct 2018 17:24:15 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to account preflush command for noflush_merge mode
Date:   Wed, 24 Oct 2018 17:24:10 +0800
Message-ID: <20181024092410.127957-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we only account preflush command for flush_merge mode,
so for noflush_merge mode, we can not know in-flight preflush
command count, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d0cc6330dd61..9f388098d174 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -666,7 +666,9 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 		return 0;
 
 	if (!test_opt(sbi, FLUSH_MERGE)) {
+		atomic_inc(&fcc->issing_flush);
 		ret = submit_flush_wait(sbi, ino);
+		atomic_dec(&fcc->issing_flush);
 		atomic_inc(&fcc->issued_flush);
 		return ret;
 	}
-- 
2.18.0.rc1

