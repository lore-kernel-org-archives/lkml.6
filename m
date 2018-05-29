Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934760AbeE2NQb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:16:31 -0400
Received: from foss.arm.com ([217.140.101.70]:39946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934203AbeE2NQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:16:19 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 02/12] coresight: tmc: Hide trace buffer handling for file read
Date: Tue, 29 May 2018 14:15:27 +0100
Message-Id: <1527599737-28408-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment we adjust the buffer pointers for reading the trace
data via misc device in the common code for ETF/ETB and ETR. Since
we are going to change how we manage the buffer for ETR, let us
move the buffer manipulation to the respective driver files, hiding
it from the common code. We do so by adding type specific helpers
for finding the length of data and the pointer to the buffer,
for a given length at a file position.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 18 +++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 34 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 41 ++++++++++++++-----------
 drivers/hwtracing/coresight/coresight-tmc.h     |  4 +++
 4 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 61d849b..73160cd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -109,6 +109,24 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+/*
+ * Return the available trace data in the buffer from @pos, with
+ * a maximum limit of @len, updating the @bufpp on where to
+ * find it.
+ */
+ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				loff_t pos, size_t len, char **bufpp)
+{
+	ssize_t actual = len;
+
+	/* Adjust the len to available size @pos */
+	if (pos + actual > drvdata->len)
+		actual = drvdata->len - pos;
+	if (actual > 0)
+		*bufpp = drvdata->buf + pos;
+	return actual;
+}
+
 static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 02f747a..f88342d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -58,6 +58,40 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+/*
+ * Return the available trace data in the buffer @pos, with a maximum
+ * limit of @len, also updating the @bufpp on where to find it.
+ */
+ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				loff_t pos, size_t len, char **bufpp)
+{
+	ssize_t actual = len;
+	char *bufp = drvdata->buf + pos;
+	char *bufend = (char *)(drvdata->vaddr + drvdata->size);
+
+	/* Adjust the len to available size @pos */
+	if (pos + actual > drvdata->len)
+		actual = drvdata->len - pos;
+
+	if (actual <= 0)
+		return actual;
+
+	/*
+	 * Since we use a circular buffer, with trace data starting
+	 * @drvdata->buf, possibly anywhere in the buffer @drvdata->vaddr,
+	 * wrap the current @pos to within the buffer.
+	 */
+	if (bufp >= bufend)
+		bufp -= drvdata->size;
+	/*
+	 * For simplicity, avoid copying over a wrapped around buffer.
+	 */
+	if ((bufp + actual) > bufend)
+		actual = bufend - bufp;
+	*bufpp = bufp;
+	return actual;
+}
+
 static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 {
 	const u32 *barrier;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 456f122..bb57e7f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -123,35 +123,40 @@ static int tmc_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
+					  loff_t pos, size_t len, char **bufpp)
+{
+	switch (drvdata->config_type) {
+	case TMC_CONFIG_TYPE_ETB:
+	case TMC_CONFIG_TYPE_ETF:
+		return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
+	case TMC_CONFIG_TYPE_ETR:
+		return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
+	}
+
+	return -EINVAL;
+}
+
 static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 			loff_t *ppos)
 {
+	char *bufp;
+	ssize_t actual;
 	struct tmc_drvdata *drvdata = container_of(file->private_data,
 						   struct tmc_drvdata, miscdev);
-	char *bufp = drvdata->buf + *ppos;
+	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
+	if (actual <= 0)
+		return 0;
 
-	if (*ppos + len > drvdata->len)
-		len = drvdata->len - *ppos;
-
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		if (bufp == (char *)(drvdata->vaddr + drvdata->size))
-			bufp = drvdata->vaddr;
-		else if (bufp > (char *)(drvdata->vaddr + drvdata->size))
-			bufp -= drvdata->size;
-		if ((bufp + len) > (char *)(drvdata->vaddr + drvdata->size))
-			len = (char *)(drvdata->vaddr + drvdata->size) - bufp;
-	}
-
-	if (copy_to_user(data, bufp, len)) {
+	if (copy_to_user(data, bufp, actual)) {
 		dev_dbg(drvdata->dev, "%s: copy_to_user failed\n", __func__);
 		return -EFAULT;
 	}
 
-	*ppos += len;
+	*ppos += actual;
+	dev_dbg(drvdata->dev, "%zu bytes copied\n", actual);
 
-	dev_dbg(drvdata->dev, "%s: %zu bytes copied, %d bytes left\n",
-		__func__, len, (int)(drvdata->len - *ppos));
-	return len;
+	return actual;
 }
 
 static int tmc_release(struct inode *inode, struct file *file)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index dfaff07..1d7cd58 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -172,10 +172,14 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etb_cs_ops;
 extern const struct coresight_ops tmc_etf_cs_ops;
 
+ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				loff_t pos, size_t len, char **bufpp);
 /* ETR functions */
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etr_cs_ops;
+ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				loff_t pos, size_t len, char **bufpp);
 
 
 #define TMC_REG_PAIR(name, lo_off, hi_off)				\
-- 
2.7.4
