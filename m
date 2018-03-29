Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeC2OuO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:50:14 -0400
Received: from mail.x-arc.de ([217.6.246.34]:56454 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbeC2OuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:50:02 -0400
From: Daniel Schultz <d.schultz@phytec.de>
To: lee.jones@linaro.org
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, w.egorov@phytec.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] mfd: rk808: Add restart functionality
Date: Thu, 29 Mar 2018 16:50:00 +0200
Message-Id: <1522335000-23057-2-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522335000-23057-1-git-send-email-d.schultz@phytec.de>
References: <1522335000-23057-1-git-send-email-d.schultz@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2018 16:50:00,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2018 16:50:00,
        Serialize complete at 29.03.2018 16:50:00
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using Rockchip SoCs with rk805/808/818 PMICs, restarts are realized by
setting the reset registers in the "Clock and Reset Unit".

Now, the driver can trigger a restart in the PMIC. Like the
shutdown function, the restart is bound to an independent
"rockchip,system-reset-controller" devicetree property can easily
enabled by adding this.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes:
	v2: Re-submit with recipients from Rockchip.
	v3: - Added devicetree property to enable the PMIC reset seperate from 
	      "rockchip,system-power-controller".
	    - Dropped the first patch of this serie.
	v4: Splitted refactoring and the new reset feature.
	v5: -

 drivers/mfd/rk808.c       | 58 ++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 1cb1b3a..7f5c3d7 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 
 struct rk808_reg_data {
 	int addr;
@@ -392,16 +393,49 @@ static void rk805_device_shutdown(void)
 {
 	rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF);
 }
+static int rk805_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF_RST);
+	return NOTIFY_DONE;
+}
 
 static void rk808_device_shutdown(void)
 {
 	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST);
 }
+static int rk808_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF);
+	return NOTIFY_DONE;
+}
 
 static void rk818_device_shutdown(void)
 {
 	rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF);
 }
+static int rk818_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF_RST);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rk805_restart_handler = {
+	.notifier_call = rk805_restart_notify,
+	.priority = 196,
+};
+
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
@@ -421,7 +455,7 @@ static int rk808_probe(struct i2c_client *client,
 	void (*pm_pwroff_fn)(void);
 	int nr_pre_init_regs;
 	int nr_cells;
-	int pm_off = 0, msb, lsb;
+	int pm_off = 0, pm_rst_off = 0, msb, lsb;
 	int ret;
 	int i;
 
@@ -456,6 +490,7 @@ static int rk808_probe(struct i2c_client *client,
 		cells = rk805s;
 		nr_cells = ARRAY_SIZE(rk805s);
 		pm_pwroff_fn = rk805_device_shutdown;
+		rk808->nb = &rk805_restart_handler;
 		break;
 	case RK808_ID:
 		rk808->regmap_cfg = &rk808_regmap_config;
@@ -465,6 +500,7 @@ static int rk808_probe(struct i2c_client *client,
 		cells = rk808s;
 		nr_cells = ARRAY_SIZE(rk808s);
 		pm_pwroff_fn = rk808_device_shutdown;
+		rk808->nb = &rk808_restart_handler;
 		break;
 	case RK818_ID:
 		rk808->regmap_cfg = &rk818_regmap_config;
@@ -474,6 +510,7 @@ static int rk808_probe(struct i2c_client *client,
 		cells = rk818s;
 		nr_cells = ARRAY_SIZE(rk818s);
 		pm_pwroff_fn = rk818_device_shutdown;
+		rk808->nb = &rk818_restart_handler;
 		break;
 	default:
 		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
@@ -524,13 +561,20 @@ static int rk808_probe(struct i2c_client *client,
 		goto err_irq;
 	}
 
-	pm_off = of_property_read_bool(np,
-				"rockchip,system-power-controller");
-	if (pm_off && !pm_power_off) {
-		rk808_i2c_client = client;
+	rk808_i2c_client = client;
+
+	pm_off = of_property_read_bool(np, "rockchip,system-power-controller");
+	if (pm_off && !pm_power_off)
 		pm_power_off = pm_pwroff_fn;
-	}
 
+	pm_rst_off = of_property_read_bool(np,
+					"rockchip,system-reset-controller");
+	if (pm_rst_off && rk808->nb) {
+		ret = register_restart_handler(rk808->nb);
+		if (ret)
+			dev_err(&client->dev,
+				"cannot register restart handler, %d\n", ret);
+	}
 	return 0;
 
 err_irq:
@@ -544,6 +588,8 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 	pm_power_off = NULL;
+	if (rk808->nb)
+		unregister_restart_handler(rk808->nb);
 
 	return 0;
 }
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index d315659..6f8583b 100644
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
