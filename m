Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3476C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680AF20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680AF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeLMBjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:39:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55534 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeLMBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:39:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E728A263A23
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] power: supply: isp1704: switch to gpiod API
Date:   Thu, 13 Dec 2018 02:38:58 +0100
Message-Id: <20181213013858.23996-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This migrates isp1704 driver from old GPIO API to new descriptor
based GPIO API and drops useless platform data as a side-effect.

Migration is simple, since all mainline users are DT based and
DT API does not change. Out of tree users of the platform data
need to migrate to gpiod_lookup_table as described here:

Documentation/driver-api/gpio/board.rst

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Patch has been tested on Nokia N900.
---
 drivers/power/supply/isp1704_charger.c | 60 ++++++--------------------
 include/linux/power/isp1704_charger.h  | 30 -------------
 2 files changed, 12 insertions(+), 78 deletions(-)
 delete mode 100644 include/linux/power/isp1704_charger.h

diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
index 95af5f305838..a63cb5dcfa08 100644
--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -30,13 +30,12 @@
 #include <linux/power_supply.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
+#include <linux/gpio/consumer.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/power/isp1704_charger.h>
 
 /* Vendor specific Power Control register */
 #define ISP1704_PWR_CTRL		0x3d
@@ -60,6 +59,7 @@ struct isp1704_charger {
 	struct device			*dev;
 	struct power_supply		*psy;
 	struct power_supply_desc	psy_desc;
+	struct gpio_desc		*enable_gpio;
 	struct usb_phy			*phy;
 	struct notifier_block		nb;
 	struct work_struct		work;
@@ -81,18 +81,9 @@ static inline int isp1704_write(struct isp1704_charger *isp, u32 reg, u32 val)
 	return usb_phy_io_write(isp->phy, val, reg);
 }
 
-/*
- * Disable/enable the power from the isp1704 if a function for it
- * has been provided with platform data.
- */
 static void isp1704_charger_set_power(struct isp1704_charger *isp, bool on)
 {
-	struct isp1704_charger_data	*board = isp->dev->platform_data;
-
-	if (board && board->set_power)
-		board->set_power(on);
-	else if (board)
-		gpio_set_value(board->enable_gpio, on);
+	gpiod_set_value(isp->enable_gpio, on);
 }
 
 /*
@@ -405,46 +396,19 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 	int			ret = -ENODEV;
 	struct power_supply_config psy_cfg = {};
 
-	struct isp1704_charger_data *pdata = dev_get_platdata(&pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
-
-	if (np) {
-		int gpio = of_get_named_gpio(np, "nxp,enable-gpio", 0);
-
-		if (gpio < 0) {
-			dev_err(&pdev->dev, "missing DT GPIO nxp,enable-gpio\n");
-			return gpio;
-		}
-
-		pdata = devm_kzalloc(&pdev->dev,
-			sizeof(struct isp1704_charger_data), GFP_KERNEL);
-		if (!pdata) {
-			ret = -ENOMEM;
-			goto fail0;
-		}
-		pdata->enable_gpio = gpio;
-
-		dev_info(&pdev->dev, "init gpio %d\n", pdata->enable_gpio);
-
-		ret = devm_gpio_request_one(&pdev->dev, pdata->enable_gpio,
-					GPIOF_OUT_INIT_HIGH, "isp1704_reset");
-		if (ret) {
-			dev_err(&pdev->dev, "gpio request failed\n");
-			goto fail0;
-		}
-	}
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform data!\n");
-		return -ENODEV;
-	}
-
-
 	isp = devm_kzalloc(&pdev->dev, sizeof(*isp), GFP_KERNEL);
 	if (!isp)
 		return -ENOMEM;
 
-	if (np)
+	isp->enable_gpio = devm_gpiod_get(&pdev->dev, "nxp,enable",
+					  GPIOD_OUT_HIGH);
+	if (IS_ERR(isp->enable_gpio)) {
+		ret = PTR_ERR(isp->enable_gpio);
+		dev_err(&pdev->dev, "Could not get reset gpio: %d\n", ret);
+		return ret;
+	}
+
+	if (pdev->dev.of_node)
 		isp->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
 	else
 		isp->phy = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
diff --git a/include/linux/power/isp1704_charger.h b/include/linux/power/isp1704_charger.h
deleted file mode 100644
index 0105d9e7af85..000000000000
--- a/include/linux/power/isp1704_charger.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * ISP1704 USB Charger Detection driver
- *
- * Copyright (C) 2011 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-
-#ifndef __ISP1704_CHARGER_H
-#define __ISP1704_CHARGER_H
-
-struct isp1704_charger_data {
-	void		(*set_power)(bool on);
-	int		enable_gpio;
-};
-
-#endif
-- 
2.19.2

