Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbeBSWkw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:40:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932163AbeBSWkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:40:51 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: groeck@chromium.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Vincent Palatin <vpalatin@chromium.org>
Subject: [PATCH 2/6] mfd: cros_ec: free IRQ automatically
Date: Mon, 19 Feb 2018 23:40:43 +0100
Message-Id: <20180219224043.21383-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Palatin <vpalatin@chromium.org>

Free the IRQ we might have requested when removing the cros_ec device,
so we can unload and reload the driver properly.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/cros_ec.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 74780f2964a1..d1a4fbee9380 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -119,9 +119,9 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	}
 
 	if (ec_dev->irq) {
-		err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   "chromeos-ec", ec_dev);
+		err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
+				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				"chromeos-ec", ec_dev);
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d",
 				ec_dev->irq, err);
@@ -135,7 +135,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		dev_err(dev,
 			"Failed to register Embedded Controller subdevice %d\n",
 			err);
-		goto fail_mfd;
+		return err;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -153,7 +153,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 			dev_err(dev,
 				"Failed to register Power Delivery subdevice %d\n",
 				err);
-			goto fail_mfd;
+			return err;
 		}
 	}
 
@@ -162,7 +162,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (err) {
 			mfd_remove_devices(dev);
 			dev_err(dev, "Failed to register sub-devices\n");
-			goto fail_mfd;
+			return err;
 		}
 	}
 
@@ -180,11 +180,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	cros_ec_acpi_install_gpe_handler(dev);
 
 	return 0;
-
-fail_mfd:
-	if (ec_dev->irq)
-		free_irq(ec_dev->irq, ec_dev);
-	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
 
-- 
2.16.1
