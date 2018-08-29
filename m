Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D947FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832242084A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832242084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeH2Knf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:43:35 -0400
Received: from mout.perfora.net ([74.208.4.194]:46681 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2Knf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:43:35 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LqSvP-1fQXKt30Zl-00e17f; Wed, 29 Aug 2018 08:48:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH] spi: tegra20-slink: explicitly enable/disable clock
Date:   Wed, 29 Aug 2018 08:47:57 +0200
Message-Id: <20180829064757.16349-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:cNhlCHERXxyGCqfAPozMapag1n5OMvTxWI0pa8MQr/hvYFVWHm3
 GUPgZlcOwcZArl9THwHJ4r+aqM5fcYzX9upAoUqcX+Ku7YzWNJiUFHfQ7pnqPyVcwfg1uUH
 IupEXCDYiLIMlCwXKJCaS/rmLR3WyiVyeJ0WiWgHfZ86I734ESJA2Do0ZqffKsKSX1xuclV
 D/wcjTOPOpFAhiFfWzrIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6cOrdTXOJ1E=:Czd2LDJBCfW0zSJb4kgr2G
 EHduUF5Y9TJGE58+bA5OlF+ANu5jDAPpRr2MlVFmDTXOusUPb4kVopiM+3QJj7measaww0hNX
 MwJDwIYNs+Apt9JK3K21NHXJIVx8aUqgGAdtdvIbTttei5/JmKg5RbxoLcSL6UPrWTN3VIlM5
 ZOIOQfEF7yEk7uNAYH4nOX9REPrAmfgxit3c6Z/EAPS0NRDwGEFHXLFB+ZG7mi70jwIcdkzAZ
 MRYckctimKZI8pHbMDtvbpfTOrVmyIZKxCdkn2kORnqaE3mUOQlJodU17Zdx1jSD/Id4rb0T4
 flhgPUeaI9Puzh5qQGOeoHirnXg0j37tRWI6+zWkeOHysfAV212aeF5hqpOvlKDOryZU3Tj8l
 W9iSmM8U3JrnbbE1SfweDjTCid1dkjwgtkUPvWi84QSfOwt6yEFrmwrjBnyZ4dUcdqVwLQaQ4
 Pi34moEnOndXUfBhYbI2Tohp3zqJLmBjFacoWF2EUn+1P6nFGWNNxpzwqVKS7q8Lz9JpXfs9J
 HPrEmL7sWjBQx6yAyriPXF5wD1nPWqcfHMuozB99GjFH6rZ+1cLEfvLB/+01yl7AChe742oyH
 bEabp210eeZqNnj/FlvUOaYItzOXAHQ+A56WFGA1X986AvAUamYaJpF1Cyiwn1EGmfBzcIytw
 YiAcEfvVypWqVbUJjVKjrtnNkM8kJF48pJKsaa3+XF5JLafaaCak+kJFzaM1ZuzZxYyY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Depending on the SPI instance one may get an interrupt storm upon
requesting resp. interrupt unless the clock is explicitly enabled
beforehand. This has been observed trying to bring up instance 4 on
T20.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/spi/spi-tegra20-slink.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 6f7b946b5ced..1427f343b39a 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1063,6 +1063,24 @@ static int tegra_slink_probe(struct platform_device *pdev)
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
@@ -1071,14 +1089,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
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
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
@@ -1138,6 +1149,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	tegra_slink_deinit_dma_param(tspi, true);
 exit_free_irq:
 	free_irq(spi_irq, tspi);
+exit_clk_disable:
+	clk_disable(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1150,6 +1163,8 @@ static int tegra_slink_remove(struct platform_device *pdev)
 
 	free_irq(tspi->irq, tspi);
 
+	clk_disable(tspi->clk);
+
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
 
-- 
2.14.4

