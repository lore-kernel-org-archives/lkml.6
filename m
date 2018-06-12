Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 014C4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94122086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kynwLYkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94122086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeFLF2G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:28:06 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29753 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeFLF2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:28:04 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5C5S3Lm025238;
        Tue, 12 Jun 2018 00:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528781283;
        bh=4F4CvV7+DHOqCBEmkaaepWp/O279QkJSEOwDDBzG1SM=;
        h=From:To:CC:Subject:Date;
        b=kynwLYkW9I48eQQ6RWpAuLlb49JUR78WMmWHBy+52p1D/VKL/oZ9dzQrg/N7voK3y
         YvIj+BxMF1kRFaUVtfv8vMgRQ89/d8xUs5/pS7EzsyNQiZ4gfq39bcdSsYpiz0y4NM
         1PLHazAZRZgkqVo4JvnFHdw+yVhi5ym+JnvRRdaY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5C5S3SW023805;
        Tue, 12 Jun 2018 00:28:03 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 00:28:03 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 00:28:03 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5C5S0Ln032243;
        Tue, 12 Jun 2018 00:28:01 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH v2 1/2] gpio: davinci: Shuffle IRQ resource fetching from DT to beginning of probe
Date:   Tue, 12 Jun 2018 10:57:52 +0530
Message-ID: <1528781273-18098-1-git-send-email-j-keerthy@ti.com>
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

Tested for GPIO Interrupts on da850-lcdk and keystone-k2g-evm boards.

No Changes in v2

 drivers/gpio/gpio-davinci.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 987126c..861f35b 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -55,7 +55,7 @@ static inline struct davinci_gpio_regs __iomem *irq2regs(struct irq_data *d)
 	return g;
 }
 
-static int davinci_gpio_irq_setup(struct platform_device *pdev);
+static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq);
 
 /*--------------------------------------------------------------------------*/
 
@@ -168,7 +168,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 {
 	static int ctrl_num, bank_base;
 	int gpio, bank, ret = 0;
-	unsigned ngpio, nbank;
+	unsigned ngpio, nbank, bank_irq;
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
 	struct device *dev = &pdev->dev;
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

