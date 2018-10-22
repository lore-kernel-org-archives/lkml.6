Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2E4C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB882083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EYWWMnoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB882083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJVQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:27:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45506 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJVQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:27:43 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9M8AAoa023122;
        Mon, 22 Oct 2018 03:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540195810;
        bh=QFBZ1vwLwKJK8YI/2D8b0CJEYACFJ2eppJuzOQ4EtYY=;
        h=From:To:CC:Subject:Date;
        b=EYWWMnohRNQF1tVzPf3eUEREe97Dfbz1jQ9w9CJmFEkYHIlS91pHIxzSZ3yFTmsTy
         yKSzcJfbpg4AZcGx4qhfElawgPrUm0RZXjrpojKEDR5MGJ89CRNFX4Qdkgbp0oWncz
         9l7MaihI9m4a246nw7b4kflfFBv2pz5nwjeQiqr4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9M8AA46005660;
        Mon, 22 Oct 2018 03:10:10 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 22
 Oct 2018 03:10:07 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 22 Oct 2018 03:10:07 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9M8A4o7022959;
        Mon, 22 Oct 2018 03:10:05 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <lee.jones@linaro.org>, <jingoohan1@gmail.com>,
        <daniel.thompson@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] backlight: gpio-backlight: Correct initial power state handling
Date:   Mon, 22 Oct 2018 11:11:09 +0300
Message-ID: <20181022081109.21456-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default-on property - or the def_value via legacy pdata) should be
handled as:
if it is 1, the backlight must be enabled (kept enabled)
if it is 0, the backlight must be disabled (kept disabled)

This only works for the case when default-on is set. If it is not set then
the brightness of the backlight is set to 0. Now if the backlight is
enabled by external driver (graphics) the backlight will stay disabled since
the brightness is configured as 0. The backlight will not turn on.

In order to minimize screen flickering during device boot:

The initial brightness should be set to 1.

If booted in non DT mode or no phandle link to the backlight node:
follow the def_value/default-on to select UNBLANK or POWERDOWN

If in DT boot we have phandle link then leave the GPIO in a state which the
bootloader left it and let the user of the backlight to configure it
further.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v1:
- Implement similiar initial power state handling as pwm backlight have

Regards,
Peter

 drivers/video/backlight/gpio_backlight.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e470da95d806..51c49f03ed83 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -62,13 +62,11 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	enum gpiod_flags flags;
 	int ret;
 
 	gbl->def_value = of_property_read_bool(np, "default-on");
-	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
-	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
+	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
 	if (IS_ERR(gbl->gpiod)) {
 		ret = PTR_ERR(gbl->gpiod);
 
@@ -82,6 +80,22 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
+{
+	struct device_node *node = gbl->dev->of_node;
+
+	/* Not booted with device tree or no phandle link to the node */
+	if (!node || !node->phandle)
+		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+
+	/* if the enable GPIO is disabled, do not enable the backlight */
+	if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
+		return FB_BLANK_POWERDOWN;
+
+	return FB_BLANK_UNBLANK;
+}
+
+
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
 	struct gpio_backlight_platform_data *pdata =
@@ -142,7 +156,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.power = gpio_backlight_initial_power_state(gbl);
+	bl->props.brightness = 1;
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

