Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B47C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB89206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB89206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbeJBUVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:21:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbeJBUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:39 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5AC17B4A;
        Tue,  2 Oct 2018 13:37:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 58/94] spi: tegra20-slink: explicitly enable/disable clock
Date:   Tue,  2 Oct 2018 06:25:12 -0700
Message-Id: <20181002132504.515190160@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

commit 7001cab1dabc0b72b2b672ef58a90ab64f5e2343 upstream.

Depending on the SPI instance one may get an interrupt storm upon
requesting resp. interrupt unless the clock is explicitly enabled
beforehand. This has been observed trying to bring up instance 4 on
T20.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-tegra20-slink.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1063,6 +1063,24 @@ static int tegra_slink_probe(struct plat
 		goto exit_free_master;
 	}
 
+	/* disabled clock may cause interrupt storm upon request */
+	tspi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tspi->clk)) {
+		ret = PTR_ERR(tspi->clk);
+		dev_err(&pdev->dev, "Can not get clock %d\n", ret);
+		goto exit_free_master;
+	}
+	ret = clk_prepare(tspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Clock prepare failed %d\n", ret);
+		goto exit_free_master;
+	}
+	ret = clk_enable(tspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Clock enable failed %d\n", ret);
+		goto exit_free_master;
+	}
+
 	spi_irq = platform_get_irq(pdev, 0);
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
@@ -1071,14 +1089,7 @@ static int tegra_slink_probe(struct plat
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
 					tspi->irq);
-		goto exit_free_master;
-	}
-
-	tspi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(tspi->clk)) {
-		dev_err(&pdev->dev, "can not get clock\n");
-		ret = PTR_ERR(tspi->clk);
-		goto exit_free_irq;
+		goto exit_clk_disable;
 	}
 
 	tspi->rst = devm_reset_control_get(&pdev->dev, "spi");
@@ -1138,6 +1149,8 @@ exit_rx_dma_free:
 	tegra_slink_deinit_dma_param(tspi, true);
 exit_free_irq:
 	free_irq(spi_irq, tspi);
+exit_clk_disable:
+	clk_disable(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1150,6 +1163,8 @@ static int tegra_slink_remove(struct pla
 
 	free_irq(tspi->irq, tspi);
 
+	clk_disable(tspi->clk);
+
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
 


