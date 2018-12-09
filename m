Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA49EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB9720661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB9720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeLIV4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:56:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36472 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726824AbeLIVzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:45 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002pp-Dw; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003TE-EK; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        "Mark Brown" <broonie@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.892693359@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 186/328] spi: tegra20-slink: explicitly
 enable/disable clock
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

commit 7001cab1dabc0b72b2b672ef58a90ab64f5e2343 upstream.

Depending on the SPI instance one may get an interrupt storm upon
requesting resp. interrupt unless the clock is explicitly enabled
beforehand. This has been observed trying to bring up instance 4 on
T20.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/spi/spi-tegra20-slink.c | 31 +++++++++++++++++++++++--------
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
 

