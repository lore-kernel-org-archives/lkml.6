Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeC1OWm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:22:42 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:15086 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752894AbeC1OWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:22:39 -0400
X-IronPort-AV: E=Sophos;i="5.48,371,1517842800";
   d="scan'208";a="275123103"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] gpio: dwapb: Add support for 32 interrupts
Date: Wed, 28 Mar 2018 15:22:30 +0100
Message-Id: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DesignWare GPIO IP can be configured for either 1 or 32 interrupts,
but the driver currently only supports 1 interrupt. See the DesignWare
DW_apb_gpio Databook description of the 'GPIO_INTR_IO' parameter.

This change allows the driver to work with up to 32 interrupts, it will
get as many interrupts as specified in the DT 'interrupts' property.
It doesn't do anything clever with the different interrupts, it just calls
the same handler used for single interrupt hardware.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Note: There are a few lines over 80 chars, but this is just guidance, right?
      Especially as there are already some lines over 80 chars.
---
 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   | 10 ++++-
 drivers/gpio/gpio-dwapb.c                          | 44 +++++++++++++++++-----
 include/linux/platform_data/gpio-dwapb.h           |  3 +-
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
index 4a75da7..e343581 100644
--- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
@@ -26,8 +26,14 @@ controller.
   the second encodes the triger flags encoded as described in
   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 - interrupt-parent : The parent interrupt controller.
-- interrupts : The interrupt to the parent controller raised when GPIOs
-  generate the interrupts.
+- interrupts : The interrupts to the parent controller raised when GPIOs
+  generate the interrupts. If the controller provides one combined interrupt
+  for all GPIOs, specify a single interrupt. If the controller provides one
+  interrupt for each GPIO, provide a list of interrupts that correspond to each
+  of the GPIO pins. When specifying multiple interrupts, if any of the GPIOs are
+  not connected to an interrupt, use the interrupt-mask property.
+- interrupt-mask : a 32-bit bit mask that specifies which interrupts in the list
+  of interrupts is valid, bit is 1 for a valid irq.
 - snps,nr-gpios : The number of pins in the port, a single cell.
 - resets : Reset line for the controller.
 
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 226977f..47d82f9 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -441,14 +441,19 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
 	irq_gc->chip_types[1].handler = handle_edge_irq;
 
 	if (!pp->irq_shared) {
-		irq_set_chained_handler_and_data(pp->irq, dwapb_irq_handler,
-						 gpio);
+		int i;
+
+		for (i = 0; i < pp->ngpio; i++) {
+			if (pp->irq[i])
+				irq_set_chained_handler_and_data(pp->irq[i],
+						dwapb_irq_handler, gpio);
+		}
 	} else {
 		/*
 		 * Request a shared IRQ since where MFD would have devices
 		 * using the same irq pin
 		 */
-		err = devm_request_irq(gpio->dev, pp->irq,
+		err = devm_request_irq(gpio->dev, pp->irq[0],
 				       dwapb_irq_handler_mfd,
 				       IRQF_SHARED, "gpio-dwapb-mfd", gpio);
 		if (err) {
@@ -524,7 +529,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	if (pp->idx == 0)
 		port->gc.set_config = dwapb_gpio_set_config;
 
-	if (pp->irq)
+	if (pp->has_irq)
 		dwapb_configure_irqs(gpio, port, pp);
 
 	err = gpiochip_add_data(&port->gc, port);
@@ -535,7 +540,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 		port->is_registered = true;
 
 	/* Add GPIO-signaled ACPI event support */
-	if (pp->irq)
+	if (pp->has_irq)
 		acpi_gpiochip_request_interrupts(&port->gc);
 
 	return err;
@@ -601,13 +606,34 @@ dwapb_gpio_get_pdata(struct device *dev)
 		if (dev->of_node && pp->idx == 0 &&
 			fwnode_property_read_bool(fwnode,
 						  "interrupt-controller")) {
-			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
-			if (!pp->irq)
+			struct device_node *np = to_of_node(fwnode);
+			u32 irq_mask = 0xFFFFFFFF;
+			int j;
+
+			/* Optional irq mask */
+			fwnode_property_read_u32(fwnode, "interrupt-mask", &irq_mask);
+
+			/*
+			 * The IP has configuration options to allow a single
+			 * combined interrupt or one per gpio. If one per gpio,
+			 * some might not be used.
+			 */
+			for (j = 0; j < pp->ngpio; j++) {
+				if (irq_mask & BIT(j)) {
+					pp->irq[j] = irq_of_parse_and_map(np, j);
+					if (pp->irq[j])
+						pp->has_irq = true;
+				}
+			}
+			if (!pp->has_irq)
 				dev_warn(dev, "no irq for port%d\n", pp->idx);
 		}
 
-		if (has_acpi_companion(dev) && pp->idx == 0)
-			pp->irq = platform_get_irq(to_platform_device(dev), 0);
+		if (has_acpi_companion(dev) && pp->idx == 0) {
+			pp->irq[0] = platform_get_irq(to_platform_device(dev), 0);
+			if (pp->irq[0])
+				pp->has_irq = true;
+		}
 
 		pp->irq_shared	= false;
 		pp->gpio_base	= -1;
diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
index 2dc7f4a..5a52d69 100644
--- a/include/linux/platform_data/gpio-dwapb.h
+++ b/include/linux/platform_data/gpio-dwapb.h
@@ -19,7 +19,8 @@ struct dwapb_port_property {
 	unsigned int	idx;
 	unsigned int	ngpio;
 	unsigned int	gpio_base;
-	unsigned int	irq;
+	unsigned int	irq[32];
+	bool		has_irq;
 	bool		irq_shared;
 };
 
-- 
2.7.4
