Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeDRMxa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:53:30 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35320 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbeDRMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:53:28 -0400
X-Google-Smtp-Source: AIpwx4+fpF19yOXW+shoBPxYl4bTLc7FVCZ2vulrKy6a/AHPUPnS3T0WDa+1noZe5Vlg4sUBNm28lA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/2] gpio: pcie-idio-24: Fix port memory offset for get_multiple/set_multiple callbacks
Date: Wed, 18 Apr 2018 08:53:21 -0400
Message-Id: <00c65eb82280318e6d50f0c54fab4efd708beafa.1524000042.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1524000042.git.vilhelm.gray@gmail.com>
References: <cover.1524000042.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioread8/iowrite8 functions expect a memory offset argument. This
patch fixes the ports array to provide the memory addresses of the
respective device I/O registers.

Fixes: ca37081595a2 ("gpio: pcie-idio-24: Implement get_multiple/set_multiple callbacks")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pcie-idio-24.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 835607ecf658..3e77c2a9a9fd 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -206,10 +206,10 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long word_mask;
 	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
 	unsigned long port_state;
-	u8 __iomem ports[] = {
-		idio24gpio->reg->out0_7, idio24gpio->reg->out8_15,
-		idio24gpio->reg->out16_23, idio24gpio->reg->in0_7,
-		idio24gpio->reg->in8_15, idio24gpio->reg->in16_23,
+	void __iomem *ports[] = {
+		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
+		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
+		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
 	};
 	const unsigned long out_mode_mask = BIT(1);
 
@@ -236,7 +236,7 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 
 		/* read bits from current gpio port (port 6 is TTL GPIO) */
 		if (i < 6)
-			port_state = ioread8(ports + i);
+			port_state = ioread8(ports[i]);
 		else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
 			port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
 		else
@@ -301,9 +301,9 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
 	unsigned long flags;
 	unsigned int out_state;
-	u8 __iomem ports[] = {
-		idio24gpio->reg->out0_7, idio24gpio->reg->out8_15,
-		idio24gpio->reg->out16_23
+	void __iomem *ports[] = {
+		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
+		&idio24gpio->reg->out16_23
 	};
 	const unsigned long out_mode_mask = BIT(1);
 	const unsigned int ttl_offset = 48;
@@ -327,9 +327,9 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
 
 		/* process output lines */
-		out_state = ioread8(ports + i) & ~gpio_mask;
+		out_state = ioread8(ports[i]) & ~gpio_mask;
 		out_state |= (*bits >> bits_offset) & gpio_mask;
-		iowrite8(out_state, ports + i);
+		iowrite8(out_state, ports[i]);
 
 		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
 	}
-- 
2.16.2
