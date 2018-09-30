Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB69C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1922089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1922089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeJAEjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJAEjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:39:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 07B6C27E036
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
Subject: [PATCHv1 09/14] power: supply: charger-manager: fix race-condition in sysfs registration
Date:   Mon,  1 Oct 2018 00:03:44 +0200
Message-Id: <20180930220349.10515-10-sebastian.reichel@collabora.com>
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
 drivers/power/supply/charger-manager.c | 51 +++++++++++---------------
 include/linux/power/charger-manager.h  |  3 +-
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 7ce0a4a2645c..dab68c6af77a 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1352,7 +1352,7 @@ static ssize_t charger_externally_control_store(struct device *dev,
 }
 
 /**
- * charger_manager_register_sysfs - Register sysfs entry for each charger
+ * charger_manager_prepare_sysfs - Prepare sysfs entry for each charger
  * @cm: the Charger Manager representing the battery.
  *
  * This function add sysfs entry for charger(regulator) to control charger from
@@ -1364,13 +1364,12 @@ static ssize_t charger_externally_control_store(struct device *dev,
  * externally_control, this charger isn't controlled from charger-manager and
  * always stay off state of regulator.
  */
-static int charger_manager_register_sysfs(struct charger_manager *cm)
+static int charger_manager_prepare_sysfs(struct charger_manager *cm)
 {
 	struct charger_desc *desc = cm->desc;
 	struct charger_regulator *charger;
 	int chargers_externally_control = 1;
 	char *name;
-	int ret;
 	int i;
 
 	/* Create sysfs entry to control charger(regulator) */
@@ -1385,8 +1384,10 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 		charger->attrs[1] = &charger->attr_state.attr;
 		charger->attrs[2] = &charger->attr_externally_control.attr;
 		charger->attrs[3] = NULL;
-		charger->attr_g.name = name;
-		charger->attr_g.attrs = charger->attrs;
+
+		charger->attr_grp.name = name;
+		charger->attr_grp.attrs = charger->attrs;
+		desc->sysfs_groups[i] = &charger->attr_grp;
 
 		sysfs_attr_init(&charger->attr_name.attr);
 		charger->attr_name.attr.name = "name";
@@ -1413,14 +1414,6 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 
 		dev_info(cm->dev, "'%s' regulator's externally_control is %d\n",
 			 charger->regulator_name, charger->externally_control);
-
-		ret = sysfs_create_group(&cm->charger_psy->dev.kobj,
-					&charger->attr_g);
-		if (ret < 0) {
-			dev_err(cm->dev, "Cannot create sysfs entry of %s regulator\n",
-				charger->regulator_name);
-			return ret;
-		}
 	}
 
 	if (chargers_externally_control) {
@@ -1561,6 +1554,13 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 
 		desc->charger_regulators = chg_regs;
 
+		desc->sysfs_groups = devm_kcalloc(dev,
+					desc->num_charger_regulators + 1,
+					sizeof(*desc->sysfs_groups),
+					GFP_KERNEL);
+		if (!desc->sysfs_groups)
+			return ERR_PTR(-ENOMEM);
+
 		for_each_child_of_node(np, child) {
 			struct charger_cable *cables;
 			struct device_node *_child;
@@ -1767,6 +1767,15 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
 
+	/* Register sysfs entry for charger(regulator) */
+	ret = charger_manager_prepare_sysfs(cm);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Cannot prepare sysfs entry of regulators\n");
+		return ret;
+	}
+	psy_cfg.attr_grp = desc->sysfs_groups;
+
 	cm->charger_psy = power_supply_register(&pdev->dev,
 						&cm->charger_psy_desc,
 						&psy_cfg);
@@ -1783,14 +1792,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 		goto err_reg_extcon;
 	}
 
-	/* Register sysfs entry for charger(regulator) */
-	ret = charger_manager_register_sysfs(cm);
-	if (ret < 0) {
-		dev_err(&pdev->dev,
-			"Cannot initialize sysfs entry of regulator\n");
-		goto err_reg_sysfs;
-	}
-
 	/* Add to the list */
 	mutex_lock(&cm_list_mtx);
 	list_add(&cm->entry, &cm_list);
@@ -1814,14 +1815,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_reg_sysfs:
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		struct charger_regulator *charger;
-
-		charger = &desc->charger_regulators[i];
-		sysfs_remove_group(&cm->charger_psy->dev.kobj,
-				&charger->attr_g);
-	}
 err_reg_extcon:
 	for (i = 0; i < desc->num_charger_regulators; i++) {
 		struct charger_regulator *charger;
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index c4fa907c8f14..2ce8d00c20de 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -119,7 +119,7 @@ struct charger_regulator {
 	struct charger_cable *cables;
 	int num_cables;
 
-	struct attribute_group attr_g;
+	struct attribute_group attr_grp;
 	struct device_attribute attr_name;
 	struct device_attribute attr_state;
 	struct device_attribute attr_externally_control;
@@ -186,6 +186,7 @@ struct charger_desc {
 
 	int num_charger_regulators;
 	struct charger_regulator *charger_regulators;
+	const struct attribute_group **sysfs_groups;
 
 	const char *psy_fuel_gauge;
 
-- 
2.19.0

