Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934636AbeE2NSh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:18:37 -0400
Received: from foss.arm.com ([217.140.101.70]:39992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934729AbeE2NQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:16:25 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 05/12] coresight: Add helper for inserting synchronization packets
Date: Tue, 29 May 2018 14:15:30 +0100
Message-Id: <1527599737-28408-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we open code filling the trace buffer with synchronization
packets when the circular buffer wraps around in different drivers.
Move this to a common place. While at it, clean up the barrier_pkt
array to strip off the trailing '\0'.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 12 ++++-------
 drivers/hwtracing/coresight/coresight-priv.h    | 10 ++++++++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 27 ++++++++-----------------
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 13 +-----------
 drivers/hwtracing/coresight/coresight.c         |  3 +--
 5 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 9b6c555..78e71bf 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -195,7 +195,6 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	bool lost = false;
 	int i;
 	u8 *buf_ptr;
-	const u32 *barrier;
 	u32 read_data, depth;
 	u32 read_ptr, write_ptr;
 	u32 frame_off, frame_endoff;
@@ -226,19 +225,16 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 
 	depth = drvdata->buffer_depth;
 	buf_ptr = drvdata->buf;
-	barrier = barrier_pkt;
 	for (i = 0; i < depth; i++) {
 		read_data = readl_relaxed(drvdata->base +
 					  ETB_RAM_READ_DATA_REG);
-		if (lost && *barrier) {
-			read_data = *barrier;
-			barrier++;
-		}
-
 		*(u32 *)buf_ptr = read_data;
 		buf_ptr += 4;
 	}
 
+	if (lost)
+		coresight_insert_barrier_packet(drvdata->buf);
+
 	if (frame_off) {
 		buf_ptr -= (frame_endoff * 4);
 		for (i = 0; i < frame_endoff; i++) {
@@ -447,7 +443,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 		buf_ptr = buf->data_pages[cur] + offset;
 		read_data = readl_relaxed(drvdata->base +
 					  ETB_RAM_READ_DATA_REG);
-		if (lost && *barrier) {
+		if (lost && i < CORESIGHT_BARRIER_PKT_SIZE) {
 			read_data = *barrier;
 			barrier++;
 		}
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 0e5a74d..1a6cf35 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -57,7 +57,8 @@ static DEVICE_ATTR_RO(name)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
 	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
 
-extern const u32 barrier_pkt[5];
+extern const u32 barrier_pkt[4];
+#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt))
 
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
@@ -91,6 +92,13 @@ struct cs_buffers {
 	void			**data_pages;
 };
 
+static inline void coresight_insert_barrier_packet(void *buf)
+{
+	if (buf)
+		memcpy(buf, barrier_pkt, CORESIGHT_BARRIER_PKT_SIZE);
+}
+
+
 static inline void CS_LOCK(void __iomem *addr)
 {
 	do {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 73160cd..0549249 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -32,39 +32,28 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
-	bool lost = false;
 	char *bufp;
-	const u32 *barrier;
-	u32 read_data, status;
+	u32 read_data, lost;
 	int i;
 
-	/*
-	 * Get a hold of the status register and see if a wrap around
-	 * has occurred.
-	 */
-	status = readl_relaxed(drvdata->base + TMC_STS);
-	if (status & TMC_STS_FULL)
-		lost = true;
-
+	/* Check if the buffer wrapped around. */
+	lost = readl_relaxed(drvdata->base + TMC_STS) & TMC_STS_FULL;
 	bufp = drvdata->buf;
 	drvdata->len = 0;
-	barrier = barrier_pkt;
 	while (1) {
 		for (i = 0; i < drvdata->memwidth; i++) {
 			read_data = readl_relaxed(drvdata->base + TMC_RRD);
 			if (read_data == 0xFFFFFFFF)
-				return;
-
-			if (lost && *barrier) {
-				read_data = *barrier;
-				barrier++;
-			}
-
+				goto done;
 			memcpy(bufp, &read_data, 4);
 			bufp += 4;
 			drvdata->len += 4;
 		}
 	}
+done:
+	if (lost)
+		coresight_insert_barrier_packet(drvdata->buf);
+	return;
 }
 
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 18c9a18..04206ff 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -91,9 +91,7 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 
 static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 {
-	const u32 *barrier;
 	u32 val;
-	u32 *temp;
 	u64 rwp;
 
 	rwp = tmc_read_rwp(drvdata);
@@ -106,16 +104,7 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 	if (val & TMC_STS_FULL) {
 		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
 		drvdata->len = drvdata->size;
-
-		barrier = barrier_pkt;
-		temp = (u32 *)drvdata->buf;
-
-		while (*barrier) {
-			*temp = *barrier;
-			temp++;
-			barrier++;
-		}
-
+		coresight_insert_barrier_packet(drvdata->buf);
 	} else {
 		drvdata->buf = drvdata->vaddr;
 		drvdata->len = rwp - drvdata->paddr;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 29e834a..4969b32 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -51,8 +51,7 @@ static struct list_head *stm_path;
  * beginning of the data collected in a buffer.  That way the decoder knows that
  * it needs to look for another sync sequence.
  */
-const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
-			    0x7fffffff, 0x7fffffff, 0x0};
+const u32 barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
 
 static int coresight_id_match(struct device *dev, void *data)
 {
-- 
2.7.4
