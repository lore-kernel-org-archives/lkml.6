Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozE0zFyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CE0C601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeFFKBX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:01:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39481 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeFFKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:36 -0400
X-Google-Smtp-Source: ADUXVKJ4PYQ4DZt8sGnxqfD+Ke+UHtJMeDytsfnYcSnxI4TNO/ehonrfNkvnDeSFs39JiHrULbEUCg==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 12/14] mfd: da9063: Register RTC only on DA9063L
Date: Wed,  6 Jun 2018 12:00:01 +0200
Message-Id: <20180606100003.17067-12-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9063L does not contain RTC block, unlike the full DA9063.
Split the RTC block into separate mfd cell and register it only
on DA9063.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V2: No change
V3: Rework of mfd: da9063: Disallow RTC on DA9063L
V4: - Change the original failure text
    - Use PLATFORM_DEVID_NONE in mfd_add_devices
V5: Rebase on top of new 01 and 02 patches
---
 drivers/mfd/da9063-core.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index ded59990f18c..6e4ce49b4405 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -76,7 +76,7 @@ static struct resource da9063_hwmon_resources[] = {
 };
 
 
-static const struct mfd_cell da9063_devs[] = {
+static const struct mfd_cell da9063_common_devs[] = {
 	{
 		.name		= DA9063_DRVNAME_REGULATORS,
 		.num_resources	= ARRAY_SIZE(da9063_regulators_resources),
@@ -100,15 +100,19 @@ static const struct mfd_cell da9063_devs[] = {
 		.resources	= da9063_onkey_resources,
 		.of_compatible = "dlg,da9063-onkey",
 	},
+	{
+		.name		= DA9063_DRVNAME_VIBRATION,
+	},
+};
+
+/* Only present on DA9063 , not on DA9063L */
+static const struct mfd_cell da9063_devs[] = {
 	{
 		.name		= DA9063_DRVNAME_RTC,
 		.num_resources	= ARRAY_SIZE(da9063_rtc_resources),
 		.resources	= da9063_rtc_resources,
 		.of_compatible	= "dlg,da9063-rtc",
 	},
-	{
-		.name		= DA9063_DRVNAME_VIBRATION,
-	},
 };
 
 static int da9063_clear_fault_log(struct da9063 *da9063)
@@ -226,10 +230,23 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
 	ret = devm_mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE,
-				   da9063_devs, ARRAY_SIZE(da9063_devs),
+				   da9063_common_devs,
+				   ARRAY_SIZE(da9063_common_devs),
 				   NULL, da9063->irq_base, NULL);
-	if (ret)
-		dev_err(da9063->dev, "Cannot add MFD cells\n");
+	if (ret) {
+		dev_err(da9063->dev, "Failed to add child devices\n");
+		return ret;
+	}
+
+	if (da9063->type == PMIC_TYPE_DA9063) {
+		ret = devm_mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE,
+					   da9063_devs, ARRAY_SIZE(da9063_devs),
+					   NULL, da9063->irq_base, NULL);
+		if (ret) {
+			dev_err(da9063->dev, "Failed to add child devices\n");
+			return ret;
+		}
+	}
 
 	return ret;
 }
-- 
2.16.2
