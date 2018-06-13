Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 33D01C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26B520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hmPf7oVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26B520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbeFMDkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:40:52 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:62418 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbeFMDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:40:51 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5D3eofl011175;
        Tue, 12 Jun 2018 22:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528861250;
        bh=sssGdrEgGWYpvfRHEa2lAA3jLqzB/6JD7enYSLxpkMA=;
        h=From:To:CC:Subject:Date;
        b=hmPf7oVV/CZQ5rt7q50RUFUC0ugXSa4oim7zIs+fuPRq2bA6Hs/3PPbCObYXVoUwe
         YsRj8hrAPqynYqfv0La/HcZ5hcjX3sfjmXXwOg61uE9FQHazvUXsLFrWHH0XzXfcmC
         F8KSKtrlzy4TNQVDzcvUdJcKzOn5IjPg54os2FxE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5D3eokt019067;
        Tue, 12 Jun 2018 22:40:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 22:40:49 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 22:40:49 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5D3elQG010765;
        Tue, 12 Jun 2018 22:40:48 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH v4 1/2] gpio: davinci: Shuffle IRQ resource fetching from DT to beginning of probe
Date:   Wed, 13 Jun 2018 09:10:36 +0530
Message-ID: <1528861237-24254-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed in case of PROBE_DEFER if IRQ resource is not yet ready.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Tested for GPIO Interrupts on da850-lcdk board.

Changes in v3:

        Changed type of bank_irq to int from unsigned

 drivers/gpio/gpio-davinci.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 987126c..0ff2c0d 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -55,7 +55,7 @@ static inline struct davinci_gpio_regs __iomem *irq2regs(struct irq_data *d)
 	return g;
 }
 
-static int davinci_gpio_irq_setup(struct platform_device *pdev);
+static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq);
 
 /*--------------------------------------------------------------------------*/
 
@@ -167,7 +167,7 @@ static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
 static int davinci_gpio_probe(struct platform_device *pdev)
 {
 	static int ctrl_num, bank_base;
-	int gpio, bank, ret = 0;
+	int gpio, bank, bank_irq, ret = 0;
 	unsigned ngpio, nbank;
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
@@ -209,6 +209,12 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio_base))
 		return PTR_ERR(gpio_base);
 
+	bank_irq = platform_get_irq(pdev, 0);
+	if (bank_irq < 0) {
+		dev_dbg(dev, "IRQ not populated\n");
+		return bank_irq;
+	}
+
 	snprintf(label, MAX_LABEL_SIZE, "davinci_gpio.%d", ctrl_num++);
 	chips->chip.label = devm_kstrdup(dev, label, GFP_KERNEL);
 		if (!chips->chip.label)
@@ -243,7 +249,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 		goto err;
 
 	platform_set_drvdata(pdev, chips);
-	ret = davinci_gpio_irq_setup(pdev);
+	ret = davinci_gpio_irq_setup(pdev, bank_irq);
 	if (ret)
 		goto err;
 
@@ -452,16 +458,15 @@ static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
  * (dm6446) can be set appropriately for GPIOV33 pins.
  */
 
-static int davinci_gpio_irq_setup(struct platform_device *pdev)
+static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 {
 	unsigned	gpio, bank;
 	int		irq;
 	int		ret;
 	struct clk	*clk;
 	u32		binten = 0;
-	unsigned	ngpio, bank_irq;
+	unsigned	ngpio;
 	struct device *dev = &pdev->dev;
-	struct resource	*res;
 	struct davinci_gpio_controller *chips = platform_get_drvdata(pdev);
 	struct davinci_gpio_platform_data *pdata = dev->platform_data;
 	struct davinci_gpio_regs __iomem *g;
@@ -481,18 +486,6 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 		gpio_get_irq_chip = (gpio_get_irq_chip_cb_t)match->data;
 
 	ngpio = pdata->ngpio;
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "Invalid IRQ resource\n");
-		return -EBUSY;
-	}
-
-	bank_irq = res->start;
-
-	if (!bank_irq) {
-		dev_err(dev, "Invalid IRQ resource\n");
-		return -ENODEV;
-	}
 
 	clk = devm_clk_get(dev, "gpio");
 	if (IS_ERR(clk)) {
-- 
1.9.1

