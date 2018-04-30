Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeD3Otb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:49:31 -0400
Received: from agrajag.zerfleddert.de ([88.198.237.222]:40322 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbeD3Ota (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:49:30 -0400
Date: Mon, 30 Apr 2018 16:49:29 +0200
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: axxia: enable clock before calling clk_get_rate()
Message-ID: <20180430144929.ld6wjyyrorrj5kcr@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

axxia_i2c_init() uses clk_get_rate() for idev->i2c_clk. clk_get_rate()
should only be called if the clock is enabled, so ensure that by moving
the clk_prepare_enable() call before the call to axxia_i2c_init().

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 08678b850cd0 ("i2c: axxia: Add I2C driver for AXM55xx")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
v2:
first version of the patch ignored that the clock should be disabled in
case we bail out later...
compile-tested and coccichecked.

 drivers/i2c/busses/i2c-axxia.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 13f07482ec68..12f92369888b 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -532,23 +532,23 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 	if (idev->bus_clk_rate == 0)
 		idev->bus_clk_rate = 100000;	/* default clock rate */
 
+	ret = clk_prepare_enable(idev->i2c_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock\n");
+		return ret;
+	}
+
 	ret = axxia_i2c_init(idev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize\n");
-		return ret;
+		goto error_disable_clk;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, axxia_i2c_isr, 0,
 			       pdev->name, idev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to claim IRQ%d\n", irq);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(idev->i2c_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		return ret;
+		goto error_disable_clk;
 	}
 
 	i2c_set_adapdata(&idev->adapter, idev);
@@ -563,12 +563,14 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, idev);
 
 	ret = i2c_add_adapter(&idev->adapter);
-	if (ret) {
-		clk_disable_unprepare(idev->i2c_clk);
-		return ret;
-	}
+	if (ret)
+		goto error_disable_clk;
 
 	return 0;
+
+error_disable_clk:
+	clk_disable_unprepare(idev->i2c_clk);
+	return ret;
 }
 
 static int axxia_i2c_remove(struct platform_device *pdev)
-- 
2.11.0
