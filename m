Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32E4C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9328B2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9328B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeJAEjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48762 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbeJAEjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:39:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8A92B27E031
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
Subject: [PATCHv1 13/14] power: supply: ds2780: switch to devm_power_supply_register
Date:   Mon,  1 Oct 2018 00:03:48 +0200
Message-Id: <20180930220349.10515-14-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify/Cleanup the driver by switching to devm_power_supply_register
and dropping the driver's remove function.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/ds2780_battery.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index d8be8c236029..9502f163ea0b 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -768,8 +768,9 @@ static int ds2780_battery_probe(struct platform_device *pdev)
 	psy_cfg.drv_data		= dev_info;
 	psy_cfg.attr_grp		= ds2780_sysfs_groups;
 
-	dev_info->bat = power_supply_register(&pdev->dev, &dev_info->bat_desc,
-					      &psy_cfg);
+	dev_info->bat = devm_power_supply_register(&pdev->dev,
+						   &dev_info->bat_desc,
+						   &psy_cfg);
 	if (IS_ERR(dev_info->bat)) {
 		dev_err(dev_info->dev, "failed to register battery\n");
 		return PTR_ERR(dev_info->bat);
@@ -778,21 +779,11 @@ static int ds2780_battery_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ds2780_battery_remove(struct platform_device *pdev)
-{
-	struct ds2780_device_info *dev_info = platform_get_drvdata(pdev);
-
-	power_supply_unregister(dev_info->bat);
-
-	return 0;
-}
-
 static struct platform_driver ds2780_battery_driver = {
 	.driver = {
 		.name = "ds2780-battery",
 	},
 	.probe	  = ds2780_battery_probe,
-	.remove   = ds2780_battery_remove,
 };
 
 module_platform_driver(ds2780_battery_driver);
-- 
2.19.0

