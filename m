Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFCCECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF5D2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF5D2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbeIREoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:44:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732501AbeIREoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:44:17 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 15993C49;
        Mon, 17 Sep 2018 23:14:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 114/158] gpio: pxa: disable pinctrl calls for PXA3xx
Date:   Tue, 18 Sep 2018 00:42:24 +0200
Message-Id: <20180917211716.522304221@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit 9dabfdd84bdfa25f0df486dd3de43e53e79a1892 ]

The pxa3xx driver uses the pinctrl-single driver since a while which
does not implement a .gpio_set_direction() callback. The pinmux core
will simply return 0 in this case, and the pxa3xx gpio driver hence
believes the pinctrl driver did its job and returns as well.

This effectively makes pxa_gpio_direction_{input,output} no-ops.

To fix this, do not call into the pinctrl subsystem for the PXA3xx
platform for now. We can revert this once the pinctrl-single driver
learned to support setting pin directions.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-pxa.c |   35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -241,6 +241,17 @@ int pxa_irq_to_gpio(int irq)
 	return irq_gpio0;
 }
 
+static bool pxa_gpio_has_pinctrl(void)
+{
+	switch (gpio_type) {
+	case PXA3XX_GPIO:
+		return false;
+
+	default:
+		return true;
+	}
+}
+
 static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct pxa_gpio_chip *pchip = chip_to_pxachip(chip);
@@ -255,9 +266,11 @@ static int pxa_gpio_direction_input(stru
 	unsigned long flags;
 	int ret;
 
-	ret = pinctrl_gpio_direction_input(chip->base + offset);
-	if (!ret)
-		return 0;
+	if (pxa_gpio_has_pinctrl()) {
+		ret = pinctrl_gpio_direction_input(chip->base + offset);
+		if (!ret)
+			return 0;
+	}
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
@@ -282,9 +295,11 @@ static int pxa_gpio_direction_output(str
 
 	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
 
-	ret = pinctrl_gpio_direction_output(chip->base + offset);
-	if (ret)
-		return ret;
+	if (pxa_gpio_has_pinctrl()) {
+		ret = pinctrl_gpio_direction_output(chip->base + offset);
+		if (ret)
+			return ret;
+	}
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
@@ -348,8 +363,12 @@ static int pxa_init_gpio_chip(struct pxa
 	pchip->chip.set = pxa_gpio_set;
 	pchip->chip.to_irq = pxa_gpio_to_irq;
 	pchip->chip.ngpio = ngpio;
-	pchip->chip.request = gpiochip_generic_request;
-	pchip->chip.free = gpiochip_generic_free;
+
+	if (pxa_gpio_has_pinctrl()) {
+		pchip->chip.request = gpiochip_generic_request;
+		pchip->chip.free = gpiochip_generic_free;
+	}
+
 #ifdef CONFIG_OF_GPIO
 	pchip->chip.of_node = np;
 	pchip->chip.of_xlate = pxa_gpio_of_xlate;


