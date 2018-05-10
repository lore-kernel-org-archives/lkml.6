Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757129AbeEJJS2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:18:28 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:59674 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757031AbeEJJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:17:45 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 59.33.101.82
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <002042bda078b60a9a00cefdd1f50441>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/5] gpio: syscon: Add gpio-syscon for rockchip
Date: Thu, 10 May 2018 17:16:37 +0800
Message-Id: <1525943800-14095-3-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
which do not belong to the general pinctrl.

Adding gpio-syscon support makes controlling regulator or
LED using these special pins very easy by reusing existing
drivers, such as gpio-regulator and led-gpio.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v1:
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt

 .../bindings/gpio/rockchip,gpio-syscon.txt         | 41 ++++++++++++++++++++++
 drivers/gpio/gpio-syscon.c                         | 30 ++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
new file mode 100644
index 0000000..e4c1650
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
@@ -0,0 +1,41 @@
+* Rockchip GPIO support for GRF_SOC_CON registers
+
+Required properties:
+- compatible: Should contain "rockchip,gpio-syscon".
+- gpio-controller: Marks the device node as a gpio controller.
+- #gpio-cells: Should be two. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity:
+    0 = Active high,
+    1 = Active low.
+- gpio,syscon-dev: Should contain <grf_phandle syscon_offset 0>.
+  If declared as child of the grf node, the grf_phandle can be 0.
+
+Example:
+
+1. As child of grf node:
+
+	grf: syscon@ff100000 {
+		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
+
+		gpio_syscon10: gpio-syscon10 {
+			compatible = "rockchip,gpio-syscon";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <0 0x0428 0>;
+		};
+	};
+
+
+2. Not child of grf node:
+
+	grf: syscon@ff100000 {
+		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
+		//...
+	};
+
+	gpio_syscon10: gpio-syscon10 {
+		compatible = "rockchip,gpio-syscon";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio,syscon-dev = <&grf 0x0428 0>;
+	};
diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 7325b86..e24b408 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -135,6 +135,32 @@ static const struct syscon_gpio_data clps711x_mctrl_gpio = {
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
+static const struct syscon_gpio_data rockchip_gpio_syscon = {
+	/* Rockchip GRF_SOC_CON Bits 0-15 */
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 16,
+	.set		= rockchip_gpio_set,
+};
+
 #define KEYSTONE_LOCK_BIT BIT(0)
 
 static void keystone_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
@@ -175,6 +201,10 @@ static const struct of_device_id syscon_gpio_ids[] = {
 		.compatible	= "ti,keystone-dsp-gpio",
 		.data		= &keystone_dsp_gpio,
 	},
+	{
+		.compatible	= "rockchip,gpio-syscon",
+		.data		= &rockchip_gpio_syscon,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
-- 
2.7.4
