Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C011AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1B327085
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1B327085
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934476AbeF1H4O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:56:14 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:53884 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934400AbeF1H4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:56:12 -0400
Received: from localhost.localdomain (200116b84699cc0061630d7c5db5b655.dip.versatel-1u1.de [IPv6:2001:16b8:4699:cc00:6163:d7c:5db5:b655])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 258C728BF04;
        Thu, 28 Jun 2018 07:52:57 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 4/4] power: ds2760_battery: add device tree glue
Date:   Thu, 28 Jun 2018 09:55:40 +0200
Message-Id: <20180628075540.1757-5-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628075540.1757-1-daniel@zonque.org>
References: <20180628075540.1757-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The w1 slave device used by this driver now has a of_node in case it
was matched against a devicetree sub-node of the bus master. This can
now be passed down to the power supply core which will parse more
properties from the node, such as 'power-supplies'.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/power/supply/ds2760_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index ae180dc929c9..77dfdeb5fbc0 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -510,6 +510,10 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 	char status;
 	int retval = 0;
 	struct ds2760_device_info *di;
+	struct device *w1_dev;
+
+	w1_dev = pdev->dev.parent;
+	psy_cfg.of_node = w1_dev->of_node;
 
 	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
 	if (!di) {
@@ -520,7 +524,7 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, di);
 
 	di->dev				= &pdev->dev;
-	di->w1_dev			= pdev->dev.parent;
+	di->w1_dev			= w1_dev;
 	di->bat_desc.name		= dev_name(&pdev->dev);
 	di->bat_desc.type		= POWER_SUPPLY_TYPE_BATTERY;
 	di->bat_desc.properties		= ds2760_battery_props;
-- 
2.17.1

