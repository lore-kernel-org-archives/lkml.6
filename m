Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeENMGG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:06:06 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:59783 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeENMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:06:04 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: david.wu@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: david.wu@rock-chips.com
X-UNIQUE-TAG: <e33cac8f0be5a8f5f6e52677acd8845c>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: David Wu <david.wu@rock-chips.com>
To: heiko@sntech.de, linus.walleij@linaro.org
Cc: huangtao@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>
Subject: [PATCH] pinctrl: rockchip: Add pinctrl support for PX30
Date: Mon, 14 May 2018 19:59:51 +0800
Message-Id: <1526299191-1140-1-git-send-email-david.wu@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 banks (GPIO0 ~ GPIO3), bank0 is in PD_PMU
subsystem, bank1/bank2/bank3 are in PD_BUS subsystem.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 .../bindings/pinctrl/rockchip,pinctrl.txt          |   1 +
 drivers/pinctrl/pinctrl-rockchip.c                 | 194 +++++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index a01a3b8..0919db2 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -20,6 +20,7 @@ defined as gpio sub-nodes of the pinmux controller.
 
 Required properties for iomux controller:
   - compatible: should be
+		"rockchip,px30-pinctrl":    for Rockchip PX30
 		"rockchip,rv1108-pinctrl":  for Rockchip RV1108
 		"rockchip,rk2928-pinctrl":  for Rockchip RK2928
 		"rockchip,rk3066a-pinctrl": for Rockchip RK3066a
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 3924779..88d4077 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -59,6 +59,7 @@
 #define GPIO_LS_SYNC		0x60
 
 enum rockchip_pinctrl_type {
+	PX30,
 	RV1108,
 	RK2928,
 	RK3066B,
@@ -701,6 +702,66 @@ static void rockchip_get_recalced_mux(struct rockchip_pin_bank *bank, int pin,
 	*bit = data->bit;
 }
 
+static struct rockchip_mux_route_data px30_mux_route_data[] = {
+	{
+		/* cif-d2m0 */
+		.bank_num = 2,
+		.pin = 0,
+		.func = 1,
+		.route_offset = 0x184,
+		.route_val = BIT(16 + 7),
+	}, {
+		/* cif-d2m1 */
+		.bank_num = 3,
+		.pin = 3,
+		.func = 3,
+		.route_offset = 0x184,
+		.route_val = BIT(16 + 7) | BIT(7),
+	}, {
+		/* pdm-m0 */
+		.bank_num = 3,
+		.pin = 22,
+		.func = 2,
+		.route_offset = 0x184,
+		.route_val = BIT(16 + 8),
+	}, {
+		/* pdm-m1 */
+		.bank_num = 2,
+		.pin = 22,
+		.func = 1,
+		.route_offset = 0x184,
+		.route_val = BIT(16 + 8) | BIT(8),
+	}, {
+		/* uart2-rxm0 */
+		.bank_num = 1,
+		.pin = 27,
+		.func = 2,
+		.route_offset = 0x184,
+		.route_val = BIT(16 + 10),
+	}, {
+		/* uart2-rxm1 */
+		.bank_num = 2,
+		.pin = 14,
+		.func = 2,
+		.route_offset = 0x184,
+		.route_val = BIT(16 + 10) | BIT(10),
+	}, {
+		/* uart3-rxm0 */
+		.bank_num = 0,
+		.pin = 17,
+		.func = 2,
+		.route_offset = 0x184,
+		.route_val = BIT(16 + 9),
+	}, {
+		/* uart3-rxm1 */
+		.bank_num = 1,
+		.pin = 15,
+		.func = 2,
+		.route_offset = 0x184,
+		.route_val = BIT(16 + 9) | BIT(9),
+	},
+};
+
 static struct rockchip_mux_route_data rk3128_mux_route_data[] = {
 	{
 		/* spi-0 */
@@ -1202,6 +1263,97 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	return ret;
 }
 
+#define PX30_PULL_PMU_OFFSET		0x10
+#define PX30_PULL_GRF_OFFSET		0x60
+#define PX30_PULL_BITS_PER_PIN		2
+#define PX30_PULL_PINS_PER_REG		8
+#define PX30_PULL_BANK_STRIDE		16
+
+static void px30_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+				       int pin_num, struct regmap **regmap,
+				       int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+
+	/* The first 32 pins of the first bank are located in PMU */
+	if (bank->bank_num == 0) {
+		*regmap = info->regmap_pmu;
+		*reg = PX30_PULL_PMU_OFFSET;
+	} else {
+		*regmap = info->regmap_base;
+		*reg = PX30_PULL_GRF_OFFSET;
+
+		/* correct the offset, as we're starting with the 2nd bank */
+		*reg -= 0x10;
+		*reg += bank->bank_num * PX30_PULL_BANK_STRIDE;
+	}
+
+	*reg += ((pin_num / PX30_PULL_PINS_PER_REG) * 4);
+	*bit = (pin_num % PX30_PULL_PINS_PER_REG);
+	*bit *= PX30_PULL_BITS_PER_PIN;
+}
+
+#define PX30_DRV_PMU_OFFSET		0x20
+#define PX30_DRV_GRF_OFFSET		0xf0
+#define PX30_DRV_BITS_PER_PIN		2
+#define PX30_DRV_PINS_PER_REG		8
+#define PX30_DRV_BANK_STRIDE		16
+
+static void px30_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+				      int pin_num, struct regmap **regmap,
+				      int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+
+	/* The first 32 pins of the first bank are located in PMU */
+	if (bank->bank_num == 0) {
+		*regmap = info->regmap_pmu;
+		*reg = PX30_DRV_PMU_OFFSET;
+	} else {
+		*regmap = info->regmap_base;
+		*reg = PX30_DRV_GRF_OFFSET;
+
+		/* correct the offset, as we're starting with the 2nd bank */
+		*reg -= 0x10;
+		*reg += bank->bank_num * PX30_DRV_BANK_STRIDE;
+	}
+
+	*reg += ((pin_num / PX30_DRV_PINS_PER_REG) * 4);
+	*bit = (pin_num % PX30_DRV_PINS_PER_REG);
+	*bit *= PX30_DRV_BITS_PER_PIN;
+}
+
+#define PX30_SCHMITT_PMU_OFFSET			0x38
+#define PX30_SCHMITT_GRF_OFFSET			0xc0
+#define PX30_SCHMITT_PINS_PER_PMU_REG		16
+#define PX30_SCHMITT_BANK_STRIDE		16
+#define PX30_SCHMITT_PINS_PER_GRF_REG		8
+
+static int px30_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
+					 int pin_num,
+					 struct regmap **regmap,
+					 int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+	int pins_per_reg;
+
+	if (bank->bank_num == 0) {
+		*regmap = info->regmap_pmu;
+		*reg = PX30_SCHMITT_PMU_OFFSET;
+		pins_per_reg = PX30_SCHMITT_PINS_PER_PMU_REG;
+	} else {
+		*regmap = info->regmap_base;
+		*reg = PX30_SCHMITT_GRF_OFFSET;
+		pins_per_reg = PX30_SCHMITT_PINS_PER_GRF_REG;
+		*reg += (bank->bank_num  - 1) * PX30_SCHMITT_BANK_STRIDE;
+	}
+
+	*reg += ((pin_num / pins_per_reg) * 4);
+	*bit = pin_num % pins_per_reg;
+
+	return 0;
+}
+
 #define RV1108_PULL_PMU_OFFSET		0x10
 #define RV1108_PULL_OFFSET		0x110
 #define RV1108_PULL_PINS_PER_REG	8
