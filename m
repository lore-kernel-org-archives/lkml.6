Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeFEXLo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:11:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37208 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeFEXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:10:45 -0400
X-Google-Smtp-Source: ADUXVKI/Vwi+pUW8mjRlRI3MRFtqk2ho0f9sRZxDJgoDAAMEpm/ZpTB41up1jQlK/yG4+YLffs78CQ==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 10/12] mfd: da9063: Register RTC only on DA9063L
Date: Wed,  6 Jun 2018 01:10:11 +0200
Message-Id: <20180605231013.1803-10-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
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
---
V2: No change
V3: Rework of mfd: da9063: Disallow RTC on DA9063L
V4: - Change the original failure text
    - Use PLATFORM_DEVID_NONE in mfd_add_devices
---
 drivers/mfd/da9063-core.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 9aff815877c0..3443c9321c09 100644
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
@@ -225,16 +229,29 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
-	ret = mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE, da9063_devs,
-			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
-			      NULL);
+	ret = mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE,
+			      da9063_common_devs,
+			      ARRAY_SIZE(da9063_common_devs),
+			      NULL, da9063->irq_base, NULL);
 	if (ret) {
-		dev_err(da9063->dev, "Cannot add MFD cells\n");
+		dev_err(da9063->dev, "Failed to add child devices\n");
 		goto err_irq_exit;
 	}
 
+	if (da9063->type == PMIC_TYPE_DA9063) {
+		ret = mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE,
+				      da9063_devs, ARRAY_SIZE(da9063_devs),
+				      NULL, da9063->irq_base, NULL);
+		if (ret) {
+			dev_err(da9063->dev, "Failed to add child devices\n");
+			goto err_mfd_cleanup;
+		}
+	}
+
 	return ret;
 
+err_mfd_cleanup:
+	mfd_remove_devices(da9063->dev);
 err_irq_exit:
 	da9063_irq_exit(da9063);
 	return ret;
-- 
2.16.2
