Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbeD3Nwr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:52:47 -0400
Received: from agrajag.zerfleddert.de ([88.198.237.222]:39184 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeD3Nwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:52:46 -0400
Date: Mon, 30 Apr 2018 15:52:44 +0200
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: axxia: enable clock before calling clk_get_rate()
Message-ID: <20180430135244.kud5hf5xjfxg4ufn@agrajag.zerfleddert.de>
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
 drivers/i2c/busses/i2c-axxia.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 13f07482ec68..51338c48d193 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -532,6 +532,12 @@ static int axxia_i2c_probe(struct platform_device *pdev)
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
@@ -545,12 +551,6 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(idev->i2c_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		return ret;
-	}
-
 	i2c_set_adapdata(&idev->adapter, idev);
 	strlcpy(idev->adapter.name, pdev->name, sizeof(idev->adapter.name));
 	idev->adapter.owner = THIS_MODULE;
-- 
2.11.0
