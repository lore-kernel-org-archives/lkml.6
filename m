Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A46C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C8620844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C8620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeIHPxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18326 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbeIHPxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:16 -0400
X-UUID: 9770e4b3961844c69eed72b1d0fb2018-20180908
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1952870122; Sat, 08 Sep 2018 19:07:42 +0800
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
Subject: [PATCH v2 14/22] pinctrl: mediatek: add multiple register bases support to pinctrl-mtk-common-v2.c
Date:   Sat, 8 Sep 2018 19:07:30 +0800
Message-ID: <8c4a741e7ed695d85844a1a550b956d767661b44.1536404280.git.sean.wang@mediatek.com>
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

Certain SoC own multiple register base for accessing each pin groups,
it's easy to be done with extend struct mtk_pin_field_calc to support
the kind of SoC such as MT8183.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 30 +++++++++++++++-----
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        |  2 ++
 drivers/pinctrl/mediatek/pinctrl-mt7623.c        | 16 ++++++-----
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 36 +++++++++++++++---------
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 24 ++++++++++++----
 5 files changed, 75 insertions(+), 33 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 2f3e3b5..2817e47 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -713,25 +713,41 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 {
 	struct resource *res;
 	struct mtk_pinctrl *hw;
-	int err;
+	int err, i;
 
 	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
 	if (!hw)
 		return -ENOMEM;
 
 	hw->soc = soc;
+	hw->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "missing IO resource\n");
-		return -ENXIO;
+	if (!hw->soc->nbase_names) {
+		dev_err(&pdev->dev,
+			"SoC should be assigned at least one register base\n");
+		return -EINVAL;
 	}
 
-	hw->dev = &pdev->dev;
-	hw->base = devm_ioremap_resource(&pdev->dev, res);
+	hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
+				      sizeof(*hw->base), GFP_KERNEL);
 	if (IS_ERR(hw->base))
 		return PTR_ERR(hw->base);
 
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
 	/* Setup pins descriptions per SoC types */
 	mtk_desc.pins = (const struct pinctrl_pin_desc *)hw->soc->pins;
 	mtk_desc.npins = hw->soc->npins;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 9ac36ab..769b36a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -768,6 +768,8 @@ static const struct mtk_pin_soc mt7622_data = {
 	.gpio_m	= 1,
 	.eint_m = 1,
 	.ies_present = false,
+	.base_names = mtk_default_register_base_names,
+	.nbase_names = ARRAY_SIZE(mtk_default_register_base_names),
 	.bias_disable_set = mtk_pinconf_bias_disable_set,
 	.bias_disable_get = mtk_pinconf_bias_disable_get,
 	.bias_set = mtk_pinconf_bias_set,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7623.c b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
index 30d2289..1f2030c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7623.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
@@ -18,15 +18,15 @@
 #define BOND_MSDC0E_CLR		0x1
 
 #define PIN_FIELD15(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
-	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, 0, _s_addr, _x_addrs, _s_bit,	\
 		       _x_bits, 15, false)
 
 #define PIN_FIELD16(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
-	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, 0, _s_addr, _x_addrs, _s_bit,	\
 		       _x_bits, 16, 0)
 
-#define PINS_FIELD16(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)\
-	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
+#define PINS_FIELD16(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, 0, _s_addr, _x_addrs, _s_bit,	\
 		       _x_bits, 16, 1)
 
 #define MT7623_PIN(_number, _name, _eint_n, _drv_grp)			\
