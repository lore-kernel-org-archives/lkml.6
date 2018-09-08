Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A70DC43143
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD7B20869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD7B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeIHPx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18326 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727157AbeIHPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:24 -0400
X-UUID: 214bd91a96594787b7fd4e4febccc8b1-20180908
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 585127549; Sat, 08 Sep 2018 19:07:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:43 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 21/22] pinctrl: mediatek: extend eint build to pinctrl-mtk-common-v2.c
Date:   Sat, 8 Sep 2018 19:07:37 +0800
Message-ID: <e6118363f41fbf19db827b2c50cba86f7909dbb8.1536404280.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Almost all MediaTek SoCs apply the exact same logic to build eint, so move
the common functions into pinctrl-mtk-common-v2.c to allow each new pinctrl
driver to reuse them. Also, add a protection checker on hw->soc->eint_hw to
avoid invalid memory access when there's certain SoC not to define its
eint_hw properly in the code flow.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 124 ---------------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 135 +++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |   2 +
 3 files changed, 137 insertions(+), 124 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index f0390b3..7cfab0c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -584,130 +584,6 @@ static int mtk_build_functions(struct mtk_pinctrl *hw)
 	return 0;
 }
 
-static int mtk_xt_find_eint_num(struct mtk_pinctrl *hw,
-				unsigned long eint_n)
-{
-	const struct mtk_pin_desc *desc;
-	int i = 0;
-
-	desc = (const struct mtk_pin_desc *)hw->soc->pins;
-
-	while (i < hw->soc->npins) {
-		if (desc[i].eint.eint_n == eint_n)
-			return desc[i].number;
-		i++;
-	}
-
-	return EINT_NA;
-}
-
-static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
-			     unsigned int *gpio_n,
-			     struct gpio_chip **gpio_chip)
-{
-	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
-	const struct mtk_pin_desc *desc;
-
-	desc = (const struct mtk_pin_desc *)hw->soc->pins;
-	*gpio_chip = &hw->chip;
-
-	/* Be greedy to guess first gpio_n is equal to eint_n */
-	if (desc[eint_n].eint.eint_n == eint_n)
-		*gpio_n = eint_n;
-	else
-		*gpio_n = mtk_xt_find_eint_num(hw, eint_n);
-
-	return *gpio_n == EINT_NA ? -EINVAL : 0;
-}
-
-static int mtk_xt_get_gpio_state(void *data, unsigned long eint_n)
-{
-	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
-	struct gpio_chip *gpio_chip;
-	unsigned int gpio_n;
-	int err;
-
-	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
-	if (err)
-		return err;
-
-	return mtk_gpio_get(gpio_chip, gpio_n);
-}
-
-static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
-{
-	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
-	const struct mtk_pin_desc *desc;
-	struct gpio_chip *gpio_chip;
-	unsigned int gpio_n;
-	int err;
-
-	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
-	if (err)
-		return err;
-
-	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio_n];
-
-	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE,
-			       desc->eint.eint_m);
-	if (err)
-		return err;
-
-	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR, MTK_INPUT);
-	if (err)
-		return err;
-
-	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static const struct mtk_eint_xt mtk_eint_xt = {
-	.get_gpio_n = mtk_xt_get_gpio_n,
-	.get_gpio_state = mtk_xt_get_gpio_state,
-	.set_gpio_as_eint = mtk_xt_set_gpio_as_eint,
-};
-
-static int
-mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
-
-	if (!IS_ENABLED(CONFIG_EINT_MTK))
-		return 0;
-
-	if (!of_property_read_bool(np, "interrupt-controller"))
-		return -ENODEV;
-
-	hw->eint = devm_kzalloc(hw->dev, sizeof(*hw->eint), GFP_KERNEL);
-	if (!hw->eint)
-		return -ENOMEM;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "eint");
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get eint resource\n");
-		return -ENODEV;
-	}
-
-	hw->eint->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hw->eint->base))
-		return PTR_ERR(hw->eint->base);
-
-	hw->eint->irq = irq_of_parse_and_map(np, 0);
-	if (!hw->eint->irq)
-		return -EINVAL;
-
-	hw->eint->dev = &pdev->dev;
-	hw->eint->hw = hw->soc->eint_hw;
-	hw->eint->pctl = hw;
-	hw->eint->gpio_xlate = &mtk_eint_xt;
-
-	return mtk_eint_do_init(hw->eint);
-}
-
 int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 			    const struct mtk_pin_soc *soc)
 {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 7d5f570..e8a2066 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -9,8 +9,11 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/of_irq.h>
 
+#include "mtk-eint.h"
 #include "pinctrl-mtk-common-v2.h"
 
 /**
@@ -207,6 +210,138 @@ int mtk_hw_get_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
 	return 0;
 }
 
+static int mtk_xt_find_eint_num(struct mtk_pinctrl *hw, unsigned long eint_n)
+{
+	const struct mtk_pin_desc *desc;
+	int i = 0;
+
+	desc = (const struct mtk_pin_desc *)hw->soc->pins;
+
+	while (i < hw->soc->npins) {
+		if (desc[i].eint.eint_n == eint_n)
+			return desc[i].number;
+		i++;
+	}
+
+	return EINT_NA;
+}
+
+static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
+			     unsigned int *gpio_n,
+			     struct gpio_chip **gpio_chip)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	const struct mtk_pin_desc *desc;
+
+	desc = (const struct mtk_pin_desc *)hw->soc->pins;
+	*gpio_chip = &hw->chip;
+
+	/* Be greedy to guess first gpio_n is equal to eint_n */
+	if (desc[eint_n].eint.eint_n == eint_n)
+		*gpio_n = eint_n;
+	else
+		*gpio_n = mtk_xt_find_eint_num(hw, eint_n);
+
+	return *gpio_n == EINT_NA ? -EINVAL : 0;
+}
+
+static int mtk_xt_get_gpio_state(void *data, unsigned long eint_n)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	const struct mtk_pin_desc *desc;
+	struct gpio_chip *gpio_chip;
+	unsigned int gpio_n;
+	int value, err;
+
+	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
+	if (err)
+		return err;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio_n];
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DI, &value);
+	if (err)
+		return err;
+
+	return !!value;
+}
+
+static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	const struct mtk_pin_desc *desc;
+	struct gpio_chip *gpio_chip;
+	unsigned int gpio_n;
+	int err;
+
+	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
+	if (err)
+		return err;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio_n];
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE,
+			       desc->eint.eint_m);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR, MTK_INPUT);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
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
+int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
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
+	if (!hw->soc->eint_hw)
+		return -ENODEV;
+
+	hw->eint->dev = &pdev->dev;
+	hw->eint->hw = hw->soc->eint_hw;
+	hw->eint->pctl = hw;
+	hw->eint->gpio_xlate = &mtk_eint_xt;
+
+	return mtk_eint_do_init(hw->eint);
+}
+
 /* Revision 0 */
 int mtk_pinconf_bias_disable_set(struct mtk_pinctrl *hw,
 				 const struct mtk_pin_desc *desc)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 05b9b39..e0d4e68 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -245,6 +245,8 @@ int mtk_hw_set_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
 int mtk_hw_get_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
 		     int field, int *value);
 
+int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev);
+
 int mtk_pinconf_bias_disable_set(struct mtk_pinctrl *hw,
 				 const struct mtk_pin_desc *desc);
 int mtk_pinconf_bias_disable_get(struct mtk_pinctrl *hw,
-- 
2.7.4

