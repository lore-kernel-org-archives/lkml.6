Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C9C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC2020844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC2020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeIHPxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38749 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726663AbeIHPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:18 -0400
X-UUID: e8e674beba094a489f1601b8155f8e2d-20180908
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1905449658; Sat, 08 Sep 2018 19:07:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:41 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 13/22] pinctrl: mediatek: use pin descriptor all in pinctrl-mtk-common-v2.c
Date:   Sat, 8 Sep 2018 19:07:29 +0800
Message-ID: <f7d9fa1721c8d75509682a20c014ceb461495f1c.1536404280.git.sean.wang@mediatek.com>
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

all use pin descriptor instead in pinctrl-mtk-common-v2.c for the
consistency and extensibility.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 66 +++++++++++++-------
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 76 +++++++++++++-----------
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  6 +-
 3 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 219cfce..2f3e3b5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -54,9 +54,13 @@ static int mtk_pinmux_set_mux(struct pinctrl_dev *pctldev,
 		func->name, grp->name);
 
 	for (i = 0; i < grp->num_pins; i++) {
+		const struct mtk_pin_desc *desc;
 		int *pin_modes = grp->data;
+		int pin = grp->pins[i];
 
-		mtk_hw_set_value(hw, grp->pins[i], PINCTRL_PIN_REG_MODE,
+		desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
+
+		mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE,
 				 pin_modes[i]);
 	}
 
@@ -68,8 +72,12 @@ static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
 					  unsigned int pin)
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	const struct mtk_pin_desc *desc;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
-	return mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_MODE, hw->soc->gpio_m);
+	return mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE,
+				hw->soc->gpio_m);
 }
 
 static int mtk_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
@@ -77,9 +85,12 @@ static int mtk_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 					 unsigned int pin, bool input)
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	const struct mtk_pin_desc *desc;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
 	/* hardware would take 0 as input direction */
-	return mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR, !input);
+	return mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR, !input);
 }
 
 static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
@@ -121,7 +132,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		}
 		break;
 	case PIN_CONFIG_SLEW_RATE:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_SR, &val);
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SR, &val);
 		if (err)
 			return err;
 
@@ -131,7 +142,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_DIR, &val);
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &val);
 		if (err)
 			return err;
 
@@ -142,11 +153,11 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 
 		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_DIR, &val);
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &val);
 		if (err)
 			return err;
 
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_SMT, &val2);
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SMT, &val2);
 		if (err)
 			return err;
 
@@ -168,7 +179,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
 		       PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
 
-		err = mtk_hw_get_value(hw, pin, reg, &val);
+		err = mtk_hw_get_value(hw, desc, reg, &val);
 		if (err)
 			return err;
 
@@ -240,12 +251,12 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			}
 			break;
 		case PIN_CONFIG_OUTPUT_ENABLE:
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SMT,
+			err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
 					       MTK_DISABLE);
 			if (err)
 				goto err;
 
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
+			err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 					       MTK_OUTPUT);
 			if (err)
 				goto err;
@@ -253,29 +264,29 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PIN_CONFIG_INPUT_ENABLE:
 
 			if (hw->soc->ies_present) {
-				mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_IES,
+				mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES,
 						 MTK_ENABLE);
 			}
 
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
+			err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 					       MTK_INPUT);
 			if (err)
 				goto err;
 			break;
 		case PIN_CONFIG_SLEW_RATE:
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SR,
+			err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SR,
 					       arg);
 			if (err)
 				goto err;
 
 			break;
 		case PIN_CONFIG_OUTPUT:
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
+			err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 					       MTK_OUTPUT);
 			if (err)
 				goto err;
 
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DO,
+			err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DO,
 					       arg);
 			if (err)
 				goto err;
@@ -285,12 +296,12 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			 * arg = 0: Output mode & SMT disable
 			 */
 			arg = arg ? 2 : 1;
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
+			err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 					       arg & 1);
 			if (err)
 				goto err;
 
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SMT,
+			err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
 					       !!(arg & 2));
 			if (err)
 				goto err;
@@ -309,7 +320,7 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			reg = (param == MTK_PIN_CONFIG_TDSEL) ?
 			       PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
 
-			err = mtk_hw_set_value(hw, pin, reg, arg);
+			err = mtk_hw_set_value(hw, desc, reg, arg);
 			if (err)
 				goto err;
 			break;
@@ -419,9 +430,12 @@ static struct pinctrl_desc mtk_desc = {
 static int mtk_gpio_get(struct gpio_chip *chip, unsigned int gpio)
 {
 	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
 	int value, err;
 
-	err = mtk_hw_get_value(hw, gpio, PINCTRL_PIN_REG_DI, &value);
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio];
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DI, &value);
 	if (err)
 		return err;
 
