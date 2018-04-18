Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753747AbeDRKYd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:24:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55528 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbeDRKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:24:17 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Daniel Hung-yu Wu <hywu@google.com>,
        Daniel Hung-yu Wu <hywu@chromium.org>
Subject: [RESEND PATCH v5 5/7] mfd: cros_ec_dev: register shutdown function for debugfs
Date: Wed, 18 Apr 2018 12:24:02 +0200
Message-Id: <20180418102405.17790-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418102405.17790-1-enric.balletbo@collabora.com>
References: <20180418102405.17790-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Hung-yu Wu <hywu@google.com>

Reboot or shutdown during delayed works could corrupt communication with
EC and certain I2C controller may not be able to recover from the error
state.

This patch registers a shutdown callback used to cancel the debugfs log
worker thread.

Signed-off-by: Daniel Hung-yu Wu <hywu@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v5: None
Changes in v4:
- [6/8] Add Acked-by Lee Jones.

Changes in v3:
- [6/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [6/8] This patch is new in this series.

 drivers/mfd/cros_ec_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a393b3c11aa0..1f889523885d 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -472,6 +472,14 @@ static int ec_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void ec_device_shutdown(struct platform_device *pdev)
+{
+	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
+
+	/* Be sure to clear up debugfs delayed works */
+	cros_ec_debugfs_remove(ec);
+}
+
 static const struct platform_device_id cros_ec_id[] = {
 	{ DRV_NAME, 0 },
 	{ /* sentinel */ },
@@ -514,6 +522,7 @@ static struct platform_driver cros_ec_dev_driver = {
 	},
 	.probe = ec_device_probe,
 	.remove = ec_device_remove,
+	.shutdown = ec_device_shutdown,
 };
 
 static int __init cros_ec_dev_init(void)
-- 
2.17.0
