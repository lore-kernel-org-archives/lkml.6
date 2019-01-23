Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23483C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8AD21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfAWJH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:07:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfAWJH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:07:56 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 417A116A68697D7F6298;
        Wed, 23 Jan 2019 17:07:54 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 17:07:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] mtd: docg3: Fix a possible memory leak of mtd->name
Date:   Wed, 23 Jan 2019 17:07:41 +0800
Message-ID: <20190123090741.14612-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case DOC_CHIPID_G3, mtd->name is not freed in err handling path,
which is alloced by kasprintf(). Fix this by using devm_kasprintf().

Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use devm_kasprintf
---
 drivers/mtd/devices/docg3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 4c94fc0..af824d3 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1767,8 +1767,8 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
 
 	switch (chip_id) {
 	case DOC_CHIPID_G3:
-		mtd->name = kasprintf(GFP_KERNEL, "docg3.%d",
-				      docg3->device_id);
+		mtd->name = devm_kasprintf(GFP_KERNEL, "docg3.%d",
+					   docg3->device_id);
 		if (!mtd->name)
 			return -ENOMEM;
 		docg3->max_block = 2047;
-- 
2.7.0