@@ -1798,6 +1950,7 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 		return !(data & BIT(bit))
 				? PIN_CONFIG_BIAS_PULL_PIN_DEFAULT
 				: PIN_CONFIG_BIAS_DISABLE;
+	case PX30:
 	case RV1108:
 	case RK3188:
 	case RK3288:
@@ -1841,6 +1994,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 			data |= BIT(bit);
 		ret = regmap_write(regmap, reg, data);
 		break;
+	case PX30:
 	case RV1108:
 	case RK3188:
 	case RK3288:
@@ -2103,6 +2257,7 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 					pull == PIN_CONFIG_BIAS_DISABLE);
 	case RK3066B:
 		return pull ? false : true;
+	case PX30:
 	case RV1108:
 	case RK3188:
 	case RK3288:
@@ -3237,6 +3392,43 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static struct rockchip_pin_bank px30_pin_banks[] = {
+	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", IOMUX_SOURCE_PMU,
+					     IOMUX_SOURCE_PMU,
+					     IOMUX_SOURCE_PMU,
+					     IOMUX_SOURCE_PMU
+			    ),
+	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT
+			    ),
+	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT
+			    ),
+	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3", IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT
+			    ),
+};
+
+static struct rockchip_pin_ctrl px30_pin_ctrl = {
+		.pin_banks		= px30_pin_banks,
+		.nr_banks		= ARRAY_SIZE(px30_pin_banks),
+		.label			= "PX30-GPIO",
+		.type			= PX30,
+		.grf_mux_offset		= 0x0,
+		.pmu_mux_offset		= 0x0,
+		.iomux_routes		= px30_mux_route_data,
+		.niomux_routes		= ARRAY_SIZE(px30_mux_route_data),
+		.pull_calc_reg		= px30_calc_pull_reg_and_bit,
+		.drv_calc_reg		= px30_calc_drv_reg_and_bit,
+		.schmitt_calc_reg	= px30_calc_schmitt_reg_and_bit,
+};
+
 static struct rockchip_pin_bank rv1108_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", IOMUX_SOURCE_PMU,
 					     IOMUX_SOURCE_PMU,
@@ -3545,6 +3737,8 @@ static struct rockchip_pin_ctrl rk3399_pin_ctrl = {
 };
 
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
+	{ .compatible = "rockchip,px30-pinctrl",
+		.data = &px30_pin_ctrl },
 	{ .compatible = "rockchip,rv1108-pinctrl",
 		.data = &rv1108_pin_ctrl },
 	{ .compatible = "rockchip,rk2928-pinctrl",
-- 
2.7.4
