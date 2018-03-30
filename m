Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeC3M6h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:58:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57722 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeC3M6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:58:35 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv6 2/2] mfd: motorola-cpcap: Add audio-codec support
Date: Fri, 30 Mar 2018 14:58:24 +0200
Message-Id: <20180330125824.21418-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
References: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sre@kernel.org>

Add support for the audio-codec node by converting from
devm_of_platform_populate() to devm_mfd_add_devices().

Tested-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/motorola-cpcap.c | 51 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index d2cc1eabac05..f6c79a4ccb55 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 
+#include <linux/mfd/core.h>
 #include <linux/mfd/motorola-cpcap.h>
 #include <linux/spi/spi.h>
 
@@ -216,6 +217,53 @@ static const struct regmap_config cpcap_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
+static const struct mfd_cell cpcap_mfd_devices[] = {
+	{
+		.name          = "cpcap_adc",
+		.of_compatible = "motorola,mapphone-cpcap-adc",
+	}, {
+		.name          = "cpcap_battery",
+		.of_compatible = "motorola,cpcap-battery",
+	}, {
+		.name          = "cpcap-charger",
+		.of_compatible = "motorola,mapphone-cpcap-charger",
+	}, {
+		.name          = "cpcap-regulator",
+		.of_compatible = "motorola,mapphone-cpcap-regulator",
+	}, {
+		.name          = "cpcap-rtc",
+		.of_compatible = "motorola,cpcap-rtc",
+	}, {
+		.name          = "cpcap-pwrbutton",
+		.of_compatible = "motorola,cpcap-pwrbutton",
+	}, {
+		.name          = "cpcap-usb-phy",
+		.of_compatible = "motorola,mapphone-cpcap-usb-phy",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 0,
+		.of_compatible = "motorola,cpcap-led-red",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 1,
+		.of_compatible = "motorola,cpcap-led-green",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 2,
+		.of_compatible = "motorola,cpcap-led-blue",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 3,
+		.of_compatible = "motorola,cpcap-led-adl",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 4,
+		.of_compatible = "motorola,cpcap-led-cp",
+	}, {
+		.name          = "cpcap-codec",
+	}
+};
+
 static int cpcap_probe(struct spi_device *spi)
 {
 	const struct of_device_id *match;
@@ -260,7 +308,8 @@ static int cpcap_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_of_platform_populate(&cpcap->spi->dev);
+	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
+				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
 }
 
 static struct spi_driver cpcap_driver = {
-- 
2.16.2
