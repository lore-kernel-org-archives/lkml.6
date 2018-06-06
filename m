Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eHtKqsce"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13373601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeFFJTO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:19:14 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:43185 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbeFFJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:19:10 -0400
From: Keerthy <j-keerthy@ti.com>
To: <linus.walleij@linaro.org>
CC: <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <t-kristo@ti.com>
Subject: [PATCH 2/2] gpio: davinci: Do not assume continuous IRQ numbering
Date: Wed, 6 Jun 2018 14:48:54 +0530
Message-ID: <1528276734-1483-2-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver assumes that the interrupts are continuous
and does platform_get_irq only once and assumes the rest are continuous,
instead call platform_get_irq for all the interrupts and store them
in an array for later use.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Tested for GPIO Interrupts on da850-lcdk and keystone-k2g-evm boards.

 drivers/gpio/gpio-davinci.c | 49 ++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 861f35b..375578c 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -42,6 +42,7 @@ struct davinci_gpio_regs {
 
 #define BINTEN	0x8 /* GPIO Interrupt Per-Bank Enable Register */
 #define MAX_LABEL_SIZE 20
+#define MAX_INT_PER_BANK 32
 
 static void __iomem *gpio_base;
 static unsigned int offset_array[5] = {0x10, 0x38, 0x60, 0x88, 0xb0};
@@ -55,7 +56,7 @@ static inline struct davinci_gpio_regs __iomem *irq2regs(struct irq_data *d)
 	return g;
 }
 
-static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq);
+static int davinci_gpio_irq_setup(struct platform_device *pdev, int *bank_irq);
 
 /*--------------------------------------------------------------------------*/
 
@@ -168,7 +169,8 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 {
 	static int ctrl_num, bank_base;
 	int gpio, bank, ret = 0;
-	unsigned ngpio, nbank, bank_irq;
+	unsigned int ngpio, nbank, nirq;
+	int bank_irq[MAX_INT_PER_BANK], i;
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
 	struct device *dev = &pdev->dev;
@@ -197,6 +199,16 @@ static int davinci_gpio_probe(struct platform_device *pdev)
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
@@ -209,10 +221,13 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio_base))
 		return PTR_ERR(gpio_base);
 
-	bank_irq = platform_get_irq(pdev, 0);
-	if (bank_irq < 0) {
-		dev_dbg(dev, "IRQ not populated\n");
-		return bank_irq;
+	for (i = 0; i < nirq; i++) {
+		bank_irq[i] = platform_get_irq(pdev, i);
+		if (bank_irq[i] < 0) {
+			dev_info(dev, "IRQ not populated, err = %d\n",
+				 bank_irq[i]);
+			return bank_irq[i];
+		}
 	}
 
 	snprintf(label, MAX_LABEL_SIZE, "davinci_gpio.%d", ctrl_num++);
@@ -458,7 +473,7 @@ static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
  * (dm6446) can be set appropriately for GPIOV33 pins.
  */
 
-static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
+static int davinci_gpio_irq_setup(struct platform_device *pdev, int *bank_irq)
 {
 	unsigned	gpio, bank;
 	int		irq;
@@ -492,6 +507,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 		dev_err(dev, "Error %ld getting gpio clock\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
+
 	ret = clk_prepare_enable(clk);
 	if (ret)
 		return ret;
@@ -531,12 +547,12 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 	if (pdata->gpio_unbanked) {
 		/* pass "bank 0" GPIO IRQs to AINTC */
 		chips->chip.to_irq = gpio_to_irq_unbanked;
-		chips->base_irq = bank_irq;
+		chips->base_irq = bank_irq[0];
 		chips->gpio_unbanked = pdata->gpio_unbanked;
 		binten = GENMASK(pdata->gpio_unbanked / 16, 0);
 
 		/* AINTC handles mask/unmask; GPIO handles triggering */
-		irq = bank_irq;
+		irq = bank_irq[0];
 		irq_chip = gpio_get_irq_chip(irq);
 		irq_chip->name = "GPIO-AINTC";
 		irq_chip->irq_set_type = gpio_irq_type_unbanked;
@@ -547,10 +563,11 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 		writel_relaxed(~0, &g->set_rising);
 
 		/* set the direct IRQs up to use that irqchip */
-		for (gpio = 0; gpio < pdata->gpio_unbanked; gpio++, irq++) {
-			irq_set_chip(irq, irq_chip);
-			irq_set_handler_data(irq, chips);
-			irq_set_status_flags(irq, IRQ_TYPE_EDGE_BOTH);
+		for (gpio = 0; gpio < pdata->gpio_unbanked; gpio++) {
+			irq_set_chip(bank_irq[gpio], irq_chip);
+			irq_set_handler_data(bank_irq[gpio], chips);
+			irq_set_status_flags(bank_irq[gpio],
+					     IRQ_TYPE_EDGE_BOTH);
 		}
 
 		goto done;
@@ -560,7 +577,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 	 * Or, AINTC can handle IRQs for banks of 16 GPIO IRQs, which we
 	 * then chain through our own handler.
 	 */
-	for (gpio = 0, bank = 0; gpio < ngpio; bank++, bank_irq++, gpio += 16) {
+	for (gpio = 0, bank = 0; gpio < ngpio; bank++, gpio += 16) {
 		/* disabled by default, enabled only as needed
 		 * There are register sets for 32 GPIOs. 2 banks of 16
 		 * GPIOs are covered by each set of registers hence divide by 2
@@ -587,8 +604,8 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
 		irqdata->bank_num = bank;
 		irqdata->chip = chips;
 
-		irq_set_chained_handler_and_data(bank_irq, gpio_irq_handler,
-						 irqdata);
+		irq_set_chained_handler_and_data(bank_irq[bank],
+						 gpio_irq_handler, irqdata);
 
 		binten |= BIT(bank);
 	}
-- 
1.9.1
