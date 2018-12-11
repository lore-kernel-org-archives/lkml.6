Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5516620870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5516620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeLKR76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:59:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48810 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeLKR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:59:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2F954260458
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v4 7/7] platform/chrome: cros_ec_lightbar: instantiate only if the EC has a lightbar
Date:   Tue, 11 Dec 2018 18:59:34 +0100
Message-Id: <20181211175934.10238-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211175934.10238-1-enric.balletbo@collabora.com>
References: <20181211175934.10238-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the way attribute groups visibility work, the function
cros_ec_lightbar_attrs_are_visible is called multiple times, once per
attribute, and each of these calls makes an EC transaction. For what is
worth the EC log reports multiple errors on boot when the lightbar is
not available. Instead, check if the EC has a lightbar in the probe
function and only instantiate the device.

Ideally we should have instantiate the driver only if the
EC_FEATURE_LIGHTBAR is defined, but that's not possible because that flag
is not in the very first Pixel Chromebook (Link), only on Samus. So, the
driver is instantiated by his parent always.

This patch changes a bit the actual behaviour. Before the patch if an EC
doesn't have a lightbar an empty lightbar folder is created in
/sys/class/chromeos/<ec-device-name>, after the patch the empty folder is
not created, so, the folder is only created if the lightbar exists.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v4:
- get rid of the cros_ec_has_lightbar function.

Changes in v3: None
Changes in v2:
- Removed ec_with_lightbar variable.

 drivers/platform/chrome/cros_ec_lightbar.c | 51 ++++++++--------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 80eed6317570..c3e4e6e5211d 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -43,7 +43,6 @@ static unsigned long lb_interval_jiffies = 50 * HZ / 1000;
  * If this is true, we won't do anything during suspend/resume.
  */
 static bool userspace_control;
-static struct cros_ec_dev *ec_with_lightbar;
 
 static ssize_t interval_msec_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
@@ -381,9 +380,6 @@ static int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
 	struct cros_ec_command *msg;
 	int ret;
 
-	if (ec != ec_with_lightbar)
-		return 0;
-
 	msg = alloc_lightbar_cmd_msg(ec);
 	if (!msg)
 		return -ENOMEM;
@@ -567,45 +563,32 @@ static struct attribute *__lb_cmds_attrs[] = {
 	NULL,
 };
 
-static bool ec_has_lightbar(struct cros_ec_dev *ec)
-{
-	return !!get_lightbar_version(ec, NULL, NULL);
-}
-
-static umode_t cros_ec_lightbar_attrs_are_visible(struct kobject *kobj,
-						  struct attribute *a, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
-	struct platform_device *pdev = to_platform_device(ec->dev);
-	struct cros_ec_platform *pdata = pdev->dev.platform_data;
-	int is_cros_ec;
-
-	is_cros_ec = strcmp(pdata->ec_name, CROS_EC_DEV_NAME);
-
-	if (is_cros_ec != 0)
-		return 0;
-
-	/* Only instantiate this stuff if the EC has a lightbar */
-	if (ec_has_lightbar(ec)) {
-		ec_with_lightbar = ec;
-		return a->mode;
-	}
-	return 0;
-}
-
 struct attribute_group cros_ec_lightbar_attr_group = {
 	.name = "lightbar",
 	.attrs = __lb_cmds_attrs,
-	.is_visible = cros_ec_lightbar_attrs_are_visible,
 };
 
 static int cros_ec_lightbar_probe(struct platform_device *pd)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
+	struct cros_ec_platform *pdata = dev_get_platdata(ec_dev->dev);
 	struct device *dev = &pd->dev;
 	int ret;
 
+	/*
+	 * Only instantiate the lightbar if the EC name is 'cros_ec'. Other EC
+	 * devices like 'cros_pd' doesn't have a lightbar.
+	 */
+	if (strcmp(pdata->ec_name, CROS_EC_DEV_NAME) != 0)
+		return -ENODEV;
+
+	/*
+	 * Ask then for the lightbar version, if it's 0 then the 'cros_ec'
+	 * doesn't have a lightbar.
+	 */
+	if (!get_lightbar_version(ec_dev, NULL, NULL))
+		return -ENODEV;
+
 	/* Take control of the lightbar from the EC. */
 	lb_manual_suspend_ctrl(ec_dev, 1);
 
@@ -635,7 +618,7 @@ static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
 
-	if (userspace_control || ec_dev != ec_with_lightbar)
+	if (userspace_control)
 		return 0;
 
 	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_RESUME);
@@ -645,7 +628,7 @@ static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
 
-	if (userspace_control || ec_dev != ec_with_lightbar)
+	if (userspace_control)
 		return 0;
 
 	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_SUSPEND);
-- 
2.19.2

