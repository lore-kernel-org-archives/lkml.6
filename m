Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B91C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD53321479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD53321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJJJJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:09:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbeJJJJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:09:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 77CA7B00432A6;
        Wed, 10 Oct 2018 09:49:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Wed, 10 Oct 2018 09:49:07 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH -next] phy: phy-ocelot-serdes: fix return value check in serdes_probe()
Date:   Wed, 10 Oct 2018 02:00:24 +0000
Message-ID: <1539136824-44940-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: 51f6b410fc22 ("phy: add driver for Microsemi Ocelot SerDes muxing")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/phy/mscc/phy-ocelot-serdes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
index 8936abd..b2be546 100644
--- a/drivers/phy/mscc/phy-ocelot-serdes.c
+++ b/drivers/phy/mscc/phy-ocelot-serdes.c
@@ -257,8 +257,8 @@ static int serdes_probe(struct platform_device *pdev)
 
 	ctrl->dev = &pdev->dev;
 	ctrl->regs = syscon_node_to_regmap(pdev->dev.parent->of_node);
-	if (!ctrl->regs)
-		return -ENODEV;
+	if (IS_ERR(ctrl->regs))
+		return PTR_ERR(ctrl->regs);
 
 	for (i = 0; i <= SERDES_MAX; i++) {
 		ret = serdes_phy_create(ctrl, i, &ctrl->phys[i]);

