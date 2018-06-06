Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGcxG8wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33565606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbeFFKDV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:03:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35524 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeFFKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:23 -0400
X-Google-Smtp-Source: ADUXVKKD25/iyXIZqa2/8fLEmSUuzDJP2S1o3hxsWE5Hii5SYx/KFAnKnAX4CDnUNTPfWTRyA6FvbA==
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
Subject: [PATCH v5 02/14] mfd: da9063: Replace mfd_add_devices with devm counterpart
Date: Wed,  6 Jun 2018 11:59:51 +0200
Message-Id: <20180606100003.17067-2-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_mfd_add_devices() instead of plain mfd_add_devices(), which
removes the need for da9063_device_exit() altogether and also for the
.remove callback in da9063-i2c.c .

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V5: New patch
---
 drivers/mfd/da9063-core.c       | 11 +++--------
 drivers/mfd/da9063-i2c.c        | 10 ----------
 include/linux/mfd/da9063/core.h |  2 --
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 2647bb371d86..76258e5709f8 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -226,20 +226,15 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
-	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
-			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
-			      NULL);
+	ret = devm_mfd_add_devices(da9063->dev, -1, da9063_devs,
+				   ARRAY_SIZE(da9063_devs), NULL,
+				   da9063->irq_base, NULL);
 	if (ret)
 		dev_err(da9063->dev, "Cannot add MFD cells\n");
 
 	return ret;
 }
 
-void da9063_device_exit(struct da9063 *da9063)
-{
-	mfd_remove_devices(da9063->dev);
-}
-
 MODULE_DESCRIPTION("PMIC driver for Dialog DA9063");
 MODULE_AUTHOR("Krystian Garbaciak");
 MODULE_AUTHOR("Michal Hajduk");
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 981805a2c521..29456e807ed4 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -270,15 +270,6 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	return da9063_device_init(da9063, i2c->irq);
 }
 
-static int da9063_i2c_remove(struct i2c_client *i2c)
-{
-	struct da9063 *da9063 = i2c_get_clientdata(i2c);
-
-	da9063_device_exit(da9063);
-
-	return 0;
-}
-
 static const struct i2c_device_id da9063_i2c_id[] = {
 	{"da9063", PMIC_DA9063},
 	{},
@@ -291,7 +282,6 @@ static struct i2c_driver da9063_i2c_driver = {
 		.of_match_table = of_match_ptr(da9063_dt_ids),
 	},
 	.probe    = da9063_i2c_probe,
-	.remove   = da9063_i2c_remove,
 	.id_table = da9063_i2c_id,
 };
 
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 9ab7049977aa..8e6684d884e0 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -94,6 +94,4 @@ struct da9063 {
 int da9063_device_init(struct da9063 *da9063, unsigned int irq);
 int da9063_irq_init(struct da9063 *da9063);
 
-void da9063_device_exit(struct da9063 *da9063);
-
 #endif /* __MFD_DA9063_CORE_H__ */
-- 
2.16.2