@@ -431,8 +445,11 @@ static int mtk_gpio_get(struct gpio_chip *chip, unsigned int gpio)
 static void mtk_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
 {
 	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
 
-	mtk_hw_set_value(hw, gpio, PINCTRL_PIN_REG_DO, !!value);
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio];
+
+	mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DO, !!value);
 }
 
 static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
@@ -620,6 +637,7 @@ static int mtk_xt_get_gpio_state(void *data, unsigned long eint_n)
 static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
 {
 	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	const struct mtk_pin_desc *desc;
 	struct gpio_chip *gpio_chip;
 	unsigned int gpio_n;
 	int err;
@@ -628,16 +646,18 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
 	if (err)
 		return err;
 
-	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_MODE,
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio_n];
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE,
 			       hw->soc->eint_m);
 	if (err)
 		return err;
 
-	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_DIR, MTK_INPUT);
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR, MTK_INPUT);
 	if (err)
 		return err;
 
-	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
 	if (err)
 		return err;
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 86eefe8..ed88b96 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -59,7 +59,8 @@ void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set)
 	mtk_w32(pctl, reg, val);
 }
 
-static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw, int pin,
+static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
+				   const struct mtk_pin_desc *desc,
 				   const struct mtk_pin_reg_calc *rc,
 				   struct mtk_pin_field *pfd)
 {
@@ -70,13 +71,14 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw, int pin,
 	e = c + rc->nranges;
 
 	while (c < e) {
-		if (pin >= c->s_pin && pin <= c->e_pin)
+		if (desc->number >= c->s_pin && desc->number <= c->e_pin)
 			break;
 		c++;
 	}
 
 	if (c >= e) {
-		dev_err(hw->dev, "Out of range for pin = %d\n", pin);
+		dev_err(hw->dev, "Out of range for pin = %d (%s)\n",
+			desc->number, desc->name);
 		return -EINVAL;
 	}
 
@@ -84,7 +86,8 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw, int pin,
 	 * if c->fixed is held, that determines the all the pins in the
 	 * range use the same field with the s_pin.
 	 */
-	bits = c->fixed ? c->s_bit : c->s_bit + (pin - c->s_pin) * (c->x_bits);
+	bits = c->fixed ? c->s_bit : c->s_bit +
+	       (desc->number - c->s_pin) * (c->x_bits);
 
 	/* Fill pfd from bits. For example 32-bit register applied is assumed
 	 * when c->sz_reg is equal to 32.
@@ -102,7 +105,8 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw, int pin,
 	return 0;
 }
 
-static int mtk_hw_pin_field_get(struct mtk_pinctrl *hw, int pin,
+static int mtk_hw_pin_field_get(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
 				int field, struct mtk_pin_field *pfd)
 {
 	const struct mtk_pin_reg_calc *rc;
@@ -119,7 +123,7 @@ static int mtk_hw_pin_field_get(struct mtk_pinctrl *hw, int pin,
 		return -EINVAL;
 	}
 
-	return mtk_hw_pin_field_lookup(hw, pin, rc, pfd);
+	return mtk_hw_pin_field_lookup(hw, desc, rc, pfd);
 }
 
 static void mtk_hw_bits_part(struct mtk_pin_field *pf, int *h, int *l)
@@ -155,12 +159,13 @@ static void mtk_hw_read_cross_field(struct mtk_pinctrl *hw,
 	*value = (h << nbits_l) | l;
 }
 
-int mtk_hw_set_value(struct mtk_pinctrl *hw, int pin, int field, int value)
+int mtk_hw_set_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
+		     int field, int value)
 {
 	struct mtk_pin_field pf;
 	int err;
 
-	err = mtk_hw_pin_field_get(hw, pin, field, &pf);
+	err = mtk_hw_pin_field_get(hw, desc, field, &pf);
 	if (err)
 		return err;
 
@@ -173,12 +178,13 @@ int mtk_hw_set_value(struct mtk_pinctrl *hw, int pin, int field, int value)
 	return 0;
 }
 
-int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value)
+int mtk_hw_get_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
+		     int field, int *value)
 {
 	struct mtk_pin_field pf;
 	int err;
 
-	err = mtk_hw_pin_field_get(hw, pin, field, &pf);
+	err = mtk_hw_pin_field_get(hw, desc, field, &pf);
 	if (err)
 		return err;
 
@@ -196,12 +202,12 @@ int mtk_pinconf_bias_disable_set(struct mtk_pinctrl *hw,
 {
 	int err;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PU,
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PU,
 			       MTK_DISABLE);
 	if (err)
 		return err;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PD,
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PD,
 			       MTK_DISABLE);
 	if (err)
 		return err;
@@ -215,11 +221,11 @@ int mtk_pinconf_bias_disable_get(struct mtk_pinctrl *hw,
 	int v, v2;
 	int err;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PU, &v);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PU, &v);
 	if (err)
 		return err;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PD, &v2);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PD, &v2);
 	if (err)
 		return err;
 
@@ -238,11 +244,11 @@ int mtk_pinconf_bias_set(struct mtk_pinctrl *hw,
 
 	arg = pullup ? 1 : 2;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PU, arg & 1);
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PU, arg & 1);
 	if (err)
 		return err;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PD,
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PD,
 			       !!(arg & 2));
 	if (err)
 		return err;
@@ -257,7 +263,7 @@ int mtk_pinconf_bias_get(struct mtk_pinctrl *hw,
 
 	reg = pullup ? PINCTRL_PIN_REG_PU : PINCTRL_PIN_REG_PD;
 
-	err = mtk_hw_get_value(hw, desc->number, reg, &v);
+	err = mtk_hw_get_value(hw, desc, reg, &v);
 	if (err)
 		return err;
 
@@ -275,7 +281,7 @@ int mtk_pinconf_bias_disable_set_rev1(struct mtk_pinctrl *hw,
 {
 	int err;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PULLEN,
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PULLEN,
 			       MTK_DISABLE);
 	if (err)
 		return err;
@@ -288,7 +294,7 @@ int mtk_pinconf_bias_disable_get_rev1(struct mtk_pinctrl *hw,
 {
 	int v, err;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PULLEN, &v);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PULLEN, &v);
 	if (err)
 		return err;
 
@@ -307,12 +313,12 @@ int mtk_pinconf_bias_set_rev1(struct mtk_pinctrl *hw,
 
 	arg = pullup ? MTK_PULLUP : MTK_PULLDOWN;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PULLEN,
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PULLEN,
 			       MTK_ENABLE);
 	if (err)
 		return err;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PULLSEL, arg);
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PULLSEL, arg);
 	if (err)
 		return err;
 
@@ -325,14 +331,14 @@ int mtk_pinconf_bias_get_rev1(struct mtk_pinctrl *hw,
 {
 	int err, v;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PULLEN, &v);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PULLEN, &v);
 	if (err)
 		return err;
 
 	if (v == MTK_DISABLE)
 		return -EINVAL;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PULLSEL, &v);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PULLSEL, &v);
 	if (err)
 		return err;
 
@@ -359,12 +365,12 @@ int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 	 */
 	if ((arg >= tb->min && arg <= tb->max) && !(arg % tb->step)) {
 		arg = (arg / tb->step - 1) * tb->scal;
-		err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_E4,
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_E4,
 				       arg & 0x1);
 		if (err)
 			return err;
 
-		err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_E8,
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_E8,
 				       (arg & 0x2) >> 1);
 		if (err)
 			return err;
