Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722EC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE9620844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE9620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeIHPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32416 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbeIHPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:20 -0400
X-UUID: 61398fd5e88a485290840d8b765d6106-20180908
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 941011337; Sat, 08 Sep 2018 19:07:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:42 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 16/22] pinctrl: mediatek: extend struct mtk_pin_desc which per-pin driver depends on
Date:   Sat, 8 Sep 2018 19:07:32 +0800
Message-ID: <8706de60fe75838b595d3be73681bbca344734a8.1536404280.git.sean.wang@mediatek.com>
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

Because the pincrl-mtk-common.c is an implementation for per-pin binding,
its pin descriptor includes more information than pinctrl-mtk-common-v2
so far can support. So, we complement these data before writing a driver
using pincrl-mtk-common-v2.c for per-pin binding. By the way, the size of
struct mtk_pin_desc would be larger than struct pinctrl_pin_desc can hold,
so it's necessary to have a copy before the pins information is being
registered into the core.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 28 ++++++++++++------
 drivers/pinctrl/mediatek/pinctrl-moore.h         |  8 ++++--
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        |  5 ++--
 drivers/pinctrl/mediatek/pinctrl-mt7623.c        |  5 ++--
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 36 +++++++++++++++++++++---
 5 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 2817e47..f0390b3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -475,10 +475,10 @@ static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
 
-	if (desc->eint_n == EINT_NA)
+	if (desc->eint.eint_n == EINT_NA)
 		return -ENOTSUPP;
 
-	return mtk_eint_find_irq(hw->eint, desc->eint_n);
+	return mtk_eint_find_irq(hw->eint, desc->eint.eint_n);
 }
 
 static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
@@ -492,12 +492,12 @@ static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 
 	if (!hw->eint ||
 	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE ||
-	    desc->eint_n == EINT_NA)
+	    desc->eint.eint_n == EINT_NA)
 		return -ENOTSUPP;
 
 	debounce = pinconf_to_config_argument(config);
 
-	return mtk_eint_set_debounce(hw->eint, desc->eint_n, debounce);
+	return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, debounce);
 }
 
 static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
@@ -593,7 +593,7 @@ static int mtk_xt_find_eint_num(struct mtk_pinctrl *hw,
 	desc = (const struct mtk_pin_desc *)hw->soc->pins;
 
 	while (i < hw->soc->npins) {
-		if (desc[i].eint_n == eint_n)
+		if (desc[i].eint.eint_n == eint_n)
 			return desc[i].number;
 		i++;
 	}
@@ -612,7 +612,7 @@ static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
 	*gpio_chip = &hw->chip;
 
 	/* Be greedy to guess first gpio_n is equal to eint_n */
-	if (desc[eint_n].eint_n == eint_n)
+	if (desc[eint_n].eint.eint_n == eint_n)
 		*gpio_n = eint_n;
 	else
 		*gpio_n = mtk_xt_find_eint_num(hw, eint_n);
@@ -649,7 +649,7 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio_n];
 
 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE,
-			       hw->soc->eint_m);
+			       desc->eint.eint_m);
 	if (err)
 		return err;
 
@@ -711,6 +711,7 @@ mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
 int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 			    const struct mtk_pin_soc *soc)
 {
+	struct pinctrl_pin_desc *pins;
 	struct resource *res;
 	struct mtk_pinctrl *hw;
 	int err, i;
@@ -748,8 +749,19 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 
 	hw->nbase = hw->soc->nbase_names;
 
+	/* Copy from internal struct mtk_pin_desc to register to the core */
+	pins = devm_kmalloc_array(&pdev->dev, hw->soc->npins, sizeof(*pins),
+				  GFP_KERNEL);
+	if (IS_ERR(pins))
+		return PTR_ERR(pins);
+
+	for (i = 0; i < hw->soc->npins; i++) {
+		pins[i].number = hw->soc->pins[i].number;
+		pins[i].name = hw->soc->pins[i].name;
+	}
+
 	/* Setup pins descriptions per SoC types */
-	mtk_desc.pins = (const struct pinctrl_pin_desc *)hw->soc->pins;
+	mtk_desc.pins = (const struct pinctrl_pin_desc *)pins;
 	mtk_desc.npins = hw->soc->npins;
 	mtk_desc.num_custom_params = ARRAY_SIZE(mtk_custom_bindings);
 	mtk_desc.custom_params = mtk_custom_bindings;
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.h b/drivers/pinctrl/mediatek/pinctrl-moore.h
index b965cc1..74a6568 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.h
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.h
@@ -28,11 +28,15 @@
 
 #define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
 
-#define MTK_PIN(_number, _name, _eint_n, _drv_n) {	\
+#define MTK_PIN(_number, _name, _eint_m, _eint_n, _drv_n) {	\
 		.number = _number,			\
 		.name = _name,				\
-		.eint_n = _eint_n,			\
+		.eint = {				\
+			.eint_m = _eint_m,		\
+			.eint_n = _eint_n,		\
+		},					\
 		.drv_n = _drv_n,			\
+		.funcs = NULL,				\
 	}
 
 #define PINCTRL_PIN_GROUP(name, id)			\
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 769b36a..ce4a8a0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -9,7 +9,7 @@
 #include "pinctrl-moore.h"
 
 #define MT7622_PIN(_number, _name)					\