@@ -1383,6 +1383,8 @@ static struct mtk_pin_soc mt7623_data = {
 	.gpio_m = 0,
 	.eint_m = 0,
 	.ies_present = true,
+	.base_names = mtk_default_register_base_names,
+	.nbase_names = ARRAY_SIZE(mtk_default_register_base_names),
 	.bias_disable_set = mtk_pinconf_bias_disable_set_rev1,
 	.bias_disable_get = mtk_pinconf_bias_disable_get_rev1,
 	.bias_set = mtk_pinconf_bias_set_rev1,
@@ -1402,9 +1404,9 @@ static void mt7623_bonding_disable(struct platform_device *pdev)
 {
 	struct mtk_pinctrl *hw = platform_get_drvdata(pdev);
 
-	mtk_rmw(hw, PIN_BOND_REG0, BOND_PCIE_CLR, BOND_PCIE_CLR);
-	mtk_rmw(hw, PIN_BOND_REG1, BOND_I2S_CLR, BOND_I2S_CLR);
-	mtk_rmw(hw, PIN_BOND_REG2, BOND_MSDC0E_CLR, BOND_MSDC0E_CLR);
+	mtk_rmw(hw, 0, PIN_BOND_REG0, BOND_PCIE_CLR, BOND_PCIE_CLR);
+	mtk_rmw(hw, 0, PIN_BOND_REG1, BOND_I2S_CLR, BOND_I2S_CLR);
+	mtk_rmw(hw, 0, PIN_BOND_REG2, BOND_MSDC0E_CLR, BOND_MSDC0E_CLR);
 }
 
 static const struct of_device_id mt7623_pctrl_match[] = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index ed88b96..18a3548 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -39,24 +39,24 @@ const struct mtk_drive_desc mtk_drive[] = {
 	[DRV_GRP4] = { 2, 16, 2, 1 },
 };
 
-static void mtk_w32(struct mtk_pinctrl *pctl, u32 reg, u32 val)
+static void mtk_w32(struct mtk_pinctrl *pctl, u8 i, u32 reg, u32 val)
 {
-	writel_relaxed(val, pctl->base + reg);
+	writel_relaxed(val, pctl->base[i] + reg);
 }
 
-static u32 mtk_r32(struct mtk_pinctrl *pctl, u32 reg)
+static u32 mtk_r32(struct mtk_pinctrl *pctl, u8 i, u32 reg)
 {
-	return readl_relaxed(pctl->base + reg);
+	return readl_relaxed(pctl->base[i] + reg);
 }
 
-void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set)
+void mtk_rmw(struct mtk_pinctrl *pctl, u8 i, u32 reg, u32 mask, u32 set)
 {
 	u32 val;
 
-	val = mtk_r32(pctl, reg);
+	val = mtk_r32(pctl, i, reg);
 	val &= ~mask;
 	val |= set;
-	mtk_w32(pctl, reg, val);
+	mtk_w32(pctl, i, reg, val);
 }
 
 static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
@@ -82,6 +82,12 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
 		return -EINVAL;
 	}
 
+	if (c->i_base > hw->nbase - 1) {
+		dev_err(hw->dev, "Invalid base is found for pin = %d (%s)\n",
+			desc->number, desc->name);
+		return -EINVAL;
+	}
+
 	/* Calculated bits as the overall offset the pin is located at,
 	 * if c->fixed is held, that determines the all the pins in the
 	 * range use the same field with the s_pin.
@@ -92,6 +98,7 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
 	/* Fill pfd from bits. For example 32-bit register applied is assumed
 	 * when c->sz_reg is equal to 32.
 	 */
+	pfd->index = c->i_base;
 	pfd->offset = c->s_addr + c->x_addrs * (bits / c->sz_reg);
 	pfd->bitpos = bits % c->sz_reg;
 	pfd->mask = (1 << c->x_bits) - 1;
