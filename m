Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD7DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57A520863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfBHKkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:40:51 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48119 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:40:50 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3AFE31C0008;
        Fri,  8 Feb 2019 10:40:47 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] gpio: zynq: properly support runtime PM for GPIO used as interrupts
Date:   Fri,  8 Feb 2019 11:40:46 +0100
Message-Id: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Zynq GPIO driver currently implements runtime PM by:

 - Enabling runtime PM support in ->probe() and letting the runtime PM
   reference counter drop to zero at the end of ->probe().

 - Increasing the runtime PM reference counter in ->request() and
   decreasing it in ->free().

However, the latter is not sufficient: when a GPIO is used as an
interrupt, ->request() and ->free() are not called. Due to this, the
runtime PM counter remains to zero when the only GPIOs in use are used
as interrupts, causing them to simply not work.

To address this problem, this commit implement the
->irq_request_resources() and ->irq_release_resources() hooks,
ensuring that the runtime PM counter is properly
incremented/decremented. Since we override the default hooks, we keep
the existing behavior by making sure they call gpiochip_reqres_irq() /
gpiochip_relres_irq() respectively.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/gpio/gpio-zynq.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 3f5fcdd5a429..65c0c29ce851 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -533,6 +533,26 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
+static int zynq_gpio_irq_reqres(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int ret;
+
+	ret = pm_runtime_get_sync(chip->parent);
+	if (ret < 0)
+		return ret;
+
+	return gpiochip_reqres_irq(chip, d->hwirq);
+}
+
+static void zynq_gpio_irq_relres(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+
+	gpiochip_relres_irq(chip, d->hwirq);
+	pm_runtime_put(chip->parent);
+}
+
 /* irq chip descriptor */
 static struct irq_chip zynq_gpio_level_irqchip = {
 	.name		= DRIVER_NAME,
@@ -542,6 +562,8 @@ static struct irq_chip zynq_gpio_level_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources = zynq_gpio_irq_reqres,
+	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
 			  IRQCHIP_MASK_ON_SUSPEND,
 };
@@ -554,6 +576,8 @@ static struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources = zynq_gpio_irq_reqres,
+	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND,
 };
 
-- 
2.20.1

