Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbeE3Qyb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:54:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42181 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbeE3Qy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:54:27 -0400
X-Google-Smtp-Source: ADUXVKLyUv3asK9080Pl4jD2NVO9PxcfHifYu0ms9KzDMMCRpuW6SWTBpH7HhydPIKDTxv0rbdNAQg==
From: Gwendal Grignou <gwendal@chromium.org>
To: bleung@chromium.org, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] cros_ec: Use devm_kzalloc for private data
Date: Wed, 30 May 2018 09:54:22 -0700
Message-Id: <20180530165422.51178-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <CAFqH_50VYJC7aep6P+KtN4qmFeV66GEXvxmFy8KrNp1BRv33xg@mail.gmail.com>
References: <CAFqH_50VYJC7aep6P+KtN4qmFeV66GEXvxmFy8KrNp1BRv33xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_kzmalloc, remove .release entry point.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Change sinc v1:
- Readd __remove to avoid a warning when loaded as a module.

 drivers/mfd/cros_ec_dev.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 1d6dc5c7a19d..81466264f7fc 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -262,12 +262,7 @@ static const struct file_operations fops = {
 #endif
 };
 
-static void __remove(struct device *dev)
-{
-	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
-					      class_dev);
-	kfree(ec);
-}
+static void __remove(struct device *dev) { }
 
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
@@ -392,7 +387,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	int retval = -ENOMEM;
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
-	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
+	struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
 
 	if (!ec)
 		return retval;
@@ -414,7 +409,6 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->class_dev.devt = MKDEV(ec_major, pdev->id);
 	ec->class_dev.class = &cros_class;
 	ec->class_dev.parent = dev;
-	ec->class_dev.release = __remove;
 
 	retval = dev_set_name(&ec->class_dev, "%s", ec_platform->ec_name);
 	if (retval) {
-- 
2.17.0.921.gf22659ad46-goog
