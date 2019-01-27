Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BE3C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6DB2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfA0Njt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 08:39:49 -0500
Received: from smtprz15.163.net ([106.3.154.248]:52297 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbfA0Njt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 08:39:49 -0500
Received: from 172.25.16.148 (unknown [172.25.16.148])
        by freemail01.tom.com (Postfix) with ESMTP id 7E8E01C81B98
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:15:46 +0800 (CST)
Received: from 172.25.16.90 (HELO smtp.tom.com) ([172.25.16.90])
          by localhost (TOM SMTP Server) with SMTP ID 279681272
          for <linux-kernel@vger.kernel.org>;
          Sun, 27 Jan 2019 21:15:46 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 4D5E51C81B92
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:15:46 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 424F6100170D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:15:46 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Vfdivqtb8CF for <linux-kernel@vger.kernel.org>;
        Sun, 27 Jan 2019 21:15:45 +0800 (CST)
Received: from localhost (unknown [222.209.19.163])
        by antispam1.tom.com (Postfix) with ESMTPA id EC1801001582;
        Sun, 27 Jan 2019 21:15:44 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] fs: Reset fully_mapped more accurately
Date:   Sun, 27 Jan 2019 21:15:33 +0800
Message-Id: <1548594933-19399-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because get_block() might set the buffer mapped, reset fully_mapped
after it is more accurately.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 52d024b..b2e9167 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2241,7 +2241,6 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 		if (!buffer_mapped(bh)) {
 			int err = 0;
 
-			fully_mapped = 0;
 			if (iblock < lblock) {
 				WARN_ON(bh->b_size != blocksize);
 				err = get_block(inode, iblock, bh, 0);
@@ -2249,6 +2248,7 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 					SetPageError(page);
 			}
 			if (!buffer_mapped(bh)) {
+				fully_mapped = 0;
 				zero_user(page, i * blocksize, blocksize);
 				if (!err)
 					set_buffer_uptodate(bh);
-- 
1.9.1

