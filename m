Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99416C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6718220839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6718220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeLLReV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:34:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbeLLReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:34:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4FC2E27EBCE
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org
Subject: [PATCH v5 6/7] mfd / platform: cros_ec_vbc: instantiate only if the EC has a VBC NVRAM
Date:   Wed, 12 Dec 2018 18:34:01 +0100
Message-Id: <20181212173402.27086-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212173402.27086-1-enric.balletbo@collabora.com>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros-ec-vbc driver is DT-only and there is a DT property that
indicates if the EC has the VCB NVRAM, in such case instantiate the
driver but don't instantiate on the other cases.

To do this move the check code to its parent instead of play with the
attribute group visibility. This changes a bit the actual behaviour.
Before the patch if an EC doesn't have a VBC NVRAM an empty vbc folder
is created in /sys/class/chromeos/<ec-device-name>, after the patch the
empty folder is not created, so, the folder is only created if the vbc
is set.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v5: None
Changes in v4:
- Changed the subject to specify the cros_ec_vbc driver.
- Fix typo s/th/the

Changes in v3:
- Fixed build error as reported by kbuild test robot.

Changes in v2:
- Remove unnecessary IS_ENABLED.
- Remove dev_err message telling that VBC is found.
- Use dev_warn instead of dev_err as the error is ignored.

 drivers/mfd/cros_ec_dev.c             | 19 ++++++++++++++++++-
 drivers/platform/chrome/cros_ec_vbc.c | 16 ----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index b9ec2a798dbb..ed809fc97df8 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -21,6 +21,7 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -391,12 +392,16 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-debugfs" },
 	{ .name = "cros-ec-lightbar" },
 	{ .name = "cros-ec-sysfs" },
-	{ .name = "cros-ec-vbc" },
+};
+
+static const struct mfd_cell cros_ec_vbc_cells[] = {
+	{ .name = "cros-ec-vbc" }
 };
 
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
+	struct device_node *node;
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
 	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
@@ -485,6 +490,18 @@ static int ec_device_probe(struct platform_device *pdev)
 			 "failed to add cros-ec platform devices: %d\n",
 			 retval);
 
+	/* Check whether this EC instance has a VBC NVRAM */
+	node = ec->ec_dev->dev->of_node;
+	if (of_property_read_bool(node, "google,has-vbc-nvram")) {
+		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+					 cros_ec_vbc_cells,
+					 ARRAY_SIZE(cros_ec_vbc_cells),
+					 NULL, 0, NULL);
+		if (retval)
+			dev_warn(ec->dev, "failed to add VBC devices: %d\n",
+				 retval);
+	}
+
 	return 0;
 
 failed:
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index da3bbf05e86f..af9bfe6f385c 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -108,21 +108,6 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
 	return data_sz;
 }
 
-static umode_t cros_ec_vbc_is_visible(struct kobject *kobj,
-				      struct bin_attribute *a, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
-	struct device_node *np = ec->ec_dev->dev->of_node;
-
-	if (IS_ENABLED(CONFIG_OF) && np) {
-		if (of_property_read_bool(np, "google,has-vbc-nvram"))
-			return a->attr.mode;
-	}
-
-	return 0;
-}
-
 static BIN_ATTR_RW(vboot_context, 16);
 
 static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
@@ -133,7 +118,6 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
 struct attribute_group cros_ec_vbc_attr_group = {
 	.name = "vbc",
 	.bin_attrs = cros_ec_vbc_bin_attrs,
-	.is_bin_visible = cros_ec_vbc_is_visible,
 };
 
 static int cros_ec_vbc_probe(struct platform_device *pd)
-- 
2.19.2

