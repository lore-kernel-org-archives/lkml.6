Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964891AbeCENRE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:17:04 -0500
Received: from mail.rapiddevelopmentkit.de ([217.6.246.34]:37964 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932449AbeCENQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:16:48 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc: w.egorov@phytec.de
Subject: [PATCH 2/2] mfd: rk808: Add restart functionality
Date: Mon, 5 Mar 2018 14:16:41 +0100
Message-Id: <1520255801-8557-2-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520255801-8557-1-git-send-email-d.schultz@phytec.de>
References: <1520255801-8557-1-git-send-email-d.schultz@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 05.03.2018 14:16:46,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 05.03.2018 14:16:47,
        Serialize complete at 05.03.2018 14:16:47
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using Rockchip SoCs with rk805/808/818 PMICs, restarts are realized by
setting the reset registers in the "Clock and Reset Unit".

Since all three shutdown functions have almost the same code, all logic
from the shutdown functions can be refactored to a new function
"rk808_update_bits", which can update a register by a given address and
bitmask.

After that, notifier blocks and the restart functions were added to the
driver. Like the shutdown function, the restart is bound to the
"rockchip,system-power-controller" device tree property and can easily
revoked to the software restart by removing the property.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 drivers/mfd/rk808.c       | 97 ++++++++++++++++++++++++++++++-----------------
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index d138721..2c68f8c 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 
 struct rk808_reg_data {
 	int addr;
@@ -369,59 +370,73 @@ static const struct regmap_irq_chip rk818_irq_chip = {
 
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
+		dev_err(&rk808_i2c_client->dev, "can't write to DEVCTRL: %x!\n",
+			ret);
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
+static int rk805_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF_RST);
+	return NOTIFY_DONE;
+}
 
-	ret = regmap_update_bits(rk808->regmap,
-				 RK808_DEVCTRL_REG,
-				 DEV_OFF_RST, DEV_OFF_RST);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+static void rk808_device_shutdown(void)
+{
+	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST);
+}
+static int rk808_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF);
+	return NOTIFY_DONE;
 }
 
 static void rk818_device_shutdown(void)
 {
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF_RST);
+}
+static int rk818_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF);
+	return NOTIFY_DONE;
+}
 
-	if (!rk808) {
-		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk818, so do nothing here\n");
-		return;
-	}
+static struct notifier_block rk805_restart_handler = {
+	.notifier_call = rk805_restart_notify,
+	.priority = 196,
+};
 
-	ret = regmap_update_bits(rk808->regmap,
-				 RK818_DEVCTRL_REG,
-				 DEV_OFF_RST, DEV_OFF_RST);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
-}
+static struct notifier_block rk808_restart_handler = {
+	.notifier_call = rk808_restart_notify,
+	.priority = 196,
+};
+
+static struct notifier_block rk818_restart_handler = {
+	.notifier_call = rk818_restart_notify,
+	.priority = 196,
+};
 
 static const struct of_device_id rk808_of_match[] = {
 	{ .compatible = "rockchip,rk805" },
@@ -476,6 +491,7 @@ static int rk808_probe(struct i2c_client *client,
 		cells = rk805s;
 		nr_cells = ARRAY_SIZE(rk805s);
 		pm_pwroff_fn = rk805_device_shutdown;
+		rk808->nb = &rk805_restart_handler;
 		break;
 	case RK808_ID:
 		rk808->regmap_cfg = &rk808_regmap_config;
@@ -485,6 +501,7 @@ static int rk808_probe(struct i2c_client *client,
 		cells = rk808s;
 		nr_cells = ARRAY_SIZE(rk808s);
 		pm_pwroff_fn = rk808_device_shutdown;
+		rk808->nb = &rk808_restart_handler;
 		break;
 	case RK818_ID:
 		rk808->regmap_cfg = &rk818_regmap_config;
@@ -494,6 +511,7 @@ static int rk808_probe(struct i2c_client *client,
 		cells = rk818s;
 		nr_cells = ARRAY_SIZE(rk818s);
 		pm_pwroff_fn = rk818_device_shutdown;
+		rk808->nb = &rk818_restart_handler;
 		break;
 	default:
 		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
@@ -546,11 +564,18 @@ static int rk808_probe(struct i2c_client *client,
 
 	pm_off = of_property_read_bool(np,
 				"rockchip,system-power-controller");
-	if (pm_off && !pm_power_off) {
+	if (pm_off) {
 		rk808_i2c_client = client;
-		pm_power_off = pm_pwroff_fn;
+		if (!pm_power_off)
+			pm_power_off = pm_pwroff_fn;
+		if (rk808->nb) {
+			ret = register_restart_handler(rk808->nb);
+			if (ret)
+				dev_err(&client->dev,
+					"cannot register restart handler, %d\n",
+					ret);
+		}
 	}
-
 	return 0;
 
 err_irq:
@@ -564,6 +589,8 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 	pm_power_off = NULL;
+	if (rk808->nb)
+		unregister_restart_handler(rk808->nb);
 
 	return 0;
 }
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 338e0f6..9c26ca2 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -453,5 +453,6 @@ struct rk808 {
 	long				variant;
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
+	struct notifier_block		*nb;
 };
 #endif /* __LINUX_REGULATOR_RK808_H */
-- 
2.7.4
