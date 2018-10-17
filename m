Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8A6ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5912151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5912151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeJQRpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:45:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbeJQRpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:45:10 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 99216DC2246DD;
        Wed, 17 Oct 2018 17:50:13 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Wed, 17 Oct 2018 17:50:07 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to account IO correctly
Date:   Wed, 17 Oct 2018 17:49:54 +0800
Message-ID: <20181017094954.67547-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below race can cause reversed reference on F2FS_RD_DATA, there is
the same issue in f2fs_submit_page_bio(), fix them by relocate
__submit_bio() and inc_page_count.

Thread A			Thread B
- f2fs_write_begin
 - f2fs_submit_page_read
 - __submit_bio
				- f2fs_read_end_io
				 - __read_end_io
				 - dec_page_count(, F2FS_RD_DATA)
 - inc_page_count(, F2FS_RD_DATA)

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c03bd0c2ed22..8b9240762156 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -480,10 +480,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	}
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
-	__submit_bio(fio->sbi, bio, fio->type);
-
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
 			__read_io_type(page): WB_DATA_TYPE(fio->page));
+
+	__submit_bio(fio->sbi, bio, fio->type);
 	return 0;
 }
 
@@ -612,8 +612,8 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 		return -EFAULT;
 	}
 	ClearPageError(page);
-	__submit_bio(F2FS_I_SB(inode), bio, DATA);
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
+	__submit_bio(F2FS_I_SB(inode), bio, DATA);
 	return 0;
 }
 
-- 
2.18.0.rc1

