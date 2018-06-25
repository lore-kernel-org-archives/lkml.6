Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C419C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0857D21529
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0857D21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932920AbeFYLXe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:23:34 -0400
Received: from foss.arm.com ([217.140.101.70]:54938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932559AbeFYLXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:23:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF5622D9;
        Mon, 25 Jun 2018 04:23:07 -0700 (PDT)
Received: from localhost.localdomain.com (unknown [10.1.207.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48E793F59C;
        Mon, 25 Jun 2018 04:23:06 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 6/6] coresight: catu: Plug in CATU as a backend for ETR buffer
Date:   Mon, 25 Jun 2018 12:22:13 +0100
Message-Id: <20180625112213.23492-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180625112213.23492-1-suzuki.poulose@arm.com>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can use a CATU with a scatter gather table, add support
for the TMC ETR to make use of the connected CATU in translate mode.
This is done by adding CATU as new buffer mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c    | 122 +++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-catu.h    |  35 +++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  25 +++--
 drivers/hwtracing/coresight/coresight-tmc.h     |   3 +
 4 files changed, 174 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 559d45b..ff94e58 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -28,6 +28,11 @@
 #define catu_dbg(x, ...) do {} while (0)
 #endif
 
+struct catu_etr_buf {
+	struct tmc_sg_table *catu_table;
+	dma_addr_t sladdr;
+};
+
 /*
  * CATU uses a page size of 4KB for page tables as well as data pages.
  * Each 64bit entry in the table has the following format.
@@ -93,6 +98,9 @@ typedef u64 cate_t;
 	(((cate_t)(addr) & CATU_ADDR_MASK) | CATU_ENTRY_VALID)
 #define CATU_ENTRY_ADDR(entry)	((cate_t)(entry) & ~((cate_t)CATU_ENTRY_VALID))
 
+/* CATU expects the INADDR to be aligned to 1M. */
+#define CATU_DEFAULT_INADDR	(1ULL << 20)
+
 /*
  * catu_get_table : Retrieve the table pointers for the given @offset
  * within the buffer. The buffer is wrapped around to a valid offset.
@@ -246,7 +254,7 @@ catu_populate_table(struct tmc_sg_table *catu_table)
 	tmc_sg_table_sync_table(catu_table);
 }
 
-static struct tmc_sg_table __maybe_unused *
+static struct tmc_sg_table *
 catu_init_sg_table(struct device *catu_dev, int node,
 		   ssize_t size, void **pages)
 {
@@ -271,6 +279,91 @@ catu_init_sg_table(struct device *catu_dev, int node,
 	return catu_table;
 }
 
+static void catu_free_etr_buf(struct etr_buf *etr_buf)
+{
+	struct catu_etr_buf *catu_buf;
+
+	if (!etr_buf || etr_buf->mode != ETR_MODE_CATU || !etr_buf->private)
+		return;
+
+	catu_buf = etr_buf->private;
+	tmc_free_sg_table(catu_buf->catu_table);
+	kfree(catu_buf);
+}
+
+static ssize_t catu_get_data_etr_buf(struct etr_buf *etr_buf, u64 offset,
+				     size_t len, char **bufpp)
+{
+	struct catu_etr_buf *catu_buf = etr_buf->private;
+
+	return tmc_sg_table_get_data(catu_buf->catu_table, offset, len, bufpp);
+}
+
+static void catu_sync_etr_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
+{
+	struct catu_etr_buf *catu_buf = etr_buf->private;
+	struct tmc_sg_table *catu_table = catu_buf->catu_table;
+	u64 r_offset, w_offset;
+
+	/*
+	 * ETR started off at etr_buf->hwaddr. Convert the RRP/RWP to
+	 * offsets within the trace buffer.
+	 */
+	r_offset = rrp - etr_buf->hwaddr;
+	w_offset = rwp - etr_buf->hwaddr;
+
+	if (!etr_buf->full) {
+		etr_buf->len = w_offset - r_offset;
+		if (w_offset < r_offset)
+			etr_buf->len += etr_buf->size;
+	} else {
+		etr_buf->len = etr_buf->size;
+	}
+
+	etr_buf->offset = r_offset;
+	tmc_sg_table_sync_data_range(catu_table, r_offset, etr_buf->len);
+}
+
+static int catu_alloc_etr_buf(struct tmc_drvdata *tmc_drvdata,
+			      struct etr_buf *etr_buf, int node, void **pages)
+{
+	struct coresight_device *csdev;
+	struct device *catu_dev;
+	struct tmc_sg_table *catu_table;
+	struct catu_etr_buf *catu_buf;
+
+	csdev = tmc_etr_get_catu_device(tmc_drvdata);
+	if (!csdev)
+		return -ENODEV;
+	catu_dev = csdev->dev.parent;
+	catu_buf = kzalloc(sizeof(*catu_buf), GFP_KERNEL);
+	if (!catu_buf)
+		return -ENOMEM;
+
+	catu_table = catu_init_sg_table(catu_dev, node, etr_buf->size, pages);
+	if (IS_ERR(catu_table)) {
+		kfree(catu_buf);
+		return PTR_ERR(catu_table);
+	}
+
+	etr_buf->mode = ETR_MODE_CATU;
+	etr_buf->private = catu_buf;
+	etr_buf->hwaddr = CATU_DEFAULT_INADDR;
+
+	catu_buf->catu_table = catu_table;
+	/* Get the table base address */
+	catu_buf->sladdr = catu_table->table_daddr;
+
+	return 0;
+}
+
+const struct etr_buf_operations etr_catu_buf_ops = {
+	.alloc = catu_alloc_etr_buf,
+	.free = catu_free_etr_buf,
+	.sync = catu_sync_etr_buf,
+	.get_data = catu_get_data_etr_buf,
+};
+
 coresight_simple_reg32(struct catu_drvdata, devid, CORESIGHT_DEVID);
 coresight_simple_reg32(struct catu_drvdata, control, CATU_CONTROL);
 coresight_simple_reg32(struct catu_drvdata, status, CATU_STATUS);
@@ -311,9 +404,10 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 				 CATU_STATUS, CATU_STATUS_READY, 1);
 }
 
