Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4206CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E013820891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nlGuWQK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E013820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933650AbeFMDlC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:41:02 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:22214 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933058AbeFMDlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:41:00 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5D3exTH032298;
        Tue, 12 Jun 2018 22:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528861259;
        bh=3ZybRiBxRWwJyve1Nit+oKT9tAko4sOQ91sjHchBDV8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nlGuWQK1g2ctyzDxmV/n+Vm5y7Xfcg6Z48POwAYP1KgcAkuP44KW1+BRfCk7Sg2KY
         uE61lZLI0305xuQSKnTFwVESc1IQ20OjIy7fxVrwqlWJ2DCnA7H2voo6Nl7lJYrt4C
         E5W56RBbPxE8HTFtwmSAYTWWoYZaq7sNDLCnqTRg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5D3exO1019172;
        Tue, 12 Jun 2018 22:40:59 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 22:40:58 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 22:40:58 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5D3elQH010765;
        Tue, 12 Jun 2018 22:40:57 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH v4 2/2] gpio: davinci: Do not assume continuous IRQ numbering
Date:   Wed, 13 Jun 2018 09:10:37 +0530
Message-ID: <1528861237-24254-2-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528861237-24254-1-git-send-email-j-keerthy@ti.com>
References: <1528861237-24254-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver assumes that the interrupts are continuous
and does platform_get_irq only once and assumes the rest are continuous,
instead call platform_get_irq for all the interrupts and store them
in an array for later use.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
Tested for GPIO Interrupts on da850-lcdk board.

Changes in v4:

  * Corrected the gpio offset calculation from irq number
    using the lookup.

Changes in v3:

  * Changed irqs type from unsigned to int

Changes in v2:

  * Extended the logic of using saved IRQs to unbanked IRQs
    as per Grygorii's suggestion.

 drivers/gpio/gpio-davinci.c                | 63 ++++++++++++++++++++----------
 include/linux/platform_data/gpio-davinci.h |  3 +-
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 0ff2c0d..b483d84 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -55,7 +55,7 @@ static inline struct davinci_gpio_regs __iomem *irq2regs(struct irq_data *d)
 	return g;
 }
 
-static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq);
+static int davinci_gpio_irq_setup(struct platform_device *pdev);
 
 /*--------------------------------------------------------------------------*/
 
@@ -167,8 +167,8 @@ static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
 static int davinci_gpio_probe(struct platform_device *pdev)
 {
 	static int ctrl_num, bank_base;
-	int gpio, bank, bank_irq, ret = 0;
-	unsigned ngpio, nbank;
+	int gpio, bank, i, ret = 0;
+	unsigned int ngpio, nbank, nirq;
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
 	struct device *dev = &pdev->dev;
@@ -197,6 +197,16 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	if (WARN_ON(ARCH_NR_GPIOS < ngpio))
 		ngpio = ARCH_NR_GPIOS;
 
+	/*
+	 * If there are unbanked interrupts then the number of
+	 * interrupts is equal to number of gpios else all are banked so
+	 * number of interrupts is equal to number of banks(each with 16 gpios)
+	 */
+	if (pdata->gpio_unbanked)
+		nirq = pdata->gpio_unbanked;
+	else
+		nirq = DIV_ROUND_UP(ngpio, 16);
+
 	nbank = DIV_ROUND_UP(ngpio, 32);
 	chips = devm_kzalloc(dev,
 			     nbank * sizeof(struct davinci_gpio_controller),
@@ -209,10 +219,13 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio_base))
 		return PTR_ERR(gpio_base);
 
-	bank_irq = platform_get_irq(pdev, 0);
-	if (bank_irq < 0) {
-		dev_dbg(dev, "IRQ not populated\n");
-		return bank_irq;
+	for (i = 0; i < nirq; i++) {
+		chips->irqs[i] = platform_get_irq(pdev, i);
+		if (chips->irqs[i] < 0) {
+			dev_info(dev, "IRQ not populated, err = %d\n",
+				 chips->irqs[i]);
+			return chips->irqs[i];
+		}
 	}
 
 	snprintf(label, MAX_LABEL_SIZE, "davinci_gpio.%d", ctrl_num++);
@@ -249,7 +262,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 		goto err;
 
 	platform_set_drvdata(pdev, chips);
-	ret = davinci_gpio_irq_setup(pdev, bank_irq);
+	ret = davinci_gpio_irq_setup(pdev);
 	if (ret)
 		goto err;
 
@@ -383,7 +396,7 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
 	 * can provide direct-mapped IRQs to AINTC (up to 32 GPIOs).
 	 */
 	if (offset < d->gpio_unbanked)
-		return d->base_irq + offset;
+		return d->irqs[offset];
 	else
 		return -ENODEV;
 }
