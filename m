Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965947AbeEIW4u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:56:50 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46628 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965426AbeEIW4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:56:48 -0400
X-Google-Smtp-Source: AB8JxZr6hP2NcsxieAoAcTBDtOVSqdG/jhvXEh/X3Nrptk5ACTMkfwyOAlgd3UY7dybg1BxhijFNzw==
From: Gwendal Grignou <gwendal@chromium.org>
To: bleung@chromium.org, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: Use to_cros_ec_dev more broadly
Date: Wed,  9 May 2018 15:56:31 -0700
Message-Id: <20180509225631.255523-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move to_cros_ec_dev macro to cros_ec.h and use it when the private ec
object is needed from device object.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mfd/cros_ec_dev.c                  |  4 ++--
 drivers/platform/chrome/cros_ec_lightbar.c | 21 +++++++--------------
 drivers/platform/chrome/cros_ec_sysfs.c    |  2 --
 drivers/platform/chrome/cros_ec_vbc.c      |  9 +++------
 include/linux/mfd/cros_ec.h                |  2 ++
 5 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index eafd06f62a3a..cad12da7f884 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -264,8 +264,8 @@ static const struct file_operations fops = {
 
 static void __remove(struct device *dev)
 {
-	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
-					      class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+
 	kfree(ec);
 }
 
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 6ea79d495aa2..68193bb53383 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -170,8 +170,7 @@ static ssize_t version_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	uint32_t version = 0, flags = 0;
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	int ret;
 
 	ret = lb_throttle();
@@ -193,8 +192,7 @@ static ssize_t brightness_store(struct device *dev,
 	struct cros_ec_command *msg;
 	int ret;
 	unsigned int val;
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
 	if (kstrtouint(buf, 0, &val))
 		return -EINVAL;
@@ -238,8 +236,7 @@ static ssize_t led_rgb_store(struct device *dev, struct device_attribute *attr,
 {
 	struct ec_params_lightbar *param;
 	struct cros_ec_command *msg;
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	unsigned int val[4];
 	int ret, i = 0, j = 0, ok = 0;
 
@@ -311,8 +308,7 @@ static ssize_t sequence_show(struct device *dev,
 	struct ec_response_lightbar *resp;
 	struct cros_ec_command *msg;
 	int ret;
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
 	msg = alloc_lightbar_cmd_msg(ec);
 	if (!msg)
@@ -439,8 +435,7 @@ static ssize_t sequence_store(struct device *dev, struct device_attribute *attr,
 	struct cros_ec_command *msg;
 	unsigned int num;
 	int ret, len;
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
 	for (len = 0; len < count; len++)
 		if (!isalnum(buf[len]))
@@ -488,8 +483,7 @@ static ssize_t program_store(struct device *dev, struct device_attribute *attr,
 	int extra_bytes, max_size, ret;
 	struct ec_params_lightbar *param;
 	struct cros_ec_command *msg;
-	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
-					      class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
 	/*
 	 * We might need to reject the program for size reasons. The EC
@@ -599,8 +593,7 @@ static umode_t cros_ec_lightbar_attrs_are_visible(struct kobject *kobj,
 						  struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct platform_device *pdev = to_platform_device(ec->dev);
 	struct cros_ec_platform *pdata = pdev->dev.platform_data;
 	int is_cros_ec;
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 5a6db3fe213a..f34a50121064 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -34,8 +34,6 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
-#define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
-
 /* Accessor functions */
 
 static ssize_t reboot_show(struct device *dev,
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 6d38e6b08334..5356f26bc022 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -29,8 +29,7 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
 				  loff_t pos, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
-					      class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct cros_ec_device *ecdev = ec->ec_dev;
 	struct ec_params_vbnvcontext *params;
 	struct cros_ec_command *msg;
@@ -70,8 +69,7 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
 				   loff_t pos, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
-					      class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct cros_ec_device *ecdev = ec->ec_dev;
 	struct ec_params_vbnvcontext *params;
 	struct cros_ec_command *msg;
@@ -111,8 +109,7 @@ static umode_t cros_ec_vbc_is_visible(struct kobject *kobj,
 				      struct bin_attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
-					      class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct device_node *np = ec->ec_dev->dev->of_node;
 
 	if (IS_ENABLED(CONFIG_OF) && np) {
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 4ff0cec979b0..4270972adb94 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -197,6 +197,8 @@ struct cros_ec_dev {
 	u32 features[2];
 };
 
+#define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
+
 /**
  * cros_ec_suspend - Handle a suspend operation for the ChromeOS EC device
  *
-- 
2.17.0.441.gb46fe60e1d-goog
