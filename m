Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55227C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1854C2469C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1854C2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeGDEo0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:44:26 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:41038 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933056AbeGDEoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:44:24 -0400
Received: from localhost.localdomain (pD95EF712.dip0.t-ipconnect.de [217.94.247.18])
        by mail.bugwerft.de (Postfix) with ESMTPSA id A973128D3F3;
        Wed,  4 Jul 2018 04:41:01 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 4/4] power: supply: ds2760_battery: add devicetree probing
Date:   Wed,  4 Jul 2018 06:44:11 +0200
Message-Id: <20180704044411.2693-5-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704044411.2693-1-daniel@zonque.org>
References: <20180704044411.2693-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a matching table for devicetree probing, and optionally set the module
parameter variables from DT properties.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/power/supply/ds2760_battery.c | 32 ++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index aa406a7c65a1..921cbcfd8c99 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -29,6 +29,7 @@
 #include <linux/power_supply.h>
 #include <linux/suspend.h>
 #include <linux/w1.h>
+#include <linux/of.h>
 
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
@@ -705,6 +706,27 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 
 	psy_cfg.drv_data = di;
 
+	if (dev->of_node) {
+		u32 tmp;
+
+		psy_cfg.of_node = dev->of_node;
+
+		if (!of_property_read_bool(dev->of_node, "maxim,pmod-enabled"))
+			pmod_enabled = true;
+
+		if (!of_property_read_u32(dev->of_node,
+					  "maxim,cache-time", &tmp))
+			cache_time = tmp;
+
+		if (!of_property_read_u32(dev->of_node,
+					  "maxim,rated-capacity", &tmp))
+			rated_capacity = tmp / 10; /* property is in mAh */
+
+		if (!of_property_read_u32(dev->of_node,
+					  "maxim,current-accumulator", &tmp))
+			current_accum = tmp;
+	}
+
 	di->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
 
 	sl->family_data = di;
@@ -719,7 +741,7 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 
 	ds2760_battery_write_status(di, status);
 
-	/* set rated capacity from module param */
+	/* set rated capacity from module param or device tree */
 	if (rated_capacity)
 		ds2760_battery_write_rated_capacity(di, rated_capacity);
 
@@ -769,6 +791,13 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
 	power_supply_unregister(di->bat);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id w1_ds2760_of_ids[] = {
+	{ .compatible = "maxim,ds2760" },
+	{}
+};
+#endif
+
 static struct w1_family_ops w1_ds2760_fops = {
 	.add_slave	= w1_ds2760_add_slave,
 	.remove_slave	= w1_ds2760_remove_slave,
@@ -778,6 +807,7 @@ static struct w1_family_ops w1_ds2760_fops = {
 static struct w1_family w1_ds2760_family = {
 	.fid		= W1_FAMILY_DS2760,
 	.fops		= &w1_ds2760_fops,
+	.of_match_table	= of_match_ptr(w1_ds2760_of_ids),
 };
 module_w1_family(w1_ds2760_family);
 
-- 
2.17.1

