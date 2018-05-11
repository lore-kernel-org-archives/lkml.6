Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeEKIbw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:31:52 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:25154 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752389AbeEKIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:31:50 -0400
X-IronPort-AV: E=Sophos;i="5.49,387,1520866800";
   d="scan'208";a="279251877"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A GPIO
Date: Fri, 11 May 2018 09:31:37 +0100
Message-Id: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DesignWare GPIO IP can be configured for either 1 interrupt or 1
per GPIO in port A, but the driver currently only supports 1 interrupt.
See the DesignWare DW_apb_gpio Databook description of the
'GPIO_INTR_IO' parameter.

This change allows the driver to work with up to 32 interrupts, it will
get as many interrupts as specified in the DT 'interrupts' property.
It doesn't do anything clever with the different interrupts, it just calls
the same handler used for single interrupt hardware.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
One point to mention is that I have made it possible for users to have
unconnected interrupts by specifying holes in the list of interrupts. This is
done by supporting the interrupts-extended DT prop.
However, I have no use for this and had to hack some test case for this.
Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?

v6:
 - Treat DT and ACPI the same as much as possible. Note that we can't use
   platform_get_irq() to get the DT interrupts as they are in the port
   sub-node and hence do not have an associated platform device.
v5:
 - Rolled ACPI companion code provided by Hoan Tran into this patch.
v4:
 - Use of_irq_get() instead of of_irq_parse_one()+irq_create_of_mapping()
v3:
 - Rolled mfd: intel_quark_i2c_gpio fix into this patch to avoid bisect problems
v2:
 - Replaced interrupt-mask DT prop with support for the interrupts-extended
   prop. This means replacing the call to irq_of_parse_and_map() with calls
   to of_irq_parse_one() and irq_create_of_mapping().
---
 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |  9 +++-
 drivers/gpio/gpio-dwapb.c                          | 49 +++++++++++++++-------
 drivers/mfd/intel_quark_i2c_gpio.c                 |  3 +-
 include/linux/platform_data/gpio-dwapb.h           |  3 +-
 4 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
index 4a75da7..3c1118b 100644
--- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
@@ -26,8 +26,13 @@ controller.
   the second encodes the triger flags encoded as described in
   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 - interrupt-parent : The parent interrupt controller.
-- interrupts : The interrupt to the parent controller raised when GPIOs
-  generate the interrupts.
+- interrupts : The interrupts to the parent controller raised when GPIOs
+  generate the interrupts. If the controller provides one combined interrupt
+  for all GPIOs, specify a single interrupt. If the controller provides one
+  interrupt for each GPIO, provide a list of interrupts that correspond to each
+  of the GPIO pins. When specifying multiple interrupts, if any are unconnected,
+  use the interrupts-extended property to specify the interrupts and set the
+  interrupt controller handle for unused interrupts to 0.
 - snps,nr-gpios : The number of pins in the port, a single cell.
 - resets : Reset line for the controller.
 
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 226977f..15b4154 100644
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
+			if (pp->irq[i] >= 0)
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
@@ -557,7 +562,7 @@ dwapb_gpio_get_pdata(struct device *dev)
 	struct dwapb_platform_data *pdata;
 	struct dwapb_port_property *pp;
 	int nports;
-	int i;
+	int i, j;
 
 	nports = device_get_child_node_count(dev);
 	if (nports == 0)
@@ -575,6 +580,8 @@ dwapb_gpio_get_pdata(struct device *dev)
 
 	i = 0;
 	device_for_each_child_node(dev, fwnode)  {
+		struct device_node *np = NULL;
+
 		pp = &pdata->properties[i++];
 		pp->fwnode = fwnode;
 
@@ -594,23 +601,35 @@ dwapb_gpio_get_pdata(struct device *dev)
 			pp->ngpio = 32;
 		}
 
+		pp->irq_shared	= false;
+		pp->gpio_base	= -1;
+
 		/*
 		 * Only port A can provide interrupts in all configurations of
 		 * the IP.
 		 */
-		if (dev->of_node && pp->idx == 0 &&
-			fwnode_property_read_bool(fwnode,
+		if (pp->idx != 0)
+			continue;
+
+		if (dev->of_node && fwnode_property_read_bool(fwnode,
 						  "interrupt-controller")) {
-			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
-			if (!pp->irq)
-				dev_warn(dev, "no irq for port%d\n", pp->idx);
+			np = to_of_node(fwnode);
 		}
 
-		if (has_acpi_companion(dev) && pp->idx == 0)
-			pp->irq = platform_get_irq(to_platform_device(dev), 0);
+		for (j = 0; j < pp->ngpio; j++) {
+			pp->irq[j] = -ENXIO;
 
-		pp->irq_shared	= false;
-		pp->gpio_base	= -1;
+			if (np)
+				pp->irq[j] = of_irq_get(np, j);
+			else if (has_acpi_companion(dev))
+				pp->irq[j] = platform_get_irq(to_platform_device(dev), j);
+
+			if (pp->irq[j] >= 0)
+				pp->has_irq = true;
+		}
+
+		if (!pp->has_irq)
+			dev_warn(dev, "no irq for port%d\n", pp->idx);
 	}
 
 	return pdata;
diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 90e35de..5bddb84 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -233,7 +233,8 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 	pdata->properties->idx		= 0;
 	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
 	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
-	pdata->properties->irq		= pdev->irq;
+	pdata->properties->irq[0]	= pdev->irq;
+	pdata->properties->has_irq	= true;
 	pdata->properties->irq_shared	= true;
 
 	cell->platform_data = pdata;
diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
index 2dc7f4a..419cfac 100644
--- a/include/linux/platform_data/gpio-dwapb.h
+++ b/include/linux/platform_data/gpio-dwapb.h
@@ -19,7 +19,8 @@ struct dwapb_port_property {
 	unsigned int	idx;
 	unsigned int	ngpio;
 	unsigned int	gpio_base;
-	unsigned int	irq;
+	int		irq[32];
+	bool		has_irq;
 	bool		irq_shared;
 };
 
-- 
2.7.4
