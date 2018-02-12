Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBLTqj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:46:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752261AbeBLTqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:46:34 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Revert "extcon: axp288: Redo charger type detection a couple of seconds after probe()"
Date: Mon, 12 Feb 2018 20:46:29 +0100
Message-Id: <20180212194630.7216-2-hdegoede@redhat.com>
In-Reply-To: <20180212194630.7216-1-hdegoede@redhat.com>
References: <20180212194630.7216-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redoing the charger type detection to give the usb-role-switch code time
to properly set the role-switch is no good for mainline, since the
usb-role-switch code is not yet in mainline (my bad, sorry).

Also once we've that code there are better ways to fix this which are
not prone to racing as doing a retry after 2 seconds is.

This reverts commit 50082c17bb1455acacd376ae30dff92f2e1addbd.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-axp288.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index c8f7b6435679..3ec4c715e240 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -1,7 +1,6 @@
 /*
  * extcon-axp288.c - X-Power AXP288 PMIC extcon cable detection driver
  *
- * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
  * Copyright (C) 2015 Intel Corporation
  * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
  *
@@ -98,11 +97,9 @@ struct axp288_extcon_info {
 	struct device *dev;
 	struct regmap *regmap;
 	struct regmap_irq_chip_data *regmap_irqc;
-	struct delayed_work det_work;
 	int irq[EXTCON_IRQ_END];
 	struct extcon_dev *edev;
 	unsigned int previous_cable;
-	bool first_detect_done;
 };
 
 /* Power up/down reason string array */
@@ -140,25 +137,6 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 	regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
 }
 
-static void axp288_chrg_detect_complete(struct axp288_extcon_info *info)
-{
-	/*
-	 * We depend on other drivers to do things like mux the data lines,
-	 * enable/disable vbus based on the id-pin, etc. Sometimes the BIOS has
-	 * not set these things up correctly resulting in the initial charger
-	 * cable type detection giving a wrong result and we end up not charging
-	 * or charging at only 0.5A.
-	 *
-	 * So we schedule a second cable type detection after 2 seconds to
-	 * give the other drivers time to load and do their thing.
-	 */
-	if (!info->first_detect_done) {
-		queue_delayed_work(system_wq, &info->det_work,
-				   msecs_to_jiffies(2000));
-		info->first_detect_done = true;
-	}
-}
-
 static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 {
 	int ret, stat, cfg, pwr_stat;
@@ -223,8 +201,6 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 		info->previous_cable = cable;
 	}
 
-	axp288_chrg_detect_complete(info);
-
 	return 0;
 
 dev_det_ret:
@@ -246,11 +222,8 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void axp288_extcon_det_work(struct work_struct *work)
+static void axp288_extcon_enable(struct axp288_extcon_info *info)
 {
-	struct axp288_extcon_info *info =
-		container_of(work, struct axp288_extcon_info, det_work.work);
-
 	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
 						BC_GLOBAL_RUN, 0);
 	/* Enable the charger detection logic */
@@ -272,7 +245,6 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;
 	info->previous_cable = EXTCON_NONE;
-	INIT_DELAYED_WORK(&info->det_work, axp288_extcon_det_work);
 
 	platform_set_drvdata(pdev, info);
 
@@ -318,7 +290,7 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 	}
 
 	/* Start charger cable type detection */
-	queue_delayed_work(system_wq, &info->det_work, 0);
+	axp288_extcon_enable(info);
 
 	return 0;
 }
-- 
2.14.3
