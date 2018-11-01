Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC511C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8100D20664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Ri7E5TzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8100D20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeKAJNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:13:12 -0400
Received: from onstation.org ([52.200.56.107]:44756 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbeKAJMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:12:42 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id BB9ADB12;
        Thu,  1 Nov 2018 00:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541031132;
        bh=nd62Lix9kepB8HvNJdVZyApb/XrXmBdkuO7lgcPCO9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ri7E5TzMG3eRtJzt7IqOTkMgRTmZffohvRy2N2PHKkYczWc/xuanaqXtiAnty0XQw
         blbd4D3eaJYB7Zb9GWzLO4lZ4zSFjHn5M95cRC+S/U6byFmH7CB+wEwFp/ci3jJfAg
         o4+ENdGDS/tVyZ4SKQzdUZSCxdxFdsM/gICBDu7c=
From:   Brian Masney <masneyb@onstation.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        jonathan@marek.ca, masneyb@onstation.org
Subject: [PATCH v2 4/7] power: supply: bq24190_charger: add extcon support for USB OTG
Date:   Wed, 31 Oct 2018 20:11:46 -0400
Message-Id: <20181101001149.13453-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extcon support so that we can notify USB drivers of cable state
changes. Based on work from Jonathan Marek. USB OTG was tested on a LG
Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/power/supply/bq24190_charger.c | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 9e7f3e33458a..4e64e6ac95c5 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -21,6 +21,7 @@
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/extcon-provider.h>
 
 #define	BQ24190_MANUFACTURER	"Texas Instruments"
 
@@ -159,6 +160,7 @@
 struct bq24190_dev_info {
 	struct i2c_client		*client;
 	struct device			*dev;
+	struct extcon_dev		*edev;
 	struct power_supply		*charger;
 	struct power_supply		*battery;
 	struct delayed_work		input_current_limit_work;
@@ -174,6 +176,11 @@ struct bq24190_dev_info {
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
@@ -1528,6 +1535,20 @@ static const struct power_supply_desc bq24190_battery_desc = {
 	.property_is_writeable	= bq24190_battery_property_is_writeable,
 };
 
+static int bq24190_configure_usb_otg(struct bq24190_dev_info *bdi, u8 ss_reg)
+{
+	bool otg_enabled;
+	int ret;
+
+	otg_enabled = !!(ss_reg & BQ24190_REG_SS_VBUS_STAT_MASK);
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
@@ -1597,8 +1618,10 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 		bdi->ss_reg = ss_reg;
 	}
 
-	if (alert_charger || alert_battery)
+	if (alert_charger || alert_battery) {
 		power_supply_changed(bdi->charger);
+		bq24190_configure_usb_otg(bdi, ss_reg);
+	}
 	if (alert_battery && bdi->battery)
 		power_supply_changed(bdi->battery);
 
@@ -1732,6 +1755,14 @@ static int bq24190_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
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
@@ -1778,6 +1809,10 @@ static int bq24190_probe(struct i2c_client *client,
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
2.17.2

