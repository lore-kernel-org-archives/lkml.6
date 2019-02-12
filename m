Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A0EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8263E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R+SvdoCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfBLHoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:44:10 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39854 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfBLHoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:44:09 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7hONx016326;
        Tue, 12 Feb 2019 01:43:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549957404;
        bh=jz9GatgUNNHQ4UsUtSfBAkzM59QWDKCr8No1nltM17U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=R+SvdoCUw2Vj8FuKfNq0BOBfveT4xuJhl/00J615RTIXTywVBcqHKYTI8pZg2gQgT
         ycsPhk7Qyc0TpjZgpNJCm/7xfirqQwlGfmmsN318JUXUNM6bKoUfCvQ26FMl10ET1V
         L8E08yHPcwXvf6/s+teUEwz9XEuI87vFq8S11HLY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7hOrI058109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 01:43:24 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:43:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:43:24 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7gss2000385;
        Tue, 12 Feb 2019 01:43:20 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 06/10] irqchip: ti-sci-intr: Add support for Interrupt Router driver
Date:   Tue, 12 Feb 2019 13:12:33 +0530
Message-ID: <20190212074237.2875-7-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212074237.2875-1-lokeshvutla@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments' K3 generation SoCs has an IP Interrupt Router
that does allows for redirection of input interrupts to host
interrupt controller. Interrupt Router inputs are either from a
peripheral or from an Interrupt Aggregator which is another
interrupt controller.

Configuration of the interrupt router registers can only be done by
a system co-processor and the driver needs to send a message to this
co processor over TISCI protocol.

Add support for Interrupt Router driver over TISCI protocol.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v4:
- Moved the ti_sci irq resource handling to ti-sci-common.c from ti_sci.c.
  Firmware maintainer rejected the idea of having this in firmware driver as
  the resource handling is specific to the client.
- Obtain the number of peripheral interrupts attached to INTR by parsing DT.
  Using this information store the max irqs that can be allocated to INTA.
  This is done for pre allocating the INTA irqs(vints) during inta driver
  probe.
  This will not work for cases where there are more that 1 INTAs attached to
  INTR, but wanted to show this approach as suggested by Marc.

 MAINTAINERS                         |   3 +
 drivers/irqchip/Kconfig             |  11 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-ti-sci-common.c | 131 ++++++++++++
 drivers/irqchip/irq-ti-sci-common.h |  59 ++++++
 drivers/irqchip/irq-ti-sci-intr.c   | 315 ++++++++++++++++++++++++++++
 6 files changed, 520 insertions(+)
 create mode 100644 drivers/irqchip/irq-ti-sci-common.c
 create mode 100644 drivers/irqchip/irq-ti-sci-common.h
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c918d9b2ee18..823eeb672cf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15065,6 +15065,9 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+F:	drivers/irqchip/irq-ti-sci-intr.c
+F:	drivers/irqchip/irq-ti-sci-common.c
+F:	drivers/irqchip/irq-ti-sci-common.h
 
 Texas Instruments ASoC drivers
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3d1e60779078..a8d9bed0254b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -406,6 +406,17 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
+config TI_SCI_INTR_IRQCHIP
+	bool
+	depends on TI_SCI_PROTOCOL && ARCH_K3
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  This enables the irqchip driver support for K3 Interrupt router
+	  over TI System Control Interface available on some new TI's SoCs.
+	  If you wish to use interrupt router irq resources managed by the
+	  TI System Controller, say Y here. Otherwise, say N.
+
 endmenu
 
 config SIFIVE_PLIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c93713d24b86..0499fae148a9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
+obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o irq-ti-sci-common.o
diff --git a/drivers/irqchip/irq-ti-sci-common.c b/drivers/irqchip/irq-ti-sci-common.c
new file mode 100644
index 000000000000..79d9c4e8ea14
--- /dev/null
+++ b/drivers/irqchip/irq-ti-sci-common.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Code for TISCI IRQCHIP drivers
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#include <linux/of.h>
+#include <linux/bitmap.h>
+#include <linux/device.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include "irq-ti-sci-common.h"
+
+/**
+ * ti_sci_get_free_resource() - Get a free resource from TISCI resource.
+ * @res:	Pointer to the TISCI resource
+ *
+ * Return: resource num if all went ok else TI_SCI_RESOURCE_NULL.
+ */
+u16 ti_sci_get_free_resource(struct ti_sci_resource *res)
+{
+	u16 set, free_bit;
+
+	mutex_lock(&res->request_mutex);
+	for (set = 0; set < res->sets; set++) {
+		free_bit = find_first_zero_bit(res->desc[set].res_map,
+					       res->desc[set].num);
+		if (free_bit != res->desc[set].num) {
+			set_bit(free_bit, res->desc[set].res_map);
+			mutex_unlock(&res->request_mutex);
+			return res->desc[set].start + free_bit;
+		}
+	}
+	mutex_unlock(&res->request_mutex);
+
+	return TI_SCI_RESOURCE_NULL;
+}
+
+/**
+ * ti_sci_release_resource() - Release a resource from TISCI resource.
+ * @res:	Pointer to the TISCI resource
+ * @id:		Resource id to be released.
+ */
+void ti_sci_release_resource(struct ti_sci_resource *res, u16 id)
+{
+	u16 set;
+
+	mutex_lock(&res->request_mutex);
+	for (set = 0; set < res->sets; set++) {
+		if (res->desc[set].start <= id &&
+		    (res->desc[set].num + res->desc[set].start) > id)
+			clear_bit(id - res->desc[set].start,
+				  res->desc[set].res_map);
+	}
+	mutex_unlock(&res->request_mutex);
+}
+
+u32 ti_sci_get_num_resources(struct ti_sci_resource *res)
+{
+	u32 count = 0, set;
+
+	for (set = 0; set < res->sets; set++)
+		count += res->desc[set].num;
+
+	return count;
+}
+
+/**
+ * devm_ti_sci_get_of_resource() - Get a TISCI resource assigned to a device
+ * @handle:	TISCI handle
+ * @dev:	Device pointer to which the resource is assigned
+ * @of_prop:	property name by which the resource are represented
+ *
+ * Return: Pointer to ti_sci_resource if all went well else appropriate
+ *	   error pointer.
+ */
+struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop)
+{
+	struct ti_sci_resource *res;
+	u32 resource_subtype;
+	int i, ret;
+
+	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	res->sets = of_property_count_elems_of_size(dev_of_node(dev), of_prop,
+						    sizeof(u32));
+	if (res->sets < 0) {
+		dev_err(dev, "%s resource type ids not available\n", of_prop);
+		return ERR_PTR(res->sets);
+	}
+
+	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
+				 GFP_KERNEL);
+	if (!res->desc)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < res->sets; i++) {
+		ret = of_property_read_u32_index(dev_of_node(dev), of_prop, i,
+						 &resource_subtype);
+		if (ret)
+			return ERR_PTR(-EINVAL);
+
+		ret = handle->ops.rm_core_ops.get_range(handle, dev_id,
+							resource_subtype,
+							&res->desc[i].start,
+							&res->desc[i].num);
+		if (ret) {
+			dev_err(dev, "dev = %d subtype %d not allocated for this host\n",
+				dev_id, resource_subtype);
+			return ERR_PTR(ret);
+		}
+
+		dev_dbg(dev, "dev = %d, subtype = %d, start = %d, num = %d\n",
+			dev_id, resource_subtype, res->desc[i].start,
+			res->desc[i].num);
+
+		res->desc[i].res_map =
+			devm_kzalloc(dev, BITS_TO_LONGS(res->desc[i].num) *
+				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
+		if (!res->desc[i].res_map)
+			return ERR_PTR(-ENOMEM);
+	}
+	mutex_init(&res->request_mutex);
+
+	return res;
+}
diff --git a/drivers/irqchip/irq-ti-sci-common.h b/drivers/irqchip/irq-ti-sci-common.h
new file mode 100644
index 000000000000..60c4b28bebab
--- /dev/null
+++ b/drivers/irqchip/irq-ti-sci-common.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common header file for TISCI IRQCHIP drivers
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#ifndef __TI_SCI_COMMON_IRQCHIP_H
+#define __TI_SCI_COMMON_IRQCHIP_H
+
+#include <linux/mutex.h>
+
+#define TI_SCI_RESOURCE_NULL	0xffff
+#define TI_SCI_DEV_ID_MASK	0xffff
+#define TI_SCI_DEV_ID_SHIFT	16
+#define TI_SCI_IRQ_ID_MASK	0xffff
+#define TI_SCI_IRQ_ID_SHIFT	0
+#define TI_SCI_VINT_IRQ		BIT(0)
+#define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >> (TI_SCI_DEV_ID_SHIFT)) & \
+				 (TI_SCI_DEV_ID_MASK))
+#define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
+#define TO_HWIRQ(dev, index)	((((dev) & TI_SCI_DEV_ID_MASK) << \
+				 TI_SCI_DEV_ID_SHIFT) | \
+				((index) & TI_SCI_IRQ_ID_MASK))
+
+/**
+ * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
+ * @start:	Start index of the resource.
+ * @num:	Number of resources.
+ * @res_map:	Bitmap to manage the allocation of these resources.
+ */
+struct ti_sci_resource_desc {
+	u16 start;
+	u16 num;
+	unsigned long *res_map;
+};
+
+/**
+ * struct ti_sci_resource - Structure representing a resource assigned
+ *			    to a device.
+ * @sets:		Number of sets available from this resource type
+ * @request_mutex:	mutex to protect request and release of resources.
+ * @desc:		Array of resource descriptors.
+ */
+struct ti_sci_resource {
+	u16 sets;
+	/* Mutex to protect request and release of resources */
+	struct mutex request_mutex;
+	struct ti_sci_resource_desc *desc;
+};
+
+u16 ti_sci_get_free_resource(struct ti_sci_resource *res);
+void ti_sci_release_resource(struct ti_sci_resource *res, u16 id);
+u32 ti_sci_get_num_resources(struct ti_sci_resource *res);
+struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop);
+#endif /*__TI_SCI_COMMON_IRQCHIP_H */
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
new file mode 100644
index 000000000000..7e224552a735
--- /dev/null
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Router irqchip driver
+ *
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/irqdomain.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include "irq-ti-sci-common.h"
+
+/**
+ * struct ti_sci_intr_irq_domain - Structure representing a TISCI based
+ *				   Interrupt Router IRQ domain.
+ * @sci:	Pointer to TISCI handle
+ * @dst_irq:	TISCI resource pointer representing GIC irq controller.
+ * @vint_irqs:	Number of GIC irqs that can be allocated to INTA.
+ * @dst_id:	TISCI device ID of the GIC irq controller.
+ */
+struct ti_sci_intr_irq_domain {
+	const struct ti_sci_handle *sci;
+	struct ti_sci_resource *dst_irq;
+	u32 vint_irqs;
+	u16 dst_id;
+};
+
+static struct irq_chip ti_sci_intr_irq_chip = {
+	.name			= "INTR",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+/**
+ * ti_sci_intr_irq_domain_translate() - Retrieve hwirq and type from
+ *					IRQ firmware specific handler.
+ * @domain:	Pointer to IRQ domain
+ * @fwspec:	Pointer to IRQ specific firmware structure
+ * @hwirq:	IRQ number identified by hardware
+ * @type:	IRQ type
+ *
+ * Return 0 if all went ok else appropriate error.
+ */
+static int ti_sci_intr_irq_domain_translate(struct irq_domain *domain,
+					    struct irq_fwspec *fwspec,
+					    unsigned long *hwirq,
+					    unsigned int *type)
+{
+	struct ti_sci_intr_irq_domain *intr = domain->host_data;
+
+	if (fwspec->param_count != 4)
+		return -EINVAL;
+
+	*hwirq = TO_HWIRQ(fwspec->param[0], fwspec->param[1]);
+	*type = fwspec->param[2];
+
+	if (fwspec->param[3] != 0 && fwspec->param[3] != 1)
+		return -EINVAL;
+
+	if (fwspec->param[3] && intr->vint_irqs <= 0)
+		return -ERANGE;
+
+	return 0;
+}
+
+static inline void ti_sci_intr_free_gic_irq(struct ti_sci_intr_irq_domain *intr,
+					    u32 hwirq, u16 dst_irq, u8 vint_irq)
+{
+	u16 src_id, src_index;
+
+	src_id = HWIRQ_TO_DEVID(hwirq);
+	src_index = HWIRQ_TO_IRQID(hwirq);
+	intr->sci->ops.rm_irq_ops.free_irq(intr->sci, src_id, src_index,
+					   intr->dst_id, dst_irq, vint_irq);
+	ti_sci_release_resource(intr->dst_irq, dst_irq);
+	if (vint_irq == TI_SCI_VINT_IRQ)
+		intr->vint_irqs++;
+}
+
+/**
+ * ti_sci_intr_irq_domain_free() - Free the specified IRQs from the domain.
+ * @domain:	Domain to which the irqs belong
+ * @virq:	Linux virtual IRQ to be freed.
+ * @nr_irqs:	Number of continuous irqs to be freed
+ */
+static void ti_sci_intr_irq_domain_free(struct irq_domain *domain,
+					unsigned int virq, unsigned int nr_irqs)
+{
+	struct ti_sci_intr_irq_domain *intr = domain->host_data;
+	struct irq_data *data, *parent_data;
+	phys_addr_t vint_irq;
+
+	data = irq_domain_get_irq_data(domain, virq);
+	vint_irq = (phys_addr_t)irq_data_get_irq_chip_data(data);
+	parent_data = irq_domain_get_irq_data(domain->parent, virq);
+
+	ti_sci_intr_free_gic_irq(intr, data->hwirq, parent_data->hwirq,
+				 vint_irq);
+	irq_domain_free_irqs_parent(domain, virq, 1);
+	irq_domain_reset_irq_data(data);
+}
+
+/**
+ * ti_sci_intr_alloc_gic_irq() - Allocate GIC specific IRQ
+ * @domain:	Point to the interrupt router IRQ domain
+ * @virq:	Corresponding Linux virtual IRQ number
+ * @dev:	TISCI device IRQ generating the IRQ
+ * @irq:	IRQ offset within the device
+ * @flags:	Corresponding flags to the IRQ
+ * @vint_irq:	Flag to tell if requested irq is from interrupt aggregator.
+ *
+ * Returns 0 if all went well else appropriate error pointer.
+ */
+static int ti_sci_intr_alloc_gic_irq(struct irq_domain *domain,
+				     unsigned int virq, u32 hwirq, u32 flags,
+				     u8 vint_irq)
+{
+	struct ti_sci_intr_irq_domain *intr = domain->host_data;
+	struct irq_fwspec fwspec;
+	u16 src_id, src_index;
+	u16 dst_irq;
+	int err;
+
+	src_id = HWIRQ_TO_DEVID(hwirq);
+	src_index = HWIRQ_TO_IRQID(hwirq);
+
+	dst_irq = ti_sci_get_free_resource(intr->dst_irq);
+	if (dst_irq == TI_SCI_RESOURCE_NULL)
+		return -EINVAL;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 3;
+	fwspec.param[0] = 0;	/* SPI */
+	fwspec.param[1] = dst_irq - 32; /* SPI offset */
+	fwspec.param[2] = flags & IRQ_TYPE_SENSE_MASK;
+
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (err)
+		goto err_irqs;
+
+	err = intr->sci->ops.rm_irq_ops.set_irq(intr->sci, src_id, src_index,
+						intr->dst_id, dst_irq,
+						vint_irq);
+	if (err)
+		goto err_msg;
+
+	if (vint_irq == TI_SCI_VINT_IRQ)
+		intr->vint_irqs--;
+
+	return 0;
+
+err_msg:
+	irq_domain_free_irqs_parent(domain, virq, 1);
+err_irqs:
+	ti_sci_release_resource(intr->dst_irq, dst_irq);
+	return err;
+}
+
+/**
+ * ti_sci_intr_irq_domain_alloc() - Allocate Interrupt router IRQs
+ * @domain:	Point to the interrupt router IRQ domain
+ * @virq:	Corresponding Linux virtual IRQ number
+ * @nr_irqs:	Continuous irqs to be allocated
+ * @data:	Pointer to firmware specifier
+ *
+ * Return 0 if all went well else appropriate error value.
+ */
+static int ti_sci_intr_irq_domain_alloc(struct irq_domain *domain,
+					unsigned int virq, unsigned int nr_irqs,
+					void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	phys_addr_t vint_irq;
+	unsigned long hwirq;
+	u32 type;
+	int err;
+
+	err = ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (err)
+		return err;
+
+	vint_irq = fwspec->param[3] & TI_SCI_VINT_IRQ;
+
+	err = ti_sci_intr_alloc_gic_irq(domain, virq, hwirq, type, vint_irq);
+	if (err)
+		return err;
+
+	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &ti_sci_intr_irq_chip,
+					    (void *)vint_irq);
+	if (err) {
+		ti_sci_intr_irq_domain_free(domain, virq, 1);
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops ti_sci_intr_irq_domain_ops = {
+	.alloc		= ti_sci_intr_irq_domain_alloc,
+	.free		= ti_sci_intr_irq_domain_free,
+	.translate	= ti_sci_intr_irq_domain_translate,
+};
+
+static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct device_node *parent_node, *dn;
+	struct ti_sci_intr_irq_domain *intr;
+	struct device *dev = &pdev->dev;
+	struct of_phandle_iterator it;
+	int ret, count, intsize;
+
+	parent_node = of_irq_find_parent(dev_of_node(dev));
+	if (!parent_node) {
+		dev_err(dev, "Failed to get IRQ parent node\n");
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent_node);
+	if (!parent_domain) {
+		dev_err(dev, "Failed to find IRQ parent domain\n");
+		return -ENODEV;
+	}
+
+	intr = devm_kzalloc(dev, sizeof(*intr), GFP_KERNEL);
+	if (!intr)
+		return -ENOMEM;
+
+	intr->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
+	if (IS_ERR(intr->sci)) {
+		ret = PTR_ERR(intr->sci);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "ti,sci read fail %d\n", ret);
+		intr->sci = NULL;
+		return ret;
+	}
+
+	ret = of_property_read_u32(dev_of_node(dev), "ti,sci-dst-id",
+				   (u32 *)&intr->dst_id);
+	if (ret) {
+		dev_err(dev, "missing 'ti,sci-dst-id' property\n");
+		return -EINVAL;
+	}
+
+	intr->dst_irq = devm_ti_sci_get_of_resource(intr->sci, dev,
+						    intr->dst_id,
+						    "ti,sci-rm-range-girq");
+	if (IS_ERR(intr->dst_irq)) {
+		dev_err(dev, "Destination irq resource allocation failed\n");
+		return PTR_ERR(intr->dst_irq);
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
+					  &ti_sci_intr_irq_domain_ops, intr);
+	if (!domain) {
+		dev_err(dev, "Failed to allocate IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	if (of_property_read_u32(dev_of_node(dev), "#interrupt-cells",
+				 &intsize))
+		return -EINVAL;
+
+	count = 0;
+	for_each_node_with_property(dn, "interrupts") {
+		if (of_irq_find_parent(dn) != dev_of_node(dev))
+			continue;
+		count += of_property_count_elems_of_size(dn, "interrupts",
+							 sizeof(u32) * intsize);
+	}
+
+	for_each_node_with_property(dn, "interrupts-extended") {
+		of_for_each_phandle(&it, ret, dn, "interrupts-extended",
+				    "#interrupt-cells", 0) {
+			if (it.node == dev_of_node(dev))
+				count++;
+		}
+	}
+
+	intr->vint_irqs = ti_sci_get_num_resources(intr->dst_irq) - count;
+
+	return 0;
+}
+
+static const struct of_device_id ti_sci_intr_irq_domain_of_match[] = {
+	{ .compatible = "ti,sci-intr", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ti_sci_intr_irq_domain_of_match);
+
+static struct platform_driver ti_sci_intr_irq_domain_driver = {
+	.probe = ti_sci_intr_irq_domain_probe,
+	.driver = {
+		.name = "ti-sci-intr",
+		.of_match_table = ti_sci_intr_irq_domain_of_match,
+	},
+};
+module_platform_driver(ti_sci_intr_irq_domain_driver);
+
+MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
+MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
+MODULE_LICENSE("GPL v2");
-- 
2.19.2

