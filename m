Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB795C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940E62081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940E62081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeKCSUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 14:20:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbeKCSUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 14:20:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EC8F4B08A280D;
        Sat,  3 Nov 2018 17:09:41 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 3 Nov 2018
 17:09:33 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <chao@kernel.org>, <devel@driverdev.osuosl.org>
CC:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: remove the redundant d_rehash() for the root dentry
Date:   Sat, 3 Nov 2018 17:23:56 +0800
Message-ID: <20181103092356.10224-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is actually no need at all to d_rehash() for the root dentry
as Al pointed out, fix it.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/super.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index f69e619807a1..1ab3553c839b 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -442,12 +442,6 @@ static int erofs_read_super(struct super_block *sb,
 
 	erofs_register_super(sb);
 
-	/*
-	 * We already have a positive dentry, which was instantiated
-	 * by d_make_root. Just need to d_rehash it.
-	 */
-	d_rehash(sb->s_root);
-
 	if (!silent)
 		infoln("mounted on %s with opts: %s.", dev_name,
 			(char *)data);
-- 
2.14.4

