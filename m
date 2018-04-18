Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeDRKYT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:24:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55504 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753473AbeDRKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:24:17 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@google.com>
Subject: [RESEND PATCH v5 6/7] mfd: cros_ec_i2c: add ACPI module device table
Date: Wed, 18 Apr 2018 12:24:03 +0200
Message-Id: <20180418102405.17790-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418102405.17790-1-enric.balletbo@collabora.com>
References: <20180418102405.17790-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei-Ning Huang <wnhuang@google.com>

Add ACPI module device table for matching cros-ec devices to load the
cros_ec_i2c driver automatically.

Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v5: None
Changes in v4:
- [7/8] Add Acked-by Lee Jones
- [7/8] Remove comma in terminator.

Changes in v3:
- [7/8] Add the Reviewed-by Andy Shevchenko.
- [7/8] Avoid commas in terminator entries.

Changes in v2:
- [7/8] Add the Reviewed-by Gwendal.

 drivers/mfd/cros_ec_dev.c |  2 +-
 drivers/mfd/cros_ec_i2c.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 1f889523885d..1d6dc5c7a19d 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -482,7 +482,7 @@ static void ec_device_shutdown(struct platform_device *pdev)
 
 static const struct platform_device_id cros_ec_id[] = {
 	{ DRV_NAME, 0 },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, cros_ec_id);
 
diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
index 9f70de1e4c70..02a7bacdc056 100644
--- a/drivers/mfd/cros_ec_i2c.c
+++ b/drivers/mfd/cros_ec_i2c.c
@@ -13,6 +13,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -344,11 +345,13 @@ static int cros_ec_i2c_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_ec_i2c_pm_ops, cros_ec_i2c_suspend,
 			  cros_ec_i2c_resume);
 
+#ifdef CONFIG_OF
 static const struct of_device_id cros_ec_i2c_of_match[] = {
 	{ .compatible = "google,cros-ec-i2c", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
+#endif
 
 static const struct i2c_device_id cros_ec_i2c_id[] = {
 	{ "cros-ec-i2c", 0 },
@@ -356,9 +359,18 @@ static const struct i2c_device_id cros_ec_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cros_ec_i2c_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cros_ec_i2c_acpi_id[] = {
+	{ "GOOG0008", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_acpi_id);
+#endif
+
 static struct i2c_driver cros_ec_driver = {
 	.driver	= {
 		.name	= "cros-ec-i2c",
+		.acpi_match_table = ACPI_PTR(cros_ec_i2c_acpi_id),
 		.of_match_table = of_match_ptr(cros_ec_i2c_of_match),
 		.pm	= &cros_ec_i2c_pm_ops,
 	},
-- 
2.17.0