@@ -381,11 +387,11 @@ int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
 
 	tb = &mtk_drive[desc->drv_n];
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_E4, &val1);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_E4, &val1);
 	if (err)
 		return err;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_E8, &val2);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_E8, &val2);
 	if (err)
 		return err;
 
@@ -409,7 +415,7 @@ int mtk_pinconf_drive_set_rev1(struct mtk_pinctrl *hw,
 	if ((arg >= tb->min && arg <= tb->max) && !(arg % tb->step)) {
 		arg = (arg / tb->step - 1) * tb->scal;
 
-		err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_DRV,
+		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV,
 				       arg);
 		if (err)
 			return err;
@@ -426,7 +432,7 @@ int mtk_pinconf_drive_get_rev1(struct mtk_pinctrl *hw,
 
 	tb = &mtk_drive[desc->drv_n];
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_DRV, &val1);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV, &val1);
 	if (err)
 		return err;
 
@@ -446,18 +452,18 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
 	 * 10K on & 50K (75K) off, when (R0, R1) = (1, 0);
 	 * 10K on & 50K (75K) on, when (R0, R1) = (1, 1)
 	 */
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_R0, arg & 1);
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_R0, arg & 1);
 	if (err)
 		return 0;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_R1,
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_R1,
 			       !!(arg & 2));
 	if (err)
 		return 0;
 
 	arg = pullup ? 0 : 1;
 
-	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PUPD, arg);
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PUPD, arg);
 
 	return err;
 }
@@ -469,7 +475,7 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
 	u32 t, t2;
 	int err;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PUPD, &t);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PUPD, &t);
 	if (err)
 		return err;
 
@@ -477,11 +483,11 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
 	if (pullup ^ !t)
 		return -EINVAL;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_R0, &t);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_R0, &t);
 	if (err)
 		return err;
 
-	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_R1, &t2);
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_R1, &t2);
 	if (err)
 		return err;
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index d90788b..6e66bdc 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -192,8 +192,10 @@ struct mtk_pinctrl {
 
 void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set);
 
-int mtk_hw_set_value(struct mtk_pinctrl *hw, int pin, int field, int value);
-int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value);
+int mtk_hw_set_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
+		     int field, int value);
+int mtk_hw_get_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
+		     int field, int *value);
 
 int mtk_pinconf_bias_disable_set(struct mtk_pinctrl *hw,
 				 const struct mtk_pin_desc *desc);
-- 
2.7.4

