Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01806C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B356E20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B356E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeIHPxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28557 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbeIHPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:15 -0400
X-UUID: b10a3526a0ae461e9717a3773eb9978d-20180908
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1054470295; Sat, 08 Sep 2018 19:07:42 +0800
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
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 15/22] pinctrl: mediatek: adjust error code and message when some register not supported is found
Date:   Sat, 8 Sep 2018 19:07:31 +0800
Message-ID: <2873ce93abf93d31a160c7dcbf5b3ff42c5e3886.1536404280.git.sean.wang@mediatek.com>
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

It's usual and not an error for there's some register not supported by a
certain SoC or a pin so that in the case we have to adjust the message to
print and the error code to get rid of unnecessary false alarm.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 35 ++++++++++++------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 18a3548..7cdd46f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -61,12 +61,21 @@ void mtk_rmw(struct mtk_pinctrl *pctl, u8 i, u32 reg, u32 mask, u32 set)
 
 static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
 				   const struct mtk_pin_desc *desc,
-				   const struct mtk_pin_reg_calc *rc,
-				   struct mtk_pin_field *pfd)
+				   int field, struct mtk_pin_field *pfd)
 {
 	const struct mtk_pin_field_calc *c, *e;
+	const struct mtk_pin_reg_calc *rc;
 	u32 bits;
 
+	if (hw->soc->reg_cal && hw->soc->reg_cal[field].range) {
+		rc = &hw->soc->reg_cal[field];
+	} else {
+		dev_dbg(hw->dev,
+			"Not support field %d for pin %d (%s)\n",
+			field, desc->number, desc->name);
+		return -ENOTSUPP;
+	}
+
 	c = rc->range;
 	e = c + rc->nranges;
 
@@ -77,14 +86,15 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
 	}
 
 	if (c >= e) {
-		dev_err(hw->dev, "Out of range for pin = %d (%s)\n",
-			desc->number, desc->name);
-		return -EINVAL;
+		dev_dbg(hw->dev, "Not support field %d for pin = %d (%s)\n",
+			field, desc->number, desc->name);
+		return -ENOTSUPP;
 	}
 
 	if (c->i_base > hw->nbase - 1) {
-		dev_err(hw->dev, "Invalid base is found for pin = %d (%s)\n",
-			desc->number, desc->name);
+		dev_err(hw->dev,
+			"Invalid base for field %d for pin = %d (%s)\n",
+			field, desc->number, desc->name);
 		return -EINVAL;
 	}
 
@@ -116,21 +126,12 @@ static int mtk_hw_pin_field_get(struct mtk_pinctrl *hw,
 				const struct mtk_pin_desc *desc,
 				int field, struct mtk_pin_field *pfd)
 {
-	const struct mtk_pin_reg_calc *rc;
-
 	if (field < 0 || field >= PINCTRL_PIN_REG_MAX) {
 		dev_err(hw->dev, "Invalid Field %d\n", field);
 		return -EINVAL;
 	}
 
-	if (hw->soc->reg_cal && hw->soc->reg_cal[field].range) {
-		rc = &hw->soc->reg_cal[field];
-	} else {
-		dev_err(hw->dev, "Undefined range for field %d\n", field);
-		return -EINVAL;
-	}
-
-	return mtk_hw_pin_field_lookup(hw, desc, rc, pfd);
+	return mtk_hw_pin_field_lookup(hw, desc, field, pfd);
 }
 
 static void mtk_hw_bits_part(struct mtk_pin_field *pf, int *h, int *l)
-- 
2.7.4

