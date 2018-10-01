Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF41C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CA32083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="B3b2H6QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CA32083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeJAMG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:06:29 -0400
Received: from onstation.org ([52.200.56.107]:35968 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbeJAMG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:06:29 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 259DC9B1;
        Mon,  1 Oct 2018 05:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538371829;
        bh=RI7egdljK2E9SPEeP7dn9S1URzissBZNn+epXn6pfGY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=B3b2H6QE4R6CdSanaZXNKF6KqOJbIIs043E4rSMmJbKOh+snVPbnHyaolFXO+DqGY
         xyfwJhUf70RZVSU3B3vwRsJ601M85FhUxn1b4ijedbmIPPnctf5BmtEjwD44SzfzdT
         fl8a9gkljfQqrNGsoJDQ9+/McfLgrxmfg4fMsUN8=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, david.brown@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH RFC 4/5] power: supply: bq24190_charger: add support for extcon and GPIO for USB OTG support
Date:   Mon,  1 Oct 2018 01:30:04 -0400
Message-Id: <20181001053005.18906-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001053005.18906-1-masneyb@onstation.org>
References: <20181001053005.18906-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

Add extcon support so that we can notify USB drivers of cable state
changes. This also adds support for an optional GPIO that is changed
depending on the cable state.

This patch makes the USB OTG work correctly on a LG Nexus 5
(hammerhead) phone.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
[masneyb@onstation.org: Fixed EXTCON cable state and USB networking
when the cable is unplugged and plugged back in, checkpatch cleanups.]
Signed-off-by: Brian Masney <masneyb@onstation.org>
Tested-by: Brian Masney <masneyb@onstation.org>
---
See my cover letter for a question about how I can convert patch #5 over
to use a gpio-hog.

 drivers/power/supply/bq24190_charger.c | 45 +++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 933d1cded697..36348668e48a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -21,6 +21,7 @@
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/extcon-provider.h>
 
 #define	BQ24190_MANUFACTURER	"Texas Instruments"
 
@@ -159,6 +160,8 @@
 struct bq24190_dev_info {
 	struct i2c_client		*client;
 	struct device			*dev;
+	struct extcon_dev		*edev;
+	struct gpio_desc		*gpio_otg;
 	struct power_supply		*charger;
 	struct power_supply		*battery;
 	struct delayed_work		input_current_limit_work;
@@ -174,6 +177,11 @@ struct bq24190_dev_info {
 	u8				watchdog;
 };
 
+static const unsigned int bq24190_usb_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_NONE,
+};
+
 /*
  * The tables below provide a 2-way mapping for the value that goes in
  * the register field and the real-world value that it represents.
@@ -1528,6 +1536,23 @@ static const struct power_supply_desc bq24190_battery_desc = {
 	.property_is_writeable	= bq24190_battery_property_is_writeable,
 };
 
+static int bq24190_configure_usb_otg(struct bq24190_dev_info *bdi, u8 ss_reg)
+{
+	bool otg_enabled;
+	int ret;
+
+	otg_enabled = !!(ss_reg & BQ24190_REG_SS_VBUS_STAT_MASK);
+	if (bdi->gpio_otg)
+		gpiod_set_value_cansleep(bdi->gpio_otg, !otg_enabled);
+
+	ret = extcon_set_state_sync(bdi->edev, EXTCON_USB, otg_enabled);
+	if (ret < 0)
+		dev_err(bdi->dev, "Can't set extcon state to %d: %d\n",
+			otg_enabled, ret);
+
+	return ret;
+}
+
 static void bq24190_check_status(struct bq24190_dev_info *bdi)
 {
 	const u8 battery_mask_ss = BQ24190_REG_SS_CHRG_STAT_MASK;
@@ -1597,8 +1622,10 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 		bdi->ss_reg = ss_reg;
 	}
 
-	if (alert_charger || alert_battery)
+	if (alert_charger || alert_battery) {
 		power_supply_changed(bdi->charger);
+		bq24190_configure_usb_otg(bdi, ss_reg);
+	}
 	if (alert_battery && bdi->battery)
 		power_supply_changed(bdi->battery);
 
@@ -1729,6 +1756,18 @@ static int bq24190_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	bdi->gpio_otg = devm_gpiod_get_optional(dev, "otg-en", GPIOD_OUT_LOW);
+	if (IS_ERR(bdi->gpio_otg))
+		return PTR_ERR(bdi->gpio_otg);
+
+	bdi->edev = devm_extcon_dev_allocate(dev, bq24190_usb_extcon_cable);
+	if (IS_ERR(bdi->edev))
+		return PTR_ERR(bdi->edev);
+
+	ret = devm_extcon_dev_register(dev, bdi->edev);
+	if (ret < 0)
+		return ret;
+
 	pm_runtime_enable(dev);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 600);
@@ -1775,6 +1814,10 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out_charger;
 	}
 
+	ret = bq24190_configure_usb_otg(bdi, bdi->ss_reg);
+	if (ret < 0)
+		goto out_charger;
+
 	ret = bq24190_sysfs_create_group(bdi);
 	if (ret < 0) {
 		dev_err(dev, "Can't create sysfs entries\n");
-- 
2.17.1

