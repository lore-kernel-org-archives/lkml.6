Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B8FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1120651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfANTPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:15:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:45889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfANTPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:15:10 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCOdh-1gadEw0soj-009AoY; Mon, 14
 Jan 2019 20:15:07 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 1/2] gpio: hlwd: Add basic IRQ support
Date:   Mon, 14 Jan 2019 20:14:49 +0100
Message-Id: <20190114191450.11597-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114191450.11597-1-j.neuschaefer@gmx.net>
References: <20190114191450.11597-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QLAld9XrVtTSMmrDEexrOGNWxlcLD84M8PRPhwutG2bXLJDy2eh
 Pj4WvSnvw4b4WmoXT1wk2vxRfSPdlw129tqOnmJJEHKY4kQqtqYBDpLFiHmaXdH3t8/QG2u
 GS3JhJvhISO8L2DYhZ47I4xauAJJM2O1o6KBuN/Dgtpw2x+vMNl7K4neErVGxupEr47Le8f
 QH6TdPwAkcQRxSQphWp/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:emt6X8MUkio=:e0SfuFjHn+UZGjuNf9zek6
 SmUbr8G+PwFeVj70ctiS7WYX0zGpDCq3/Kxh3Qe7X1yAyvMvmjftd2f/Ph3/BoH73E6Hs+aJp
 ZG57YjreyTDClQfi5G50LivfGZQHjHf56PpWF0SxlTwfMYJSHEqvwmi9vbbUsEd1vSXO/z/uC
 KeRlxudCfKdb9aHFrlDzcIfLdGSBzwxfTPVpP11DgI98WSGLz5OMxHW8yh7OANVbQwWu2nnIx
 DOD+O+9Hw10cX+hyJA2eV/VhBIMZmPO5zfFS9t8l1SV7ERadZgO6KtgwdDf4CJ+rvOuSm3r5j
 uSrVBWBQnjm+4xfss9YgjbBLpP4iV8wEgsOOF18ZjntSwyoLz342q3bslAVy0eQSTFDZJu2ds
 LWbHa5mQKaUHz3i9jK7r9++zvyEBORTavhbFGA6kd73vfgiXeONWIWAtAxksEQ28If0uhLnee
 MxuV2PFaJzc/lPU4Oc0OCl4SCAWVs+bmt+4KiplRdKeymTau+vTbzq/z/mj08ijYniTju5M/f
 gck4E0JnZ6aRiljAijuhNNtLgWtmOFXFuJX1m4D3wSUT7OgANJSNsMfTx0vr/5x36oO2lRi7F
 3fVUWruolpNOuLm9DFxKnLifLmMxVwYUwbTym/Su5QRl+4My/pEzZFn27xzz1D9y92sCTo0VQ
 c1Il4xvQ6e9fp+HZg6hsICF+PSh5znNXYZYf1R6/4jY5wgaxKzLrNdNuNnMGThnN0pOVEyZNw
 Eakv2jx2E0hen1ShkVZtXBvf59MJ2XW5gznGgNzo9DirgizmBiGQk0h2K47MNTmtidg4x8YNo
 5XsIC44pveJVtIbdER8g2L0HazxpYqRWQ/CsADMqMY4gPPlLkpqoiQI0melSvIFjsRCPXHaSZ
 bmbTEcDVWgc+pBbQoJYQqcx5zEo0/+OKzMr8Qy9JkwE/qZwMoLDqjgNjRJ7Pko/ZvtvZvMspH
 mvDLBdf9bnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements level-triggered IRQs in the Hollywood GPIO driver.
Edge triggered interrupts are not supported in this GPIO controller, so
I moved their emulation into a separate patch.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2:
- Changed register addresses to io{read,write}32be() instead of
  hlwd->gpioc.{read,write}_reg, as suggested by Linus Walleij.
- Changed the IRQ chip's name from "GPIO" to dev_name(&pdev->dev), which
  is "d8000c0.gpio" for the one GPIO controller in the Wii, but might
  help tell the two GPIO controllers in the Wii U apart.
  (also suggested by Linus Walleij)


v1: https://lore.kernel.org/lkml/20190113135844.13109-2-j.neuschaefer@gmx.net/
---
 drivers/gpio/Kconfig     |   1 +
 drivers/gpio/gpio-hlwd.c | 136 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b5a2845347ec..f77180dd87bd 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -258,6 +258,7 @@ config GPIO_HLWD
 	tristate "Nintendo Wii (Hollywood) GPIO"
 	depends on OF_GPIO
 	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
 	help
 	  Select this to support the GPIO controller of the Nintendo Wii.
 
diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index a63136a68ba3..61983c115856 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -48,9 +48,107 @@
 
 struct hlwd_gpio {
 	struct gpio_chip gpioc;
+	struct irq_chip irqc;
 	void __iomem *regs;
+	int irq;
 };
 
