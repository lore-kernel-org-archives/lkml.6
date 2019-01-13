Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370DAC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028E721734
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfAMJ5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:57:46 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:56580 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfAMJ5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:57:42 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id E6D645FD20; Sun, 13 Jan 2019 17:57:36 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] pinctrl: sunxi: Fix and simplify pin bank regulator handling
Date:   Sun, 13 Jan 2019 17:57:22 +0800
Message-Id: <20190113095723.25295-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new per-pin-bank regulator handling code in the sunxi pinctrl driver
has mismatched conditions for enabling and disabling the regulator: it
is enabled each time a pin is requested, but only disabled when the
pin-bank's reference count reaches zero.

Since we are doing reference counting already, there's no need to enable
the regulator each time a pin is requested. Instead we can just do it
for the first requested pin of each pin-bank. Thus we can reverse the
test and bail out early if it's not the first occurrence.

Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:

  - Moved before the other fix. Both fixes are needed, but having this
    one first made reworking the other one easier.

---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 36 ++++++++++++---------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 5d9184d18c16..9ad6e9c2adab 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -699,25 +699,21 @@ static int sunxi_pmx_request(struct pinctrl_dev *pctldev, unsigned offset)
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	unsigned short bank = offset / PINS_PER_BANK;
 	struct sunxi_pinctrl_regulator *s_reg = &pctl->regulators[bank];
-	struct regulator *reg;
+	struct regulator *reg = s_reg->regulator;
+	char supply[16];
 	int ret;
 
-	reg = s_reg->regulator;
-	if (!reg) {
-		char supply[16];
-
-		snprintf(supply, sizeof(supply), "vcc-p%c", 'a' + bank);
-		reg = regulator_get(pctl->dev, supply);
-		if (IS_ERR(reg)) {
-			dev_err(pctl->dev, "Couldn't get bank P%c regulator\n",
-				'A' + bank);
-			return PTR_ERR(reg);
-		}
-
-		s_reg->regulator = reg;
-		refcount_set(&s_reg->refcount, 1);
-	} else {
+	if (reg) {
 		refcount_inc(&s_reg->refcount);
+		return 0;
+	}
+
+	snprintf(supply, sizeof(supply), "vcc-p%c", 'a' + bank);
+	reg = regulator_get(pctl->dev, supply);
+	if (IS_ERR(reg)) {
+		dev_err(pctl->dev, "Couldn't get bank P%c regulator\n",
+			'A' + bank);
+		return PTR_ERR(reg);
 	}
 
 	ret = regulator_enable(reg);
@@ -727,13 +723,13 @@ static int sunxi_pmx_request(struct pinctrl_dev *pctldev, unsigned offset)
 		goto out;
 	}
 
+	s_reg->regulator = reg;
+	refcount_set(&s_reg->refcount, 1);
+
 	return 0;
 
 out:
-	if (refcount_dec_and_test(&s_reg->refcount)) {
-		regulator_put(s_reg->regulator);
-		s_reg->regulator = NULL;
-	}
+	regulator_put(s_reg->regulator);
 
 	return ret;
 }
-- 
2.20.1

