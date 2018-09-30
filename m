Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE96C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E002089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E002089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJAEjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48670 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJAEjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:39:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E7DF127E036
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
Subject: [PATCHv1 07/14] power: supply: bq24257: fix race-condition in sysfs registration
Date:   Mon,  1 Oct 2018 00:03:42 +0200
Message-Id: <20180930220349.10515-8-sebastian.reichel@collabora.com>
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
 drivers/power/supply/bq24257_charger.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 6fc31bdc639b..673c7d6ff1a7 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -845,7 +845,7 @@ static DEVICE_ATTR(high_impedance_enable, S_IWUSR | S_IRUGO,
 static DEVICE_ATTR(sysoff_enable, S_IWUSR | S_IRUGO,
 		   bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
 
-static struct attribute *bq24257_charger_attr[] = {
+static struct attribute *bq24257_charger_sysfs_attrs[] = {
 	&dev_attr_ovp_voltage.attr,
 	&dev_attr_in_dpm_voltage.attr,
 	&dev_attr_high_impedance_enable.attr,
@@ -853,14 +853,13 @@ static struct attribute *bq24257_charger_attr[] = {
 	NULL,
 };
 
-static const struct attribute_group bq24257_attr_group = {
-	.attrs = bq24257_charger_attr,
-};
+ATTRIBUTE_GROUPS(bq24257_charger_sysfs);
 
 static int bq24257_power_supply_init(struct bq24257_device *bq)
 {
 	struct power_supply_config psy_cfg = { .drv_data = bq, };
 
+	psy_cfg.attr_grp = bq24257_charger_sysfs_groups;
 	psy_cfg.supplied_to = bq24257_charger_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(bq24257_charger_supplied_to);
 
@@ -1084,12 +1083,6 @@ static int bq24257_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = sysfs_create_group(&bq->charger->dev.kobj, &bq24257_attr_group);
-	if (ret < 0) {
-		dev_err(dev, "Can't create sysfs entries\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -1100,8 +1093,6 @@ static int bq24257_remove(struct i2c_client *client)
 	if (bq->iilimit_autoset_enable)
 		cancel_delayed_work_sync(&bq->iilimit_setup_work);
 
-	sysfs_remove_group(&bq->charger->dev.kobj, &bq24257_attr_group);
-
 	bq24257_field_write(bq, F_RESET, 1); /* reset to defaults */
 
 	return 0;
-- 
2.19.0