-static int catu_enable_hw(struct catu_drvdata *drvdata, void *__unused)
+static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 {
-	u32 control;
+	u32 control, mode;
+	struct etr_buf *etr_buf = data;
 
 	if (catu_wait_for_ready(drvdata))
 		dev_warn(drvdata->dev, "Timeout while waiting for READY\n");
@@ -325,9 +419,27 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *__unused)
 	}
 
 	control |= BIT(CATU_CONTROL_ENABLE);
-	catu_write_mode(drvdata, CATU_MODE_PASS_THROUGH);
+
+	if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
+		struct catu_etr_buf *catu_buf = etr_buf->private;
+
+		mode = CATU_MODE_TRANSLATE;
+		catu_write_axictrl(drvdata, CATU_OS_AXICTRL);
+		catu_write_sladdr(drvdata, catu_buf->sladdr);
+		catu_write_inaddr(drvdata, CATU_DEFAULT_INADDR);
+	} else {
+		mode = CATU_MODE_PASS_THROUGH;
+		catu_write_sladdr(drvdata, 0);
+		catu_write_inaddr(drvdata, 0);
+	}
+
+	catu_write_irqen(drvdata, 0);
+	catu_write_mode(drvdata, mode);
 	catu_write_control(drvdata, control);
-	dev_dbg(drvdata->dev, "Enabled in Pass through mode\n");
+	dev_dbg(drvdata->dev, "Enabled in %s mode\n",
+		(mode == CATU_MODE_PASS_THROUGH) ?
+		"Pass through" :
+		"Translate");
 	return 0;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 05da33d..53f521c 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -27,6 +27,32 @@
 #define CATU_MODE_PASS_THROUGH	0U
 #define CATU_MODE_TRANSLATE	1U
 
+#define CATU_AXICTRL_ARCACHE_SHIFT	4
+#define CATU_AXICTRL_ARCACHE_MASK	0xf
+#define CATU_AXICTRL_ARPROT_MASK	0x3
+#define CATU_AXICTRL_ARCACHE(arcache)		\
+	(((arcache) & CATU_AXICTRL_ARCACHE_MASK) << CATU_AXICTRL_ARCACHE_SHIFT)
+
+#define CATU_AXICTRL_VAL(arcache, arprot)	\
+	(CATU_AXICTRL_ARCACHE(arcache) | ((arprot) & CATU_AXICTRL_ARPROT_MASK))
+
+#define AXI3_AxCACHE_WB_READ_ALLOC	0x7
+/*
+ * AXI - ARPROT bits:
+ * See AMBA AXI & ACE Protocol specification (ARM IHI 0022E)
+ * sectionA4.7 Access Permissions.
+ *
+ * Bit 0: 0 - Unprivileged access, 1 - Privileged access
+ * Bit 1: 0 - Secure access, 1 - Non-secure access.
+ * Bit 2: 0 - Data access, 1 - instruction access.
+ *
+ * CATU AXICTRL:ARPROT[2] is res0 as we always access data.
+ */
+#define CATU_OS_ARPROT			0x2
+
+#define CATU_OS_AXICTRL		\
+	CATU_AXICTRL_VAL(AXI3_AxCACHE_WB_READ_ALLOC, CATU_OS_ARPROT)
+
 #define CATU_STATUS_READY	8
 #define CATU_STATUS_ADRERR	0
 #define CATU_STATUS_AXIERR	4
