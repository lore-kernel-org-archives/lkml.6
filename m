Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47694ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCD320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCD320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbeGTN1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:27:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbeGTN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:27:39 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 09771CC2;
        Fri, 20 Jul 2018 12:36:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.17 006/101] pinctrl: mt7622: stop using the deprecated pinctrl_add_gpio_range
Date:   Fri, 20 Jul 2018 14:13:12 +0200
Message-Id: <20180720121423.156839140@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit de227ed7965d06dcfcd06376e03c107004a4881c upstream.

If the pinctrl node has the gpio-ranges property, the range will be added
by the gpio core and doesn't need to be added by the pinctrl driver.

But for keeping backward compatibility, an explicit pinctrl_add_gpio_range
is still needed to be called when there is a missing gpio-ranges in pinctrl
node in old dts files.

Cc: stable@vger.kernel.org
Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1463,11 +1463,20 @@ static int mtk_build_gpiochip(struct mtk
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


