Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeBWPHP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:07:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37276 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeBWPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:06:17 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, Vincent Palatin <vpalatin@chromium.org>
Subject: [PATCH v2 2/8] mfd: cros_ec: free IRQ automatically
Date: Fri, 23 Feb 2018 16:05:59 +0100
Message-Id: <20180223150605.10417-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223150605.10417-1-enric.balletbo@collabora.com>
References: <20180223150605.10417-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Palatin <vpalatin@chromium.org>

Free the IRQ we might have requested when removing the cros_ec device,
so we can unload and reload the driver properly.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

---

Changes in v2:
- [2/8] Remove the free_irq in cros_ec_remove.

 drivers/mfd/cros_ec.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 74780f2964a1..ea8aa704b61e 100644
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
 
@@ -194,9 +189,6 @@ int cros_ec_remove(struct cros_ec_device *ec_dev)
 
 	cros_ec_acpi_remove_gpe_handler();
 
-	if (ec_dev->irq)
-		free_irq(ec_dev->irq, ec_dev);
-
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_remove);
-- 
2.16.1