@@ -67,6 +93,8 @@ catu_write_##name(struct catu_drvdata *drvdata, u64 val)		\
 
 CATU_REG32(control, CATU_CONTROL);
 CATU_REG32(mode, CATU_MODE);
+CATU_REG32(irqen, CATU_IRQEN);
+CATU_REG32(axictrl, CATU_AXICTRL);
 CATU_REG_PAIR(sladdr, CATU_SLADDRLO, CATU_SLADDRHI)
 CATU_REG_PAIR(inaddr, CATU_INADDRLO, CATU_INADDRHI)
 
@@ -82,4 +110,11 @@ static inline bool coresight_is_catu_device(struct coresight_device *csdev)
 	       subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
 }
 
+#ifdef CONFIG_CORESIGHT_CATU
+extern const struct etr_buf_operations etr_catu_buf_ops;
+#else
+/* Dummy declaration for the CATU ops */
+static const struct etr_buf_operations etr_catu_buf_ops;
+#endif
+
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e37923a..2eda5de 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -710,7 +710,7 @@ static const struct etr_buf_operations etr_sg_buf_ops = {
  * Returns	: coresight_device ptr for the CATU device if a CATU is found.
  *		: NULL otherwise.
  */
-static inline struct coresight_device *
+struct coresight_device *
 tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 {
 	int i;
@@ -733,7 +733,7 @@ static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
 	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
 
 	if (catu && helper_ops(catu)->enable)
-		helper_ops(catu)->enable(catu, NULL);
+		helper_ops(catu)->enable(catu, drvdata->etr_buf);
 }
 
 static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
@@ -741,12 +741,13 @@ static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
 	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
 
 	if (catu && helper_ops(catu)->disable)
-		helper_ops(catu)->disable(catu, NULL);
+		helper_ops(catu)->disable(catu, drvdata->etr_buf);
 }
 
 static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
+	[ETR_MODE_CATU] = &etr_catu_buf_ops,
 };
 
 static inline int tmc_etr_mode_alloc_buf(int mode,
@@ -754,12 +755,15 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
 					 struct etr_buf *etr_buf, int node,
 					 void **pages)
 {
-	int rc;
+	int rc = -EINVAL;
 
 	switch (mode) {
 	case ETR_MODE_FLAT:
 	case ETR_MODE_ETR_SG:
-		rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf, node, pages);
+	case ETR_MODE_CATU:
+		if (etr_buf_ops[mode]->alloc)
+			rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf,
+						      node, pages);
 		if (!rc)
 			etr_buf->ops = etr_buf_ops[mode];
 		return rc;
@@ -782,10 +786,14 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 {
 	int rc = -ENOMEM;
 	bool has_etr_sg, has_iommu;
+	bool has_sg, has_catu;
 	struct etr_buf *etr_buf;
 
 	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
 	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
+	has_catu = !!tmc_etr_get_catu_device(drvdata);
+
+	has_sg = has_catu || has_etr_sg;
 
 	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
 	if (!etr_buf)
@@ -806,17 +814,22 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 	 *
 	 */
 	if (!pages &&
-	    (!has_etr_sg || has_iommu || size < SZ_1M))
+	    (!has_sg || has_iommu || size < SZ_1M))
 		rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
 					    etr_buf, node, pages);
 	if (rc && has_etr_sg)
 		rc = tmc_etr_mode_alloc_buf(ETR_MODE_ETR_SG, drvdata,
 					    etr_buf, node, pages);
+	if (rc && has_catu)
+		rc = tmc_etr_mode_alloc_buf(ETR_MODE_CATU, drvdata,
+					    etr_buf, node, pages);
 	if (rc) {
 		kfree(etr_buf);
 		return ERR_PTR(rc);
 	}
 
+	dev_dbg(drvdata->dev, "allocated buffer of size %ldKB in mode %d\n",
+		(unsigned long)size >> 10, etr_buf->mode);
 	return etr_buf;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index e745657..7027bd6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -126,6 +126,7 @@ enum tmc_mem_intf_width {
 enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
+	ETR_MODE_CATU,		/* Use SG mechanism in CATU */
 };
 
 struct etr_buf_operations;
@@ -303,4 +304,6 @@ tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 	return sg_table->data_pages.nr_pages << PAGE_SHIFT;
 }
 
+struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
+
 #endif
-- 
2.9.5

