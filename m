Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EilrHVYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BCC4606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932525AbeFFJTK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:19:10 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:21719 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeFFJTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:19:08 -0400
From: Keerthy <j-keerthy@ti.com>
To: <linus.walleij@linaro.org>
CC: <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <t-kristo@ti.com>
Subject: [PATCH 1/2] gpio: davinci: Move fetching IRQ to beginning of probe
Date: Wed, 6 Jun 2018 14:48:53 +0530
Message-ID: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently IRQ resource fetching is done at the very end of probe.
In case the of IRQ resource not being ready, we defer probe
and need to revert prior changes. Hence move it to the beginning of
the probe so as to avoid reverting.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Tested for GPIO Interrupts on da850-lcdk and keystone-k2g-evm boards.

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
+	unsigned int ngpio, nbank, bank_irq;
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
+	unsigned int	ngpio;
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
