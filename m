Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeCEU6J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:58:09 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44990 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeCEU6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:58:07 -0500
X-Google-Smtp-Source: AG47ELtklMoO2wzYLNUVVlybZqrPwDB9sIS8FgBHJx0flOkkS1tD3WtLS+fmxPtz0oXIk/xC0c+mpA==
From: Tim Harvey <tharvey@gateworks.com>
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Guo Zeng <Guo.Zeng@csr.com>
Subject: [PATCH v2] regmap: irq: fix ack-invert
Date: Mon,  5 Mar 2018 12:57:37 -0800
Message-Id: <1520283457-31637-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acking irqs we need to take into account the ack-invert case.
Without this chips that require 0's to ACK interrupts will never clear
the interrupt.

By using regmap_irq_update_bits to ACK the interrupts we use the masked
status bits so we take care not to affect any other bits then use
ack_invert to determine if we clear or set those bits.

The only user of ack_invert currently appears to be the motorola-cpcap
driver which we find is incorrectly setting ack_invert and thus we
fix that at the same time as otherwise it would break.

Cc: Guo Zeng <Guo.Zeng@csr.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - use regmap_irq_update_bits for readability as well as taking into account
   only affecting bits we are acking
 - add fix for affected motorola-cpcap driver
---
 drivers/base/regmap/regmap-irq.c | 5 ++++-
 drivers/mfd/motorola-cpcap.c     | 3 ---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 429ca8e..840cadee 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -360,7 +360,10 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
 			reg = chip->ack_base +
 				(i * map->reg_stride * data->irq_reg_stride);
-			ret = regmap_write(map, reg, data->status_buf[i]);
+			ret = regmap_irq_update_bits(d, reg,
+						     data->status_buf[i],
+						     chip->ack_invert ?
+						     0x00 : 0xFF);
 			if (ret != 0)
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
 					reg, ret);
diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index d2cc1ea..59082cf 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -99,7 +99,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI1,
 		.mask_base = CPCAP_REG_MIM1,
 		.use_ack = true,
-		.ack_invert = true,
 	},
 	{
 		.name = "cpcap-m2",
@@ -108,7 +107,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI2,
 		.mask_base = CPCAP_REG_MIM2,
 		.use_ack = true,
-		.ack_invert = true,
 	},
 	{
 		.name = "cpcap1-4",
@@ -117,7 +115,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_INT1,
 		.mask_base = CPCAP_REG_INTM1,
 		.use_ack = true,
-		.ack_invert = true,
 	},
 };
 
-- 
2.7.4
