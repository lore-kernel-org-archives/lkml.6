Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E62C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0C426B08
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0C426B08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755107AbeF0APT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:15:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:39017 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbeF0APS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:15:18 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNQ6qg022979;
        Tue, 26 Jun 2018 18:27:08 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 09/14] fsi: master-gpio: Add missing release function
Date:   Wed, 27 Jun 2018 09:26:00 +1000
Message-Id: <20180626232605.13420-10-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The embedded struct device needs a release function to be
able to successfully remove the driver.

We remove the devm_gpiod_put() as they are unnecessary
(the resources will be released automatically) and because
fsi_master_unregister() will cause the master structure to
be freed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 91d89597784a..bad7951a2677 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -792,6 +792,15 @@ static ssize_t external_mode_store(struct device *dev,
 static DEVICE_ATTR(external_mode, 0664,
 		external_mode_show, external_mode_store);
 
+static void fsi_master_gpio_release(struct device *dev)
+{
+	struct fsi_master_gpio *master = to_fsi_master_gpio(dev_to_fsi_master(dev));
+
+	of_node_put(dev_of_node(master->dev));
+
+	kfree(dev);
+}
+
 static int fsi_master_gpio_probe(struct platform_device *pdev)
 {
 	struct fsi_master_gpio *master;
@@ -805,6 +814,7 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	master->dev = &pdev->dev;
 	master->master.dev.parent = master->dev;
 	master->master.dev.of_node = of_node_get(dev_of_node(master->dev));
+	master->master.dev.release = fsi_master_gpio_release;
 	master->last_addr = LAST_ADDR_INVALID;
 
 	gpio = devm_gpiod_get(&pdev->dev, "clock", 0);
@@ -871,25 +881,21 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	return fsi_master_register(&master->master);
+	rc = fsi_master_register(&master->master);
+	if (rc)
+		device_remove_file(&pdev->dev, &dev_attr_external_mode);
+	return rc;
 }
 
 
+
 static int fsi_master_gpio_remove(struct platform_device *pdev)
 {
 	struct fsi_master_gpio *master = platform_get_drvdata(pdev);
 
-	devm_gpiod_put(&pdev->dev, master->gpio_clk);
-	devm_gpiod_put(&pdev->dev, master->gpio_data);
-	if (master->gpio_trans)
-		devm_gpiod_put(&pdev->dev, master->gpio_trans);
-	if (master->gpio_enable)
-		devm_gpiod_put(&pdev->dev, master->gpio_enable);
-	if (master->gpio_mux)
-		devm_gpiod_put(&pdev->dev, master->gpio_mux);
-	fsi_master_unregister(&master->master);
+	device_remove_file(&pdev->dev, &dev_attr_external_mode);
 
-	of_node_put(master->master.dev.of_node);
+	fsi_master_unregister(&master->master);
 
 	return 0;
 }
-- 
2.17.1

