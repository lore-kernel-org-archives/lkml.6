Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932785AbeEaD2x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:28:53 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:44714 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeEaD2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:28:43 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 183.57.25.242
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <4327491e3b8af5013f5ff4342d144c31>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/5] gpio: syscon: rockchip: add GPIO_MUTE support for rk3328
Date: Thu, 31 May 2018 11:27:50 +0800
Message-Id: <1527737273-8387-3-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
References: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
mute control, can also be used for general purpose. It is manipulated by
the GRF_SOC_CON10 register.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v3:
- Change from general gpio-syscon to specific rk3328-gpio-mute

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in doc

Changes in v1:
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt

 .../bindings/gpio/rockchip,rk3328-gpio-mute.txt    | 28 +++++++++++++++++++
 drivers/gpio/gpio-syscon.c                         | 31 ++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
new file mode 100644
index 0000000..10bc632
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
@@ -0,0 +1,28 @@
+Rockchip RK3328 GPIO controller dedicated for the GPIO_MUTE pin.
+
+In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec mute
+control, can also be used for general purpose. It is manipulated by the
+GRF_SOC_CON10 register.
+
+Required properties:
+- compatible: Should contain "rockchip,rk3328-gpio-mute".
+- gpio-controller: Marks the device node as a gpio controller.
+- #gpio-cells: Should be 2. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity:
+    0 = Active high,
+    1 = Active low.
+
+Example:
+
+	grf: syscon@ff100000 {
+		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
+
+		gpio_mute: gpio-mute {
+			compatible = "rockchip,rk3328-gpio-mute";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
+
+Note: The gpio_mute node should be declared as the child of the GRF (General
+Register File) node. The GPIO_MUTE pin is referred to as <&gpio_mute 0>.
diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 7325b86..49a142a 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -135,6 +135,33 @@ static const struct syscon_gpio_data clps711x_mctrl_gpio = {
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
+static const struct syscon_gpio_data rockchip_rk3328_gpio_mute = {
+	/* RK3328 GPIO_MUTE is an output only pin at GRF_SOC_CON10[1] */
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 1,
+	.dat_bit_offset = 0x0428 * 8 + 1,
+	.set		= rockchip_gpio_set,
+};
+
 #define KEYSTONE_LOCK_BIT BIT(0)
 
 static void keystone_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
@@ -175,6 +202,10 @@ static const struct of_device_id syscon_gpio_ids[] = {
 		.compatible	= "ti,keystone-dsp-gpio",
 		.data		= &keystone_dsp_gpio,
 	},
+	{
+		.compatible	= "rockchip,rk3328-gpio-mute",
+		.data		= &rockchip_rk3328_gpio_mute,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
-- 
2.7.4
