Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeC3RZm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:25:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58964 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeC3RYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:24:39 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 07/10] mfd: ti-lmu: register one backlight device per channel
Date: Fri, 30 Mar 2018 19:24:11 +0200
Message-Id: <20180330172414.26575-8-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All LMU devices support multiple channels, that can be controlled
independently. This registers one backlight sub-device per channel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/ti-lmu.c       | 62 +++++++++++++++++++++++++++++++++++++---------
 include/linux/mfd/ti-lmu.h |  4 +++
 2 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index f43b8acc30e1..f4311d215dfa 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -56,8 +56,16 @@ static void ti_lmu_disable_hw(void *data)
 
 static const struct mfd_cell lm3532_devices[] = {
 	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3532,
+		.name          = "ti-lmu-led-backlight",
+		.id            = 0,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 1,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 2,
 	},
 };
 
@@ -75,8 +83,12 @@ static const struct mfd_cell lm3631_devices[] = {
 	LM363X_REGULATOR(LM3631_LDO_POS),
 	LM363X_REGULATOR(LM3631_LDO_NEG),
 	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3631,
+		.name          = "ti-lmu-led-backlight",
+		.id            = 0,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 1,
 	},
 };
 
@@ -85,15 +97,27 @@ static const struct mfd_cell lm3632_devices[] = {
 	LM363X_REGULATOR(LM3632_LDO_POS),
 	LM363X_REGULATOR(LM3632_LDO_NEG),
 	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3632,
+		.name          = "ti-lmu-led-backlight",
+		.id            = 0,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 1,
 	},
 };
 
 static const struct mfd_cell lm3633_devices[] = {
 	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3633,
+		.name          = "ti-lmu-led-backlight",
+		.id            = 0,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 1,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 2,
 	},
 	{
 		.name          = "lm3633-leds",
@@ -109,15 +133,27 @@ static const struct mfd_cell lm3633_devices[] = {
 
 static const struct mfd_cell lm3695_devices[] = {
 	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3695,
+		.name          = "ti-lmu-led-backlight",
+		.id            = 0,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 1,
 	},
 };
 
 static const struct mfd_cell lm3697_devices[] = {
 	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3697,
+		.name          = "ti-lmu-led-backlight",
+		.id            = 0,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 1,
+	},
+	{
+		.name          = "ti-lmu-led-backlight",
+		.id            = 2,
 	},
 	/* Monitoring driver for open/short circuit detection */
 	{
@@ -163,6 +199,7 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 		return -ENOMEM;
 
 	lmu->dev = &cl->dev;
+	lmu->id = id->driver_data;
 
 	/* Setup regmap */
 	memset(&regmap_cfg, 0, sizeof(struct regmap_config));
@@ -208,6 +245,7 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 	 * configuration. The notifier enables such kind of handling.
 	 */
 	BLOCKING_INIT_NOTIFIER_HEAD(&lmu->notifier);
+	lmu->backlight_initialized = false;
 
 	i2c_set_clientdata(cl, lmu);
 
diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
index 246ab5145dff..708c79adcabe 100644
--- a/include/linux/mfd/ti-lmu.h
+++ b/include/linux/mfd/ti-lmu.h
@@ -80,6 +80,8 @@ enum lm363x_regulator_id {
  * @en_gpio:	GPIO for HWEN pin [Optional]
  * @pwm:	PWM for module [Optional]
  * @notifier:	Notifier for reporting hwmon event
+ * @id:		Device ID
+ * @backlight_initialized: Global Backlight has been initialized
  */
 struct ti_lmu {
 	struct device *dev;
@@ -87,5 +89,7 @@ struct ti_lmu {
 	struct gpio_desc *en_gpio;
 	struct pwm_device *pwm;
 	struct blocking_notifier_head notifier;
+	enum ti_lmu_id id;
+	bool backlight_initialized;
 };
 #endif
-- 
2.16.2
