Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeBWPG3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:06:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeBWPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:06:18 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Subject: [PATCH v2 3/8] mfd: cros_ec: Don't try to grab log when suspended
Date: Fri, 23 Feb 2018 16:06:00 +0100
Message-Id: <20180223150605.10417-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223150605.10417-1-enric.balletbo@collabora.com>
References: <20180223150605.10417-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

We should stop our worker thread while we're suspended.  If we don't
then we'll get messages like:

  cros-ec-spi spi5.0: spi transfer failed: -108
  cros-ec-spi spi5.0: cs-deassert spi transfer failed: -108
  cros-ec-ctl cros-ec-ctl.0.auto: EC communication failed

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- [3/8] That patch is new in this series.

 drivers/mfd/cros_ec_dev.c                 |  4 ++++
 drivers/platform/chrome/cros_ec_debugfs.c | 20 ++++++++++++++++++++
 include/linux/mfd/cros_ec.h               |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index e4fafdd96e5e..f98e5beffca6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -471,6 +471,8 @@ static __maybe_unused int ec_device_suspend(struct device *dev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(dev);
 
+	cros_ec_debugfs_suspend(ec);
+
 	lb_suspend(ec);
 
 	return 0;
@@ -480,6 +482,8 @@ static __maybe_unused int ec_device_resume(struct device *dev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(dev);
 
+	cros_ec_debugfs_resume(ec);
+
 	lb_resume(ec);
 
 	return 0;
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 0e88e18362c1..0328856ec3a2 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -398,3 +398,23 @@ void cros_ec_debugfs_remove(struct cros_ec_dev *ec)
 	cros_ec_cleanup_console_log(ec->debug_info);
 }
 EXPORT_SYMBOL(cros_ec_debugfs_remove);
+
+void cros_ec_debugfs_suspend(struct cros_ec_dev *ec)
+{
+	/*
+	 * cros_ec_debugfs_init() failures are non-fatal; it's also possible
+	 * that we initted things but decided that console log wasn't supported.
+	 * We'll use the same set of checks that cros_ec_debugfs_remove() +
+	 * cros_ec_cleanup_console_log() end up using to handle those cases.
+	 */
+	if (ec->debug_info && ec->debug_info->log_buffer.buf)
+		cancel_delayed_work_sync(&ec->debug_info->log_poll_work);
+}
+EXPORT_SYMBOL(cros_ec_debugfs_suspend);
+
+void cros_ec_debugfs_resume(struct cros_ec_dev *ec)
+{
+	if (ec->debug_info && ec->debug_info->log_buffer.buf)
+		schedule_delayed_work(&ec->debug_info->log_poll_work, 0);
+}
+EXPORT_SYMBOL(cros_ec_debugfs_resume);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index c61535979b8f..804b3ddbf819 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -325,6 +325,8 @@ extern struct attribute_group cros_ec_vbc_attr_group;
 /* debugfs stuff */
 int cros_ec_debugfs_init(struct cros_ec_dev *ec);
 void cros_ec_debugfs_remove(struct cros_ec_dev *ec);
+void cros_ec_debugfs_suspend(struct cros_ec_dev *ec);
+void cros_ec_debugfs_resume(struct cros_ec_dev *ec);
 
 /* ACPI GPE handler */
 #ifdef CONFIG_ACPI
-- 
2.16.1
