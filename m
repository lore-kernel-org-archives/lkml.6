Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600DEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AA42083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v+iGJ8wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfBLHo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:44:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40434 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfBLHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:44:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7hXKU005376;
        Tue, 12 Feb 2019 01:43:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549957413;
        bh=t/z6qGlQVK89zXWHO0YPaiFzIhO77306BokwRa9/nDQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=v+iGJ8wIz9r8NlrtenbvNvVILPMGwhwalx0NYg/CdY+BUUV6kJkG9eXosMWxGaQlx
         preMprNle7m5BvzICJBUxw83MLAoGzHrq38qQFoAQ+oNGcp2WVa/b+PJ1KDYKvwoAI
         UqCrAVQ8sm1dQODmtFWLlk3cwCza1dlITa4lqXgA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7hXI2020174
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 01:43:33 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:43:32 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:43:32 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7gss4000385;
        Tue, 12 Feb 2019 01:43:28 -0600
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
Subject: [PATCH v5 08/10] irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
Date:   Tue, 12 Feb 2019 13:12:35 +0530
Message-ID: <20190212074237.2875-9-lokeshvutla@ti.com>
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

Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
which is an interrupt controller that does the following:
- Converts events to interrupts that can be understood by
  an interrupt router.
- Allows for multiplexing of events to interrupts.

Configuration of the interrupt aggregator registers can only be done by
a system co-processor and the driver needs to send a message to this
co processor over TISCI protocol.

Add support for Interrupt Aggregator driver with 2 IRQ Domains:
- INTA MSI domain that interfaces the devices using which interrupts can be
  allocated dynamically.
- INTA domain that is parent to the MSI domain that manages the interrupt
  resources.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Changes since v4:
- Allocate the INTA output interrupts during probe.

 MAINTAINERS                       |   1 +
 drivers/irqchip/Kconfig           |  12 +
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-ti-sci-inta.c | 531 ++++++++++++++++++++++++++++++
 4 files changed, 545 insertions(+)
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 970c732b7158..44a3392239d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15069,6 +15069,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/irqchip/irq-ti-sci-common.c
 F:	drivers/irqchip/irq-ti-sci-common.h
+F:	drivers/irqchip/irq-ti-sci-inta.c
 
 Texas Instruments ASoC drivers
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a8d9bed0254b..d16fd39408ad 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -417,6 +417,18 @@ config TI_SCI_INTR_IRQCHIP
 	  If you wish to use interrupt router irq resources managed by the
 	  TI System Controller, say Y here. Otherwise, say N.
 
+config TI_SCI_INTA_IRQCHIP
+	bool
+	depends on TI_SCI_PROTOCOL && ARCH_K3
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	select K3_INTA_MSI_DOMAIN
+	help
+	  This enables the irqchip driver support for K3 Interrupt aggregator
+	  over TI System Control Interface available on some new TI's SoCs.
+	  If you wish to use interrupt aggregator irq resources managed by the
+	  TI System Controller, say Y here. Otherwise, say N.
+
 endmenu
 
 config SIFIVE_PLIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0499fae148a9..caf6d084e0d4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,3 +95,4 @@ obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o irq-ti-sci-common.o
+obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o irq-ti-sci-common.o
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
new file mode 100644
index 000000000000..131944fec6fe
--- /dev/null
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Aggregator irqchip driver
+ *
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/msi.h>
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/soc/ti/k3_inta_msi.h>
+#include <linux/irqchip/chained_irq.h>
+#include <asm-generic/msi.h>
+#include "irq-ti-sci-common.h"
+
+#define MAX_EVENTS_PER_VINT	64
+
+#define VINT_ENABLE_SET_OFFSET	0x0
+#define VINT_ENABLE_CLR_OFFSET	0x8
+#define VINT_STATUS_OFFSET	0x18
+
+/**
+ * struct ti_sci_inta_event_desc - Description of an event coming to
+ *				   Interrupt Aggregator.
+ * @global_event:	Global event number corresponding to this event
+ * @src_id:		TISCI device ID of the event source
+ * @src_index:		Event source index within the device.
+ */
+struct ti_sci_inta_event_desc {
+	u16 global_event;
+	u16 src_id;
+	u16 src_index;
+};
+
+/**
+ * struct ti_sci_inta_vint_desc - Description of a virtual interrupt coming out
+ *				  of Interrupt Aggregator.
+ * @domain:		Pointer to IRQ domain to which this vint belongs.
+ * @list:		List entry for the vint list
+ * @event_lock:		lock to guard the event map
+ * @event_map:		Bitmap to manage the allocation of events to vint.
+ * @events:		Array of event descriptors assigned to this vint.
+ * @parent_virq:	Linux IRQ number that gets attached to parent
+ * @vint_id:		TISCI vint ID
+ */
+struct ti_sci_inta_vint_desc {
+	struct irq_domain *domain;
+	struct list_head list;
+	struct mutex event_lock;
+	unsigned long *event_map;
+	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
+	unsigned int parent_virq;
+	u16 vint_id;
+};
+
+/**
+ * struct ti_sci_inta_irq_domain - Structure representing a TISCI based
+ *				   Interrupt Aggregator IRQ domain.
+ * @sci:		Pointer to TISCI handle
+ * @vint:		TISCI resource pointer representing IA inerrupts.
+ * @global_event:	TISCI resource pointer representing global events.
+ * @vint_list:		List of the vints active in the system
+ * @base:		Base address of the memory mapped IO registers
+ * @ia_id:		TISCI device ID of this Interrupt Aggregator.
+ */
+struct ti_sci_inta_irq_domain {
+	const struct ti_sci_handle *sci;
+	struct ti_sci_resource *vint;
+	struct ti_sci_resource *global_event;
+	struct list_head vint_list;
+	void __iomem *base;
+	u16 ia_id;
+};
+
+static int __get_event_index(struct ti_sci_inta_vint_desc *vint_desc,
+			     int global_event)
+{
+	int event_index = -ENODEV, i;
+
+	for (i = 0; i < MAX_EVENTS_PER_VINT; i++) {
+		if (vint_desc->events[i].global_event == global_event) {
+			event_index = i;
+			break;
+		}
+	}
+
+	return event_index;
+}
+
+static void __ti_sci_inta_manage_event(struct irq_data *data, u32 offset)
+{
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct ti_sci_inta_irq_domain *inta;
+	int global_event, event_index;
+
+	vint_desc = irq_data_get_irq_chip_data(data);
+	global_event = data->hwirq;
+	event_index = __get_event_index(vint_desc, global_event);
+	inta = vint_desc->domain->host_data;
+
+	if (event_index < 0)
+		return;
+
+	writeq_relaxed(BIT(event_index), inta->base +
+		       vint_desc->vint_id * 0x1000 + offset);
+}
+
+static void ti_sci_inta_mask_irq(struct irq_data *data)
+{
+	__ti_sci_inta_manage_event(data, VINT_ENABLE_CLR_OFFSET);
+}
+
+static void ti_sci_inta_unmask_irq(struct irq_data *data)
+{
+	__ti_sci_inta_manage_event(data, VINT_ENABLE_SET_OFFSET);
+}
+
+static int ti_sci_inta_set_affinity(struct irq_data *d,
+				    const struct cpumask *mask_val, bool force)
+{
+	struct ti_sci_inta_vint_desc *vint_desc = irq_data_get_irq_chip_data(d);
+	struct irq_chip *chip = irq_get_chip(vint_desc->parent_virq);
+	struct irq_data *data = irq_get_irq_data(vint_desc->parent_virq);
+
+	if (chip && chip->irq_set_affinity)
+		return chip->irq_set_affinity(data, mask_val, force);
+	else
+		return -EINVAL;
+}
+
+static struct irq_chip ti_sci_inta_irq_chip = {
+	.name			= "INTA",
+	.irq_mask		= ti_sci_inta_mask_irq,
+	.irq_unmask		= ti_sci_inta_unmask_irq,
+	.irq_set_affinity	= ti_sci_inta_set_affinity,
+};
+
+/**
+ * ti_sci_free_event_irq() - Free an event from vint
+ * @domain:	Pointer to Interrupt Aggregator IRQ domain
+ * @vint_desc:	Virtual interrupt descriptor containing the event.
+ * @global_event: Global event id to be freed.
+ */
+static void ti_sci_free_event_irq(struct irq_domain *domain,
+				  struct ti_sci_inta_vint_desc *vint_desc,
+				  u16 global_event)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->host_data;
+	struct ti_sci_inta_event_desc *event_desc;
+	int event_index = 0;
+
+	event_index = __get_event_index(vint_desc, global_event);
+	event_desc = &vint_desc->events[event_index];
+	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
+						 event_desc->src_id,
+						 event_desc->src_index,
+						 inta->ia_id,
+						 vint_desc->vint_id,
+						 event_desc->global_event,
+						 event_index);
+
+	clear_bit(event_index, vint_desc->event_map);
+
+	ti_sci_release_resource(inta->global_event, event_desc->global_event);
+}
+
+static void ti_sci_inta_free_vint(struct ti_sci_inta_irq_domain *inta,
+				  struct ti_sci_inta_vint_desc *vint_desc)
+{
+	/* If all events are cleared, release vint */
+	if (find_first_bit(vint_desc->event_map, MAX_EVENTS_PER_VINT) ==
+	    MAX_EVENTS_PER_VINT)
+		ti_sci_release_resource(inta->vint, vint_desc->vint_id);
+}
+
+/**
+ * ti_sci_inta_irq_domain_free() - Free an IRQ from the IRQ domain
+ * @domain:	Domain to which the irqs belong
+ * @virq:	base linux virtual IRQ to be freed.
+ * @nr_irqs:	Number of continuous irqs to be freed
+ */
+static void ti_sci_inta_irq_domain_free(struct irq_domain *domain,
+					unsigned int virq, unsigned int nr_irqs)
+{
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct irq_data *data;
+
+	data = irq_domain_get_irq_data(domain, virq);
+	vint_desc = irq_data_get_irq_chip_data(data);
+
+	ti_sci_free_event_irq(domain, vint_desc, data->hwirq);
+	ti_sci_inta_free_vint(domain->host_data, vint_desc);
+	irq_domain_reset_irq_data(data);
+}
+
+/**
+ * ti_sci_allocate_event_irq() - Allocate an event to a IA vint.
+ *
+ * Return global_event if all went ok else appropriate error value.
+ */
+static
+int ti_sci_allocate_event_irq(struct irq_domain *domain, msi_alloc_info_t *arg)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->host_data;
+	struct ti_sci_inta_event_desc *event_desc;
+	struct ti_sci_inta_vint_desc *vint_desc;
+	u16 free_bit, src_id, src_index;
+	int err;
+
+	src_id = HWIRQ_TO_DEVID(arg->hwirq);
+	src_index = HWIRQ_TO_IRQID(arg->hwirq);
+	vint_desc = arg->scratchpad[0].ptr;
+
+	mutex_lock(&vint_desc->event_lock);
+	free_bit = find_first_zero_bit(vint_desc->event_map,
+				       MAX_EVENTS_PER_VINT);
+	if (free_bit != MAX_EVENTS_PER_VINT)
+		set_bit(free_bit, vint_desc->event_map);
+	mutex_unlock(&vint_desc->event_lock);
+
+	event_desc = &vint_desc->events[free_bit];
+
+	event_desc->src_id = src_id;
+	event_desc->src_index = src_index;
+	event_desc->global_event = ti_sci_get_free_resource(inta->global_event);
+	if (event_desc->global_event == TI_SCI_RESOURCE_NULL) {
+		err = -EINVAL;
+		goto free_event;
+	}
+
+	err = inta->sci->ops.rm_irq_ops.set_event_map(inta->sci,
+						      src_id, src_index,
+						      inta->ia_id,
+						      vint_desc->vint_id,
+						      event_desc->global_event,
+						      free_bit);
+	if (err)
+		goto free_global_event;
+
+	return event_desc->global_event;
+free_global_event:
+	ti_sci_release_resource(inta->global_event, event_desc->global_event);
+free_event:
+	clear_bit(free_bit, vint_desc->event_map);
+	return err;
+}
+
+struct ti_sci_inta_vint_desc *
+ti_sci_inta_get_vint(struct ti_sci_inta_irq_domain *inta, u16 vint)
+{
+	struct ti_sci_inta_vint_desc *vint_desc;
+
+	list_for_each_entry(vint_desc, &inta->vint_list, list)
+		if (vint_desc->vint_id == vint)
+			return vint_desc;
+	return NULL;
+}
+
+/**
+ * ti_sci_inta_irq_domain_alloc() - Allocate Interrupt aggregator IRQs
+ * @domain:	Point to the interrupt aggregator IRQ domain
+ * @virq:	Corresponding Linux virtual IRQ number
+ * @nr_irqs:	Continuous irqs to be allocated
+ * @data:	Pointer to firmware specifier
+ *
+ * Return 0 if all went well else appropriate error value.
+ */
+static int ti_sci_inta_irq_domain_alloc(struct irq_domain *domain,
+					unsigned int virq, unsigned int nr_irqs,
+					void *data)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->host_data;
+	msi_alloc_info_t *arg = data;
+	int hwirq;
+	u16 vint;
+
+	if (arg->desc->inta.share) {
+		if (!arg->scratchpad[0].ptr) {
+			vint = ti_sci_get_free_resource(inta->vint);
+			arg->scratchpad[0].ptr = ti_sci_inta_get_vint(inta,
+								      vint);
+		}
+	} else {
+		vint = ti_sci_get_free_resource(inta->vint);
+		arg->scratchpad[0].ptr = ti_sci_inta_get_vint(inta, vint);
+	}
+
+	hwirq = ti_sci_allocate_event_irq(domain, arg);
+	if (hwirq < 0)
+		return hwirq;
+
+	irq_domain_set_info(domain, virq, hwirq, &ti_sci_inta_irq_chip,
+			    arg->scratchpad[0].ptr, handle_simple_irq,
+			    NULL, NULL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
+	.alloc		= ti_sci_inta_irq_domain_alloc,
+	.free		= ti_sci_inta_irq_domain_free,
+};
+
+static struct irq_chip inta_msi_irq_chip = {
+	.name		= "MSI-INTA",
+};
+
+static void inta_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = TO_HWIRQ(desc->inta.dev_id, desc->inta.index);
+}
+
+static struct msi_domain_ops inta_msi_ops = {
+	.set_desc	= inta_msi_set_desc,
+};
+
+static struct msi_domain_info inta_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &inta_msi_ops,
+	.chip	= &inta_msi_irq_chip,
+};
+
+static void inta_msi_irq_handler(struct irq_desc *desc)
+{
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct ti_sci_inta_irq_domain *inta;
+	struct irq_domain *domain;
+	struct irq_data *irq_data;
+	u32 hwirq, bit, virq;
+	u64 val;
+
+	vint_desc = irq_desc_get_handler_data(desc);
+	domain = vint_desc->domain;
+	inta = domain->host_data;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
+			    VINT_STATUS_OFFSET);
+
+	for (bit = 0; bit < MAX_EVENTS_PER_VINT; bit++) {
+		if (BIT(bit) & val) {
+			hwirq = vint_desc->events[bit].global_event;
+			virq = irq_find_mapping(domain, hwirq);
+			irq_data = irq_get_irq_data(virq);
+			if (irqd_get_trigger_type(irq_data) ==
+			    IRQF_TRIGGER_HIGH)
+				writeq_relaxed(BIT(bit),
+					       inta->base + vint_desc->vint_id *
+					       0x1000 + VINT_STATUS_OFFSET);
+
+			if (virq)
+				generic_handle_irq(virq);
+		}
+	}
+
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+/**
+ * ti_sci_inta_alloc_parent_irq() - Allocate parent irq to Interrupt aggregator
+ * @domain:	IRQ domain corresponding to Interrupt Aggregator
+ * @virq:	Linux virtual IRQ number
+ *
+ * Return 0 if all went well else corresponding error value.
+ */
+static int ti_sci_inta_alloc_parent_irq(struct irq_domain *domain, u16 vint_id)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->host_data;
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct irq_fwspec parent_fwspec;
+	unsigned int virq;
+
+	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
+	if (!vint_desc)
+		return -ENOMEM;
+
+	vint_desc->event_map = kcalloc(BITS_TO_LONGS(MAX_EVENTS_PER_VINT),
+				       sizeof(*vint_desc->event_map),
+				       GFP_KERNEL);
+	if (!vint_desc->event_map) {
+		kfree(vint_desc);
+		return -ENOMEM;
+	}
+
+	vint_desc->domain = domain;
+	vint_desc->vint_id = vint_id;
+	INIT_LIST_HEAD(&vint_desc->list);
+	list_add_tail(&vint_desc->list, &inta->vint_list);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 4;
+	/* Interrupt parent is Interrupt Router */
+	parent_fwspec.param[0] = inta->ia_id;
+	parent_fwspec.param[1] = vint_desc->vint_id;
+	parent_fwspec.param[2] = IRQF_TRIGGER_HIGH;
+	parent_fwspec.param[3] = 1;
+
+	virq = irq_create_fwspec_mapping(&parent_fwspec);
+	if (virq <= 0) {
+		kfree(vint_desc->event_map);
+		kfree(vint_desc);
+		return -ERANGE;
+	}
+
+	irq_set_chained_handler_and_data(virq, inta_msi_irq_handler, vint_desc);
+
+	mutex_init(&vint_desc->event_lock);
+
+	return 0;
+}
+
+static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
+{
+	struct irq_domain *parent_domain, *domain, *msi_domain;
+	struct device_node *parent_node, *node;
+	struct ti_sci_inta_irq_domain *inta;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret, set, i;
+
+	node = dev_of_node(dev);
+	parent_node = of_irq_find_parent(node);
+	if (!parent_node) {
+		dev_err(dev, "Failed to get IRQ parent node\n");
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent_node);
+	if (!parent_domain)
+		return -EPROBE_DEFER;
+
+	inta = devm_kzalloc(dev, sizeof(*inta), GFP_KERNEL);
+	if (!inta)
+		return -ENOMEM;
+
+	inta->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
+	if (IS_ERR(inta->sci)) {
+		ret = PTR_ERR(inta->sci);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "ti,sci read fail %d\n", ret);
+		inta->sci = NULL;
+		return ret;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id",
+				   (u32 *)&inta->ia_id);
+	if (ret) {
+		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
+		return -EINVAL;
+	}
+
+	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev,
+						 inta->ia_id,
+						 "ti,sci-rm-range-vint");
+	if (IS_ERR(inta->vint)) {
+		dev_err(dev, "VINT resource allocation failed\n");
+		return PTR_ERR(inta->vint);
+	}
+
+	inta->global_event =
+		devm_ti_sci_get_of_resource(inta->sci, dev,
+					    inta->ia_id,
+					    "ti,sci-rm-range-global-event");
+	if (IS_ERR(inta->global_event)) {
+		dev_err(dev, "Global event resource allocation failed\n");
+		return PTR_ERR(inta->global_event);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	inta->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(inta->base))
+		return -ENODEV;
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
+					  &ti_sci_inta_irq_domain_ops, inta);
+	if (!domain) {
+		dev_err(dev, "Failed to allocate IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi_domain = inta_msi_create_irq_domain(of_node_to_fwnode(node),
+						&inta_msi_domain_info,
+						domain);
+	if (!msi_domain) {
+		irq_domain_remove(domain);
+		dev_err(dev, "Failed to allocate msi domain\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&inta->vint_list);
+	for (set = 0; set < inta->vint->sets; set++) {
+		for (i = 0; i < inta->vint->desc[set].num; i++) {
+			if (ti_sci_inta_alloc_parent_irq(domain,
+					inta->vint->desc[set].start + i))
+				break;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ti_sci_inta_irq_domain_of_match[] = {
+	{ .compatible = "ti,sci-inta", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ti_sci_inta_irq_domain_of_match);
+
+static struct platform_driver ti_sci_inta_irq_domain_driver = {
+	.probe = ti_sci_inta_irq_domain_probe,
+	.driver = {
+		.name = "ti-sci-inta",
+		.of_match_table = ti_sci_inta_irq_domain_of_match,
+	},
+};
+module_platform_driver(ti_sci_inta_irq_domain_driver);
+
+MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
+MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
+MODULE_LICENSE("GPL v2");
-- 
2.19.2

