Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9054AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6E62168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6E62168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbeI1SEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:04:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57371 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729291AbeI1SEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:04:39 -0400
X-UUID: 554169f8611342478881d40d46051314-20180928
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1956017505; Fri, 28 Sep 2018 19:41:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Sep 2018 19:41:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 19:41:09 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 2/2] mmc: mediatek: add bus_clk control
Date:   Fri, 28 Sep 2018 19:40:55 +0800
Message-ID: <1538134855-11198-3-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
References: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when gate MSDC0_HCLK, access register will hang, even the MSDC driver
will never accessing register after HCLK was gated, but for safety, need
gate the bus_clk(which used to access register) too.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 0484138..1c1c967 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -387,6 +387,7 @@ struct msdc_host {
 
 	struct clk *src_clk;	/* msdc source clock */
 	struct clk *h_clk;      /* msdc h_clk */
+	struct clk *bus_clk;	/* bus clock which used to access register */
 	struct clk *src_clk_cg; /* msdc source clock control gate */
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
@@ -660,12 +661,14 @@ static void msdc_gate_clock(struct msdc_host *host)
 {
 	clk_disable_unprepare(host->src_clk_cg);
 	clk_disable_unprepare(host->src_clk);
+	clk_disable_unprepare(host->bus_clk);
 	clk_disable_unprepare(host->h_clk);
 }
 
 static void msdc_ungate_clock(struct msdc_host *host)
 {
 	clk_prepare_enable(host->h_clk);
+	clk_prepare_enable(host->bus_clk);
 	clk_prepare_enable(host->src_clk);
 	clk_prepare_enable(host->src_clk_cg);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
@@ -1900,6 +1903,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	host->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
+	if (IS_ERR(host->bus_clk))
+		host->bus_clk = NULL;
 	/*source clock control gate is optional clock*/
 	host->src_clk_cg = devm_clk_get(&pdev->dev, "source_cg");
 	if (IS_ERR(host->src_clk_cg))
-- 
1.8.1.1.dirty