+static void hlwd_gpio_irqhandler(struct irq_desc *desc)
+{
+	struct hlwd_gpio *hlwd =
+		gpiochip_get_data(irq_desc_get_handler_data(desc));
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long flags;
+	unsigned long pending;
+	int hwirq;
+
+	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
+	pending = ioread32be(hlwd->regs + HW_GPIOB_INTFLAG);
+	pending &= ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
+	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+
+	chained_irq_enter(chip, desc);
+
+	for_each_set_bit(hwirq, &pending, 32) {
+		int irq = irq_find_mapping(hlwd->gpioc.irq.domain, hwirq);
+
+		generic_handle_irq(irq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void hlwd_gpio_irq_ack(struct irq_data *data)
+{
+	struct hlwd_gpio *hlwd =
+		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+
+	iowrite32be(BIT(data->hwirq), hlwd->regs + HW_GPIOB_INTFLAG);
+}
+
+static void hlwd_gpio_irq_mask(struct irq_data *data)
+{
+	struct hlwd_gpio *hlwd =
+		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	unsigned long flags;
+	u32 mask;
+
+	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
+	mask = ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
+	mask &= ~BIT(data->hwirq);
+	iowrite32be(mask, hlwd->regs + HW_GPIOB_INTMASK);
+	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+}
+
+static void hlwd_gpio_irq_unmask(struct irq_data *data)
+{
+	struct hlwd_gpio *hlwd =
+		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	unsigned long flags;
+	u32 mask;
+
+	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
+	mask = ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
+	mask |= BIT(data->hwirq);
+	iowrite32be(mask, hlwd->regs + HW_GPIOB_INTMASK);
+	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+}
+
+static void hlwd_gpio_irq_enable(struct irq_data *data)
+{
+	hlwd_gpio_irq_ack(data);
+	hlwd_gpio_irq_unmask(data);
+}
+
+static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	struct hlwd_gpio *hlwd =
+		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	unsigned long flags;
+	u32 level;
+
+	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
+
+	switch (flow_type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		level = ioread32be(hlwd->regs + HW_GPIOB_INTLVL);
+		level |= BIT(data->hwirq);
+		iowrite32be(level, hlwd->regs + HW_GPIOB_INTLVL);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		level = ioread32be(hlwd->regs + HW_GPIOB_INTLVL);
+		level &= ~BIT(data->hwirq);
+		iowrite32be(level, hlwd->regs + HW_GPIOB_INTLVL);
+		break;
+	default:
+		spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+		return -EINVAL;
+	}
+
+	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+	return 0;
+}
+
 static int hlwd_gpio_probe(struct platform_device *pdev)
 {
 	struct hlwd_gpio *hlwd;
@@ -92,7 +190,43 @@ static int hlwd_gpio_probe(struct platform_device *pdev)
 		ngpios = 32;
 	hlwd->gpioc.ngpio = ngpios;
 
-	return devm_gpiochip_add_data(&pdev->dev, &hlwd->gpioc, hlwd);
+	res = devm_gpiochip_add_data(&pdev->dev, &hlwd->gpioc, hlwd);
+	if (res)
+		return res;
+
+	/* Mask and ack all interrupts */
+	iowrite32be(0, hlwd->regs + HW_GPIOB_INTMASK);
+	iowrite32be(0xffffffff, hlwd->regs + HW_GPIOB_INTFLAG);
+
+	/*
+	 * If this GPIO controller is not marked as an interrupt controller in
+	 * the DT, return.
+	 */
+	if (!of_property_read_bool(pdev->dev.of_node, "interrupt-controller"))
+		return 0;
+
+	hlwd->irq = platform_get_irq(pdev, 0);
+	if (hlwd->irq < 0) {
+		dev_info(&pdev->dev, "platform_get_irq returned %d\n",
+			 hlwd->irq);
+		return hlwd->irq;
+	}
+
+	hlwd->irqc.name = dev_name(&pdev->dev);
+	hlwd->irqc.irq_mask = hlwd_gpio_irq_mask;
+	hlwd->irqc.irq_unmask = hlwd_gpio_irq_unmask;
+	hlwd->irqc.irq_enable = hlwd_gpio_irq_enable;
+	hlwd->irqc.irq_set_type = hlwd_gpio_irq_set_type;
+
+	res = gpiochip_irqchip_add(&hlwd->gpioc, &hlwd->irqc, 0,
+				   handle_level_irq, IRQ_TYPE_NONE);
+	if (res)
+		return res;
+
+	gpiochip_set_chained_irqchip(&hlwd->gpioc, &hlwd->irqc,
+				     hlwd->irq, hlwd_gpio_irqhandler);
+
+	return 0;
 }
 
 static const struct of_device_id hlwd_gpio_match[] = {
-- 
2.20.1