@@ -139,10 +146,10 @@ static void mtk_hw_write_cross_field(struct mtk_pinctrl *hw,
 
 	mtk_hw_bits_part(pf, &nbits_h, &nbits_l);
 
-	mtk_rmw(hw, pf->offset, pf->mask << pf->bitpos,
+	mtk_rmw(hw, pf->index, pf->offset, pf->mask << pf->bitpos,
 		(value & pf->mask) << pf->bitpos);
 
-	mtk_rmw(hw, pf->offset + pf->next, BIT(nbits_h) - 1,
+	mtk_rmw(hw, pf->index, pf->offset + pf->next, BIT(nbits_h) - 1,
 		(value & pf->mask) >> nbits_l);
 }
 
@@ -153,8 +160,10 @@ static void mtk_hw_read_cross_field(struct mtk_pinctrl *hw,
 
 	mtk_hw_bits_part(pf, &nbits_h, &nbits_l);
 
-	l  = (mtk_r32(hw, pf->offset) >> pf->bitpos) & (BIT(nbits_l) - 1);
-	h  = (mtk_r32(hw, pf->offset + pf->next)) & (BIT(nbits_h) - 1);
+	l  = (mtk_r32(hw, pf->index, pf->offset)
+	      >> pf->bitpos) & (BIT(nbits_l) - 1);
+	h  = (mtk_r32(hw, pf->index, pf->offset + pf->next))
+	      & (BIT(nbits_h) - 1);
 
 	*value = (h << nbits_l) | l;
 }
@@ -170,7 +179,7 @@ int mtk_hw_set_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
 		return err;
 
 	if (!pf.next)
-		mtk_rmw(hw, pf.offset, pf.mask << pf.bitpos,
+		mtk_rmw(hw, pf.index, pf.offset, pf.mask << pf.bitpos,
 			(value & pf.mask) << pf.bitpos);
 	else
 		mtk_hw_write_cross_field(hw, &pf, value);
@@ -189,7 +198,8 @@ int mtk_hw_get_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
 		return err;
 
 	if (!pf.next)
-		*value = (mtk_r32(hw, pf.offset) >> pf.bitpos) & pf.mask;
+		*value = (mtk_r32(hw, pf.index, pf.offset)
+			  >> pf.bitpos) & pf.mask;
 	else
 		mtk_hw_read_cross_field(hw, &pf, value);
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 6e66bdc..040c6b7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -18,10 +18,11 @@
 
 #define EINT_NA	-1
 
-#define PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
-			_x_bits, _sz_reg, _fixed) {			\
+#define PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs,      \
+		       _s_bit, _x_bits, _sz_reg, _fixed) {		\
 		.s_pin = _s_pin,					\
 		.e_pin = _e_pin,					\
+		.i_base = _i_base,					\
 		.s_addr = _s_addr,					\
 		.x_addrs = _x_addrs,					\
 		.s_bit = _s_bit,					\
@@ -31,11 +32,11 @@
 	}
 
 #define PIN_FIELD(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
-	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, 0, _s_addr, _x_addrs, _s_bit,	\
 		       _x_bits, 32, 0)
 
 #define PINS_FIELD(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
-	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, 0, _s_addr, _x_addrs, _s_bit,	\
 		       _x_bits, 32, 1)
 
 /* List these attributes which could be modified for the pin */
@@ -73,8 +74,13 @@ enum {
 	DRV_GRP_MAX,
 };
 
+static const char * const mtk_default_register_base_names[] = {
+	"base",
+};
+
 /* struct mtk_pin_field - the structure that holds the information of the field
  *			  used to describe the attribute for the pin
+ * @base:		the index pointing to the entry in base address list
  * @offset:		the register offset relative to the base address
  * @mask:		the mask used to filter out the field from the register
  * @bitpos:		the start bit relative to the register
@@ -82,6 +88,7 @@ enum {
 			next register
  */
 struct mtk_pin_field {
+	u8  index;
 	u32 offset;
 	u32 mask;
 	u8  bitpos;
@@ -92,6 +99,7 @@ struct mtk_pin_field {
  *			       the guide used to look up the relevant field
  * @s_pin:		the start pin within the range
  * @e_pin:		the end pin within the range
+ * @i_base:		the index pointing to the entry in base address list
  * @s_addr:		the start address for the range
  * @x_addrs:		the address distance between two consecutive registers
  *			within the range
@@ -105,6 +113,7 @@ struct mtk_pin_field {
 struct mtk_pin_field_calc {
 	u16 s_pin;
 	u16 e_pin;
+	u8  i_base;
 	u32 s_addr;
 	u8  x_addrs;
 	u8  s_bit;
@@ -157,6 +166,8 @@ struct mtk_pin_soc {
 	u8				gpio_m;
 	u8				eint_m;
 	bool				ies_present;
+	const char * const		*base_names;
+	unsigned int			nbase_names;
 
 	/* Specific pinconfig operations */
 	int (*bias_disable_set)(struct mtk_pinctrl *hw,
@@ -183,14 +194,15 @@ struct mtk_pin_soc {
 
 struct mtk_pinctrl {
 	struct pinctrl_dev		*pctrl;
-	void __iomem			*base;
+	void __iomem			**base;
+	u8				nbase;
 	struct device			*dev;
 	struct gpio_chip		chip;
 	const struct mtk_pin_soc        *soc;
 	struct mtk_eint			*eint;
 };
 
-void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set);
+void mtk_rmw(struct mtk_pinctrl *pctl, u8 i, u32 reg, u32 mask, u32 set);
 
 int mtk_hw_set_value(struct mtk_pinctrl *hw, const struct mtk_pin_desc *desc,
 		     int field, int value);
-- 
2.7.4

