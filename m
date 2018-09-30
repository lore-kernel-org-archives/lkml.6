Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0FAC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C7D2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C7D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeJAEjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48650 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeJAEi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:38:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9A27927E031
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
Subject: [PATCHv1 06/14] power: supply: bq24190_charger: fix race-condition in sysfs registration
Date:   Mon,  1 Oct 2018 00:03:41 +0200
Message-Id: <20180930220349.10515-7-sebastian.reichel@collabora.com>
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
 drivers/power/supply/bq24190_charger.c | 43 +++++---------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index b58df04d03b3..9d63d4e601cc 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -402,9 +402,7 @@ static struct bq24190_sysfs_field_info bq24190_sysfs_field_tbl[] = {
 static struct attribute *
 	bq24190_sysfs_attrs[ARRAY_SIZE(bq24190_sysfs_field_tbl) + 1];
 
-static const struct attribute_group bq24190_sysfs_attr_group = {
-	.attrs = bq24190_sysfs_attrs,
-};
+ATTRIBUTE_GROUPS(bq24190_sysfs);
 
 static void bq24190_sysfs_init_attrs(void)
 {
@@ -491,26 +489,6 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 
 	return count;
 }
-
-static int bq24190_sysfs_create_group(struct bq24190_dev_info *bdi)
-{
-	bq24190_sysfs_init_attrs();
-
-	return sysfs_create_group(&bdi->charger->dev.kobj,
-			&bq24190_sysfs_attr_group);
-}
-
-static void bq24190_sysfs_remove_group(struct bq24190_dev_info *bdi)
-{
-	sysfs_remove_group(&bdi->charger->dev.kobj, &bq24190_sysfs_attr_group);
-}
-#else
-static int bq24190_sysfs_create_group(struct bq24190_dev_info *bdi)
-{
-	return 0;
-}
-
-static inline void bq24190_sysfs_remove_group(struct bq24190_dev_info *bdi) {}
 #endif
 
 #ifdef CONFIG_REGULATOR
@@ -1736,6 +1714,11 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out_pmrt;
 	}
 
+#ifdef CONFIG_SYSFS
+	bq24190_sysfs_init_attrs();
+	charger_cfg.attr_grp = bq24190_sysfs_groups;
+#endif
+
 	charger_cfg.drv_data = bdi;
 	charger_cfg.of_node = dev->of_node;
 	charger_cfg.supplied_to = bq24190_charger_supplied_to;
@@ -1773,12 +1756,6 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out_charger;
 	}
 
-	ret = bq24190_sysfs_create_group(bdi);
-	if (ret < 0) {
-		dev_err(dev, "Can't create sysfs entries\n");
-		goto out_charger;
-	}
-
 	bdi->initialized = true;
 
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
@@ -1787,12 +1764,12 @@ static int bq24190_probe(struct i2c_client *client,
 			"bq24190-charger", bdi);
 	if (ret < 0) {
 		dev_err(dev, "Can't set up irq handler\n");
-		goto out_sysfs;
+		goto out_charger;
 	}
 
 	ret = bq24190_register_vbus_regulator(bdi);
 	if (ret < 0)
-		goto out_sysfs;
+		goto out_charger;
 
 	enable_irq_wake(client->irq);
 
@@ -1801,9 +1778,6 @@ static int bq24190_probe(struct i2c_client *client,
 
 	return 0;
 
-out_sysfs:
-	bq24190_sysfs_remove_group(bdi);
-
 out_charger:
 	if (!IS_ERR_OR_NULL(bdi->battery))
 		power_supply_unregister(bdi->battery);
@@ -1828,7 +1802,6 @@ static int bq24190_remove(struct i2c_client *client)
 	}
 
 	bq24190_register_reset(bdi);
-	bq24190_sysfs_remove_group(bdi);
 	if (bdi->battery)
 		power_supply_unregister(bdi->battery);
 	power_supply_unregister(bdi->charger);
-- 
2.19.0

