Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeDSNM5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:12:57 -0400
Received: from agrajag.zerfleddert.de ([88.198.237.222]:55596 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeDSNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:12:55 -0400
Date: Thu, 19 Apr 2018 15:03:58 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ldv-project@linuxtesting.org, sil2review@lists.osadl.org
Subject: [PATCH] Enable the clock before calling clk_get_rate().
Message-ID: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 142168eba9dc spi: bcm63xx-hsspi: add bcm63xx HSSPI driver
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index cbcba614b253..46cd9b683d22 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -352,6 +352,10 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
 	rate = clk_get_rate(clk);
 	if (!rate) {
 		struct clk *pll_clk = devm_clk_get(dev, "pll");
@@ -364,10 +368,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
 	if (!master) {
 		ret = -ENOMEM;
-- 
2.17.0
