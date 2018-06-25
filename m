Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A36C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9957E257F8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9957E257F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932558AbeFYLXF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:23:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54904 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932387AbeFYLXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:23:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE71A22C7;
        Mon, 25 Jun 2018 04:23:02 -0700 (PDT)
Received: from localhost.localdomain.com (unknown [10.1.207.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A46E3F59C;
        Mon, 25 Jun 2018 04:23:01 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 3/6] coresight: Introduce support for Coresight Address Translation Unit
Date:   Mon, 25 Jun 2018 12:22:10 +0100
Message-Id: <20180625112213.23492-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180625112213.23492-1-suzuki.poulose@arm.com>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial support for Coresight Address Translation Unit, which
augments the TMC in Coresight SoC-600 by providing an improved Scatter
Gather mechanism. CATU is always connected to a single TMC-ETR and
converts the AXI address with a translated address (from a given SG
table with specific format). The CATU should be programmed in pass
through mode and enabled even if the ETR doesn't use the translation
by CATU.

This patch provides mechanism to enable/disable the CATU always in the
pass through mode.

We reuse the existing ports mechanism to link the TMC-ETR to the
connected CATU.

i.e, TMC-ETR:output_port0 -> CATU:input_port0

Reference manual for CATU component is avilable in version r2p0 of :
"Arm Coresight System-on-Chip SoC-600 Technical Reference Manual".

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/Kconfig             |  11 ++
 drivers/hwtracing/coresight/Makefile            |   1 +
 drivers/hwtracing/coresight/coresight-catu.c    | 214 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-catu.h    |  85 ++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  52 ++++++
 include/linux/coresight.h                       |   1 +
 6 files changed, 364 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.c
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.h

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ef9cb3c..ad34380 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -31,6 +31,17 @@ config CORESIGHT_LINK_AND_SINK_TMC
 	  complies with the generic implementation of the component without
 	  special enhancement or added features.
 
+config CORESIGHT_CATU
+	bool "Coresight Address Translation Unit (CATU) driver"
+	depends on CORESIGHT_LINK_AND_SINK_TMC
+	help
+	   Enable support for the Coresight Address Translation Unit (CATU).
+	   CATU supports a scatter gather table of 4K pages, with forward/backward
+	   lookup. CATU helps TMC ETR to use a large physically non-contiguous trace
+	   buffer by translating the addresses used by ETR to the physical address
+	   by looking up the provided table. CATU can also be used in pass-through
+	   mode where the address is not translated.
+
 config CORESIGHT_SINK_TPIU
 	bool "Coresight generic TPIU driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 61db9dd..41870de 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
+obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
new file mode 100644
index 0000000..9d0cb1f
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Arm Limited. All rights reserved.
+ *
+ * Coresight Address Translation Unit support
+ *
+ * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
+ */
+
+#include <linux/amba/bus.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "coresight-catu.h"
+#include "coresight-priv.h"
+
+#define csdev_to_catu_drvdata(csdev)	\
+	dev_get_drvdata(csdev->dev.parent)
+
+coresight_simple_reg32(struct catu_drvdata, devid, CORESIGHT_DEVID);
+coresight_simple_reg32(struct catu_drvdata, control, CATU_CONTROL);
+coresight_simple_reg32(struct catu_drvdata, status, CATU_STATUS);
+coresight_simple_reg32(struct catu_drvdata, mode, CATU_MODE);
+coresight_simple_reg32(struct catu_drvdata, axictrl, CATU_AXICTRL);
+coresight_simple_reg32(struct catu_drvdata, irqen, CATU_IRQEN);
+coresight_simple_reg64(struct catu_drvdata, sladdr,
+		       CATU_SLADDRLO, CATU_SLADDRHI);
+coresight_simple_reg64(struct catu_drvdata, inaddr,
+		       CATU_INADDRLO, CATU_INADDRHI);
+
+static struct attribute *catu_mgmt_attrs[] = {
+	&dev_attr_devid.attr,
+	&dev_attr_control.attr,
+	&dev_attr_status.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_axictrl.attr,
+	&dev_attr_irqen.attr,
+	&dev_attr_sladdr.attr,
+	&dev_attr_inaddr.attr,
+	NULL,
+};
+
+static const struct attribute_group catu_mgmt_group = {
+	.attrs = catu_mgmt_attrs,
+	.name = "mgmt",
+};
+
+static const struct attribute_group *catu_groups[] = {
+	&catu_mgmt_group,
+	NULL,
+};
+
+
+static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
+{
+	return coresight_timeout(drvdata->base,
+				 CATU_STATUS, CATU_STATUS_READY, 1);
+}
+
+static int catu_enable_hw(struct catu_drvdata *drvdata, void *__unused)
+{
+	u32 control;
+
+	if (catu_wait_for_ready(drvdata))
+		dev_warn(drvdata->dev, "Timeout while waiting for READY\n");
+
+	control = catu_read_control(drvdata);
+	if (control & BIT(CATU_CONTROL_ENABLE)) {
+		dev_warn(drvdata->dev, "CATU is already enabled\n");
+		return -EBUSY;
+	}
+
+	control |= BIT(CATU_CONTROL_ENABLE);
+	catu_write_mode(drvdata, CATU_MODE_PASS_THROUGH);
+	catu_write_control(drvdata, control);
+	dev_dbg(drvdata->dev, "Enabled in Pass through mode\n");
+	return 0;
+}
+
+static int catu_enable(struct coresight_device *csdev, void *data)
+{
+	int rc;
+	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
+
+	CS_UNLOCK(catu_drvdata->base);
+	rc = catu_enable_hw(catu_drvdata, data);
+	CS_LOCK(catu_drvdata->base);
+	return rc;
+}
+
+static int catu_disable_hw(struct catu_drvdata *drvdata)
+{
+	int rc = 0;
+
+	catu_write_control(drvdata, 0);
+	if (catu_wait_for_ready(drvdata)) {
+		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
+		rc = -EAGAIN;
+	}
+
+	dev_dbg(drvdata->dev, "Disabled\n");
+	return rc;
+}
+
+static int catu_disable(struct coresight_device *csdev, void *__unused)
+{
+	int rc;
+	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
+
+	CS_UNLOCK(catu_drvdata->base);
+	rc = catu_disable_hw(catu_drvdata);
+	CS_LOCK(catu_drvdata->base);
+	return rc;
+}
+
+const struct coresight_ops_helper catu_helper_ops = {
+	.enable = catu_enable,
+	.disable = catu_disable,
+};
+
+const struct coresight_ops catu_ops = {
+	.helper_ops = &catu_helper_ops,
+};
+
+static int catu_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	int ret = 0;
+	u32 dma_mask;
+	struct catu_drvdata *drvdata;
+	struct coresight_desc catu_desc;
+	struct coresight_platform_data *pdata = NULL;
+	struct device *dev = &adev->dev;
+	struct device_node *np = dev->of_node;
+	void __iomem *base;
+
+	if (np) {
+		pdata = of_get_coresight_platform_data(dev, np);
+		if (IS_ERR(pdata)) {
+			ret = PTR_ERR(pdata);
+			goto out;
+		}
+		dev->platform_data = pdata;
+	}
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	drvdata->dev = dev;
+	dev_set_drvdata(dev, drvdata);
+	base = devm_ioremap_resource(dev, &adev->res);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto out;
+	}
+
+	/* Setup dma mask for the device */
+	dma_mask = readl_relaxed(base + CORESIGHT_DEVID) & 0x3f;
+	switch (dma_mask) {
+	case 32:
+	case 40:
+	case 44:
+	case 48:
+	case 52:
+	case 56:
+	case 64:
+		break;
+	default:
+		/* Default to the 40bits as supported by TMC-ETR */
+		dma_mask = 40;
+	}
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_mask));
+	if (ret)
+		goto out;
+
+	drvdata->base = base;
+	catu_desc.pdata = pdata;
+	catu_desc.dev = dev;
+	catu_desc.groups = catu_groups;
+	catu_desc.type = CORESIGHT_DEV_TYPE_HELPER;
+	catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
+	catu_desc.ops = &catu_ops;
+	drvdata->csdev = coresight_register(&catu_desc);
+	if (IS_ERR(drvdata->csdev))
+		ret = PTR_ERR(drvdata->csdev);
+out:
+	pm_runtime_put(&adev->dev);
+	return ret;
+}
+
+static struct amba_id catu_ids[] = {
+	{
+		.id	= 0x000bb9ee,
+		.mask	= 0x000fffff,
+	},
+	{},
+};
+
+static struct amba_driver catu_driver = {
+	.drv = {
+		.name			= "coresight-catu",
+		.owner			= THIS_MODULE,
+		.suppress_bind_attrs	= true,
+	},
+	.probe				= catu_probe,
+	.id_table			= catu_ids,
+};
+
+builtin_amba_driver(catu_driver);
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
new file mode 100644
index 0000000..05da33d
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Arm Limited. All rights reserved.
+ *
+ * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
+ */
+
+#ifndef _CORESIGHT_CATU_H
+#define _CORESIGHT_CATU_H
+
+#include "coresight-priv.h"
+
+/* Register offset from base */
+#define CATU_CONTROL		0x000
+#define CATU_MODE		0x004
+#define CATU_AXICTRL		0x008
+#define CATU_IRQEN		0x00c
+#define CATU_SLADDRLO		0x020
+#define CATU_SLADDRHI		0x024
+#define CATU_INADDRLO		0x028
+#define CATU_INADDRHI		0x02c
+#define CATU_STATUS		0x100
+#define CATU_DEVARCH		0xfbc
+
+#define CATU_CONTROL_ENABLE	0
+
+#define CATU_MODE_PASS_THROUGH	0U
+#define CATU_MODE_TRANSLATE	1U
+
+#define CATU_STATUS_READY	8
+#define CATU_STATUS_ADRERR	0
+#define CATU_STATUS_AXIERR	4
+
+#define CATU_IRQEN_ON		0x1
+#define CATU_IRQEN_OFF		0x0
+
+struct catu_drvdata {
+	struct device *dev;
+	void __iomem *base;
+	struct coresight_device *csdev;
+	int irq;
+};
+
+#define CATU_REG32(name, offset)					\
+static inline u32							\
+catu_read_##name(struct catu_drvdata *drvdata)				\
+{									\
+	return coresight_read_reg_pair(drvdata->base, offset, -1);	\
+}									\
+static inline void							\
+catu_write_##name(struct catu_drvdata *drvdata, u32 val)		\
+{									\
+	coresight_write_reg_pair(drvdata->base, val, offset, -1);	\
+}
+
+#define CATU_REG_PAIR(name, lo_off, hi_off)				\
+static inline u64							\
+catu_read_##name(struct catu_drvdata *drvdata)				\
+{									\
+	return coresight_read_reg_pair(drvdata->base, lo_off, hi_off);	\
+}									\
+static inline void							\
+catu_write_##name(struct catu_drvdata *drvdata, u64 val)		\
+{									\
+	coresight_write_reg_pair(drvdata->base, val, lo_off, hi_off);	\
+}
+
+CATU_REG32(control, CATU_CONTROL);
+CATU_REG32(mode, CATU_MODE);
+CATU_REG_PAIR(sladdr, CATU_SLADDRLO, CATU_SLADDRHI)
+CATU_REG_PAIR(inaddr, CATU_INADDRLO, CATU_INADDRHI)
+
+static inline bool coresight_is_catu_device(struct coresight_device *csdev)
+{
+	enum coresight_dev_subtype_helper subtype;
+
+	/* Make the checkpatch happy */
+	subtype = csdev->subtype.helper_subtype;
+
+	return IS_ENABLED(CONFIG_CORESIGHT_CATU) &&
+	       csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
+	       subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
+}
+
+#endif
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 8af4512..e37923a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include "coresight-catu.h"
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
@@ -701,6 +702,48 @@ static const struct etr_buf_operations etr_sg_buf_ops = {
 	.get_data = tmc_etr_get_data_sg_buf,
 };
 
