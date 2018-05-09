Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965939AbeEIXGh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 19:06:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39057 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965426AbeEIXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 19:06:36 -0400
X-Google-Smtp-Source: AB8JxZrtnIGIe2hWtgbCH3LdhsAeJ1c8Gir6O1BW12c2/EJ9fr9emr6g6hqCVIdCXTBWVlyrHm0N8Q==
From: Gwendal Grignou <gwendal@chromium.org>
To: bleung@chromium.org, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cros_ec: Use devm_kzalloc for private data
Date: Wed,  9 May 2018 16:06:30 -0700
Message-Id: <20180509230630.258755-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_kzmalloc, remove .release entry point.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index eafd06f62a3a..45d42511a3e5 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -262,13 +262,6 @@ static const struct file_operations fops = {
 #endif
 };
 
-static void __remove(struct device *dev)
-{
-	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
-					      class_dev);
-	kfree(ec);
-}
-
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
 	/*
@@ -388,7 +381,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	int retval = -ENOMEM;
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
-	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
+	struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
 
 	if (!ec)
 		return retval;
@@ -410,7 +403,6 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->class_dev.devt = MKDEV(ec_major, pdev->id);
 	ec->class_dev.class = &cros_class;
 	ec->class_dev.parent = dev;
-	ec->class_dev.release = __remove;
 
 	retval = dev_set_name(&ec->class_dev, "%s", ec_platform->ec_name);
 	if (retval) {
-- 
2.17.0.441.gb46fe60e1d-goog
