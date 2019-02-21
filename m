Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB3EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579372086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfBUMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:40:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbfBUMkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:40:32 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C4805F0FD4D4B573A3A9;
        Thu, 21 Feb 2019 20:40:29 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Feb 2019 20:40:20 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to update iostat correctly in IPU path
Date:   Thu, 21 Feb 2019 20:40:13 +0800
Message-ID: <20190221124013.47531-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error path of IPU, we didn't account iostat correctly, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3602acee4985..86a6fcbe8484 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3197,10 +3197,10 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	stat_inc_inplace_blocks(fio->sbi);
 
 	err = f2fs_submit_page_bio(fio);
-	if (!err)
+	if (!err) {
 		update_device_state(fio);
-
-	f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
+		f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
+	}
 
 	return err;
 }
-- 
2.18.0.rc1

