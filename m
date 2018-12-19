Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D1020874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n0Nwm/lA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f11zoYX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbeLSWLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:11:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbeLSWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:11:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 058DD60886; Wed, 19 Dec 2018 22:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257493;
        bh=mRkZSi5i/SMFfp0127rUNIzf0utqIZ/0JlGgxYeT7cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0Nwm/lAdrEXEBK62Pvdya5TBTBuCKU3LtFJgadPB7fKWxpQo7I3l0beAyJEumOvA
         WuWKvkQPXXGpt8wotfGmHBldDhxGE0WqvXY5H/T4rwuo/4CGPJzVXXDMTbbE9COydd
         a+uZz78MaiiiYB9icbMtzdd4y/AJ32nRurVgELcA=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4C3B60878;
        Wed, 19 Dec 2018 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257491;
        bh=mRkZSi5i/SMFfp0127rUNIzf0utqIZ/0JlGgxYeT7cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f11zoYX2foePkouBGGpeIFfRtK/iNDUo20d5DtErABYxC7KbVuNGv53K2ScKjiMYf
         MyTRFJ03PmHdr1Ae1SPiap4zCgLxe5aRPrWv55Ypsx431I0rgPHm3LMYQOzKX7eqFR
         p0C5F3i+8Q07N+AUQMHYFMZC/E2QZHoz7p1RP1oQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4C3B60878
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 3/7] drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs
Date:   Wed, 19 Dec 2018 15:11:01 -0700
Message-Id: <20181219221105.3004-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219221105.3004-1-ilina@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

Introduce a new domain for wakeup capable GPIOs. The domain can be
requested using the bus token DOMAIN_BUS_WAKEUP. In the following
patches, we will specify PDC as the wakeup-parent for the TLMM GPIO
irqchip. Requesting a wakeup GPIO will setup the GPIO and the
corresponding PDC interrupt as its parent.

Also, provide the map of the PDC pins for the GPIOs for SDM845.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
[ilina: create separate file for PDC data]
---
 drivers/irqchip/Makefile        |   2 +-
 drivers/irqchip/qcom-pdc-data.c |  94 +++++++++++++++++++++++++++
 drivers/irqchip/qcom-pdc.c      | 111 +++++++++++++++++++++++++++++---
 drivers/irqchip/qcom-pdc.h      |  24 +++++++
 include/linux/soc/qcom/irq.h    |  23 +++++++
 5 files changed, 244 insertions(+), 10 deletions(-)
 create mode 100644 drivers/irqchip/qcom-pdc-data.c
 create mode 100644 drivers/irqchip/qcom-pdc.h
 create mode 100644 include/linux/soc/qcom/irq.h

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 794c13d3ac3d..9c172f1328de 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,7 +87,7 @@ obj-$(CONFIG_ARCH_SYNQUACER)		+= irq-sni-exiu.o
 obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
-obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o qcom-pdc-data.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
diff --git a/drivers/irqchip/qcom-pdc-data.c b/drivers/irqchip/qcom-pdc-data.c
new file mode 100644
index 000000000000..99b4be0af5db
--- /dev/null
+++ b/drivers/irqchip/qcom-pdc-data.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include "qcom-pdc.h"
+
+static const struct pdc_gpio_pin_map sdm845_gpio_pdc_map[] = {
+	{ 1, 30 },
+	{ 3, 31 },
+	{ 5, 32 },
+	{ 10, 33 },
+	{ 11, 34 },
+	{ 20, 35 },
+	{ 22, 36 },
+	{ 24, 37 },
+	{ 26, 38 },
+	{ 30, 39 },
+	{ 31, 117 },
+	{ 32, 41 },
+	{ 34, 42 },
+	{ 36, 43 },
+	{ 37, 44 },
+	{ 38, 45 },
+	{ 39, 46 },
+	{ 40, 47 },
+	{ 41, 115 },
+	{ 43, 49 },
+	{ 44, 50 },
+	{ 46, 51 },
+	{ 48, 52 },
+	{ 49, 118 },
+	{ 52, 54 },
+	{ 53, 55 },
+	{ 54, 56 },
+	{ 56, 57 },
+	{ 57, 58 },
+	{ 58, 59 },
+	{ 59, 60 },
+	{ 60, 61 },
+	{ 61, 62 },
+	{ 62, 63 },
+	{ 63, 64 },
+	{ 64, 65 },
+	{ 66, 66 },
+	{ 68, 67 },
+	{ 71, 68 },
+	{ 73, 69 },
+	{ 77, 70 },
+	{ 78, 71 },
+	{ 79, 72 },
+	{ 80, 73 },
+	{ 84, 74 },
+	{ 85, 75 },
+	{ 86, 76 },
+	{ 88, 77 },
+	{ 89, 116 },
+	{ 91, 79 },
+	{ 92, 80 },
+	{ 95, 81 },
+	{ 96, 82 },
+	{ 97, 83 },
+	{ 101, 84 },
+	{ 103, 85 },
+	{ 104, 86 },
+	{ 115, 90 },
+	{ 116, 91 },
+	{ 117, 92 },
+	{ 118, 93 },
+	{ 119, 94 },
+	{ 120, 95 },
+	{ 121, 96 },
+	{ 122, 97 },
+	{ 123, 98 },
+	{ 124, 99 },
+	{ 125, 100 },
+	{ 127, 102 },
+	{ 128, 103 },
+	{ 129, 104 },
+	{ 130, 105 },
+	{ 132, 106 },
+	{ 133, 107 },
+	{ 145, 108 },
+};
+
+static const struct pdc_gpio_pin_data sdm845_gpio_data = {
+	.size = ARRAY_SIZE(sdm845_gpio_pdc_map),
+	.map = sdm845_gpio_pdc_map,
+};
+
+const struct of_device_id pdc_gpio_match_table[] = {
+	{ .compatible = "qcom,845-pdc", .data = &sdm845_gpio_data },
+	{ },
+};
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index faa7d61b9d6c..1b9ec35958b1 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -13,12 +13,15 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "qcom-pdc.h"
+
 #define PDC_MAX_IRQS		126
+#define PDC_MAX_GPIO_IRQS	256
 
 #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
 #define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
@@ -47,9 +50,8 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
 