-	MTK_PIN(_number, _name, _number, DRV_GRP0)
+	MTK_PIN(_number, _name, 1, _number, DRV_GRP0)
 
 static const struct mtk_pin_field_calc mt7622_pin_mode_range[] = {
 	PIN_FIELD(0, 0, 0x320, 0x10, 16, 4),
@@ -758,7 +758,7 @@ static const struct mtk_eint_hw mt7622_eint_hw = {
 
 static const struct mtk_pin_soc mt7622_data = {
 	.reg_cal = mt7622_reg_cals,
-	.pins = (const struct pinctrl_pin_desc *)mt7622_pins,
+	.pins = mt7622_pins,
 	.npins = ARRAY_SIZE(mt7622_pins),
 	.grps = mt7622_groups,
 	.ngrps = ARRAY_SIZE(mt7622_groups),
@@ -766,7 +766,6 @@ static const struct mtk_pin_soc mt7622_data = {
 	.nfuncs = ARRAY_SIZE(mt7622_functions),
 	.eint_hw = &mt7622_eint_hw,
 	.gpio_m	= 1,
-	.eint_m = 1,
 	.ies_present = false,
 	.base_names = mtk_default_register_base_names,
 	.nbase_names = ARRAY_SIZE(mtk_default_register_base_names),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7623.c b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
index 1f2030c..b8d9d31 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7623.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
@@ -30,7 +30,7 @@
 		       _x_bits, 16, 1)
 
 #define MT7623_PIN(_number, _name, _eint_n, _drv_grp)			\
-	MTK_PIN(_number, _name, _eint_n, _drv_grp)
+	MTK_PIN(_number, _name, 0, _eint_n, _drv_grp)
 
 static const struct mtk_pin_field_calc mt7623_pin_mode_range[] = {
 	PIN_FIELD15(0, 278, 0x760, 0x10, 0, 3),
@@ -1373,7 +1373,7 @@ static const struct mtk_eint_hw mt7623_eint_hw = {
 
 static struct mtk_pin_soc mt7623_data = {
 	.reg_cal = mt7623_reg_cals,
-	.pins = (const struct pinctrl_pin_desc *)mt7623_pins,
+	.pins = mt7623_pins,
 	.npins = ARRAY_SIZE(mt7623_pins),
 	.grps = mt7623_groups,
 	.ngrps = ARRAY_SIZE(mt7623_groups),
@@ -1381,7 +1381,6 @@ static struct mtk_pin_soc mt7623_data = {
 	.nfuncs = ARRAY_SIZE(mt7623_functions),
 	.eint_hw = &mt7623_eint_hw,
 	.gpio_m = 0,
-	.eint_m = 0,
 	.ies_present = true,
 	.base_names = mtk_default_register_base_names,
 	.nbase_names = ARRAY_SIZE(mtk_default_register_base_names),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 040c6b7..d5819ca 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -134,18 +134,44 @@ struct mtk_pin_reg_calc {
 };
 
 /**
+ * struct mtk_func_desc - the structure that providing information
+ *			  all the funcs for this pin
+ * @name:		the name of function
+ * @muxval:		the mux to the function
+ */
+struct mtk_func_desc {
+	const char *name;
+	u8 muxval;
+};
+
+/**
+ * struct mtk_eint_desc - the structure that providing information
+ *			       for eint data per pin
+ * @eint_m:		the eint mux for this pin
+ * @eitn_n:		the eint number for this pin
+ */
+struct mtk_eint_desc {
+	u8 eint_m;
+	u16 eint_n;
+};
+
+/**
  * struct mtk_pin_desc - the structure that providing information
  *			       for each pin of chips
  * @number:		unique pin number from the global pin number space
  * @name:		name for this pin
- * @eint_n:		the eint number for this pin
+ * @eint:		the eint data for this pin
  * @drv_n:		the index with the driving group
+ * @funcs:		all available functions for this pins (only used in
+ *			those drivers compatible to pinctrl-mtk-common.c-like
+ *			ones)
  */
 struct mtk_pin_desc {
 	unsigned int number;
 	const char *name;
-	u16 eint_n;
+	struct mtk_eint_desc eint;
 	u8 drv_n;
+	struct mtk_func_desc *funcs;
 };
 
 struct mtk_pinctrl;
@@ -153,7 +179,7 @@ struct mtk_pinctrl;
 /* struct mtk_pin_soc - the structure that holds SoC-specific data */
 struct mtk_pin_soc {
 	const struct mtk_pin_reg_calc	*reg_cal;
-	const struct pinctrl_pin_desc	*pins;
+	const struct mtk_pin_desc	*pins;
 	unsigned int			npins;
 	const struct group_desc		*grps;
 	unsigned int			ngrps;
@@ -164,7 +190,6 @@ struct mtk_pin_soc {
 
 	/* Specific parameters per SoC */
 	u8				gpio_m;
-	u8				eint_m;
 	bool				ies_present;
 	const char * const		*base_names;
 	unsigned int			nbase_names;
@@ -190,6 +215,9 @@ struct mtk_pin_soc {
 	int (*adv_pull_get)(struct mtk_pinctrl *hw,
 			    const struct mtk_pin_desc *desc, bool pullup,
 			    u32 *val);
+
+	/* Specific driver data */
+	void				*driver_data;
 };
 
 struct mtk_pinctrl {
-- 
2.7.4

