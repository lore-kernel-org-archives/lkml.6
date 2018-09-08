Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D82BC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1718420844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1718420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeIHPxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28557 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726378AbeIHPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:21 -0400
X-UUID: 064c5792a65045e6ab298d1ac4e5fa3d-20180908
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 606583365; Sat, 08 Sep 2018 19:07:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:42 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 17/22] pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings
Date:   Sat, 8 Sep 2018 19:07:33 +0800
Message-ID: <ed67b2e8e71220a8cd32c9a7e584931af3d83041.1536404280.git.sean.wang@mediatek.com>
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

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

Add pinctrl-paris core that implements vendor dt-binding which MediaTek
tablet, box and smartphone-based SoCs such as MT81xx, MT27xx, and MT67xx
SoCs really want to depend on. The driver is just completely rewritten
according to pinctrl-mtk-common.c but uses the new logic from
pinctrl-mtk-common-v2.c to have an elegant way to support new SoCs in the
future.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig                 |   9 +
 drivers/pinctrl/mediatek/Makefile                |   1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |   8 +
 drivers/pinctrl/mediatek/pinctrl-paris.c         | 884 +++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.h         |  65 ++
 5 files changed, 967 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-paris.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-paris.h

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 6124ef0..4a8086e 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -24,6 +24,15 @@ config PINCTRL_MTK_MOORE
 	select GPIOLIB
 	select OF_GPIO
 
+config PINCTRL_MTK_PARIS
+	bool "MediaTek Paris Core that implements vendor binding"
+	depends on OF
+	select PINMUX
+	select GENERIC_PINCONF
+	select GPIOLIB
+	select EINT_MTK
+	select OF_GPIO
+
 # For ARMv7 SoCs
 config PINCTRL_MT2701
 	bool "Mediatek MT2701 pin control"
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index 5df28e1..8847dce 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_EINT_MTK)		+= mtk-eint.o
 obj-$(CONFIG_PINCTRL_MTK)	+= pinctrl-mtk-common.o
 obj-$(CONFIG_PINCTRL_MTK_MOORE) += pinctrl-moore.o pinctrl-mtk-common-v2.o
+obj-$(CONFIG_PINCTRL_MTK_PARIS) += pinctrl-paris.o pinctrl-mtk-common-v2.o
 
 # SoC Drivers
 obj-$(CONFIG_PINCTRL_MT2701)	+= pinctrl-mt2701.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index d5819ca..05b9b39 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -174,6 +174,12 @@ struct mtk_pin_desc {
 	struct mtk_func_desc *funcs;
 };
 
+struct mtk_pinctrl_group {
+	const char	*name;
+	unsigned long	config;
+	unsigned	pin;
+};
+
 struct mtk_pinctrl;
 
 /* struct mtk_pin_soc - the structure that holds SoC-specific data */
