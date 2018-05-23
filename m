Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeEWLnL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:43:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37894 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932662AbeEWLm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:42:57 -0400
X-Google-Smtp-Source: AB8JxZrNovUUBdops1xIBOqmJzQRsC1plFiktWGd6Tic+894cDxvIbOPOnXhb4Qap/Gq/5nQmKQipA==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/6] mfd: da9063: Disallow RTC on DA9063L
Date: Wed, 23 May 2018 13:42:28 +0200
Message-Id: <20180523114230.10109-4-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9063L does not contain RTC block, unlike the full DA9063.
Do not allow binding RTC driver on this variant of the chip.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/mfd/da9063-core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 7360b76b4f72..263c83006413 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -101,14 +101,14 @@ static const struct mfd_cell da9063_devs[] = {
 		.of_compatible = "dlg,da9063-onkey",
 	},
 	{
+		.name		= DA9063_DRVNAME_VIBRATION,
+	},
+	{	/* Only present on DA9063 , not on DA9063L */
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
@@ -163,7 +163,7 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 {
 	struct da9063_pdata *pdata = da9063->dev->platform_data;
 	int model, variant_id, variant_code;
-	int ret;
+	int da9063_devs_len, ret;
 
 	ret = da9063_clear_fault_log(da9063);
 	if (ret < 0)
@@ -225,9 +225,13 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
-	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
-			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
-			      NULL);
+	da9063_devs_len = ARRAY_SIZE(da9063_devs);
+	/* RTC, the last device in the list, is only present on DA9063 */
+	if (da9063->type == PMIC_TYPE_DA9063L)
+		da9063_devs_len -= 1;
+
+	ret = mfd_add_devices(da9063->dev, -1, da9063_devs, da9063_devs_len,
+			      NULL, da9063->irq_base, NULL);
 	if (ret)
 		dev_err(da9063->dev, "Cannot add MFD cells\n");
 
-- 
2.16.2