+/*
+ * TMC ETR could be connected to a CATU device, which can provide address
+ * translation service. This is represented by the Output port of the TMC
+ * (ETR) connected to the input port of the CATU.
+ *
+ * Returns	: coresight_device ptr for the CATU device if a CATU is found.
+ *		: NULL otherwise.
+ */
+static inline struct coresight_device *
+tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
+{
+	int i;
+	struct coresight_device *tmp, *etr = drvdata->csdev;
+
+	if (!IS_ENABLED(CONFIG_CORESIGHT_CATU))
+		return NULL;
+
+	for (i = 0; i < etr->nr_outport; i++) {
+		tmp = etr->conns[i].child_dev;
+		if (tmp && coresight_is_catu_device(tmp))
+			return tmp;
+	}
+
+	return NULL;
+}
+
+static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
+{
+	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
+
+	if (catu && helper_ops(catu)->enable)
+		helper_ops(catu)->enable(catu, NULL);
+}
+
+static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
+{
+	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
+
+	if (catu && helper_ops(catu)->disable)
+		helper_ops(catu)->disable(catu, NULL);
+}
+
 static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
@@ -844,6 +887,12 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 	u32 axictl, sts;
 	struct etr_buf *etr_buf = drvdata->etr_buf;
 
+	/*
+	 * If this ETR is connected to a CATU, enable it before we turn
+	 * this on
+	 */
+	tmc_etr_enable_catu(drvdata);
+
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
@@ -952,6 +1001,9 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	tmc_disable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
+
+	/* Disable CATU device if this ETR is connected to one */
+	tmc_etr_disable_catu(drvdata);
 }
 
 static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 3d40a2b..d828a6e 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
 
 enum coresight_dev_subtype_helper {
 	CORESIGHT_DEV_SUBTYPE_HELPER_NONE,
+	CORESIGHT_DEV_SUBTYPE_HELPER_CATU,
 };
 
 /**
-- 
2.9.5

