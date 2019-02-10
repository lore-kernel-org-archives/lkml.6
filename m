Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA97C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20352206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfBJJnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:43:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbfBJJnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 04:43:51 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50A8A121E3E2FAA17C9F;
        Sun, 10 Feb 2019 17:43:48 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sun, 10 Feb 2019
 17:43:38 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <hirofumi@mail.parknet.co.jp>
CC:     <houtao1@huawei.com>
Subject: [PATCH] fat: enable .splice_write to support splice on O_DIRECT file
Date:   Sun, 10 Feb 2019 17:47:54 +0800
Message-ID: <20190210094754.56355-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now splice() on O_DIRECT-opened fat file will return -EFAULT, that is
because the default .splice_write, namely default_file_splice_write(),
will construct an ITER_KVEC iov_iter and dio_refill_pages() in dio path
can not handle it.

Fix it by implementing .splice_write through iter_file_splice_write().

Spotted by xfs-tests generic/091.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fat/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 13935ee99e1e..b3bed32946b1 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -214,6 +214,7 @@ const struct file_operations fat_file_operations = {
 #endif
 	.fsync		= fat_file_fsync,
 	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
 	.fallocate	= fat_fallocate,
 };
 
-- 
2.16.2.dirty

