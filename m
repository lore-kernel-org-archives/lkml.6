Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B21C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FDD206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I2wkMG41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfAIJLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:11:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48252 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbfAIJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:11:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x099BM5s055464;
        Wed, 9 Jan 2019 03:11:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547025082;
        bh=ldcte9NoiwgWZQQDr7hCoaXEK5wNb5WkJyiMlHWfUg0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=I2wkMG41/xVOWKmYmW0Ihrndf/XQFKzS9T3SGDbZFI3C5MDGGcAIsHToi1XiEI45W
         5cBnh7T4JUzvYcX1WmprKWWbrj+HgpMmTL+LQrDKnWnrftNDNFtKONS8k9KPBPGPS1
         pCcimfs4iILQ5W1eKz+N1kHN8A+k/bt/pB3eBgac=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x099BMJx099844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 03:11:22 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 03:11:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 03:11:22 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x099BFBP017497;
        Wed, 9 Jan 2019 03:11:19 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] serial: 8250_omap: Drop check for of_node
Date:   Wed, 9 Jan 2019 14:42:04 +0530
Message-ID: <20190109091206.25759-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109091206.25759-1-vigneshr@ti.com>
References: <20190109091206.25759-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250_omap is DT only driver so dev->of_node always exists. Drop check
for existence of valid dev->of_node to simplify omap8250_probe().

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 63 +++++++++++++----------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ad7ba7d0f28d..a74126569785 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1134,10 +1134,12 @@ static int omap8250_probe(struct platform_device *pdev)
 {
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	struct device_node *np = pdev->dev.of_node;
 	struct omap8250_priv *priv;
 	struct uart_8250_port up;
 	int ret;
 	void __iomem *membase;
+	const struct of_device_id *id;
 
 	if (!regs || !irq) {
 		dev_err(&pdev->dev, "missing registers or irq\n");
@@ -1194,27 +1196,20 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.unthrottle = omap_8250_unthrottle;
 	up.port.rs485_config = omap_8250_rs485_config;
 
-	if (pdev->dev.of_node) {
-		const struct of_device_id *id;
-
-		ret = of_alias_get_id(pdev->dev.of_node, "serial");
-
-		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				     &up.port.uartclk);
-		priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
-
-		id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
-		if (id && id->data)
-			priv->habit |= *(u8 *)id->data;
-	} else {
-		ret = pdev->id;
-	}
+	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias/pdev id\n");
+		dev_err(&pdev->dev, "failed to get alias\n");
 		return ret;
 	}
 	up.port.line = ret;
 
+	of_property_read_u32(np, "clock-frequency", &up.port.uartclk);
+	priv->wakeirq = irq_of_parse_and_map(np, 1);
+
+	id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
+	if (id && id->data)
+		priv->habit |= *(u8 *)id->data;
+
 	if (!up.port.uartclk) {
 		up.port.uartclk = DEFAULT_CLK_SPEED;
 		dev_warn(&pdev->dev,
@@ -1242,25 +1237,23 @@ static int omap8250_probe(struct platform_device *pdev)
 	omap_serial_fill_features_erratas(&up, priv);
 	up.port.handle_irq = omap8250_no_handle_irq;
 #ifdef CONFIG_SERIAL_8250_DMA
-	if (pdev->dev.of_node) {
-		/*
-		 * Oh DMA support. If there are no DMA properties in the DT then
-		 * we will fall back to a generic DMA channel which does not
-		 * really work here. To ensure that we do not get a generic DMA
-		 * channel assigned, we have the the_no_dma_filter_fn() here.
-		 * To avoid "failed to request DMA" messages we check for DMA
-		 * properties in DT.
-		 */
-		ret = of_property_count_strings(pdev->dev.of_node, "dma-names");
-		if (ret == 2) {
-			up.dma = &priv->omap8250_dma;
-			priv->omap8250_dma.fn = the_no_dma_filter_fn;
-			priv->omap8250_dma.tx_dma = omap_8250_tx_dma;
-			priv->omap8250_dma.rx_dma = omap_8250_rx_dma;
-			priv->omap8250_dma.rx_size = RX_TRIGGER;
-			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
-			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
-		}
+	/*
+	 * Oh DMA support. If there are no DMA properties in the DT then
+	 * we will fall back to a generic DMA channel which does not
+	 * really work here. To ensure that we do not get a generic DMA
+	 * channel assigned, we have the the_no_dma_filter_fn() here.
+	 * To avoid "failed to request DMA" messages we check for DMA
+	 * properties in DT.
+	 */
+	ret = of_property_count_strings(np, "dma-names");
+	if (ret == 2) {
+		up.dma = &priv->omap8250_dma;
+		priv->omap8250_dma.fn = the_no_dma_filter_fn;
+		priv->omap8250_dma.tx_dma = omap_8250_tx_dma;
+		priv->omap8250_dma.rx_dma = omap_8250_rx_dma;
+		priv->omap8250_dma.rx_size = RX_TRIGGER;
+		priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
+		priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
 	}
 #endif
 	ret = serial8250_register_8250_port(&up);
-- 
2.20.1