@@ -228,6 +234,8 @@ struct mtk_pinctrl {
 	struct gpio_chip		chip;
 	const struct mtk_pin_soc        *soc;
 	struct mtk_eint			*eint;
+	struct mtk_pinctrl_group	*groups;
+	const char          **grp_names;
 };
 
 void mtk_rmw(struct mtk_pinctrl *pctl, u8 i, u32 reg, u32 mask, u32 set);
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
new file mode 100644
index 0000000..50d6893
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -0,0 +1,884 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek Pinctrl Paris Driver, which implement the vendor per-pin
+ * bindings for MediaTek SoC.
+ *
+ * Copyright (C) 2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *	   Zhiyong Tao <zhiyong.tao@mediatek.com>
+ *	   Hongzhou.Yang <hongzhou.yang@mediatek.com>
+ */
+
+#include <dt-bindings/pinctrl/mt65xx.h>
+#include "pinctrl-paris.h"
+
+#define PINCTRL_PINCTRL_DEV	KBUILD_MODNAME
+
+/* Custom pinconf parameters */
+#define MTK_PIN_CONFIG_TDSEL	(PIN_CONFIG_END + 1)
+#define MTK_PIN_CONFIG_RDSEL	(PIN_CONFIG_END + 2)
+#define MTK_PIN_CONFIG_PU_ADV	(PIN_CONFIG_END + 3)
+#define MTK_PIN_CONFIG_PD_ADV	(PIN_CONFIG_END + 4)
+
+static const struct pinconf_generic_params mtk_custom_bindings[] = {
+	{"mediatek,tdsel",	MTK_PIN_CONFIG_TDSEL,		0},
+	{"mediatek,rdsel",	MTK_PIN_CONFIG_RDSEL,		0},
+	{"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,		1},
+	{"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,	1},
+};
+
+#ifdef CONFIG_DEBUG_FS
+static const struct pin_config_item mtk_conf_items[] = {
+	PCONFDUMP(MTK_PIN_CONFIG_TDSEL, "tdsel", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
+};
+#endif
+
+static const char * const mtk_gpio_functions[] = {
+	"func0", "func1", "func2", "func3",
+	"func4", "func5", "func6", "func7",
+	"func8", "func9", "func10", "func11",
+	"func12", "func13", "func14", "func15",
+};
+
+static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
+					  struct pinctrl_gpio_range *range,
+					  unsigned int pin)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	const struct mtk_pin_desc *desc;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
+
+	return mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE,
+				hw->soc->gpio_m);
+}
+
+static int mtk_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
+					 struct pinctrl_gpio_range *range,
+					 unsigned int pin, bool input)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	const struct mtk_pin_desc *desc;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
+
+	/* hardware would take 0 as input direction */
+	return mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR, !input);
+}
+
+static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
+			   unsigned int pin, unsigned long *config)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	u32 param = pinconf_to_config_param(*config);
+	int val, val2, err, reg, ret = 1;
+	const struct mtk_pin_desc *desc;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (hw->soc->bias_disable_get) {
+			err = hw->soc->bias_disable_get(hw, desc, &ret);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if (hw->soc->bias_get) {
+			err = hw->soc->bias_get(hw, desc, 1, &ret);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (hw->soc->bias_get) {
+			err = hw->soc->bias_get(hw, desc, 0, &ret);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SR, &val);
+		if (err)
+			return err;
+
+		if (!val)
+			return -EINVAL;
+
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &val);
+		if (err)
+			return err;
+
+		/* HW takes input mode as zero; output mode as non-zero */
+		if ((val && param == PIN_CONFIG_INPUT_ENABLE) ||
+		    (!val && param == PIN_CONFIG_OUTPUT_ENABLE))
+			return -EINVAL;
+
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &val);
+		if (err)
+			return err;
+
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SMT, &val2);
+		if (err)
+			return err;
+
+		if (val || !val2)
+			return -EINVAL;
+
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		if (hw->soc->drive_get) {
+			err = hw->soc->drive_get(hw, desc, &ret);
+			if (err)
+				return err;
+		} else {
+			err = -ENOTSUPP;
+		}
+		break;
+	case MTK_PIN_CONFIG_TDSEL:
+	case MTK_PIN_CONFIG_RDSEL:
+		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
+		       PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
+
+		err = mtk_hw_get_value(hw, desc, reg, &val);
+		if (err)
+			return err;
+
+		ret = val;
+
+		break;
+	case MTK_PIN_CONFIG_PU_ADV:
+	case MTK_PIN_CONFIG_PD_ADV:
+		if (hw->soc->adv_pull_get) {
+			bool pullup;
+
+			pullup = param == MTK_PIN_CONFIG_PU_ADV;
+			err = hw->soc->adv_pull_get(hw, desc, pullup, &ret);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, ret);
+
+	return 0;
+}
+
+static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+			   enum pin_config_param param,
+			   enum pin_config_param arg)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	const struct mtk_pin_desc *desc;
+	int err = 0;
+	u32 reg;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
+
+	switch ((u32)param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (hw->soc->bias_disable_set) {
+			err = hw->soc->bias_disable_set(hw, desc);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if (hw->soc->bias_set) {
+			err = hw->soc->bias_set(hw, desc, 1);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (hw->soc->bias_set) {
+			err = hw->soc->bias_set(hw, desc, 0);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
+				       MTK_DISABLE);
+		if (err)
+			goto err;
+
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
+				       MTK_OUTPUT);
+		if (err)
+			goto err;
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		if (hw->soc->ies_present) {
+			mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES,
+					 MTK_ENABLE);
+		}
+
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
+				       MTK_INPUT);
+		if (err)
+			goto err;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SR,
+				       arg);
+		if (err)
+			goto err;
+
+		break;
+	case PIN_CONFIG_OUTPUT:
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
+				       MTK_OUTPUT);
+		if (err)
+			goto err;
+
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DO,
+				       arg);
+		if (err)
+			goto err;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		/* arg = 1: Input mode & SMT enable ;
+		 * arg = 0: Output mode & SMT disable
+		 */
+		arg = arg ? 2 : 1;
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
+				       arg & 1);
+		if (err)
+			goto err;
+
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
+				       !!(arg & 2));
+		if (err)
+			goto err;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		if (hw->soc->drive_set) {
+			err = hw->soc->drive_set(hw, desc, arg);
+		if (err)
+			return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	case MTK_PIN_CONFIG_TDSEL:
+	case MTK_PIN_CONFIG_RDSEL:
+		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
+		       PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
+
+		err = mtk_hw_set_value(hw, desc, reg, arg);
+		if (err)
+			goto err;
+		break;
+	case MTK_PIN_CONFIG_PU_ADV:
+	case MTK_PIN_CONFIG_PD_ADV:
+		if (hw->soc->adv_pull_set) {
+			bool pullup;
+
+			pullup = param == MTK_PIN_CONFIG_PU_ADV;
+			err = hw->soc->adv_pull_set(hw, desc, pullup,
+						    arg);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
+	default:
+		err = -ENOTSUPP;
+	}
+
+err:
+	return err;
+}
+
+static struct mtk_pinctrl_group *
+mtk_pctrl_find_group_by_pin(struct mtk_pinctrl *hw, u32 pin)
+{
+	int i;
+
+	for (i = 0; i < hw->soc->ngrps; i++) {
+		struct mtk_pinctrl_group *grp = hw->groups + i;
+
+		if (grp->pin == pin)
+			return grp;
+	}
+
+	return NULL;
+}
+
+static const struct mtk_func_desc *
+mtk_pctrl_find_function_by_pin(struct mtk_pinctrl *hw, u32 pin_num, u32 fnum)
+{
+	const struct mtk_pin_desc *pin = hw->soc->pins + pin_num;
+	const struct mtk_func_desc *func = pin->funcs;
+
+	while (func && func->name) {
+		if (func->muxval == fnum)
+			return func;
+		func++;
+	}
+
+	return NULL;
+}
+
+static bool mtk_pctrl_is_function_valid(struct mtk_pinctrl *hw, u32 pin_num,
+					u32 fnum)
+{
+	int i;
+
+	for (i = 0; i < hw->soc->npins; i++) {
+		const struct mtk_pin_desc *pin = hw->soc->pins + i;
+
+		if (pin->number == pin_num) {
+			const struct mtk_func_desc *func = pin->funcs;
+
+			while (func && func->name) {
+				if (func->muxval == fnum)
+					return true;
+				func++;
+			}
+
+			break;
+		}
+	}
+
+	return false;
+}
+
+static int mtk_pctrl_dt_node_to_map_func(struct mtk_pinctrl *pctl,
+					 u32 pin, u32 fnum,
+					 struct mtk_pinctrl_group *grp,
+					 struct pinctrl_map **map,
+					 unsigned *reserved_maps,
+					 unsigned *num_maps)
+{
+	bool ret;
+
+	if (*num_maps == *reserved_maps)
+		return -ENOSPC;
+
+	(*map)[*num_maps].type = PIN_MAP_TYPE_MUX_GROUP;
+	(*map)[*num_maps].data.mux.group = grp->name;
+
+	ret = mtk_pctrl_is_function_valid(pctl, pin, fnum);
+	if (!ret) {
+		dev_err(pctl->dev, "invalid function %d on pin %d .\n",
+			fnum, pin);
+		return -EINVAL;
+	}
+
+	(*map)[*num_maps].data.mux.function = mtk_gpio_functions[fnum];
+	(*num_maps)++;
+
+	return 0;
+}
+
+static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
+				       struct device_node *node,
+				       struct pinctrl_map **map,
+				       unsigned *reserved_maps,
+				       unsigned *num_maps)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	int num_pins, num_funcs, maps_per_pin, i, err;
+	struct mtk_pinctrl_group *grp;
+	unsigned int num_configs;
+	bool has_config = false;
+	unsigned long *configs;
+	u32 pinfunc, pin, func;
+	struct property *pins;
+	unsigned reserve = 0;
+
+	pins = of_find_property(node, "pinmux", NULL);
+	if (!pins) {
+		dev_err(hw->dev, "missing pins property in node %s .\n",
+			node->name);
+		return -EINVAL;
+	}
+
+	err = pinconf_generic_parse_dt_config(node, pctldev, &configs,
+					      &num_configs);
+	if (err)
+		return err;
+
+	if (num_configs)
+		has_config = true;
+
+	num_pins = pins->length / sizeof(u32);
+	num_funcs = num_pins;
+	maps_per_pin = 0;
+	if (num_funcs)
+		maps_per_pin++;
+	if (has_config && num_pins >= 1)
+		maps_per_pin++;
+
+	if (!num_pins || !maps_per_pin) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	reserve = num_pins * maps_per_pin;
+
+	err = pinctrl_utils_reserve_map(pctldev, map, reserved_maps, num_maps,
+					reserve);
+	if (err < 0)
+		goto exit;
+
+	for (i = 0; i < num_pins; i++) {
+		err = of_property_read_u32_index(node, "pinmux", i, &pinfunc);
+		if (err)
+			goto exit;
+
+		pin = MTK_GET_PIN_NO(pinfunc);
+		func = MTK_GET_PIN_FUNC(pinfunc);
+
+		if (pin >= hw->soc->npins ||
+		    func >= ARRAY_SIZE(mtk_gpio_functions)) {
+			dev_err(hw->dev, "invalid pins value.\n");
+			err = -EINVAL;
+			goto exit;
+		}
+
+		grp = mtk_pctrl_find_group_by_pin(hw, pin);
+		if (!grp) {
+			dev_err(hw->dev, "unable to match pin %d to group\n",
+				pin);
+			err = -EINVAL;
+			goto exit;
+		}
+
+		err = mtk_pctrl_dt_node_to_map_func(hw, pin, func, grp, map,
+						    reserved_maps, num_maps);
+		if (err < 0)
+			goto exit;
+
+		if (has_config) {
+			err = pinctrl_utils_add_map_configs(pctldev, map,
+							    reserved_maps,
+							    num_maps,
+							    grp->name,
+							    configs,
+							    num_configs,
+							    PIN_MAP_TYPE_CONFIGS_GROUP);
+			if (err < 0)
+				goto exit;
+		}
+	}
+
+	err = 0;
+
+exit:
+	kfree(configs);
+	return err;
+}
+
+static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+				    struct device_node *np_config,
+				    struct pinctrl_map **map,
+				    unsigned *num_maps)
+{
+	struct device_node *np;
+	unsigned reserved_maps;
+	int ret;
+
+	*map = NULL;
+	*num_maps = 0;
+	reserved_maps = 0;
+
+	for_each_child_of_node(np_config, np) {
+		ret = mtk_pctrl_dt_subnode_to_map(pctldev, np, map,
+						  &reserved_maps,
+						  num_maps);
+		if (ret < 0) {
+			pinctrl_utils_free_map(pctldev, *map, *num_maps);
+			of_node_put(np);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+
+	return hw->soc->ngrps;
+}
+
+static const char *mtk_pctrl_get_group_name(struct pinctrl_dev *pctldev,
+					    unsigned group)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+
+	return hw->groups[group].name;
+}
+
+static int mtk_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
+				    unsigned group, const unsigned **pins,
+				    unsigned *num_pins)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = (unsigned *)&hw->groups[group].pin;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops mtk_pctlops = {
+	.dt_node_to_map		= mtk_pctrl_dt_node_to_map,
+	.dt_free_map		= pinctrl_utils_free_map,
+	.get_groups_count	= mtk_pctrl_get_groups_count,
+	.get_group_name		= mtk_pctrl_get_group_name,
+	.get_group_pins		= mtk_pctrl_get_group_pins,
+};
+
+static int mtk_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(mtk_gpio_functions);
+}
+
+static const char *mtk_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					 unsigned selector)
+{
+	return mtk_gpio_functions[selector];
+}
+
+static int mtk_pmx_get_func_groups(struct pinctrl_dev *pctldev,
+				   unsigned function,
+				   const char * const **groups,
+				   unsigned * const num_groups)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = hw->grp_names;
+	*num_groups = hw->soc->ngrps;
+
+	return 0;
+}
+
+static int mtk_pmx_set_mux(struct pinctrl_dev *pctldev,
+			   unsigned function,
+			   unsigned group)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	struct mtk_pinctrl_group *grp = hw->groups + group;
+	const struct mtk_func_desc *desc_func;
+	const struct mtk_pin_desc *desc;
+	bool ret;
+
+	ret = mtk_pctrl_is_function_valid(hw, grp->pin, function);
+	if (!ret) {
+		dev_err(hw->dev, "invalid function %d on group %d .\n",
+			function, group);
+		return -EINVAL;
+	}
+
+	desc_func = mtk_pctrl_find_function_by_pin(hw, grp->pin, function);
+	if (!desc_func)
+		return -EINVAL;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[grp->pin];
+	mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE, desc_func->muxval);
+
+	return 0;
+}
+
+static const struct pinmux_ops mtk_pmxops = {
+	.get_functions_count	= mtk_pmx_get_funcs_cnt,
+	.get_function_name	= mtk_pmx_get_func_name,
+	.get_function_groups	= mtk_pmx_get_func_groups,
+	.set_mux		= mtk_pmx_set_mux,
+	.gpio_set_direction	= mtk_pinmux_gpio_set_direction,
+	.gpio_request_enable	= mtk_pinmux_gpio_request_enable,
+};
+
+static int mtk_pconf_group_get(struct pinctrl_dev *pctldev, unsigned group,
+			       unsigned long *config)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+
+	*config = hw->groups[group].config;
+
+	return 0;
+}
+
+static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
+			       unsigned long *configs, unsigned num_configs)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	struct mtk_pinctrl_group *grp = &hw->groups[group];
+	int i, ret;
+
+	for (i = 0; i < num_configs; i++) {
+		ret = mtk_pinconf_set(pctldev, grp->pin,
+				      pinconf_to_config_param(configs[i]),
+				      pinconf_to_config_argument(configs[i]));
+		if (ret < 0)
+			return ret;
+
+		grp->config = configs[i];
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops mtk_confops = {
+	.pin_config_get = mtk_pinconf_get,
+	.pin_config_group_get	= mtk_pconf_group_get,
+	.pin_config_group_set	= mtk_pconf_group_set,
+};
+
+static struct pinctrl_desc mtk_desc = {
+	.name = PINCTRL_PINCTRL_DEV,
+	.pctlops = &mtk_pctlops,
+	.pmxops = &mtk_pmxops,
+	.confops = &mtk_confops,
+	.owner = THIS_MODULE,
+};
+
+static int mtk_gpio_get_direction(struct gpio_chip *chip, unsigned int gpio)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
+	int value, err;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio];
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &value);
+	if (err)
+		return err;
+
+	return !value;
+}
+
+static int mtk_gpio_get(struct gpio_chip *chip, unsigned int gpio)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
+	int value, err;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio];
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DI, &value);
+	if (err)
+		return err;
+
+	return !!value;
+}
+
+static void mtk_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio];
+
+	mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DO, !!value);
+}
+
+static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
+{
+	return pinctrl_gpio_direction_input(chip->base + gpio);
+}
+
+static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
+				     int value)
+{
+	mtk_gpio_set(chip, gpio, value);
+
+	return pinctrl_gpio_direction_output(chip->base + gpio);
+}
+
+static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+			       unsigned long config)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
+	u32 debounce;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
+
+	if (!hw->eint ||
+	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE ||
+	    desc->eint.eint_n == EINT_NA)
+		return -ENOTSUPP;
+
+	debounce = pinconf_to_config_argument(config);
+
+	return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, debounce);
+}
+
+static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
+{
+	struct gpio_chip *chip = &hw->chip;
+	int ret;
+
+	chip->label		= PINCTRL_PINCTRL_DEV;
+	chip->parent		= hw->dev;
+	chip->request		= gpiochip_generic_request;
+	chip->free		= gpiochip_generic_free;
+	chip->get_direction	= mtk_gpio_get_direction;
+	chip->direction_input	= mtk_gpio_direction_input;
+	chip->direction_output	= mtk_gpio_direction_output;
+	chip->get		= mtk_gpio_get;
+	chip->set		= mtk_gpio_set;
+	chip->set_config	= mtk_gpio_set_config,
+	chip->base		= -1;
+	chip->ngpio		= hw->soc->npins;
+	chip->of_node		= np;
+	chip->of_gpio_n_cells	= 2;
+
+	ret = gpiochip_add_data(chip, hw);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mtk_pctrl_build_state(struct platform_device *pdev)
+{
+	struct mtk_pinctrl *hw = platform_get_drvdata(pdev);
+	int i;
+
+	/* Allocate groups */
+	hw->groups = devm_kmalloc_array(&pdev->dev, hw->soc->ngrps,
+					sizeof(*hw->groups), GFP_KERNEL);
+	if (!hw->groups)
+		return -ENOMEM;
+
+	/* We assume that one pin is one group, use pin name as group name. */
+	hw->grp_names = devm_kmalloc_array(&pdev->dev, hw->soc->ngrps,
+					   sizeof(*hw->grp_names), GFP_KERNEL);
+	if (!hw->grp_names)
+		return -ENOMEM;
+
+	for (i = 0; i < hw->soc->npins; i++) {
+		const struct mtk_pin_desc *pin = hw->soc->pins + i;
+		struct mtk_pinctrl_group *group = hw->groups + i;
+
+		group->name = pin->name;
+		group->pin = pin->number;
+
+		hw->grp_names[i] = pin->name;
+	}
+
+	return 0;
+}
+
+int mtk_paris_pinctrl_probe(struct platform_device *pdev,
+			    const struct mtk_pin_soc *soc)
+{
+	struct pinctrl_pin_desc *pins;
+	struct mtk_pinctrl *hw;
+	struct resource *res;
+	int err, i;
+
+	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hw);
+	hw->soc = soc;
+	hw->dev = &pdev->dev;
+
+	if (!hw->soc->nbase_names) {
+		dev_err(&pdev->dev,
+			"SoC should be assigned at least one register base\n");
+		return -EINVAL;
+	}
+
+	hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
+				      sizeof(*hw->base), GFP_KERNEL);
+	if (IS_ERR(hw->base))
+		return PTR_ERR(hw->base);
+
+	for (i = 0; i < hw->soc->nbase_names; i++) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   hw->soc->base_names[i]);
+		if (!res) {
+			dev_err(&pdev->dev, "missing IO resource\n");
+			return -ENXIO;
+		}
+
+		hw->base[i] = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(hw->base[i]))
+			return PTR_ERR(hw->base[i]);
+	}
+
+	hw->nbase = hw->soc->nbase_names;
+
+	err = mtk_pctrl_build_state(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "build state failed: %d\n", err);
+		return -EINVAL;
+	}
+
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
+	/* Setup pins descriptions per SoC types */
+	mtk_desc.pins = (const struct pinctrl_pin_desc *)pins;
+	mtk_desc.npins = hw->soc->npins;
+	mtk_desc.num_custom_params = ARRAY_SIZE(mtk_custom_bindings);
+	mtk_desc.custom_params = mtk_custom_bindings;
+#ifdef CONFIG_DEBUG_FS
+	mtk_desc.custom_conf_items = mtk_conf_items;
+#endif
+
+	err = devm_pinctrl_register_and_init(&pdev->dev, &mtk_desc, hw,
+					     &hw->pctrl);
+	if (err)
+		return err;
+
+	err = pinctrl_enable(hw->pctrl);
+	if (err)
+		return err;
+
+	/* Build gpiochip should be after pinctrl_enable is done */
+	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
+		return err;
+	}
+
+	platform_set_drvdata(pdev, hw);
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.h b/drivers/pinctrl/mediatek/pinctrl-paris.h
new file mode 100644
index 0000000..e4d204e
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *	   Zhiyong Tao <zhiyong.tao@mediatek.com>
+ *	   Hongzhou.Yang <hongzhou.yang@mediatek.com>
+ */
+#ifndef __PINCTRL_PARIS_H
+#define __PINCTRL_PARIS_H
+
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinctrl-utils.h"
+#include "../pinmux.h"
+#include "mtk-eint.h"
+#include "pinctrl-mtk-common-v2.h"
+
+#define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
+
+#define MTK_EINT_FUNCTION(_eintmux, _eintnum)				\
+	{							\
+		.eint_m = _eintmux,					\
+		.eint_n = _eintnum,					\
+	}
+
+#define MTK_FUNCTION(_val, _name)				\
+	{							\
+		.muxval = _val,					\
+		.name = _name,					\
+	}
+
+#define MTK_PIN(_number, _name, _eint, _drv_n, ...) {	\
+		.number = _number,			\
+		.name = _name,				\
+		.eint = _eint,				\
+		.drv_n = _drv_n,			\
+		.funcs = (struct mtk_func_desc[]){	\
+			__VA_ARGS__, { } },				\
+	}
+
+#define PINCTRL_PIN_GROUP(name, id)			\
+	{						\
+		name,					\
+		id##_pins,				\
+		ARRAY_SIZE(id##_pins),			\
+		id##_funcs,				\
+	}
+
+int mtk_paris_pinctrl_probe(struct platform_device *pdev,
+			    const struct mtk_pin_soc *soc);
+
+#endif /* __PINCTRL_PARIS_H */
-- 
2.7.4

