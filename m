Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEDEC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6D3208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6D3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJAEis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:38:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48596 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeJAEir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:38:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4D4EB260A8A
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
Subject: [PATCHv1 02/14] power: supply: bq2415x: fix race-condition in sysfs registration
Date:   Mon,  1 Oct 2018 00:03:37 +0200
Message-Id: <20180930220349.10515-3-sebastian.reichel@collabora.com>
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
 drivers/power/supply/bq2415x_charger.c | 119 ++++++++++---------------
 1 file changed, 49 insertions(+), 70 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index cbec70f3e73e..6693e7aeead5 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1032,54 +1032,6 @@ static int bq2415x_power_supply_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static int bq2415x_power_supply_init(struct bq2415x_device *bq)
-{
-	int ret;
-	int chip;
-	char revstr[8];
-	struct power_supply_config psy_cfg = {
-		.drv_data = bq,
-		.of_node = bq->dev->of_node,
-	};
-
-	bq->charger_desc.name = bq->name;
-	bq->charger_desc.type = POWER_SUPPLY_TYPE_USB;
-	bq->charger_desc.properties = bq2415x_power_supply_props;
-	bq->charger_desc.num_properties =
-			ARRAY_SIZE(bq2415x_power_supply_props);
-	bq->charger_desc.get_property = bq2415x_power_supply_get_property;
-
-	ret = bq2415x_detect_chip(bq);
-	if (ret < 0)
-		chip = BQUNKNOWN;
-	else
-		chip = ret;
-
-	ret = bq2415x_detect_revision(bq);
-	if (ret < 0)
-		strcpy(revstr, "unknown");
-	else
-		sprintf(revstr, "1.%d", ret);
-
-	bq->model = kasprintf(GFP_KERNEL,
-				"chip %s, revision %s, vender code %.3d",
-				bq2415x_chip_name[chip], revstr,
-				bq2415x_get_vender_code(bq));
-	if (!bq->model) {
-		dev_err(bq->dev, "failed to allocate model name\n");
-		return -ENOMEM;
-	}
-
-	bq->charger = power_supply_register(bq->dev, &bq->charger_desc,
-					    &psy_cfg);
-	if (IS_ERR(bq->charger)) {
-		kfree(bq->model);
-		return PTR_ERR(bq->charger);
-	}
-
-	return 0;
-}
-
 static void bq2415x_power_supply_exit(struct bq2415x_device *bq)
 {
 	bq->autotimer = 0;
@@ -1496,7 +1448,7 @@ static DEVICE_ATTR(charge_status, S_IRUGO, bq2415x_sysfs_show_status, NULL);
 static DEVICE_ATTR(boost_status, S_IRUGO, bq2415x_sysfs_show_status, NULL);
 static DEVICE_ATTR(fault_status, S_IRUGO, bq2415x_sysfs_show_status, NULL);
 
-static struct attribute *bq2415x_sysfs_attributes[] = {
+static struct attribute *bq2415x_sysfs_attrs[] = {
 	/*
 	 * TODO: some (appropriate) of these attrs should be switched to
 	 * use power supply class props.
@@ -1525,19 +1477,55 @@ static struct attribute *bq2415x_sysfs_attributes[] = {
 	NULL,
 };
 
-static const struct attribute_group bq2415x_sysfs_attr_group = {
-	.attrs = bq2415x_sysfs_attributes,
-};
+ATTRIBUTE_GROUPS(bq2415x_sysfs);
 
-static int bq2415x_sysfs_init(struct bq2415x_device *bq)
+static int bq2415x_power_supply_init(struct bq2415x_device *bq)
 {
-	return sysfs_create_group(&bq->charger->dev.kobj,
-			&bq2415x_sysfs_attr_group);
-}
+	int ret;
+	int chip;
+	char revstr[8];
+	struct power_supply_config psy_cfg = {
+		.drv_data = bq,
+		.of_node = bq->dev->of_node,
+		.attr_grp = bq2415x_sysfs_groups,
+	};
 
-static void bq2415x_sysfs_exit(struct bq2415x_device *bq)
-{
-	sysfs_remove_group(&bq->charger->dev.kobj, &bq2415x_sysfs_attr_group);
+	bq->charger_desc.name = bq->name;
+	bq->charger_desc.type = POWER_SUPPLY_TYPE_USB;
+	bq->charger_desc.properties = bq2415x_power_supply_props;
+	bq->charger_desc.num_properties =
+			ARRAY_SIZE(bq2415x_power_supply_props);
+	bq->charger_desc.get_property = bq2415x_power_supply_get_property;
+
+	ret = bq2415x_detect_chip(bq);
+	if (ret < 0)
+		chip = BQUNKNOWN;
+	else
+		chip = ret;
+
+	ret = bq2415x_detect_revision(bq);
+	if (ret < 0)
+		strcpy(revstr, "unknown");
+	else
+		sprintf(revstr, "1.%d", ret);
+
+	bq->model = kasprintf(GFP_KERNEL,
+				"chip %s, revision %s, vender code %.3d",
+				bq2415x_chip_name[chip], revstr,
+				bq2415x_get_vender_code(bq));
+	if (!bq->model) {
+		dev_err(bq->dev, "failed to allocate model name\n");
+		return -ENOMEM;
+	}
+
+	bq->charger = power_supply_register(bq->dev, &bq->charger_desc,
+					    &psy_cfg);
+	if (IS_ERR(bq->charger)) {
+		kfree(bq->model);
+		return PTR_ERR(bq->charger);
+	}
+
+	return 0;
 }
 
 /* main bq2415x probe function */
@@ -1651,16 +1639,10 @@ static int bq2415x_probe(struct i2c_client *client,
 		goto error_2;
 	}
 
-	ret = bq2415x_sysfs_init(bq);
-	if (ret) {
-		dev_err(bq->dev, "failed to create sysfs entries: %d\n", ret);
-		goto error_3;
-	}
-
 	ret = bq2415x_set_defaults(bq);
 	if (ret) {
 		dev_err(bq->dev, "failed to set default values: %d\n", ret);
-		goto error_4;
+		goto error_3;
 	}
 
 	if (bq->notify_node || bq->init_data.notify_device) {
@@ -1668,7 +1650,7 @@ static int bq2415x_probe(struct i2c_client *client,
 		ret = power_supply_reg_notifier(&bq->nb);
 		if (ret) {
 			dev_err(bq->dev, "failed to reg notifier: %d\n", ret);
-			goto error_4;
+			goto error_3;
 		}
 
 		bq->automode = 1;
@@ -1707,8 +1689,6 @@ static int bq2415x_probe(struct i2c_client *client,
 	dev_info(bq->dev, "driver registered\n");
 	return 0;
 
-error_4:
-	bq2415x_sysfs_exit(bq);
 error_3:
 	bq2415x_power_supply_exit(bq);
 error_2:
@@ -1733,7 +1713,6 @@ static int bq2415x_remove(struct i2c_client *client)
 		power_supply_unreg_notifier(&bq->nb);
 
 	of_node_put(bq->notify_node);
-	bq2415x_sysfs_exit(bq);
 	bq2415x_power_supply_exit(bq);
 
 	bq2415x_reset_chip(bq);
-- 
2.19.0

