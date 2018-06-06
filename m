Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDD2qFSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A54A5601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeFFKAi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:00:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54024 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFFKAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:34 -0400
X-Google-Smtp-Source: ADUXVKLBz1mjQASAU/cUPB8M5sLvSgUpn/xqJTKPrjUlp/ZucisN8MsRDRWFqIgQkrSeGwvs3QyVPQ==
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
Subject: [PATCH v5 11/14] mfd: da9063: Add custom IRQ map for DA9063L
Date: Wed,  6 Jun 2018 12:00:00 +0200
Message-Id: <20180606100003.17067-11-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9063L does not have an RTC. Add custom IRQ map for DA9063L to
ignore the Alarm and Tick IRQs from the PMIC.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V3: New patch
V4: - Formatting fixes
    - Drop extra newline in da9063l_irq_chip
    - Drop mention of the buggy datasheet in commit message
V5: Rebase on top of new 01 and 02 patches
---
 drivers/mfd/da9063-irq.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index 579947f83486..ecc0c8ce6c58 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -102,8 +102,81 @@ static const struct regmap_irq_chip da9063_irq_chip = {
 	.init_ack_masked = true,
 };
 
+static const struct regmap_irq da9063l_irqs[] = {
+	/* DA9063 event A register */
+	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
+	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
+	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
+	/* DA9063 event B register */
+	REGMAP_IRQ_REG(DA9063_IRQ_WAKE,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_WAKE),
+	REGMAP_IRQ_REG(DA9063_IRQ_TEMP,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_TEMP),
+	REGMAP_IRQ_REG(DA9063_IRQ_COMP_1V2,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_COMP_1V2),
+	REGMAP_IRQ_REG(DA9063_IRQ_LDO_LIM,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_LDO_LIM),
+	REGMAP_IRQ_REG(DA9063_IRQ_REG_UVOV,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_UVOV),
+	REGMAP_IRQ_REG(DA9063_IRQ_DVC_RDY,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_DVC_RDY),
+	REGMAP_IRQ_REG(DA9063_IRQ_VDD_MON,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_MON),
+	REGMAP_IRQ_REG(DA9063_IRQ_WARN,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_WARN),
+	/* DA9063 event C register */
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI0,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI0),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI1,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI1),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI2,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI2),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI3,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI3),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI4,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI4),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI5,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI5),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI6,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI6),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI7,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI7),
+	/* DA9063 event D register */
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI8,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI8),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI9,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI9),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI10,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI10),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI11,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI11),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI12,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI12),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI13,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI13),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI14,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI14),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI15,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI15),
+};
+
+static const struct regmap_irq_chip da9063l_irq_chip = {
+	.name = "da9063l-irq",
+	.irqs = da9063l_irqs,
+	.num_irqs = ARRAY_SIZE(da9063l_irqs),
+	.num_regs = 4,
+	.status_base = DA9063_REG_EVENT_A,
+	.mask_base = DA9063_REG_IRQ_MASK_A,
+	.ack_base = DA9063_REG_EVENT_A,
+	.init_ack_masked = true,
+};
+
 int da9063_irq_init(struct da9063 *da9063)
 {
+	const struct regmap_irq_chip *irq_chip;
 	int ret;
 
 	if (!da9063->chip_irq) {
@@ -111,11 +184,15 @@ int da9063_irq_init(struct da9063 *da9063)
 		return -EINVAL;
 	}
 
+	if (da9063->type == PMIC_TYPE_DA9063)
+		irq_chip = &da9063_irq_chip;
+	else
+		irq_chip = &da9063l_irq_chip;
+
 	ret = devm_regmap_add_irq_chip(da9063->dev, da9063->regmap,
 			da9063->chip_irq,
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
-			da9063->irq_base, &da9063_irq_chip,
-			&da9063->regmap_irq);
+			da9063->irq_base, irq_chip, &da9063->regmap_irq);
 	if (ret) {
 		dev_err(da9063->dev, "Failed to reguest IRQ %d: %d\n",
 				da9063->chip_irq, ret);
-- 
2.16.2
