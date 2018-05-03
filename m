Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeECXlB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:41:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37972 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECXk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:40:59 -0400
From: Mark Brown <broonie@kernel.org>
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: pxa2xx: check clk_prepare_enable() return value" to the spi tree
In-Reply-To: <20180430143006.ckcbicijw2to2ghl@agrajag.zerfleddert.de>
Message-Id: <20180503234049.727DD44007A@finisterre.ee.mobilebroadband>
Date: Fri,  4 May 2018 00:40:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pxa2xx: check clk_prepare_enable() return value

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 62bbc864d1946c715063bd481bff3641fd1324e2 Mon Sep 17 00:00:00 2001
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Date: Mon, 30 Apr 2018 16:30:06 +0200
Subject: [PATCH] spi: pxa2xx: check clk_prepare_enable() return value

clk_prepare_enable() can fail, so its return value should be checked and
acted upon.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 3343b7a6d2cd ("spi/pxa2xx: convert to the common clk framework")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 40f1346b8188..0b2d60d30f69 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1612,7 +1612,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Enable SOC clock */
-	clk_prepare_enable(ssp->clk);
+	status = clk_prepare_enable(ssp->clk);
+	if (status)
+		goto out_error_dma_irq_alloc;
 
 	master->max_speed_hz = clk_get_rate(ssp->clk);
 
@@ -1716,6 +1718,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(ssp->clk);
+
+out_error_dma_irq_alloc:
 	pxa2xx_spi_dma_release(drv_data);
 	free_irq(ssp->irq, drv_data);
 
@@ -1789,8 +1793,11 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev))
-		clk_prepare_enable(ssp->clk);
+	if (!pm_runtime_suspended(dev)) {
+		status = clk_prepare_enable(ssp->clk);
+		if (status)
+			return status;
+	}
 
 	/* Restore LPSS private register bits */
 	if (is_lpss_ssp(drv_data))
@@ -1819,9 +1826,10 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
+	int status;
 
-	clk_prepare_enable(drv_data->ssp->clk);
-	return 0;
+	status = clk_prepare_enable(drv_data->ssp->clk);
+	return status;
 }
 #endif
 
-- 
2.17.0
