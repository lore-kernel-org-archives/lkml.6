Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeB0QGc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:06:32 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39129 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeB0QGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:06:31 -0500
X-Google-Smtp-Source: AH8x22688Ki/VpMIuGKlTaWPeX1U5y8p274ZtMvRBF9ATeS/Md756pM6Gp7ly4dM1WRp2jlKwpuK1g==
From: Tim Harvey <tharvey@gateworks.com>
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH] regmap: irq: fix ack-invert
Date: Tue, 27 Feb 2018 08:05:58 -0800
Message-Id: <1519747558-17257-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acking irqs we need to take into account the ack-invert case. Without
this chips that require 0's to ACK interrupts will never clear the interrupt.

I am working on an mfd driver that will use ack-invert and discovered
this issue. The only user of ack_invert currently appears to be the
motorola-cpcap driver. I'm not clear why that driver doesn't appear affected
so I'm cc'ing those involved with that driver for review and testing.

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/base/regmap/regmap-irq.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 429ca8e..abfed41 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -355,16 +355,25 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	 * doing a write per register.
 	 */
 	for (i = 0; i < data->chip->num_regs; i++) {
-		data->status_buf[i] &= ~data->mask_buf[i];
-
-		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
+		if ( (data->status_buf[i] & ~data->mask_buf[i]) &&
+		     (chip->ack_base || chip->use_ack) ) {
 			reg = chip->ack_base +
 				(i * map->reg_stride * data->irq_reg_stride);
-			ret = regmap_write(map, reg, data->status_buf[i]);
+			/* some chips ack by write 0 */
+			if (chip->ack_invert)
+				ret = regmap_write(map, reg,
+						   ~data->status_buf[i] &
+						   ~data->mask_buf[i]);
+
+			else
+				ret = regmap_write(map, reg,
+						   data->status_buf[i] &
+						   ~data->mask_buf[i]);
 			if (ret != 0)
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
 					reg, ret);
 		}
+		data->status_buf[i] &= ~data->mask_buf[i];
 	}
 
 	for (i = 0; i < chip->num_irqs; i++) {
-- 
2.7.4
