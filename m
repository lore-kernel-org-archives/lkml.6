Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934832AbeE2NRU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:17:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934777AbeE2NQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:16:38 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 11/12] coresight: tmc-etr buf: Add TMC scatter gather mode backend
Date: Tue, 29 May 2018 14:15:36 +0100
Message-Id: <1527599737-28408-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for Scatter-Gather mode to the etr-buf layer.
Since we now have two different modes, we choose the backend
based on a set of conditions, documented in the code.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Change since last version:
 - New in this version, splitted from the original patch.
 - No functional changes.
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 114 +++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h     |   1 +
 2 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index a0e504a..19955cf 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -516,7 +516,7 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
  * @size	- Total size of the data buffer
  * @pages	- Optional list of page virtual address
  */
-static struct etr_sg_table __maybe_unused *
+static struct etr_sg_table *
 tmc_init_etr_sg_table(struct device *dev, int node,
 		  unsigned long size, void **pages)
 {
@@ -623,8 +623,86 @@ static const struct etr_buf_operations etr_flat_buf_ops = {
 	.get_data = tmc_etr_get_data_flat_buf,
 };
 
+/*
+ * tmc_etr_alloc_sg_buf: Allocate an SG buf @etr_buf. Setup the parameters
+ * appropriately.
+ */
+static int tmc_etr_alloc_sg_buf(struct tmc_drvdata *drvdata,
+				struct etr_buf *etr_buf, int node,
+				void **pages)
+{
+	struct etr_sg_table *etr_table;
+
+	etr_table = tmc_init_etr_sg_table(drvdata->dev, node,
+					  etr_buf->size, pages);
+	if (IS_ERR(etr_table))
+		return -ENOMEM;
+	etr_buf->hwaddr = etr_table->hwaddr;
+	etr_buf->mode = ETR_MODE_ETR_SG;
+	etr_buf->private = etr_table;
+	return 0;
+}
+
+static void tmc_etr_free_sg_buf(struct etr_buf *etr_buf)
+{
+	struct etr_sg_table *etr_table = etr_buf->private;
+
+	if (etr_table) {
+		tmc_free_sg_table(etr_table->sg_table);
+		kfree(etr_table);
+	}
+}
+
+static ssize_t tmc_etr_get_data_sg_buf(struct etr_buf *etr_buf, u64 offset,
+				       size_t len, char **bufpp)
+{
+	struct etr_sg_table *etr_table = etr_buf->private;
+
+	return tmc_sg_table_get_data(etr_table->sg_table, offset, len, bufpp);
+}
+
+static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
+{
+	long r_offset, w_offset;
+	struct etr_sg_table *etr_table = etr_buf->private;
+	struct tmc_sg_table *table = etr_table->sg_table;
+
+	/* Convert hw address to offset in the buffer */
+	r_offset = tmc_sg_get_data_page_offset(table, rrp);
+	if (r_offset < 0) {
+		dev_warn(table->dev,
+			 "Unable to map RRP %llx to offset\n", rrp);
+		etr_buf->len = 0;
+		return;
+	}
+
+	w_offset = tmc_sg_get_data_page_offset(table, rwp);
+	if (w_offset < 0) {
+		dev_warn(table->dev,
+			 "Unable to map RWP %llx to offset\n", rwp);
+		etr_buf->len = 0;
+		return;
+	}
+
+	etr_buf->offset = r_offset;
+	if (etr_buf->full)
+		etr_buf->len = etr_buf->size;
+	else
+		etr_buf->len = ((w_offset < r_offset) ? etr_buf->size : 0) +
+				w_offset - r_offset;
+	tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
+}
+
+static const struct etr_buf_operations etr_sg_buf_ops = {
+	.alloc = tmc_etr_alloc_sg_buf,
+	.free = tmc_etr_free_sg_buf,
+	.sync = tmc_etr_sync_sg_buf,
+	.get_data = tmc_etr_get_data_sg_buf,
+};
+
 static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
+	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
 };
 
 static inline int tmc_etr_mode_alloc_buf(int mode,
@@ -636,6 +714,7 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
 
 	switch (mode) {
 	case ETR_MODE_FLAT:
+	case ETR_MODE_ETR_SG:
 		rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf, node, pages);
 		if (!rc)
 			etr_buf->ops = etr_buf_ops[mode];
@@ -657,17 +736,38 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 					 ssize_t size, int flags,
 					 int node, void **pages)
 {
-	int rc = 0;
+	int rc = -ENOMEM;
+	bool has_etr_sg, has_iommu;
 	struct etr_buf *etr_buf;
 
+	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
+	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
+
 	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
 	if (!etr_buf)
 		return ERR_PTR(-ENOMEM);
 
 	etr_buf->size = size;
 
-	rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
-				    etr_buf, node, pages);
+	/*
+	 * If we have to use an existing list of pages, we cannot reliably
+	 * use a contiguous DMA memory (even if we have an IOMMU). Otherwise,
+	 * we use the contiguous DMA memory if at least one of the following
+	 * conditions is true:
+	 *  a) The ETR cannot use Scatter-Gather.
+	 *  b) we have a backing IOMMU
+	 *  c) The requested memory size is smaller (< 1M).
+	 *
+	 * Fallback to available mechanisms.
+	 *
+	 */
+	if (!pages &&
+	    (!has_etr_sg || has_iommu || size < SZ_1M))
+		rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
+					    etr_buf, node, pages);
+	if (rc && has_etr_sg)
+		rc = tmc_etr_mode_alloc_buf(ETR_MODE_ETR_SG, drvdata,
+					    etr_buf, node, pages);
 	if (rc) {
 		kfree(etr_buf);
 		return ERR_PTR(rc);
@@ -761,6 +861,12 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 		axictl |= TMC_AXICTL_ARCACHE_OS;
 	}
 
+	if (etr_buf->mode == ETR_MODE_ETR_SG) {
+		if (WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
+			return;
+		axictl |= TMC_AXICTL_SCT_GAT_MODE;
+	}
+
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	tmc_write_dba(drvdata, etr_buf->hwaddr);
 	/*
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 39ed306..eeeba48 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -125,6 +125,7 @@ enum tmc_mem_intf_width {
 
 enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
+	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
 };
 
 struct etr_buf_operations;
-- 
2.7.4
