Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE59C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED290208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED290208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeJAEi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:38:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48636 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeJAEi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:38:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 771C027E036
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Milo Kim <milo.kim@ti.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Breck <kernel@networkimprov.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 05/14] power: supply: lp8788: fix race-condition in sysfs registration
Date:   Mon,  1 Oct 2018 00:03:40 +0200
Message-Id: <20180930220349.10515-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This registers custom sysfs properties using the native functionality
of the power-supply framework, which cleans up the code a bit and
fixes a race-condition. Before this patch the sysfs attributes were
not properly registered to udev.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/lp8788-charger.c | 62 ++++++++++++---------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 0f3432795f3c..309e6efbb8ef 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -410,30 +410,6 @@ static const struct power_supply_desc lp8788_psy_battery_desc = {
 	.get_property	= lp8788_battery_get_property,
 };
 
-static int lp8788_psy_register(struct platform_device *pdev,
-				struct lp8788_charger *pchg)
-{
-	struct power_supply_config charger_cfg = {};
-
-	charger_cfg.supplied_to = battery_supplied_to;
-	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
-
-	pchg->charger = power_supply_register(&pdev->dev,
-					      &lp8788_psy_charger_desc,
-					      &charger_cfg);
-	if (IS_ERR(pchg->charger))
-		return -EPERM;
-
-	pchg->battery = power_supply_register(&pdev->dev,
-					      &lp8788_psy_battery_desc, NULL);
-	if (IS_ERR(pchg->battery)) {
-		power_supply_unregister(pchg->charger);
-		return -EPERM;
-	}
-
-	return 0;
-}
-
 static void lp8788_psy_unregister(struct lp8788_charger *pchg)
 {
 	power_supply_unregister(pchg->battery);
@@ -690,16 +666,39 @@ static DEVICE_ATTR(charger_status, S_IRUSR, lp8788_show_charger_status, NULL);
 static DEVICE_ATTR(eoc_time, S_IRUSR, lp8788_show_eoc_time, NULL);
 static DEVICE_ATTR(eoc_level, S_IRUSR, lp8788_show_eoc_level, NULL);
 
-static struct attribute *lp8788_charger_attr[] = {
+static struct attribute *lp8788_charger_sysfs_attrs[] = {
 	&dev_attr_charger_status.attr,
 	&dev_attr_eoc_time.attr,
 	&dev_attr_eoc_level.attr,
 	NULL,
 };
 
-static const struct attribute_group lp8788_attr_group = {
-	.attrs = lp8788_charger_attr,
-};
+ATTRIBUTE_GROUPS(lp8788_charger_sysfs);
+
+static int lp8788_psy_register(struct platform_device *pdev,
+				struct lp8788_charger *pchg)
+{
+	struct power_supply_config charger_cfg = {};
+
+	charger_cfg.attr_grp = lp8788_charger_sysfs_groups;
+	charger_cfg.supplied_to = battery_supplied_to;
+	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
+
+	pchg->charger = power_supply_register(&pdev->dev,
+					      &lp8788_psy_charger_desc,
+					      &charger_cfg);
+	if (IS_ERR(pchg->charger))
+		return -EPERM;
+
+	pchg->battery = power_supply_register(&pdev->dev,
+					      &lp8788_psy_battery_desc, NULL);
+	if (IS_ERR(pchg->battery)) {
+		power_supply_unregister(pchg->charger);
+		return -EPERM;
+	}
+
+	return 0;
+}
 
 static int lp8788_charger_probe(struct platform_device *pdev)
 {
@@ -726,12 +725,6 @@ static int lp8788_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &lp8788_attr_group);
-	if (ret) {
-		lp8788_psy_unregister(pchg);
-		return ret;
-	}
-
 	ret = lp8788_irq_register(pdev, pchg);
 	if (ret)
 		dev_warn(dev, "failed to register charger irq: %d\n", ret);
@@ -745,7 +738,6 @@ static int lp8788_charger_remove(struct platform_device *pdev)
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
-	sysfs_remove_group(&pdev->dev.kobj, &lp8788_attr_group);
 	lp8788_psy_unregister(pchg);
 	lp8788_release_adc_channel(pchg);
 
-- 
2.19.0

