Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B00C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7742085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBUMhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:37:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfBUMhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:37:39 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF613E4DF1B7B5361BDD;
        Thu, 21 Feb 2019 20:37:30 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Feb 2019 20:37:21 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix encrypted page memory leak
Date:   Thu, 21 Feb 2019 20:37:14 +0800
Message-ID: <20190221123714.47172-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IPU path of f2fs_do_write_data_page(), in its error path, we
need to release encrypted page and fscrypt context, otherwise it
will cause memory leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e099babf85bd..b0d1e946e141 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1860,8 +1860,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi);
 		err = f2fs_inplace_write_data(fio);
-		if (err && PageWriteback(page))
-			end_page_writeback(page);
+		if (err) {
+			if (f2fs_encrypted_file(inode))
+				fscrypt_pullback_bio_page(&fio->encrypted_page,
+									true);
+			if (PageWriteback(page))
+				end_page_writeback(page);
+		}
 		trace_f2fs_do_write_data_page(fio->page, IPU);
 		set_inode_flag(inode, FI_UPDATE_WRITE);
 		return err;
-- 
2.18.0.rc1

