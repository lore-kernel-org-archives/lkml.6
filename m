Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0CAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E4723CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E4723CAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934441AbeFVDtd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:49:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64946 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934377AbeFVDt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:49:28 -0400
X-UUID: 48cfe840b6ac4993a8378577cfd6023a-20180622
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 695077034; Fri, 22 Jun 2018 11:49:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 22 Jun 2018 11:49:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 22 Jun 2018 11:49:15 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH 4/7] pinctrl: mt7622: stop using the deprecated pinctrl_add_gpio_range
Date:   Fri, 22 Jun 2018 11:49:07 +0800
Message-ID: <098100772163e54fe5ca49576042edbfaf3807a5.1529639050.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

If the pinctrl node has the gpio-ranges property, the range will be added
by the gpio core and doesn't need to be added by the pinctrl driver.

But for keeping backward compatibility, an explicit pinctrl_add_gpio_range
is still needed to be called when there is a missing gpio-ranges in pinctrl
node in old dts files.

Cc: stable@vger.kernel.org
Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 42155d4..055074bb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1508,11 +1508,20 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 	if (ret < 0)
 		return ret;
 
-	ret = gpiochip_add_pin_range(chip, dev_name(hw->dev), 0, 0,
-				     chip->ngpio);
-	if (ret < 0) {
-		gpiochip_remove(chip);
-		return ret;
+	/* Just for backward compatible for these old pinctrl nodes without
+	 * "gpio-ranges" property. Otherwise, called directly from a
+	 * DeviceTree-supported pinctrl driver is DEPRECATED.
+	 * Please see Section 2.1 of
+	 * Documentation/devicetree/bindings/gpio/gpio.txt on how to
+	 * bind pinctrl and gpio drivers via the "gpio-ranges" property.
+	 */
+	if (!of_find_property(np, "gpio-ranges", NULL)) {
+		ret = gpiochip_add_pin_range(chip, dev_name(hw->dev), 0, 0,
+					     chip->ngpio);
+		if (ret < 0) {
+			gpiochip_remove(chip);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.7.4

