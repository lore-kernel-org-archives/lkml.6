Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1205D2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfAHCWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:22:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfAHCWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:22:07 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F898A29FB5F9DA0A3B9;
        Tue,  8 Jan 2019 10:22:04 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 8 Jan 2019 10:21:55 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to trigger fsck if dirent.name_len is zero
Date:   Tue, 8 Jan 2019 10:21:24 +0800
Message-ID: <20190108022124.33447-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While traversing dirents in f2fs_fill_dentries(), if bitmap is valid,
filename length should not be zero, otherwise, directory structure
consistency could be corrupted, in this case, let's print related
info and set SBI_NEED_FSCK to trigger fsck for repairing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 50d0d36280fa..926166528cd4 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -800,6 +800,10 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		if (de->name_len == 0) {
 			bit_pos++;
 			ctx->pos = start_pos + bit_pos;
+			printk_ratelimited(
+				"%s, invalid namelen(0), ino:%u, run fsck to fix.",
+				KERN_WARNING, le32_to_cpu(de->ino));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			continue;
 		}
 
-- 
2.18.0.rc1

