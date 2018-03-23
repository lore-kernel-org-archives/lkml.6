Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeCWRnA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:43:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46986 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeCWRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:42:58 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org, bleung@chromium.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v4 5/6] platform/chrome: cros_ec_debugfs: Add PD port info to debugfs
Date: Fri, 23 Mar 2018 18:42:46 +0100
Message-Id: <20180323174247.6680-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323174247.6680-1-enric.balletbo@collabora.com>
References: <20180323174247.6680-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Nematbakhsh <shawnn@chromium.org>

Add info useful for debugging USB-PD port state.

Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v4: None
Changes in v3:
- [5/6] Add EC_USB_PD_MAX_PORTS define to avoid interdependencies.
- [5/6] Add Reviewed-by Andy Shevchenko

Changes in v2:
- [5/6] Drop unrelated changes.

 drivers/platform/chrome/cros_ec_debugfs.c | 72 +++++++++++++++++++++++++++++++
 include/linux/mfd/cros_ec_commands.h      |  3 ++
 2 files changed, 75 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 539403022568..cc265ed8deb7 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -211,6 +211,58 @@ static int cros_ec_console_log_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static ssize_t cros_ec_pdinfo_read(struct file *file,
+				   char __user *user_buf,
+				   size_t count,
+				   loff_t *ppos)
+{
+	char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
+	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
+	struct {
+		struct cros_ec_command msg;
+		union {
+			struct ec_response_usb_pd_control_v1 resp;
+			struct ec_params_usb_pd_control params;
+		};
+	} __packed ec_buf;
+	struct cros_ec_command *msg;
+	struct ec_response_usb_pd_control_v1 *resp;
+	struct ec_params_usb_pd_control *params;
+	int i;
+
+	msg = &ec_buf.msg;
+	params = (struct ec_params_usb_pd_control *)msg->data;
+	resp = (struct ec_response_usb_pd_control_v1 *)msg->data;
+
+	msg->command = EC_CMD_USB_PD_CONTROL;
+	msg->version = 1;
+	msg->insize = sizeof(*resp);
+	msg->outsize = sizeof(*params);
+
+	/*
+	 * Read status from all PD ports until failure, typically caused
+	 * by attempting to read status on a port that doesn't exist.
+	 */
+	for (i = 0; i < EC_USB_PD_MAX_PORTS; ++i) {
+		params->port = i;
+		params->role = 0;
+		params->mux = 0;
+		params->swap = 0;
+
+		if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0)
+			break;
+
+		p += scnprintf(p, sizeof(read_buf) + read_buf - p,
+			       "p%d: %s en:%.2x role:%.2x pol:%.2x\n", i,
+			       resp->state, resp->enabled, resp->role,
+			       resp->polarity);
+	}
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       read_buf, p - read_buf);
+}
+
 const struct file_operations cros_ec_console_log_fops = {
 	.owner = THIS_MODULE,
 	.open = cros_ec_console_log_open,
@@ -220,6 +272,13 @@ const struct file_operations cros_ec_console_log_fops = {
 	.release = cros_ec_console_log_release,
 };
 
+const struct file_operations cros_ec_pdinfo_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = cros_ec_pdinfo_read,
+	.llseek = default_llseek,
+};
+
 static int ec_read_version_supported(struct cros_ec_dev *ec)
 {
 	struct ec_params_get_cmd_versions_v1 *params;
@@ -355,6 +414,15 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	return ret;
 }
 
+static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
+{
+	if (!debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
+				 &cros_ec_pdinfo_fops))
+		return -ENOMEM;
+
+	return 0;
+}
+
 int cros_ec_debugfs_init(struct cros_ec_dev *ec)
 {
 	struct cros_ec_platform *ec_platform = dev_get_platdata(ec->dev);
@@ -379,6 +447,10 @@ int cros_ec_debugfs_init(struct cros_ec_dev *ec)
 	if (ret)
 		goto remove_debugfs;
 
+	ret = cros_ec_create_pdinfo(debug_info);
+	if (ret)
+		goto remove_debugfs;
+
 	ec->debug_info = debug_info;
 
 	return 0;
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 2b96e630e3b6..f2edd9969b40 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2948,6 +2948,9 @@ struct ec_response_usb_pd_control_v1 {
 
 #define EC_CMD_USB_PD_PORTS 0x102
 
+/* Maximum number of PD ports on a device, num_ports will be <= this */
+#define EC_USB_PD_MAX_PORTS 8
+
 struct ec_response_usb_pd_ports {
 	uint8_t num_ports;
 } __packed;
-- 
2.16.2
