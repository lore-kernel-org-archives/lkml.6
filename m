Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64502C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F5E23FDC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F5E23FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeGFFgT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:36:19 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:37648 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbeGFFgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:36:07 -0400
Received: from localhost.localdomain (pD95EF57F.dip0.t-ipconnect.de [217.94.245.127])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 37C0F28DBF7;
        Fri,  6 Jul 2018 05:36:02 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 5/5] power: supply: ds2760_battery: add devicetree probing
Date:   Fri,  6 Jul 2018 07:35:52 +0200
Message-Id: <20180706053552.11438-6-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706053552.11438-1-daniel@zonque.org>
References: <20180706053552.11438-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a matching table for devicetree probing, and optionally set the module
parameter variables from DT properties.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/power/supply/ds2760_battery.c | 29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index aa406a7c65a1..11bed88a89fa 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -29,6 +29,7 @@
 #include <linux/power_supply.h>
 #include <linux/suspend.h>
 #include <linux/w1.h>
+#include <linux/of.h>
 
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
@@ -705,6 +706,24 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 
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
+					  "maxim,cache-time-ms", &tmp))
+			cache_time = tmp;
+
+		if (!of_property_read_u32(dev->of_node,
+					  "rated-capacity-microamp-hours",
+					  &tmp))
+			rated_capacity = tmp / 10; /* property is in mAh */
+	}
+
 	di->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
 
 	sl->family_data = di;
@@ -719,7 +738,7 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 
 	ds2760_battery_write_status(di, status);
 
-	/* set rated capacity from module param */
+	/* set rated capacity from module param or device tree */
 	if (rated_capacity)
 		ds2760_battery_write_rated_capacity(di, rated_capacity);
 
@@ -769,6 +788,13 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
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
@@ -778,6 +804,7 @@ static struct w1_family_ops w1_ds2760_fops = {
 static struct w1_family w1_ds2760_family = {
 	.fid		= W1_FAMILY_DS2760,
 	.fops		= &w1_ds2760_fops,
+	.of_match_table	= of_match_ptr(w1_ds2760_of_ids),
 };
 module_w1_family(w1_ds2760_family);
 
-- 
2.17.1