@@ -392,11 +405,18 @@ static int gpio_irq_type_unbanked(struct irq_data *data, unsigned trigger)
 {
 	struct davinci_gpio_controller *d;
 	struct davinci_gpio_regs __iomem *g;
-	u32 mask;
+	u32 mask, i;
 
 	d = (struct davinci_gpio_controller *)irq_data_get_irq_handler_data(data);
 	g = (struct davinci_gpio_regs __iomem *)d->regs[0];
-	mask = __gpio_mask(data->irq - d->base_irq);
+	for (i = 0; i < MAX_INT_PER_BANK; i++)
+		if (data->irq == d->irqs[i])
+			break;
+
+	if (i == MAX_INT_PER_BANK)
+		return -EINVAL;
+
+	mask = __gpio_mask(i);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		return -EINVAL;
@@ -458,7 +478,7 @@ static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
  * (dm6446) can be set appropriately for GPIOV33 pins.
  */
 
-static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
+static int davinci_gpio_irq_setup(struct platform_device *pdev)
 {
 	unsigned	gpio, bank;
 	int		irq;
@@ -492,6 +512,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 		dev_err(dev, "Error %ld getting gpio clock\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
+
 	ret = clk_prepare_enable(clk);
 	if (ret)
 		return ret;
@@ -531,12 +552,11 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 	if (pdata->gpio_unbanked) {
 		/* pass "bank 0" GPIO IRQs to AINTC */
 		chips->chip.to_irq = gpio_to_irq_unbanked;
-		chips->base_irq = bank_irq;
 		chips->gpio_unbanked = pdata->gpio_unbanked;
 		binten = GENMASK(pdata->gpio_unbanked / 16, 0);
 
 		/* AINTC handles mask/unmask; GPIO handles triggering */
-		irq = bank_irq;
+		irq = chips->irqs[0];
 		irq_chip = gpio_get_irq_chip(irq);
 		irq_chip->name = "GPIO-AINTC";
 		irq_chip->irq_set_type = gpio_irq_type_unbanked;
@@ -547,10 +567,11 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 		writel_relaxed(~0, &g->set_rising);
 
 		/* set the direct IRQs up to use that irqchip */
-		for (gpio = 0; gpio < pdata->gpio_unbanked; gpio++, irq++) {
-			irq_set_chip(irq, irq_chip);
-			irq_set_handler_data(irq, chips);
-			irq_set_status_flags(irq, IRQ_TYPE_EDGE_BOTH);
+		for (gpio = 0; gpio < pdata->gpio_unbanked; gpio++) {
+			irq_set_chip(chips->irqs[gpio], irq_chip);
+			irq_set_handler_data(chips->irqs[gpio], chips);
+			irq_set_status_flags(chips->irqs[gpio],
+					     IRQ_TYPE_EDGE_BOTH);
 		}
 
 		goto done;
@@ -560,7 +581,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 	 * Or, AINTC can handle IRQs for banks of 16 GPIO IRQs, which we
 	 * then chain through our own handler.
 	 */
-	for (gpio = 0, bank = 0; gpio < ngpio; bank++, bank_irq++, gpio += 16) {
+	for (gpio = 0, bank = 0; gpio < ngpio; bank++, gpio += 16) {
 		/* disabled by default, enabled only as needed
 		 * There are register sets for 32 GPIOs. 2 banks of 16
 		 * GPIOs are covered by each set of registers hence divide by 2
@@ -587,8 +608,8 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 		irqdata->bank_num = bank;
 		irqdata->chip = chips;
 
-		irq_set_chained_handler_and_data(bank_irq, gpio_irq_handler,
-						 irqdata);
+		irq_set_chained_handler_and_data(chips->irqs[bank],
+						 gpio_irq_handler, irqdata);
 
 		binten |= BIT(bank);
 	}
diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index 90ae19c..57a5a35 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -22,6 +22,7 @@
 #include <asm-generic/gpio.h>
 
 #define MAX_REGS_BANKS		5
+#define MAX_INT_PER_BANK 32
 
 struct davinci_gpio_platform_data {
 	u32	ngpio;
@@ -41,7 +42,7 @@ struct davinci_gpio_controller {
 	spinlock_t		lock;
 	void __iomem		*regs[MAX_REGS_BANKS];
 	int			gpio_unbanked;
-	unsigned int		base_irq;
+	int			irqs[MAX_INT_PER_BANK];
 	unsigned int		base;
 };
 
-- 
1.9.1

