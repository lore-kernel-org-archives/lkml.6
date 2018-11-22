Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6597FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F760204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F760204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394851AbeKVWN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:13:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54058 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394787AbeKVWNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:13:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C01A327E840
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 7/7] platform/chrome: cros_ec_lightbar: instantiate only if the EC has a lightbar.
Date:   Thu, 22 Nov 2018 12:33:56 +0100
Message-Id: <20181122113356.23610-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122113356.23610-1-enric.balletbo@collabora.com>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
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
/sys/class/chromeos/<ec device>, after the patch the empty folder is not
created, so, the folder is only created if the lightbar exists.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_lightbar.c | 29 +++++++++-------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 31d22f594fac..d255264eb082 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -567,37 +567,28 @@ static struct attribute *__lb_cmds_attrs[] = {
 	NULL,
 };
 
-static bool ec_has_lightbar(struct cros_ec_dev *ec)
+static bool cros_ec_has_lightbar(struct cros_ec_dev *ec_dev)
 {
-	return !!get_lightbar_version(ec, NULL, NULL);
-}
-
-static umode_t cros_ec_lightbar_attrs_are_visible(struct kobject *kobj,
-						  struct attribute *a, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
-	struct platform_device *pdev = to_platform_device(ec->dev);
+	struct platform_device *pdev = to_platform_device(ec_dev->dev);
 	struct cros_ec_platform *pdata = pdev->dev.platform_data;
 	int is_cros_ec;
 
 	is_cros_ec = strcmp(pdata->ec_name, CROS_EC_DEV_NAME);
 
 	if (is_cros_ec != 0)
-		return 0;
+		return false;
 
-	/* Only instantiate this stuff if the EC has a lightbar */
-	if (ec_has_lightbar(ec)) {
-		ec_with_lightbar = ec;
-		return a->mode;
+	if (!!get_lightbar_version(ec_dev, NULL, NULL)) {
+		ec_with_lightbar = ec_dev;
+		return true;
 	}
-	return 0;
+
+	return false;
 }
 
 struct attribute_group cros_ec_lightbar_attr_group = {
 	.name = "lightbar",
 	.attrs = __lb_cmds_attrs,
-	.is_visible = cros_ec_lightbar_attrs_are_visible,
 };
 
 static int cros_ec_lightbar_probe(struct platform_device *pd)
@@ -611,6 +602,10 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
 		return -EINVAL;
 	}
 
+	/* Only instantiate this stuff if the EC has a lightbar */
+	if (!cros_ec_has_lightbar(ec_dev))
+		return -ENODEV;
+
 	/* Take control of the lightbar from the EC. */
 	lb_manual_suspend_ctrl(ec_dev, 1);
 
-- 
2.19.1

