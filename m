Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeEHC4F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:56:05 -0400
Received: from regular1.263xmail.com ([211.150.99.139]:48465 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeEHC4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:56:04 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 59.33.107.187
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <06e95ef40aa750cf23ee021b3f0dda6b>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 1/2] gpio: syscon: Add gpio-syscon for rk3328
Date: Tue,  8 May 2018 10:48:23 +0800
Message-Id: <1525747704-8537-2-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525747704-8537-1-git-send-email-djw@t-chip.com.cn>
References: <1525747704-8537-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

In Rockchip RK3328 Soc, there's a output only gpio pin labeled
`gpiomut_pmuio_iout`, which can be set by bit[1] of GRF_SOC_CON10.
(bit[0] controls the enable state of the pin and defaults to enabled.)

This pin is used by the roc-rk3328-cc board to switch sdmmc io signal
voltage between 1.8V and 3.3V, which is essential to the SD card UHS
support.

Signed-off-by: Levin Du <djw@t-chip.com.cn>
---

 drivers/gpio/gpio-syscon.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 537cec7..b69f65f 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -135,6 +135,34 @@ static const struct syscon_gpio_data clps711x_mctrl_gpio = {
 	.dat_bit_offset	= 0x40 * 8 + 8,
 };
 
+static void rockchip_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			      int val)
+{
+	struct syscon_gpio_priv *priv = gpiochip_get_data(chip);
+	unsigned int offs;
+	u8 bit;
+	u32 data;
+	int ret;
+
+	offs = priv->dreg_offset + priv->data->dat_bit_offset + offset;
+	bit = offs % SYSCON_REG_BITS;
+	data = (val ? BIT(bit) : 0) | BIT(bit + 16);
+	ret = regmap_write(priv->syscon,
+			   (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
+			   data);
+	if (ret < 0)
+		dev_err(chip->parent, "gpio write failed ret(%d)\n", ret);
+}
+
+static const struct syscon_gpio_data rk3328_gpio_syscon10 = {
+	/* Rockchip RK3328 GRF_SOC_CON10 Bits 0-1 */
+	.compatible	= "rockchip,rk3328-grf",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 2,
+	.dat_bit_offset	= 0x0428 * 8,
+	.set		= rockchip_gpio_set,
+};
+
 #define KEYSTONE_LOCK_BIT BIT(0)
 
 static void keystone_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
@@ -175,6 +203,10 @@ static const struct of_device_id syscon_gpio_ids[] = {
 		.compatible	= "ti,keystone-dsp-gpio",
 		.data		= &keystone_dsp_gpio,
 	},
+	{
+		.compatible	= "rockchip,rk3328-gpio-syscon10",
+		.data		= &rk3328_gpio_syscon10,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
-- 
2.7.4
