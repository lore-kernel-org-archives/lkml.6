Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EA4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886A020684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886A020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394783AbeKVWNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:13:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54042 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390848AbeKVWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:13:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7AB3227DBE5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/7] mfd: cros_ec: use devm_mfd_add_devices.
Date:   Thu, 22 Nov 2018 12:33:50 +0100
Message-Id: <20181122113356.23610-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122113356.23610-1-enric.balletbo@collabora.com>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_mfd_add_devices() for adding MFD child devices. This reduces
the need of remove callback for removing MFD child devices.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/cros_ec.c                 | 12 ++----------
 drivers/mfd/cros_ec_dev.c             |  8 ++++----
 drivers/platform/chrome/cros_ec_i2c.c | 10 ----------
 drivers/platform/chrome/cros_ec_lpc.c |  4 ----
 drivers/platform/chrome/cros_ec_spi.c | 11 -----------
 5 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index fe6f83766144..5f18e279bfc3 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -129,7 +129,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		}
 	}
 
-	err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell, 1,
+	err = devm_mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell, 1,
 			      NULL, ec_dev->irq, NULL);
 	if (err) {
 		dev_err(dev,
@@ -147,7 +147,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		 * - the EC is responsive at init time (it is not true for a
 		 *   sensor hub.
 		 */
-		err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
+		err = devm_mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
 				      &ec_pd_cell, 1, NULL, ec_dev->irq, NULL);
 		if (err) {
 			dev_err(dev,
@@ -181,14 +181,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 }
 EXPORT_SYMBOL(cros_ec_register);
 
-int cros_ec_remove(struct cros_ec_device *ec_dev)
-{
-	mfd_remove_devices(ec_dev->dev);
-
-	return 0;
-}
-EXPORT_SYMBOL(cros_ec_remove);
-
 #ifdef CONFIG_PM_SLEEP
 int cros_ec_suspend(struct cros_ec_device *ec_dev)
 {
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 8f9d6964173e..3cde77dd17f6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -366,7 +366,7 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 		id++;
 	}
 
-	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
+	ret = devm_mfd_add_devices(ec->dev, 0, sensor_cells, id,
 			      NULL, 0, NULL);
 	if (ret)
 		dev_err(ec->dev, "failed to add EC sensors\n");
@@ -430,7 +430,7 @@ static int ec_device_probe(struct platform_device *pdev)
 
 	/* Check whether this EC instance has CEC host command support */
 	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+		retval = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
 					 cros_ec_cec_cells,
 					 ARRAY_SIZE(cros_ec_cec_cells),
 					 NULL, 0, NULL);
@@ -442,7 +442,7 @@ static int ec_device_probe(struct platform_device *pdev)
 
 	/* Check whether this EC instance has RTC host command support */
 	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+		retval = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
 					 cros_ec_rtc_cells,
 					 ARRAY_SIZE(cros_ec_rtc_cells),
 					 NULL, 0, NULL);
@@ -454,7 +454,7 @@ static int ec_device_probe(struct platform_device *pdev)
 
 	/* Check whether this EC instance has the PD charge manager */
 	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+		retval = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
 					 cros_usbpd_charger_cells,
 					 ARRAY_SIZE(cros_usbpd_charger_cells),
 					 NULL, 0, NULL);
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index ef9b4763356f..9a009eaa4ada 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -317,15 +317,6 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int cros_ec_i2c_remove(struct i2c_client *client)
-{
-	struct cros_ec_device *ec_dev = i2c_get_clientdata(client);
-
-	cros_ec_remove(ec_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int cros_ec_i2c_suspend(struct device *dev)
 {
@@ -376,7 +367,6 @@ static struct i2c_driver cros_ec_driver = {
 		.pm	= &cros_ec_i2c_pm_ops,
 	},
 	.probe		= cros_ec_i2c_probe,
-	.remove		= cros_ec_i2c_remove,
 	.id_table	= cros_ec_i2c_id,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index e1b75775cd4a..14684a56e40f 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -327,7 +327,6 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 
 static int cros_ec_lpc_remove(struct platform_device *pdev)
 {
-	struct cros_ec_device *ec_dev;
 	struct acpi_device *adev;
 
 	adev = ACPI_COMPANION(&pdev->dev);
@@ -335,9 +334,6 @@ static int cros_ec_lpc_remove(struct platform_device *pdev)
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   cros_ec_lpc_acpi_notify);
 
-	ec_dev = platform_get_drvdata(pdev);
-	cros_ec_remove(ec_dev);
-
 	return 0;
 }
 
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 2060d1483043..6cfbc2835beb 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -685,16 +685,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int cros_ec_spi_remove(struct spi_device *spi)
-{
-	struct cros_ec_device *ec_dev;
-
-	ec_dev = spi_get_drvdata(spi);
-	cros_ec_remove(ec_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int cros_ec_spi_suspend(struct device *dev)
 {
@@ -733,7 +723,6 @@ static struct spi_driver cros_ec_driver_spi = {
 		.pm	= &cros_ec_spi_pm_ops,
 	},
 	.probe		= cros_ec_spi_probe,
-	.remove		= cros_ec_spi_remove,
 	.id_table	= cros_ec_spi_id,
 };
 
-- 
2.19.1

