Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D85C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC99B206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bt6Arl5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfAIJLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:11:32 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58008 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfAIJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:11:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x099BTpi041974;
        Wed, 9 Jan 2019 03:11:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547025089;
        bh=gczjm2ittIUq2444ZRz+TaQB+QGZRcSnI28sIaUrf9I=;
        h=From:To:CC:Subject:Date;
        b=Bt6Arl5xKiNbT46xsV0ICt+Z5ve+VLLlxfnSFDBBuB0/4bQQMqgI67vJkIyvakdV0
         XPWqE8vXPu8keT5qNzz0UPzVtEta8JXh+uwutaPp/DFg+h9M+skQ+T3xe7ab1tYqGW
         6+conGdxtvvcWuz4G0Bv5UkTFOI69S3BARM7KalI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x099BTCG100014
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 03:11:29 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 03:11:28 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 03:11:28 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x099BQxC019583;
        Wed, 9 Jan 2019 03:11:26 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>
Subject: [PATCH] gpio: pcf857x: Fix interrupts on multiple instances
Date:   Wed, 9 Jan 2019 11:11:24 +0200
Message-ID: <1547025084-16999-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple instances of pcf857x chips are present, a fix up
message [1] is printed during the probe of the 2nd and later
instances.

The issue is that the driver is using the same irq_chip data
structure between multiple instances.

Fix this by allocating the irq_chip data structure per instance.

[1] fix up message addressed by this patch
[    1.212100] gpio gpiochip9: (pcf8575): detected irqchip that is shared with multiple gpiochips: please fix the driver.

Cc: Stable <stable@vger.kernel.org> # 4.20+
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/gpio/gpio-pcf857x.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index adf72dd..68a35b6 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -84,6 +84,7 @@ MODULE_DEVICE_TABLE(of, pcf857x_of_table);
  */
 struct pcf857x {
 	struct gpio_chip	chip;
+	struct irq_chip		irqchip;
 	struct i2c_client	*client;
 	struct mutex		lock;		/* protect 'out' */
 	unsigned		out;		/* software latch */
@@ -252,18 +253,6 @@ static void pcf857x_irq_bus_sync_unlock(struct irq_data *data)
 	mutex_unlock(&gpio->lock);
 }
 
-static struct irq_chip pcf857x_irq_chip = {
-	.name		= "pcf857x",
-	.irq_enable	= pcf857x_irq_enable,
-	.irq_disable	= pcf857x_irq_disable,
-	.irq_ack	= noop,
-	.irq_mask	= noop,
-	.irq_unmask	= noop,
-	.irq_set_wake	= pcf857x_irq_set_wake,
-	.irq_bus_lock		= pcf857x_irq_bus_lock,
-	.irq_bus_sync_unlock	= pcf857x_irq_bus_sync_unlock,
-};
-
 /*-------------------------------------------------------------------------*/
 
 static int pcf857x_probe(struct i2c_client *client,
@@ -376,8 +365,17 @@ static int pcf857x_probe(struct i2c_client *client,
 
 	/* Enable irqchip if we have an interrupt */
 	if (client->irq) {
+		gpio->irqchip.name = "pcf857x",
+		gpio->irqchip.irq_enable = pcf857x_irq_enable,
+		gpio->irqchip.irq_disable = pcf857x_irq_disable,
+		gpio->irqchip.irq_ack = noop,
+		gpio->irqchip.irq_mask = noop,
+		gpio->irqchip.irq_unmask = noop,
+		gpio->irqchip.irq_set_wake = pcf857x_irq_set_wake,
+		gpio->irqchip.irq_bus_lock = pcf857x_irq_bus_lock,
+		gpio->irqchip.irq_bus_sync_unlock = pcf857x_irq_bus_sync_unlock,
 		status = gpiochip_irqchip_add_nested(&gpio->chip,
-						     &pcf857x_irq_chip,
+						     &gpio->irqchip,
 						     0, handle_level_irq,
 						     IRQ_TYPE_NONE);
 		if (status) {
@@ -392,7 +390,7 @@ static int pcf857x_probe(struct i2c_client *client,
 		if (status)
 			goto fail;
 
-		gpiochip_set_nested_irqchip(&gpio->chip, &pcf857x_irq_chip,
+		gpiochip_set_nested_irqchip(&gpio->chip, &gpio->irqchip,
 					    client->irq);
 		gpio->irq_parent = client->irq;
 	}
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

