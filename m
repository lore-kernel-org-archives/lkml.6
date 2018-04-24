Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeDXQQq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:16:46 -0400
Received: from smtpgwcipde.automotive.elektrobit.com ([213.95.163.141]:56266
        "EHLO smtpgwcipde.elektrobit.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750757AbeDXQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:16:43 -0400
Date: Tue, 24 Apr 2018 18:16:05 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>, <ldv-project@linuxtesting.org>,
        <sil2review@lists.osadl.org>
Subject: [PATCH v2] spi/bcm63xx-hspi: Enable the clock before calling
 clk_get_rate().
Message-ID: <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [10.0.24.181]
X-ClientProxiedBy: denue6es007.ebgroup.elektrobit.com (10.5.139.21) To
 denue6es008.ebgroup.elektrobit.com (10.5.139.25)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the clock prior to calling clk_get_rate(), because clk_get_rate()
should only be called if the clock is enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 142168eba9dc (spi: "bcm63xx-hsspi: add bcm63xx HSSPI driver")
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
