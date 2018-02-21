Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933749AbeBURIk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:08:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55634 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754140AbeBURIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:08:01 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shawn Nematbakhsh <shawnn@chromium.org>
Subject: [PATCH v2 5/6] platform/chrome: cros_ec_debugfs: Add PD port info to debugfs
Date: Wed, 21 Feb 2018 18:07:47 +0100
Message-Id: <20180221170748.27505-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221170748.27505-1-enric.balletbo@collabora.com>
References: <20180221170748.27505-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Nematbakhsh <shawnn@chromium.org>

Add info useful for debugging USB-PD port state.

Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
- Drop unrelated changes. Suggested by Andy Shevchenko.

 drivers/platform/chrome/cros_ec_debugfs.c | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 8be739b7385b..c62ee8e610a0 100644
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
-- 
2.16.1
