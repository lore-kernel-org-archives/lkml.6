Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B84C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA9120870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfAWHAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:00:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfAWHAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:00:19 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5581275B08B3A9034AD;
        Wed, 23 Jan 2019 15:00:17 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 15:00:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mtd: docg3: Fix a possible memory leak of mtd->name
Date:   Wed, 23 Jan 2019 14:59:43 +0800
Message-ID: <20190123065943.5868-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case DOC_CHIPID_G3, mtd->name should be freed in the
err handling path, which is alloced by kasprintf.

Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/devices/docg3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 60ddc38..cbd25f9 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1867,6 +1867,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
 
 nomem4:
 	kfree(docg3->bbt);
+	kfree(mtd->name);
 nomem3:
 	kfree(mtd);
 nomem2:
-- 
2.7.0


