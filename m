Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F45AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459C20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0459C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeIHPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38749 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726796AbeIHPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:20 -0400
X-UUID: 39da40fc9e774d5a9c986a6569122268-20180908
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 808543917; Sat, 08 Sep 2018 19:07:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:43 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 22/22] pinctrl: mediatek: add eint support to MT8183 pinctrl driver
Date:   Sat, 8 Sep 2018 19:07:38 +0800
Message-ID: <17745498577a9d4492deee861d71a135de5b8473.1536404280.git.sean.wang@mediatek.com>
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

Just add eint support to MT8183 pinctrl driver as usual as
happens on the other SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8183.c |  8 ++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.c  | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index 9d5aa27..6262fd3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -492,11 +492,19 @@ static const char * const mt8183_pinctrl_register_base_names[] = {
 	"iocfg6", "iocfg7", "iocfg8",
 };
 
+static const struct mtk_eint_hw mt8183_eint_hw = {
+	.port_mask = 7,
+	.ports     = 6,
+	.ap_num    = 212,
+	.db_cnt    = 13,
+};
+
 static const struct mtk_pin_soc mt8183_data = {
 	.reg_cal = mt8183_reg_cals,
 	.pins = mtk_pins_mt8183,
 	.npins = ARRAY_SIZE(mtk_pins_mt8183),
 	.ngrps = ARRAY_SIZE(mtk_pins_mt8183),
+	.eint_hw = &mt8183_eint_hw,
 	.gpio_m = 0,
 	.ies_present = true,
 	.base_names = mt8183_pinctrl_register_base_names,
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 50d6893..9f4224f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -718,6 +718,22 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 	return pinctrl_gpio_direction_output(chip->base + gpio);
 }
 
+static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
+
+	if (!hw->eint)
+		return -ENOTSUPP;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
+
+	if (desc->eint.eint_n == EINT_NA)
+		return -ENOTSUPP;
+
+	return mtk_eint_find_irq(hw->eint, desc->eint.eint_n);
+}
+
 static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 			       unsigned long config)
 {
@@ -751,6 +767,7 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 	chip->direction_output	= mtk_gpio_direction_output;
 	chip->get		= mtk_gpio_get;
 	chip->set		= mtk_gpio_set;
+	chip->to_irq		= mtk_gpio_to_irq,
 	chip->set_config	= mtk_gpio_set_config,
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
@@ -871,6 +888,11 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 	if (err)
 		return err;
 
+	err = mtk_build_eint(hw, pdev);
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Failed to add EINT, but pinctrl still can work\n");
+
 	/* Build gpiochip should be after pinctrl_enable is done */
 	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
 	if (err) {
-- 
2.7.4

