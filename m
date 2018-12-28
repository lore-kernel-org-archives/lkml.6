Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8071C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898CF208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeL1Giu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 01:38:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbeL1Git (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 01:38:49 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B7D91D5F454AC;
        Fri, 28 Dec 2018 14:38:46 +0800 (CST)
Received: from SIA1000080854.huawei.com (10.180.101.187) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 14:38:40 +0800
From:   h00249924 <hutenghui@huawei.com>
To:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <liyuequan@hisilicon.com>, <cash.qianli@hisilicon.com>,
        <huangli295@hisilicon.com>, <hantanglei@huawei.com>,
        <wangyoulin1@hisilicon.com>, <ninggaoyu@hisilicon.com>,
        <hanxiaolong3@hisilicon.com>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/3] k3dma: Upgrade k3dma drever to support hisi_asp_dma hardware
Date:   Fri, 28 Dec 2018 14:36:21 +0800
Message-ID: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.101.187]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

There is an new "hisi-pcm-asp-dma-1.0" device added in
"arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
So we have to add a matching id in the driver file:
"{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", }"

And also hisi-pcm-asp dma device needs no setting to the clock.
So we skip this by "if" sentence on id string matching:
"if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0)"

After above this driver will support both k3 and hisi_asp dma hardware.

Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/k3dma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index fdec2b6..10eecc2 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -792,6 +792,7 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
 
 static const struct of_device_id k3_pdma_dt_ids[] = {
 	{ .compatible = "hisilicon,k3-dma-1.0", },
+	{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
@@ -835,10 +836,12 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-requests", &d->dma_requests);
 	}
 
-	d->clk = devm_clk_get(&op->dev, NULL);
-	if (IS_ERR(d->clk)) {
-		dev_err(&op->dev, "no dma clk\n");
-		return PTR_ERR(d->clk);
+	if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0) {
+		d->clk = devm_clk_get(&op->dev, NULL);
+		if (IS_ERR(d->clk)) {
+			dev_err(&op->dev, "no dma clk\n");
+			return PTR_ERR(d->clk);
+		}
 	}
 
 	irq = platform_get_irq(op, 0);
-- 
1.9.1

