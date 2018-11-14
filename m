Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFDFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC921780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFC921780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbeKNQ1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:27:38 -0500
Received: from ms.tdt.de ([195.243.126.94]:57476 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbeKNQ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:27:37 -0500
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2018 11:27:36 EST
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id DAF6020948;
        Wed, 14 Nov 2018 06:17:17 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH] net: phy: mdio-gpio: fix access that may sleep
Date:   Wed, 14 Nov 2018 07:17:03 +0100
Message-Id: <20181114061703.11026-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit re-enables support for slow GPIO pins. It was initially
introduced by commit
	2d6c9091ab7630dfcf34417c6683ce4764d7d40a
and got lost by commit
	7e5fbd1e0700f1bdb94508f84ec2aeb01eed7b12

Also add a warning about slow GPIO pins like it is done in i2c-gpio.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/net/phy/mdio-gpio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-gpio.c b/drivers/net/phy/mdio-gpio.c
index 33265747bf39..d4430631ca6a 100644
--- a/drivers/net/phy/mdio-gpio.c
+++ b/drivers/net/phy/mdio-gpio.c
@@ -63,7 +63,7 @@ static void mdio_dir(struct mdiobb_ctrl *ctrl, int dir)
 		 * assume the pin serves as pull-up. If direction is
 		 * output, the default value is high.
 		 */
-		gpiod_set_value(bitbang->mdo, 1);
+		gpiod_set_value_cansleep(bitbang->mdo, 1);
 		return;
 	}
 
@@ -78,7 +78,7 @@ static int mdio_get(struct mdiobb_ctrl *ctrl)
 	struct mdio_gpio_info *bitbang =
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
-	return gpiod_get_value(bitbang->mdio);
+	return gpiod_get_value_cansleep(bitbang->mdio);
 }
 
 static void mdio_set(struct mdiobb_ctrl *ctrl, int what)
@@ -87,9 +87,9 @@ static void mdio_set(struct mdiobb_ctrl *ctrl, int what)
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
 	if (bitbang->mdo)
-		gpiod_set_value(bitbang->mdo, what);
+		gpiod_set_value_cansleep(bitbang->mdo, what);
 	else
-		gpiod_set_value(bitbang->mdio, what);
+		gpiod_set_value_cansleep(bitbang->mdio, what);
 }
 
 static void mdc_set(struct mdiobb_ctrl *ctrl, int what)
@@ -97,7 +97,7 @@ static void mdc_set(struct mdiobb_ctrl *ctrl, int what)
 	struct mdio_gpio_info *bitbang =
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
-	gpiod_set_value(bitbang->mdc, what);
+	gpiod_set_value_cansleep(bitbang->mdc, what);
 }
 
 static const struct mdiobb_ops mdio_gpio_ops = {
@@ -162,6 +162,11 @@ static int mdio_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (gpiod_cansleep(bitbang->mdc) || gpiod_cansleep(bitbang->mdio)
+		|| gpiod_cansleep(bitbang->mdo))
+		dev_warn(&pdev->dev, "Slow GPIO pins might wreak havoc into"
+				     "I2C/SMBus bus timing");
+
 	if (pdev->dev.of_node) {
 		bus_id = of_alias_get_id(pdev->dev.of_node, "mdio-gpio");
 		if (bus_id < 0) {
-- 
2.11.0

