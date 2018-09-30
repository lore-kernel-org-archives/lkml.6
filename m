Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B3EC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7019206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7019206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeJAEjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48752 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbeJAEjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:39:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 68A6227E031
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
Subject: [PATCHv1 12/14] power: supply: ds2781: fix race-condition in bin attribute registration
Date:   Mon,  1 Oct 2018 00:03:47 +0200
Message-Id: <20180930220349.10515-13-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up patch to the previous one, which fixed a
race-condition during registration of the attribute group.
This fixes the same issue for the binary attributes by adding
them to the properly registered group. As a side effect the
code is further cleaned up.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/ds2781_battery.c | 50 ++++++++++-----------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index 5bfd4c77eb89..ea8c66abf602 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -660,7 +660,7 @@ static ssize_t ds2781_write_param_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static const struct bin_attribute ds2781_param_eeprom_bin_attr = {
+static struct bin_attribute ds2781_param_eeprom_bin_attr = {
 	.attr = {
 		.name = "param_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
@@ -706,7 +706,7 @@ static ssize_t ds2781_write_user_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static const struct bin_attribute ds2781_user_eeprom_bin_attr = {
+static struct bin_attribute ds2781_user_eeprom_bin_attr = {
 	.attr = {
 		.name = "user_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
@@ -725,7 +725,6 @@ static DEVICE_ATTR(rsgain_setting, S_IRUGO | S_IWUSR, ds2781_get_rsgain_setting,
 static DEVICE_ATTR(pio_pin, S_IRUGO | S_IWUSR, ds2781_get_pio_pin,
 	ds2781_set_pio_pin);
 
-
 static struct attribute *ds2781_sysfs_attrs[] = {
 	&dev_attr_pmod_enabled.attr,
 	&dev_attr_sense_resistor_value.attr,
@@ -734,12 +733,26 @@ static struct attribute *ds2781_sysfs_attrs[] = {
 	NULL
 };
 
-ATTRIBUTE_GROUPS(ds2781_sysfs);
+static struct bin_attribute *ds2781_sysfs_bin_attrs[] = {
+	&ds2781_param_eeprom_bin_attr,
+	&ds2781_user_eeprom_bin_attr,
+	NULL,
+};
+
+static const struct attribute_group ds2781_sysfs_group = {
+	.attrs = ds2781_sysfs_attrs,
+	.bin_attrs = ds2781_sysfs_bin_attrs,
+
+};
+
+static const struct attribute_group *ds2781_sysfs_groups[] = {
+	&ds2781_sysfs_group,
+	NULL,
+};
 
 static int ds2781_battery_probe(struct platform_device *pdev)
 {
 	struct power_supply_config psy_cfg = {};
-	int ret = 0;
 	struct ds2781_device_info *dev_info;
 
 	dev_info = devm_kzalloc(&pdev->dev, sizeof(*dev_info), GFP_KERNEL);
@@ -763,35 +776,10 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 						&psy_cfg);
 	if (IS_ERR(dev_info->bat)) {
 		dev_err(dev_info->dev, "failed to register battery\n");
-		ret = PTR_ERR(dev_info->bat);
-		goto fail;
-	}
-
-	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
-					&ds2781_param_eeprom_bin_attr);
-	if (ret) {
-		dev_err(dev_info->dev,
-				"failed to create param eeprom bin file");
-		goto fail_unregister;
-	}
-
-	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
-					&ds2781_user_eeprom_bin_attr);
-	if (ret) {
-		dev_err(dev_info->dev,
-				"failed to create user eeprom bin file");
-		goto fail_remove_bin_file;
+		return PTR_ERR(dev_info->bat);
 	}
 
 	return 0;
-
-fail_remove_bin_file:
-	sysfs_remove_bin_file(&dev_info->bat->dev.kobj,
-				&ds2781_param_eeprom_bin_attr);
-fail_unregister:
-	power_supply_unregister(dev_info->bat);
-fail:
-	return ret;
 }
 
 static int ds2781_battery_remove(struct platform_device *pdev)
-- 
2.19.0

