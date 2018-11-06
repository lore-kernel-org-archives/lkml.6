Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC37FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887B220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887B220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbeKFSHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:07:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33280 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387754AbeKFSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:07:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA68gDkI093582;
        Tue, 6 Nov 2018 02:42:13 -0600
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA68gDv6128779
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 02:42:13 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 02:42:13 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 02:42:13 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA68fJ3v032677;
        Tue, 6 Nov 2018 02:42:09 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH v3 12/13] irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
Date:   Tue, 6 Nov 2018 14:11:04 +0530
Message-ID: <20181106084105.32483-13-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106084105.32483-1-lokeshvutla@ti.com>
References: <20181106084105.32483-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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

Add support for Interrupt Aggregator driver over TISCI protocol.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Changes since v2:
- Added support for MSI

 MAINTAINERS                       |   1 +
 drivers/irqchip/Kconfig           |  12 +
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-ti-sci-inta.c | 543 ++++++++++++++++++++++++++++++
 4 files changed, 557 insertions(+)
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f20efab4664..fc89a1392478 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14742,6 +14742,7 @@ F:	drivers/reset/reset-ti-sci.c
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
+F:	drivers/irqchip/irq-ti-sci-inta.c
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f285b294fe2f..4768208c464d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -402,6 +402,18 @@ config TI_SCI_INTR_IRQCHIP
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
index 8e1b656b5a07..a44d9e9dc4f9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
+obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
new file mode 100644
index 000000000000..1d75fbe1c271
--- /dev/null
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Aggregator irqchip driver
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
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
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/soc/ti/k3_inta_msi.h>
+#include <linux/irqchip/chained_irq.h>
+#include <asm-generic/msi.h>
+
+#define MAX_EVENTS_PER_VINT	64
+
+#define VINT_ENABLE_SET_OFFSET	0x0
+#define VINT_ENABLE_CLR_OFFSET	0x8
+#define VINT_STATUS_OFFSET	0x18
+
+#define TI_SCI_DEV_ID_MASK	0xffff
+#define TI_SCI_DEV_ID_SHIFT	16
+#define TI_SCI_IRQ_ID_MASK	0xffff
+#define TI_SCI_IRQ_ID_SHIFT	0
+
+#define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >> (TI_SCI_DEV_ID_SHIFT)) & \
+				 (TI_SCI_DEV_ID_MASK))
+#define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
+
+/**
+ * struct ti_sci_inta_irq_domain - Structure representing a TISCI based
+ *				   Interrupt Aggregator IRQ domain.
+ * @sci:	Pointer to TISCI handle
+ * @vint:	TISCI resource pointer representing IA inerrupts.
+ * @global_event:TISCI resource pointer representing global events.
+ * @base:	Base address of the memory mapped IO registers
+ * @ia_id:	TISCI device ID of this Interrupt Aggregator.
+ * @dst_id:	TISCI device ID of the destination irq controller.
+ */
+struct ti_sci_inta_irq_domain {
+	const struct ti_sci_handle *sci;
+	struct ti_sci_resource *vint;
+	struct ti_sci_resource *global_event;
+	void __iomem *base;
+	u16 ia_id;
+	u16 dst_id;
+};
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
+ * @event_lock:		lock to guard the event map
+ * @event_map:		Bitmap to manage the allocation of events to vint.
+ * @events:		Array of event descriptors assigned to this vint.
+ * @parent_virq:	Linux IRQ number that gets attached to parent
+ * @vint_id:		TISCI vint ID
+ */
+struct ti_sci_inta_vint_desc {
+	struct irq_domain *domain;
+	struct mutex event_lock;
+	unsigned long *event_map;
+	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
+	unsigned int parent_virq;
+	u16 vint_id;
+};
+
+static int __get_event_index(struct ti_sci_inta_vint_desc *vint_desc,
+			     int global_event)
+{
+	int event_index = -ENODEV, i;
+
+	for (i = 0; i < MAX_EVENTS_PER_VINT; i++) {
+		if (vint_desc->events[i].global_event == global_event)
+			event_index = i;
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
+static struct irq_chip ti_sci_inta_irq_chip = {
+	.name			= "INTA",
+	.irq_mask		= ti_sci_inta_mask_irq,
+	.irq_unmask		= ti_sci_inta_unmask_irq,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
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
+	struct irq_data *gic_data;
+	int event_index = 0;
+
+	event_index = __get_event_index(vint_desc, global_event);
+	gic_data = irq_domain_get_irq_data(domain->parent->parent,
+					   vint_desc->parent_virq);
+	event_desc = &vint_desc->events[event_index];
+	inta->sci->ops.rm_irq_ops.free_event_irq(inta->sci,
+						 event_desc->src_id,
+						 event_desc->src_index,
+						 inta->dst_id,
+						 gic_data->hwirq,
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
+	/* If all events are cleared, delete parent irq */
+	if (find_first_bit(vint_desc->event_map, MAX_EVENTS_PER_VINT) ==
+	    MAX_EVENTS_PER_VINT) {
+		irq_dispose_mapping(vint_desc->parent_virq);
+		ti_sci_release_resource(inta->vint, vint_desc->vint_id);
+		kfree(vint_desc->event_map);
+		kfree(vint_desc);
+	}
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
+	struct irq_desc *desc = irq_to_desc(virq);
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct msi_desc *mdesc;
+	struct irq_data *data;
+
+	mdesc = desc->irq_common_data.msi_desc;
+	data = irq_domain_get_irq_data(domain, virq);
+	vint_desc = irq_data_get_irq_chip_data(data);
+
+	mdesc->msg.data = vint_desc->parent_virq;
+	ti_sci_free_event_irq(domain, vint_desc, data->hwirq);
+	irq_domain_reset_irq_data(data);
+}
+
+/**
+ * ti_sci_allocate_event_irq() - Allocate an event to a IA vint.
+ *
+ * Return 0 if all went ok else appropriate error value.
+ */
+static struct ti_sci_inta_event_desc *
+ti_sci_allocate_event_irq(struct irq_domain *domain, msi_alloc_info_t *arg)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->host_data;
+	struct ti_sci_inta_event_desc *event_desc;
+	u16 free_bit, src_id, src_index, dst_irq;
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct irq_data *gic_data;
+	int err;
+
+	src_id = HWIRQ_TO_DEVID(arg->hwirq);
+	src_index = HWIRQ_TO_IRQID(arg->hwirq);
+	vint_desc = arg->scratchpad[0].ptr;
+	gic_data = irq_domain_get_irq_data(domain->parent->parent,
+					   vint_desc->parent_virq);
+	dst_irq = gic_data->hwirq;
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
+	err = inta->sci->ops.rm_irq_ops.set_event_irq(inta->sci,
+						      src_id, src_index,
+						      inta->dst_id,
+						      dst_irq,
+						      inta->ia_id,
+						      vint_desc->vint_id,
+						      event_desc->global_event,
+						      free_bit);
+	if (err) {
+		pr_err("%s: Event allocation failed from src = %d, index = %d, to dst = %d,irq = %d,via ia_id = %d, vint = %d,global event = %d, status_bit = %d\n",
+		       __func__, src_id, src_index, inta->dst_id, dst_irq,
+		       inta->ia_id, vint_desc->vint_id,
+		       event_desc->global_event, free_bit);
+		goto free_global_event;
+	}
+
+	return event_desc;
+free_global_event:
+	ti_sci_release_resource(inta->global_event, event_desc->global_event);
+free_event:
+	clear_bit(free_bit, vint_desc->event_map);
+	return ERR_PTR(err);
+}
+
+static void inta_msi_irq_handler(struct irq_desc *desc)
+{
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct ti_sci_inta_irq_domain *inta;
+	struct irq_domain *domain;
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
+			writeq_relaxed(BIT(bit),
+				       inta->base + vint_desc->vint_id *
+				       0x1000 + VINT_STATUS_OFFSET);
+			hwirq = vint_desc->events[bit].global_event;
+			virq = irq_find_mapping(domain, hwirq);
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
+ * Return pointer to vint descriptor if all went well else corresponding
+ * error pointer.
+ */
+static struct ti_sci_inta_vint_desc *
+ti_sci_inta_alloc_parent_irq(struct irq_domain *domain, msi_alloc_info_t *arg)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->host_data;
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct irq_fwspec parent_fwspec;
+	unsigned int virq;
+
+	if (!irq_domain_get_of_node(domain->parent))
+		return ERR_PTR(-EINVAL);
+
+	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
+	if (!vint_desc)
+		return ERR_PTR(-ENOMEM);
+
+	vint_desc->event_map = kcalloc(BITS_TO_LONGS(MAX_EVENTS_PER_VINT),
+				       sizeof(*vint_desc->event_map),
+				       GFP_KERNEL);
+	if (!vint_desc->event_map) {
+		kfree(vint_desc);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	vint_desc->domain = domain;
+	vint_desc->vint_id = ti_sci_get_free_resource(inta->vint);
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
+	if (virq <= 0)
+		goto err_irqs;
+
+	irq_set_chained_handler_and_data(virq, inta_msi_irq_handler, vint_desc);
+	vint_desc->parent_virq = virq;
+
+	mutex_init(&vint_desc->event_lock);
+
+	return vint_desc;
+
+err_irqs:
+	ti_sci_release_resource(inta->vint, vint_desc->vint_id);
+	kfree(vint_desc);
+	return ERR_PTR(virq);
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
+	struct ti_sci_inta_event_desc *event_desc;
+	msi_alloc_info_t *arg = data;
+
+	event_desc = ti_sci_allocate_event_irq(domain, arg);
+	if (IS_ERR(event_desc)) {
+		ti_sci_inta_free_vint(domain->host_data,
+				      arg->scratchpad[0].ptr);
+		return PTR_ERR(event_desc);
+	}
+
+	irq_domain_set_info(domain, virq, event_desc->global_event,
+			    &ti_sci_inta_irq_chip, arg->scratchpad[0].ptr,
+			    handle_edge_irq, NULL, NULL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
+	.alloc		= ti_sci_inta_irq_domain_alloc,
+	.free		= ti_sci_inta_irq_domain_free,
+};
+
+static int inta_msi_domain_ops_prepare(struct irq_domain *domain,
+				       struct device *dev, int nvec,
+				       msi_alloc_info_t *arg)
+{
+	struct ti_sci_inta_vint_desc *vint_desc;
+
+	memset(arg, 0, sizeof(*arg));
+
+	vint_desc = ti_sci_inta_alloc_parent_irq(domain->parent, arg);
+	if (IS_ERR(vint_desc))
+		return PTR_ERR(vint_desc);
+	arg->scratchpad[0].ptr = vint_desc;
+
+	return 0;
+}
+
+void inta_msi_domain_ops_unprepare(struct irq_domain *domain, int nvec,
+				   void *data)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->parent->host_data;
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct irq_desc *desc;
+	unsigned int virq;
+
+	virq = *(unsigned int *)data;
+	desc = irq_to_desc(virq);
+	vint_desc = irq_desc_get_handler_data(desc);
+	ti_sci_inta_free_vint(inta, vint_desc);
+}
+
+static struct irq_chip inta_msi_irq_chip = {
+	.name		= "MSI-INTA",
+};
+
+static struct msi_domain_ops inta_msi_ops = {
+	.msi_prepare	= inta_msi_domain_ops_prepare,
+	.msi_unprepare	= inta_msi_domain_ops_unprepare,
+};
+
+static struct msi_domain_info inta_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &inta_msi_ops,
+	.chip	= &inta_msi_irq_chip,
+};
+
+static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
+{
+	struct irq_domain *parent_domain, *domain, *msi_domain;
+	struct device_node *parent_node, *node;
+	struct ti_sci_inta_irq_domain *inta;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
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
+	ret = of_property_read_u32(parent_node, "ti,sci-dst-id",
+				   (u32 *)&inta->dst_id);
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
2.19.1

