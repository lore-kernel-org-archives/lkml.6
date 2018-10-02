Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B8BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4708A2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4708A2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeJBUtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:49:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbeJBUMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:18 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 546A1266;
        Tue,  2 Oct 2018 13:28:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 131/228] gpio: tegra: Fix tegra_gpio_irq_set_type()
Date:   Tue,  2 Oct 2018 06:23:48 -0700
Message-Id: <20181002132508.286221852@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit f78709a5d4114edc21a5d86586ed5e56e284f2bd ]

Commit 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
broke tegra_gpio_irq_set_type() because requesting of GPIO direction must
be done after enabling GPIO function for a pin.

This patch fixes drivers probe failure like this:

 gpio gpiochip0: (tegra-gpio): gpiochip_lock_as_irq: cannot get GPIO direction
 tegra-gpio 6000d000.gpio: unable to lock Tegra GPIO 144 as IRQ

Fixes: 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-tegra.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -323,13 +323,6 @@ static int tegra_gpio_irq_set_type(struc
 		return -EINVAL;
 	}
 
-	ret = gpiochip_lock_as_irq(&tgi->gc, gpio);
-	if (ret) {
-		dev_err(tgi->dev,
-			"unable to lock Tegra GPIO %u as IRQ\n", gpio);
-		return ret;
-	}
-
 	spin_lock_irqsave(&bank->lvl_lock[port], flags);
 
 	val = tegra_gpio_readl(tgi, GPIO_INT_LVL(tgi, gpio));
@@ -342,6 +335,14 @@ static int tegra_gpio_irq_set_type(struc
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, gpio), gpio, 0);
 	tegra_gpio_enable(tgi, gpio);
 
+	ret = gpiochip_lock_as_irq(&tgi->gc, gpio);
+	if (ret) {
+		dev_err(tgi->dev,
+			"unable to lock Tegra GPIO %u as IRQ\n", gpio);
+		tegra_gpio_disable(tgi, gpio);
+		return ret;
+	}
+
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		irq_set_handler_locked(d, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))


