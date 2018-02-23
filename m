Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBWPMi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:12:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37318 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeBWPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:11:32 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, Daniel Hung-yu Wu <hywu@google.com>,
        Daniel Hung-yu Wu <hywu@chromium.org>
Subject: [PATCH v2 6/8] mfd: cros_ec_dev: register shutdown function for debugfs
Date: Fri, 23 Feb 2018 16:11:20 +0100
Message-Id: <20180223151122.11567-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223151122.11567-1-enric.balletbo@collabora.com>
References: <20180223151122.11567-1-enric.balletbo@collabora.com>
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
---

Changes in v2:
- [6/8] This patch is new in this series.

 drivers/mfd/cros_ec_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index fd7f0068fb45..354eb9e01d52 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -535,6 +535,14 @@ static int ec_device_remove(struct platform_device *pdev)
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
@@ -577,6 +585,7 @@ static struct platform_driver cros_ec_dev_driver = {
 	},
 	.probe = ec_device_probe,
 	.remove = ec_device_remove,
+	.shutdown = ec_device_shutdown,
 };
 
 static int __init cros_ec_dev_init(void)
-- 
2.16.1
