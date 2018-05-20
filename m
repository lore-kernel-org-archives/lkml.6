Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeETRCc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:02:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25249 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751639AbeETRCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:02:20 -0400
X-UUID: eb680f2954e74b5fa731518d11d63a97-20180521
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 3/7] pinctrl: mediatek: add EINT support to MT7622 SoC
Date: Mon, 21 May 2018 01:01:49 +0800
Message-ID: <2d02c8e5c4c6b2f783ad55b887ce38d130be2a3f.1526835466.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add EINT support to MT7622 SoC and the support is made as just an option
to MT7622 pinctrl.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig          |   2 +-
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 143 ++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 310db42..9905dc6 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -3,7 +3,7 @@ menu "MediaTek pinctrl drivers"
 
 config EINT_MTK
 	bool "MediaTek External Interrupt Support"
-	depends on PINCTRL_MTK || COMPILE_TEST
+	depends on PINCTRL_MTK || PINCTRL_MT7622 || COMPILE_TEST
 	select IRQ_DOMAIN
 
 config PINCTRL_MTK
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 06e8406..ad6da11 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -30,6 +31,7 @@
 #include "../core.h"
 #include "../pinconf.h"
 #include "../pinmux.h"
+#include "mtk-eint.h"
 
 #define PINCTRL_PINCTRL_DEV		KBUILD_MODNAME
 #define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
@@ -123,6 +125,8 @@ struct mtk_pin_soc {
 	unsigned int			ngrps;
 	const struct function_desc	*funcs;
 	unsigned int			nfuncs;
+	const struct mtk_eint_regs	*eint_regs;
+	const struct mtk_eint_hw	*eint_hw;
 };
 
 struct mtk_pinctrl {
@@ -131,6 +135,7 @@ struct mtk_pinctrl {
 	struct device			*dev;
 	struct gpio_chip		chip;
 	const struct mtk_pin_soc	*soc;
+	struct mtk_eint			*eint;
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_mode_range[] = {
@@ -913,6 +918,13 @@ static const struct pin_config_item mtk_conf_items[] = {
 };
 #endif
 
+static const struct mtk_eint_hw mt7622_eint_hw = {
+	.port_mask = 7,
+	.ports     = 7,
+	.ap_num    = ARRAY_SIZE(mt7622_pins),
+	.db_cnt    = 20,
+};
+
 static const struct mtk_pin_soc mt7622_data = {
 	.reg_cal = mt7622_reg_cals,
 	.pins = mt7622_pins,
@@ -921,6 +933,7 @@ static const struct mtk_pin_soc mt7622_data = {
 	.ngrps = ARRAY_SIZE(mt7622_groups),
 	.funcs = mt7622_functions,
 	.nfuncs = ARRAY_SIZE(mt7622_functions),
+	.eint_hw = &mt7622_eint_hw,
 };
 
 static void mtk_w32(struct mtk_pinctrl *pctl, u32 reg, u32 val)
@@ -1441,6 +1454,32 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 	return pinctrl_gpio_direction_output(chip->base + gpio);
 }
 
+static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	unsigned long eint_n;
+
+	eint_n = offset;
+
+	return mtk_eint_find_irq(hw->eint, eint_n);
+}
+
+static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+			       unsigned long config)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	unsigned long eint_n;
+	u32 debounce;
+
+	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
+		return -ENOTSUPP;
+
+	debounce = pinconf_to_config_argument(config);
+	eint_n = offset;
+
+	return mtk_eint_set_debounce(hw->eint, eint_n, debounce);
+}
+
 static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 {
 	struct gpio_chip *chip = &hw->chip;
@@ -1454,6 +1493,8 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 	chip->direction_output	= mtk_gpio_direction_output;
 	chip->get		= mtk_gpio_get;
 	chip->set		= mtk_gpio_set;
+	chip->to_irq		= mtk_gpio_to_irq,
+	chip->set_config	= mtk_gpio_set_config,
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
 	chip->of_node		= np;
@@ -1514,6 +1555,103 @@ static int mtk_build_functions(struct mtk_pinctrl *hw)
 	return 0;
 }
 
+static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
+			     unsigned int *gpio_n,
+			     struct gpio_chip **gpio_chip)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+
+	*gpio_chip = &hw->chip;
+	*gpio_n = eint_n;
+
+	return 0;
+}
+
+static int mtk_xt_get_gpio_state(void *data, unsigned long eint_n)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	struct gpio_chip *gpio_chip;
+	unsigned int gpio_n;
+	int err;
+
+	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
+	if (err)
+		return err;
+
+	return mtk_gpio_get(gpio_chip, gpio_n);
+}
+
+static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	struct gpio_chip *gpio_chip;
+	unsigned int gpio_n;
+	int err;
+
+	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_MODE,
+			       MTK_GPIO_MODE);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_DIR, MTK_INPUT);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct mtk_eint_xt mtk_eint_xt = {
+	.get_gpio_n = mtk_xt_get_gpio_n,
+	.get_gpio_state = mtk_xt_get_gpio_state,
+	.set_gpio_as_eint = mtk_xt_set_gpio_as_eint,
+};
+
+static int
+mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+
+	if (!IS_ENABLED(CONFIG_EINT_MTK))
+		return 0;
+
+	if (!of_property_read_bool(np, "interrupt-controller"))
+		return -ENODEV;
+
+	hw->eint = devm_kzalloc(hw->dev, sizeof(*hw->eint), GFP_KERNEL);
+	if (!hw->eint)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "eint");
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get eint resource\n");
+		return -ENODEV;
+	}
+
+	hw->eint->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hw->eint->base))
+		return PTR_ERR(hw->eint->base);
+
+	hw->eint->irq = irq_of_parse_and_map(np, 0);
+	if (!hw->eint->irq)
+		return -EINVAL;
+
+	hw->eint->dev = &pdev->dev;
+	hw->eint->hw = hw->soc->eint_hw;
+	hw->eint->pctl = hw;
+	hw->eint->gpio_xlate = &mtk_eint_xt;
+
+	return mtk_eint_do_init(hw->eint);
+}
+
 static const struct of_device_id mtk_pinctrl_of_match[] = {
 	{ .compatible = "mediatek,mt7622-pinctrl", .data = &mt7622_data},
 	{ }
@@ -1577,6 +1715,11 @@ static int mtk_pinctrl_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = mtk_build_eint(hw, pdev);
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Failed to add EINT, but pinctrl still can work\n");
+
 	platform_set_drvdata(pdev, hw);
 
 	return 0;
-- 
2.7.4
