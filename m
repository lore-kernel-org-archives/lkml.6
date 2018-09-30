Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0491C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0091206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0091206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeJAEiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:38:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeJAEiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:38:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 15DD827E031
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
Subject: [PATCHv1 04/14] power: supply: ds2781: fix race-condition in sysfs registration
Date:   Mon,  1 Oct 2018 00:03:39 +0200
Message-Id: <20180930220349.10515-5-sebastian.reichel@collabora.com>
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
 drivers/power/supply/ds2781_battery.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index d1b5a19aae7c..5bfd4c77eb89 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -726,7 +726,7 @@ static DEVICE_ATTR(pio_pin, S_IRUGO | S_IWUSR, ds2781_get_pio_pin,
 	ds2781_set_pio_pin);
 
 
-static struct attribute *ds2781_attributes[] = {
+static struct attribute *ds2781_sysfs_attrs[] = {
 	&dev_attr_pmod_enabled.attr,
 	&dev_attr_sense_resistor_value.attr,
 	&dev_attr_rsgain_setting.attr,
@@ -734,9 +734,7 @@ static struct attribute *ds2781_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group ds2781_attr_group = {
-	.attrs = ds2781_attributes,
-};
+ATTRIBUTE_GROUPS(ds2781_sysfs);
 
 static int ds2781_battery_probe(struct platform_device *pdev)
 {
@@ -759,6 +757,7 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 	dev_info->bat_desc.get_property	= ds2781_battery_get_property;
 
 	psy_cfg.drv_data		= dev_info;
+	psy_cfg.attr_grp		= ds2781_sysfs_groups;
 
 	dev_info->bat = power_supply_register(&pdev->dev, &dev_info->bat_desc,
 						&psy_cfg);
@@ -768,18 +767,12 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = sysfs_create_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
-	if (ret) {
-		dev_err(dev_info->dev, "failed to create sysfs group\n");
-		goto fail_unregister;
-	}
-
 	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
 					&ds2781_param_eeprom_bin_attr);
 	if (ret) {
 		dev_err(dev_info->dev,
 				"failed to create param eeprom bin file");
-		goto fail_remove_group;
+		goto fail_unregister;
 	}
 
 	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
@@ -795,8 +788,6 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 fail_remove_bin_file:
 	sysfs_remove_bin_file(&dev_info->bat->dev.kobj,
 				&ds2781_param_eeprom_bin_attr);
-fail_remove_group:
-	sysfs_remove_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
 fail_unregister:
 	power_supply_unregister(dev_info->bat);
 fail:
@@ -807,12 +798,6 @@ static int ds2781_battery_remove(struct platform_device *pdev)
 {
 	struct ds2781_device_info *dev_info = platform_get_drvdata(pdev);
 
-	/*
-	 * Remove attributes before unregistering power supply
-	 * because 'bat' will be freed on power_supply_unregister() call.
-	 */
-	sysfs_remove_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
-
 	power_supply_unregister(dev_info->bat);
 
 	return 0;
-- 
2.19.0

