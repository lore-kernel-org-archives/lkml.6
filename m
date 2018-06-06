Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJoTAybY"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03A0C606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeFFKAY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:00:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39105 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeFFKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:22 -0400
X-Google-Smtp-Source: ADUXVKIx6bADFIgb2BmrB9UJ/sFg/t2EymJ+947aq7mHNFBCEhYnh9Iu50lUsTfevzLX6MdoHL1XHA==
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
Subject: [PATCH v5 01/14] mfd: da9063: Replace regmap_add_irq_chip with devm counterpart
Date: Wed,  6 Jun 2018 11:59:50 +0200
Message-Id: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_regmap_add_irq_chip() instead of plain regmap_add_irq_chip(),
which removes the need for da9063_irq_exit() altogether and also
fixes a bug in da9063_device_init() where the da9063_irq_exit() was
not called in a failpath.

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
 drivers/mfd/da9063-core.c       | 1 -
 drivers/mfd/da9063-irq.c        | 8 ++------
 include/linux/mfd/da9063/core.h | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 6c2870d4e754..2647bb371d86 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -238,7 +238,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 void da9063_device_exit(struct da9063 *da9063)
 {
 	mfd_remove_devices(da9063->dev);
-	da9063_irq_exit(da9063);
 }
 
 MODULE_DESCRIPTION("PMIC driver for Dialog DA9063");
diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index 207bbfe55449..da6ceb41f0d1 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -170,7 +170,8 @@ int da9063_irq_init(struct da9063 *da9063)
 		return -EINVAL;
 	}
 
-	ret = regmap_add_irq_chip(da9063->regmap, da9063->chip_irq,
+	ret = devm_regmap_add_irq_chip(da9063->dev, da9063->regmap,
+			da9063->chip_irq,
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
 			da9063->irq_base, &da9063_irq_chip,
 			&da9063->regmap_irq);
@@ -182,8 +183,3 @@ int da9063_irq_init(struct da9063 *da9063)
 
 	return 0;
 }
-
-void da9063_irq_exit(struct da9063 *da9063)
-{
-	regmap_del_irq_chip(da9063->chip_irq, da9063->regmap_irq);
-}
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index f3ae65db4c86..9ab7049977aa 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -95,6 +95,5 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq);
 int da9063_irq_init(struct da9063 *da9063);
 
 void da9063_device_exit(struct da9063 *da9063);
-void da9063_irq_exit(struct da9063 *da9063);
 
 #endif /* __MFD_DA9063_CORE_H__ */
-- 
2.16.2