-static void pdc_enable_intr(struct irq_data *d, bool on)
+static void pdc_enable_intr(irq_hw_number_t pin_out, bool on)
 {
-	int pin_out = d->hwirq;
 	u32 index, mask;
 	u32 enable;
 
@@ -65,13 +67,23 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
 
 static void qcom_pdc_gic_mask(struct irq_data *d)
 {
-	pdc_enable_intr(d, false);
+	irq_hw_number_t hwirq = d->hwirq;
+
+	if (hwirq == ULONG_MAX)
+		return;
+
+	pdc_enable_intr(hwirq, false);
 	irq_chip_mask_parent(d);
 }
 
 static void qcom_pdc_gic_unmask(struct irq_data *d)
 {
-	pdc_enable_intr(d, true);
+	irq_hw_number_t hwirq = d->hwirq;
+
+	if (hwirq == ULONG_MAX)
+		return;
+
+	pdc_enable_intr(hwirq, true);
 	irq_chip_unmask_parent(d);
 }
 
@@ -111,9 +123,12 @@ enum pdc_irq_config_bits {
  */
 static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 {
-	int pin_out = d->hwirq;
+	irq_hw_number_t pin_out = d->hwirq;
 	enum pdc_irq_config_bits pdc_type;
 
+	if (pin_out == ULONG_MAX)
+		return 0;
+
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		pdc_type = PDC_EDGE_RISING;
@@ -157,7 +172,7 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static irq_hw_number_t get_parent_hwirq(int pin)
+static irq_hw_number_t get_parent_hwirq(irq_hw_number_t pin)
 {
 	int i;
 	struct pdc_pin_region *region;
@@ -169,7 +184,6 @@ static irq_hw_number_t get_parent_hwirq(int pin)
 			return (region->parent_base + pin - region->pin_base);
 	}
 
-	WARN_ON(1);
 	return ~0UL;
 }
 
@@ -232,6 +246,73 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
+static irq_hw_number_t qcom_gpio_to_pdc_pin(struct irq_domain *domain,
+					    unsigned int gpio)
+{
+	struct device_node *dn = irq_domain_get_of_node(domain);
+	const struct of_device_id *match_id;
+	const struct pdc_gpio_pin_data *data;
+	unsigned int i;
+
+	match_id = of_match_node(pdc_gpio_match_table, dn);
+	if (!match_id)
+		return ULONG_MAX;
+
+	data = match_id->data;
+	if (!data)
+		return ULONG_MAX;
+
+	for (i = 0; i < data->size; i++)
+		if (gpio == data->map[i].gpio)
+			return data->map[i].pdc_pin;
+
+	return ULONG_MAX;
+}
+
+static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs, void *data)
+{
+	struct qcom_irq_fwspec *qcom_fwspec = data;
+	struct irq_fwspec *fwspec = &qcom_fwspec->fwspec;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq, parent_hwirq;
+	unsigned int type;
+	int ret;
+
+	hwirq = qcom_gpio_to_pdc_pin(domain, fwspec->param[0]);
+	parent_hwirq = get_parent_hwirq(hwirq);
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &qcom_pdc_gic_chip, NULL);
+	if (ret)
+		return ret;
+
+	if (hwirq == ULONG_MAX)
+		return 0;
+
+	qcom_fwspec->mask = true;
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type = IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type = IRQ_TYPE_LEVEL_HIGH;
+
+	parent_fwspec.fwnode      = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0]    = 0;
+	parent_fwspec.param[1]    = parent_hwirq;
+	parent_fwspec.param[2]    = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops qcom_pdc_gpio_ops = {
+	.alloc		= qcom_pdc_gpio_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n;
@@ -270,7 +351,7 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 
 static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *pdc_domain;
+	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
 	int ret;
 
 	pdc_base = of_iomap(node, 0);
@@ -301,6 +382,18 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 		goto fail;
 	}
 
+	pdc_gpio_domain = irq_domain_create_hierarchy(parent_domain, 0,
+						      PDC_MAX_GPIO_IRQS,
+						      of_fwnode_handle(node),
+						      &qcom_pdc_gpio_ops, NULL);
+	if (!pdc_gpio_domain) {
+		pr_err("%pOF: GIC domain add failed for GPIO domain\n", node);
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	irq_domain_update_bus_token(pdc_gpio_domain, DOMAIN_BUS_WAKEUP);
+
 	return 0;
 
 fail:
diff --git a/drivers/irqchip/qcom-pdc.h b/drivers/irqchip/qcom-pdc.h
new file mode 100644
index 000000000000..3091db646004
--- /dev/null
+++ b/drivers/irqchip/qcom-pdc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __QCOM_PDC_H
+#define __QCOM_PDC_H
+
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+
+struct pdc_gpio_pin_map {
+	unsigned int gpio;
+	u32 pdc_pin;
+};
+
+struct pdc_gpio_pin_data {
+	size_t size;
+	const struct pdc_gpio_pin_map *map;
+};
+
+extern const struct of_device_id pdc_gpio_match_table[];
+
+#endif /* __QCOM_PDC_H */
diff --git a/include/linux/soc/qcom/irq.h b/include/linux/soc/qcom/irq.h
new file mode 100644
index 000000000000..bacc9edbce0d
--- /dev/null
+++ b/include/linux/soc/qcom/irq.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_IRQ_H
+#define __QCOM_IRQ_H
+
+#include <linux/irqdomain.h>
+
+/**
+ * struct qcom_irq_fwspec - qcom specific irq fwspec wrapper
+ * @fwspec: irq fwspec
+ * @mask: if true, keep the irq masked in the gpio controller
+ *
+ * Use this structure to communicate between the parent irq chip, MPM or PDC,
+ * to the gpio chip, TLMM, about the gpio being allocated in the parent
+ * and if the gpio chip should keep the line masked because the parent irq
+ * chip is handling everything about the irq line.
+ */
+struct qcom_irq_fwspec {
+	struct irq_fwspec fwspec;
+	bool mask;
+};
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

