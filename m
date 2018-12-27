Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B02214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yaZNONT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeL0GOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:14:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40926 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbeL0GO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:14:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBR6Ds2q042891;
        Thu, 27 Dec 2018 00:13:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545891234;
        bh=6Bxn6N+GWrk3vb3sPK93KMd8FPjCInAorojDfdx2VkQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yaZNONT98a54VhEIVUYbrdYW9+Gt4o8gTyXRLMaxdLrD8NL9HY6RtUj7/rDS7JTPA
         biowVQHRig1kYK8cxhDtQt+tbTZVjWvy3v+0JOPi2mQ8tA8wxn7B163KDQf+BMKzZm
         LPqm8C1OWU8bKURuwCOfgQ5WjupAH5ixJLN63GLU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBR6Ds3K052982
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Dec 2018 00:13:54 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Dec 2018 00:13:54 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 27 Dec 2018 00:13:54 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBR6DRrD026064;
        Thu, 27 Dec 2018 00:13:50 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 07/13] irqchip: ti-sci-intr: Add support for Interrupt Router driver
Date:   Thu, 27 Dec 2018 11:43:07 +0530
Message-ID: <20181227061313.5451-7-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227061313.5451-1-lokeshvutla@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
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
 MAINTAINERS                       |   1 +
 drivers/irqchip/Kconfig           |  11 ++
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-ti-sci-intr.c | 310 ++++++++++++++++++++++++++++++
 4 files changed, 323 insertions(+)
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c7513b02d50..4480eb2fe851 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15024,6 +15024,7 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+F:	drivers/irqchip/irq-ti-sci-intr.c
 
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
index c93713d24b86..b4ff376a08ef 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
+obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
new file mode 100644
index 000000000000..a5396e08412c
--- /dev/null
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Router irqchip driver
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
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
+
+#define TI_SCI_DEV_ID_MASK	0xffff
+#define TI_SCI_DEV_ID_SHIFT	16
+#define TI_SCI_IRQ_ID_MASK	0xffff
+#define TI_SCI_IRQ_ID_SHIFT	0
+#define TI_SCI_EVENT_IRQ	BIT(0)
+
+#define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >> (TI_SCI_DEV_ID_SHIFT)) & \
+				 (TI_SCI_DEV_ID_MASK))
+#define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
+#define FWSPEC_TO_HWIRQ(fwspec)	(((fwspec->param[0] & TI_SCI_DEV_ID_MASK) << \
+				 TI_SCI_DEV_ID_SHIFT) | \
+				(fwspec->param[1] & TI_SCI_IRQ_ID_MASK))
+
+/**
+ * struct ti_sci_intr_irq_domain - Structure representing a TISCI based
+ *				   Interrupt Router IRQ domain.
+ * @sci:	Pointer to TISCI handle
+ * @dst_irq:	TISCI resource pointer representing destination irq controller.
+ * @dst_id:	TISCI device ID of the destination irq controller.
+ */
+struct ti_sci_intr_irq_domain {
+	const struct ti_sci_handle *sci;
+	struct ti_sci_resource *dst_irq;
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
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 4)
+			return -EINVAL;
+
+		*hwirq = FWSPEC_TO_HWIRQ(fwspec);
+		*type = fwspec->param[2];
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static inline void ti_sci_intr_delete_desc(struct ti_sci_intr_irq_domain *intr,
+					   u16 src_id, u16 src_index,
+					   u16 dst_irq)
+{
+	intr->sci->ops.rm_irq_ops.free_direct_irq(intr->sci, src_id, src_index,
+						  intr->dst_id, dst_irq);
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
+	u64 flags;
+	int i;
+
+	intr = domain->host_data;
+
+	for (i = 0; i < nr_irqs; i++) {
+		data = irq_domain_get_irq_data(domain, virq + i);
+		flags = (u64)irq_data_get_irq_chip_data(data);
+		parent_data = irq_domain_get_irq_data(domain->parent, virq + i);
+
+		if (!(flags & TI_SCI_EVENT_IRQ))
+			ti_sci_intr_delete_desc(intr,
+						HWIRQ_TO_DEVID(data->hwirq),
+						HWIRQ_TO_IRQID(data->hwirq),
+						parent_data->hwirq);
+		ti_sci_release_resource(intr->dst_irq, parent_data->hwirq);
+		irq_domain_free_irqs_parent(domain, virq + i, 1);
+		irq_domain_reset_irq_data(data);
+	}
+}
+
+/**
+ * ti_sci_intr_allocate_gic_irq() - Allocate GIC specific IRQ
+ * @domain:	Point to the interrupt router IRQ domain
+ * @dev:	TISCI device IRQ generating the IRQ
+ * @irq:	IRQ offset within the device
+ * @flags:	Corresponding flags to the IRQ
+ * @event_irq:	Flag to tell if requested irq is from interrupt aggregator.
+ *
+ * Returns 0 if all went well else appropriate error pointer.
+ */
+static int ti_sci_intr_allocate_gic_irq(struct irq_domain *domain,
+					unsigned int virq, u16 dev, u16 irq,
+					u32 flags, u8 event_irq)
+{
+	struct ti_sci_intr_irq_domain *intr = domain->host_data;
+	struct irq_fwspec fwspec;
+	u16 dst_irq;
+	int err;
+
+	if (!irq_domain_get_of_node(domain->parent))
+		return -EINVAL;
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
+	/* If event is requested then return */
+	if (event_irq == TI_SCI_EVENT_IRQ)
+		return 0;
+
+	err = intr->sci->ops.rm_irq_ops.set_direct_irq(intr->sci, dev, irq,
+						       intr->dst_id, dst_irq);
+	if (err) {
+		pr_err("%s: IRQ allocation failed from src = %d, src_index = %d to dst_id = %d, dst_irq = %d",
+		       __func__, dev, irq, intr->dst_id, dst_irq);
+		goto err_msg;
+	}
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
+	u16 src_id, src_index;
+	unsigned long hwirq;
+	u8 event_irq;
+	int i, err;
+	u32 type;
+
+	err = ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (err)
+		return err;
+
+	src_id = HWIRQ_TO_DEVID(hwirq);
+	src_index = HWIRQ_TO_IRQID(hwirq);
+	event_irq = fwspec->param[3];
+
+	for (i = 0; i < nr_irqs; i++) {
+		err = ti_sci_intr_allocate_gic_irq(domain, virq + i, src_id,
+						   src_index + i, type,
+						   event_irq);
+		if (err)
+			goto err_irq;
+
+		err = irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+						    &ti_sci_intr_irq_chip,
+						    (void *)(u64)event_irq);
+		if (err)
+			goto err_irq;
+	}
+
+	return 0;
+err_irq:
+	ti_sci_intr_irq_domain_free(domain, virq, i);
+	return err;
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
+	struct ti_sci_intr_irq_domain *intr;
+	struct device_node *parent_node;
+	struct device *dev = &pdev->dev;
+	int ret;
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

