Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeCTPwF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:52:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeCTPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:51:35 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org, bleung@chromium.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v3 1/6] platform/chrome: cros_ec_sysfs: Modify error handling
Date: Tue, 20 Mar 2018 16:51:20 +0100
Message-Id: <20180320155125.3046-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320155125.3046-1-enric.balletbo@collabora.com>
References: <20180320155125.3046-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

When accessing a sysfs attribute, if the EC command fails, -EPROTO is
now returned instead of an error message as it is unlikely an app is
parsing the error message to do something meaningful.
Also, this patch makes use of cros_ec_cmd_xfer_status() instead of
cros_ec_cmd_xfer() so an error message is printed in the syslog.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/platform/chrome/cros_ec_sysfs.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index da0a719d32f7..c03621e523a3 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -114,15 +114,9 @@ static ssize_t store_ec_reboot(struct device *dev,
 	msg->command = EC_CMD_REBOOT_EC + ec->cmd_offset;
 	msg->outsize = sizeof(*param);
 	msg->insize = 0;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0) {
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0)
 		count = ret;
-		goto exit;
-	}
-	if (msg->result != EC_RES_SUCCESS) {
-		dev_dbg(ec->dev, "EC result %d\n", msg->result);
-		count = -EINVAL;
-	}
 exit:
 	kfree(msg);
 	return count;
@@ -150,17 +144,11 @@ static ssize_t show_ec_version(struct device *dev,
 	msg->command = EC_CMD_GET_VERSION + ec->cmd_offset;
 	msg->insize = sizeof(*r_ver);
 	msg->outsize = 0;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0) {
 		count = ret;
 		goto exit;
 	}
-	if (msg->result != EC_RES_SUCCESS) {
-		count = scnprintf(buf, PAGE_SIZE,
-				  "ERROR: EC returned %d\n", msg->result);
-		goto exit;
-	}
-
 	r_ver = (struct ec_response_get_version *)msg->data;
 	/* Strings should be null-terminated, but let's be sure. */
 	r_ver->version_string_ro[sizeof(r_ver->version_string_ro) - 1] = '\0';
@@ -255,14 +243,9 @@ static ssize_t show_ec_flashinfo(struct device *dev,
 	msg->command = EC_CMD_FLASH_INFO + ec->cmd_offset;
 	msg->insize = sizeof(*resp);
 	msg->outsize = 0;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0)
 		goto exit;
-	if (msg->result != EC_RES_SUCCESS) {
-		ret = scnprintf(buf, PAGE_SIZE,
-				"ERROR: EC returned %d\n", msg->result);
-		goto exit;
-	}
 
 	resp = (struct ec_response_flash_info *)msg->data;
 
-- 
2.16.2
