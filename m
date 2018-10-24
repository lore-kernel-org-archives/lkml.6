Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3463C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D172082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D172082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJXR5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:57:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726676AbeJXR5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:57:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53516B946A42B;
        Wed, 24 Oct 2018 17:29:46 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Oct 2018 17:29:39 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to be aware discard/preflush command in is_idle()
Date:   Wed, 24 Oct 2018 17:29:36 +0800
Message-ID: <20181024092936.129587-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing in-flight discard/preflush command count check
in is_idle().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- add in-flight preflush count check as well.
 fs/f2fs/f2fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6af2a105529d..70009709d50c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2156,7 +2156,9 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
-		get_pages(sbi, F2FS_WB_CP_DATA))
+		get_pages(sbi, F2FS_WB_CP_DATA) ||
+		atomic_read(&SM_I(sbi)->dcc_info->issing_discard) ||
+		atomic_read(&SM_I(sbi)->fcc_info->issing_flush))
 		return false;
 	return f2fs_time_over(sbi, type);
 }
-- 
2.18.0.rc1

