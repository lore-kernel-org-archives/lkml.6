Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71324C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C5920672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C5920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeK0ErY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:47:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43842 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeK0ErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:47:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6E1BB27DA2A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v2 6/8] mfd / platform: cros_ec: instantiate only if th EC has a VBC NVRAM.
Date:   Mon, 26 Nov 2018 18:51:56 +0100
Message-Id: <20181126175158.5425-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126175158.5425-1-enric.balletbo@collabora.com>
References: <20181126175158.5425-1-enric.balletbo@collabora.com>
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
is created in /sys/class/chromeos/<ec device>, after the patch the empty
folder is not created, so, the folder is only created if the vbc is set.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- Remove unnecessary IS_ENABLED.
- Remove dev_err message telling that VBC is found.
- Use dev_warn instead of dev_err as the error is ignored.

 drivers/mfd/cros_ec_dev.c             |  7 ++++++-
 drivers/platform/chrome/cros_ec_vbc.c | 16 ----------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 590e705f253f..13b6dc26dc9a 100644
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
@@ -386,7 +387,10 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
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
@@ -395,6 +399,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
 	struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	struct device_node *node;
 
 	if (!ec)
 		return retval;
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
2.19.1

