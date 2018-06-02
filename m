Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeFBKNI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:13:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37224 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFBKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:12:17 -0400
X-Google-Smtp-Source: ADUXVKKxL6GPNTPwn/3p9nfgkpmXPd/Pzz68a0W6QFCO1MXjErGPb9Fw9q3HKPJRkwhb33x1N54AgQ==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 02/10] mfd: da9063: Use REGMAP_IRQ_REG
Date: Sat,  2 Jun 2018 12:11:47 +0200
Message-Id: <20180602101155.26375-2-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regmap_irq table to use REGMAP_IRQ_REG().

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V3: New patch
Note: A sed oneliner was used:
      sed -i "/\[DA9063_IRQ_/ {N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.* = \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c
---
 drivers/mfd/da9063-irq.c | 145 ++++++++++-------------------------------------
 1 file changed, 29 insertions(+), 116 deletions(-)

diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index 207bbfe55449..5b406ecfc14a 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -28,125 +28,38 @@
 
 static const struct regmap_irq da9063_irqs[] = {
 	/* DA9063 event A register */
-	[DA9063_IRQ_ONKEY] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_ONKEY,
-	},
-	[DA9063_IRQ_ALARM] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_ALARM,
-	},
-	[DA9063_IRQ_TICK] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_TICK,
-	},
-	[DA9063_IRQ_ADC_RDY] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_ADC_RDY,
-	},
-	[DA9063_IRQ_SEQ_RDY] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_SEQ_RDY,
-	},
+	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
+	REGMAP_IRQ_REG(DA9063_IRQ_ALARM, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ALARM),
+	REGMAP_IRQ_REG(DA9063_IRQ_TICK, DA9063_REG_EVENT_A_OFFSET, DA9063_M_TICK),
+	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
+	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
 	/* DA9063 event B register */
-	[DA9063_IRQ_WAKE] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_WAKE,
-	},
-	[DA9063_IRQ_TEMP] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_TEMP,
-	},
-	[DA9063_IRQ_COMP_1V2] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_COMP_1V2,
-	},
-	[DA9063_IRQ_LDO_LIM] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_LDO_LIM,
-	},
-	[DA9063_IRQ_REG_UVOV] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_UVOV,
-	},
-	[DA9063_IRQ_DVC_RDY] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_DVC_RDY,
-	},
-	[DA9063_IRQ_VDD_MON] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_VDD_MON,
-	},
-	[DA9063_IRQ_WARN] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_VDD_WARN,
-	},
+	REGMAP_IRQ_REG(DA9063_IRQ_WAKE, DA9063_REG_EVENT_B_OFFSET, DA9063_M_WAKE),
+	REGMAP_IRQ_REG(DA9063_IRQ_TEMP, DA9063_REG_EVENT_B_OFFSET, DA9063_M_TEMP),
+	REGMAP_IRQ_REG(DA9063_IRQ_COMP_1V2, DA9063_REG_EVENT_B_OFFSET, DA9063_M_COMP_1V2),
+	REGMAP_IRQ_REG(DA9063_IRQ_LDO_LIM, DA9063_REG_EVENT_B_OFFSET, DA9063_M_LDO_LIM),
+	REGMAP_IRQ_REG(DA9063_IRQ_REG_UVOV, DA9063_REG_EVENT_B_OFFSET, DA9063_M_UVOV),
+	REGMAP_IRQ_REG(DA9063_IRQ_DVC_RDY, DA9063_REG_EVENT_B_OFFSET, DA9063_M_DVC_RDY),
+	REGMAP_IRQ_REG(DA9063_IRQ_VDD_MON, DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_MON),
+	REGMAP_IRQ_REG(DA9063_IRQ_WARN, DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_WARN),
 	/* DA9063 event C register */
-	[DA9063_IRQ_GPI0] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI0,
-	},
-	[DA9063_IRQ_GPI1] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI1,
-	},
-	[DA9063_IRQ_GPI2] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI2,
-	},
-	[DA9063_IRQ_GPI3] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI3,
-	},
-	[DA9063_IRQ_GPI4] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI4,
-	},
-	[DA9063_IRQ_GPI5] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI5,
-	},
-	[DA9063_IRQ_GPI6] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI6,
-	},
-	[DA9063_IRQ_GPI7] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI7,
-	},
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI0, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI0),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI1, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI1),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI2, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI2),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI3, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI3),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI4, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI4),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI5, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI5),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI6, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI6),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI7, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI7),
 	/* DA9063 event D register */
-	[DA9063_IRQ_GPI8] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI8,
-	},
-	[DA9063_IRQ_GPI9] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI9,
-	},
-	[DA9063_IRQ_GPI10] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI10,
-	},
-	[DA9063_IRQ_GPI11] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI11,
-	},
-	[DA9063_IRQ_GPI12] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI12,
-	},
-	[DA9063_IRQ_GPI13] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI13,
-	},
-	[DA9063_IRQ_GPI14] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI14,
-	},
-	[DA9063_IRQ_GPI15] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI15,
-	},
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI8, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI8),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI9, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI9),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI10, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI10),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI11, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI11),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI12, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI12),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI13, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI13),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI14, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI14),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI15, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI15),
 };
 
 static const struct regmap_irq_chip da9063_irq_chip = {
-- 
2.16.2
