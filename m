Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbeCPQsR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:48:17 -0400
Received: from mail.phycore.de ([217.6.246.34]:46824 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbeCPQsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:48:12 -0400
From: Daniel Schultz <d.schultz@phytec.de>
To: lee.jones@linaro.org
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, w.egorov@phytec.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mfd: rk808: Refactor shutdown functions
Date: Fri, 16 Mar 2018 17:48:10 +0100
Message-Id: <1521218891-26616-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.03.2018 17:48:11,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.03.2018 17:48:11,
        Serialize complete at 16.03.2018 17:48:11
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all three shutdown functions have almost the same code, all logic
from the shutdown functions can be refactored to a new function
"rk808_update_bits", which can update a register by a given address and
bitmask.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes:
	v2: Re-submit with recipients from Rockchip.
	v3: - Added devicetree property to enable the PMIC reset seperate from 
	      "rockchip,system-power-controller".
	    - Dropped the first patch of this serie.
	v4: Splitted refactoring and the new reset feature.

 drivers/mfd/rk808.c | 47 ++++++++++++++---------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 216fbf6..ae014ee 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -369,58 +369,39 @@ static const struct regmap_irq_chip rk818_irq_chip = {
 
 static struct i2c_client *rk808_i2c_client;
 
-static void rk805_device_shutdown(void)
+static void rk808_update_bits(unsigned int reg, unsigned int bit_mask)
 {
 	int ret;
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
 	if (!rk808) {
 		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk805, so do nothing here\n");
+			 "have no %s, so do nothing here\n",
+			 rk808->regmap_irq_chip->name);
 		return;
 	}
 
 	ret = regmap_update_bits(rk808->regmap,
-				 RK805_DEV_CTRL_REG,
-				 DEV_OFF, DEV_OFF);
+				 reg,
+				 bit_mask, bit_mask);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+		dev_err(&rk808_i2c_client->dev,
+			"can't write to register 0x%x: %x!\n", reg, ret);
 }
 
-static void rk808_device_shutdown(void)
+static void rk805_device_shutdown(void)
 {
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808) {
-		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk808, so do nothing here\n");
-		return;
-	}
+	rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF);
+}
 
-	ret = regmap_update_bits(rk808->regmap,
-				 RK808_DEVCTRL_REG,
-				 DEV_OFF_RST, DEV_OFF_RST);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+static void rk808_device_shutdown(void)
+{
+	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST);
 }
 
 static void rk818_device_shutdown(void)
 {
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808) {
-		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk818, so do nothing here\n");
-		return;
-	}
-
-	ret = regmap_update_bits(rk808->regmap,
-				 RK818_DEVCTRL_REG,
-				 DEV_OFF, DEV_OFF);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+	rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF);
 }
 
 static const struct of_device_id rk808_of_match[] = {
-- 
2.7.4
