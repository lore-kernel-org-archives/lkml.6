Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeCVMfN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:35:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40844 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeCVMfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:35:10 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] pinctrl: ocelot: fix gpio direction
Date: Thu, 22 Mar 2018 13:35:00 +0100
Message-Id: <20180322123500.2379-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bits have to be cleared in DEVCPU_GCB:GPIO:GPIO_OE for input and set for
output. ocelot_gpio_set_direction() got it wrong and this went unnoticed
when the driver was reworked.

Reported-by: Gregory Clement <gregory.clement@bootlin.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index a9423238471e..b5b3547fdcb2 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -252,7 +252,7 @@ static int ocelot_gpio_set_direction(struct pinctrl_dev *pctldev,
 	struct ocelot_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 
 	regmap_update_bits(info->map, OCELOT_GPIO_OE, BIT(pin),
-			   input ? BIT(pin) : 0);
+			   input ? 0 : BIT(pin));
 
 	return 0;
 }
-- 
2.16.2
