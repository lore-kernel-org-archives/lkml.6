Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbeEWIwy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:52:54 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:42257 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754168AbeEWIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:52:51 -0400
X-IronPort-AV: E=Sophos;i="5.49,432,1520866800";
   d="scan'208";a="281820586"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] gpio: dwapb: Rework support for 1 interrupt per port A GPIO
Date: Wed, 23 May 2018 09:52:44 +0100
Message-Id: <1527065564-9127-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat DT and ACPI the same as much as possible. Note that we can't use
platform_get_irq() to get the DT interrupts as they are in the port
sub-node and hence do not have an associated platform device.

This also fixes a problem introduced with error checking when calling
platform_get_irq().

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/gpio/gpio-dwapb.c | 53 ++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 7dcd06b..15b4154 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -444,7 +444,7 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
 		int i;
 
 		for (i = 0; i < pp->ngpio; i++) {
-			if (pp->irq[i])
+			if (pp->irq[i] >= 0)
 				irq_set_chained_handler_and_data(pp->irq[i],
 						dwapb_irq_handler, gpio);
 		}
@@ -562,7 +562,7 @@ dwapb_gpio_get_pdata(struct device *dev)
 	struct dwapb_platform_data *pdata;
 	struct dwapb_port_property *pp;
 	int nports;
-	int i;
+	int i, j;
 
 	nports = device_get_child_node_count(dev);
 	if (nports == 0)
@@ -580,6 +580,8 @@ dwapb_gpio_get_pdata(struct device *dev)
 
 	i = 0;
 	device_for_each_child_node(dev, fwnode)  {
+		struct device_node *np = NULL;
+
 		pp = &pdata->properties[i++];
 		pp->fwnode = fwnode;
 
@@ -599,46 +601,35 @@ dwapb_gpio_get_pdata(struct device *dev)
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
-						  "interrupt-controller")) {
-			struct device_node *np = to_of_node(fwnode);
-			unsigned int j;
-
-			/*
-			 * The IP has configuration options to allow a single
-			 * combined interrupt or one per gpio. If one per gpio,
-			 * some might not be used.
-			 */
-			for (j = 0; j < pp->ngpio; j++) {
-				int irq = of_irq_get(np, j);
-				if (irq < 0)
-					continue;
-
-				pp->irq[j] = irq;
-				pp->has_irq = true;
-			}
+		if (pp->idx != 0)
+			continue;
 
-			if (!pp->has_irq)
-				dev_warn(dev, "no irq for port%d\n", pp->idx);
+		if (dev->of_node && fwnode_property_read_bool(fwnode,
+						  "interrupt-controller")) {
+			np = to_of_node(fwnode);
 		}
 
-		if (has_acpi_companion(dev) && pp->idx == 0) {
-			unsigned int j;
+		for (j = 0; j < pp->ngpio; j++) {
+			pp->irq[j] = -ENXIO;
 
-			for (j = 0; j < pp->ngpio; j++) {
+			if (np)
+				pp->irq[j] = of_irq_get(np, j);
+			else if (has_acpi_companion(dev))
 				pp->irq[j] = platform_get_irq(to_platform_device(dev), j);
-				if (pp->irq[j])
-					pp->has_irq = true;
-			}
+
+			if (pp->irq[j] >= 0)
+				pp->has_irq = true;
 		}
 
-		pp->irq_shared	= false;
-		pp->gpio_base	= -1;
+		if (!pp->has_irq)
+			dev_warn(dev, "no irq for port%d\n", pp->idx);
 	}
 
 	return pdata;
-- 
2.7.4
