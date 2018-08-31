Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F302DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37252083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ymlBV0qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37252083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeHaXWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:22:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38808 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbeHaXWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:22:20 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJDSUO085363;
        Fri, 31 Aug 2018 14:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535742808;
        bh=23MEsB3WE6rDoSI2ZBb7wJHnp8NdvE2+R4eyD8SloWY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ymlBV0qP/nSQFtdsvzhDDtAtdIcRRf26xV4N1XyxUIWoZentPz63aWUlc2NPJ8p3E
         XLFbwD0RcM9r8F/83b9mIrD6frgFI02SpyqrowXjOByldRFLq1eZtaGEZ1l8TdXHLc
         0nkWrYg9tHh3PqjbFlQ+Panz7Dfd34g7LQ87Ols8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDSxl025220;
        Fri, 31 Aug 2018 14:13:28 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:13:28 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:13:28 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDRw0004124;
        Fri, 31 Aug 2018 14:13:27 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJDRx13199;
        Fri, 31 Aug 2018 14:13:27 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic base selection
Date:   Fri, 31 Aug 2018 14:13:23 -0500
Message-ID: <20180831191326.25106-2-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831191326.25106-1-afd@ti.com>
References: <20180831191326.25106-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_name to get a unique label and use -1 for a base to get our
selection automatically. We pull in all GPIOs per chip now so this
does not have the effect of out of order labels like before.

We do these both together so we can drop all the static data in one
patch. This also lets us normalize the return paths as we don't need
any cleanup after this change.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/gpio/gpio-davinci.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index a5ece8ea79bc..14d1729927d3 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -41,7 +41,6 @@ struct davinci_gpio_regs {
 typedef struct irq_chip *(*gpio_get_irq_chip_cb_t)(unsigned int irq);
 
 #define BINTEN	0x8 /* GPIO Interrupt Per-Bank Enable Register */
-#define MAX_LABEL_SIZE 20
 
 static void __iomem *gpio_base;
 static unsigned int offset_array[5] = {0x10, 0x38, 0x60, 0x88, 0xb0};
@@ -166,14 +165,12 @@ davinci_gpio_get_pdata(struct platform_device *pdev)
 
 static int davinci_gpio_probe(struct platform_device *pdev)
 {
-	static int ctrl_num, bank_base;
 	int gpio, bank, i, ret = 0;
 	unsigned int ngpio, nbank, nirq;
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	char label[MAX_LABEL_SIZE];
 
 	pdata = davinci_gpio_get_pdata(pdev);
 	if (!pdata) {
@@ -228,10 +225,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 		}
 	}
 
-	snprintf(label, MAX_LABEL_SIZE, "davinci_gpio.%d", ctrl_num++);
-	chips->chip.label = devm_kstrdup(dev, label, GFP_KERNEL);
-		if (!chips->chip.label)
-			return -ENOMEM;
+	chips->chip.label = dev_name(dev);
 
 	chips->chip.direction_input = davinci_direction_in;
 	chips->chip.get = davinci_gpio_get;
@@ -239,7 +233,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	chips->chip.set = davinci_gpio_set;
 
 	chips->chip.ngpio = ngpio;
-	chips->chip.base = bank_base;
+	chips->chip.base = -1;
 
 #ifdef CONFIG_OF_GPIO
 	chips->chip.of_gpio_n_cells = 2;
@@ -252,28 +246,20 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	}
 #endif
 	spin_lock_init(&chips->lock);
-	bank_base += ngpio;
 
 	for (gpio = 0, bank = 0; gpio < ngpio; gpio += 32, bank++)
 		chips->regs[bank] = gpio_base + offset_array[bank];
 
 	ret = devm_gpiochip_add_data(dev, &chips->chip, chips);
 	if (ret)
-		goto err;
+		return ret;
 
 	platform_set_drvdata(pdev, chips);
 	ret = davinci_gpio_irq_setup(pdev);
 	if (ret)
-		goto err;
+		return ret;
 
 	return 0;
-
-err:
-	/* Revert the static variable increments */
-	ctrl_num--;
-	bank_base -= ngpio;
-
-	return ret;
 }
 
 /*--------------------------------------------------------------------------*/
-- 
2.18.0

