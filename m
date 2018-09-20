Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A44ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BD521531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2xO3o9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BD521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeIUBDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41882 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbeIUBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so4819184pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d7KXFlRnIuoKx9WD1Q8Bn/fODwXcUwmuItoY8vv8QjI=;
        b=D2xO3o9eVfFvx7i/mioynyy2l0vHIv9IK5RsoYaXv75CuigTBnrhYAMLuZP3PFdHgx
         Hl6tCBIVYUgs47I/98zV+uD6VoqGm3T3RxwxOqzm1vt4DgODnEUitGPPQcCYpLeSdMES
         /ZZaxVilWAxnRPQHXyEAKGygrQsSRKOnh6N68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d7KXFlRnIuoKx9WD1Q8Bn/fODwXcUwmuItoY8vv8QjI=;
        b=liR0ZYODjlgrOsrkG8gNcfXeJ16JMbaqfwNEzzrIVNJCJ0FnH7OHhW2yNt7EDggqBF
         4WwtWGQu1je36BKxzYgXMIAzZ3QfN1pQ8xAiK7WRebi8BVWRk1Zm2ReXStgGTk0+fw40
         G4aiM5igRuJT15PuDW1FHP4sG7pgDf+LrBgOBjuy1HR+pTfS0cS3IEjozot95HQOl79V
         czw0PxBfATaL1AgOM0ORMrUmRr4Dx4sjWMgLs4nqlUyRoKbODA1dKYppEM23E0pvvYIi
         zJSVHGWIGUnBG8lCUtX/5Zyq5rWfvgA2aDNM0vHULcXfMPJJi5/stPjphfDSNpM6C7wI
         xUfw==
X-Gm-Message-State: APzg51DMwe9Q2dTOI8yIlVsIsqyyAzngbvYAICBkM2TA24LmEOtC1RSx
        sxXfC8dup26mbHfZOqsqDztrCQ==
X-Google-Smtp-Source: ANB0VdZyVyCXwPn7RD+Xo+tXGCRgTeDLHUXU1VqujZA8R8xs/IEAdxlZepTDr4tx3+XSJzfWlUy6kg==
X-Received: by 2002:a63:9e0a:: with SMTP id s10-v6mr38671425pgd.326.1537471135389;
        Thu, 20 Sep 2018 12:18:55 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:54 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 22/44] coresight: etm-perf: Add support for ETR backend
Date:   Thu, 20 Sep 2018 13:17:57 -0600
Message-Id: <1537471099-19781-23-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add support for using TMC-ETR as backend for ETM perf tracing.
We use software double buffering at the moment. i.e, the TMC-ETR
uses a separate buffer than the perf ring buffer. The data is
copied to the perf ring buffer once a session completes.

The TMC-ETR would try to match the larger of perf ring buffer
or the ETR buffer size configured via sysfs, scaling down to
a minimum limit of 1MB.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 248 +++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h     |   2 +
 2 files changed, 248 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 1aedfc3629c0..56fea4ff947e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "coresight-catu.h"
+#include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
@@ -21,6 +22,28 @@ struct etr_flat_buf {
 };
 
 /*
+ * etr_perf_buffer - Perf buffer used for ETR
+ * @etr_buf		- Actual buffer used by the ETR
+ * @snaphost		- Perf session mode
+ * @head		- handle->head at the beginning of the session.
+ * @nr_pages		- Number of pages in the ring buffer.
+ * @pages		- Array of Pages in the ring buffer.
+ */
+struct etr_perf_buffer {
+	struct etr_buf		*etr_buf;
+	bool			snapshot;
+	unsigned long		head;
+	int			nr_pages;
+	void			**pages;
+};
+
+/* Convert the perf index to an offset within the ETR buffer */
+#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+
+/* Lower limit for ETR hardware buffer */
+#define TMC_ETR_PERF_MIN_BUF_SIZE	SZ_1M
+
+/*
  * The TMC ETR SG has a page size of 4K. The SG table contains pointers
  * to 4KB buffers. However, the OS may use a PAGE_SIZE different from
  * 4K (i.e, 16KB or 64KB). This implies that a single OS page could
@@ -1103,10 +1126,228 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	return ret;
 }
 
+/*
+ * tmc_etr_setup_perf_buf: Allocate ETR buffer for use by perf.
+ * The size of the hardware buffer is dependent on the size configured
+ * via sysfs and the perf ring buffer size. We prefer to allocate the
+ * largest possible size, scaling down the size by half until it
+ * reaches a minimum limit (1M), beyond which we give up.
+ */
+static struct etr_perf_buffer *
+tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, int node, int nr_pages,
+		       void **pages, bool snapshot)
+{
+	struct etr_buf *etr_buf;
+	struct etr_perf_buffer *etr_perf;
+	unsigned long size;
+
+	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
+	if (!etr_perf)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Try to match the perf ring buffer size if it is larger
+	 * than the size requested via sysfs.
+	 */
+	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
+		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
+					    0, node, NULL);
+		if (!IS_ERR(etr_buf))
+			goto done;
+	}
+
+	/*
+	 * Else switch to configured size for this ETR
+	 * and scale down until we hit the minimum limit.
+	 */
+	size = drvdata->size;
+	do {
+		etr_buf = tmc_alloc_etr_buf(drvdata, size, 0, node, NULL);
+		if (!IS_ERR(etr_buf))
+			goto done;
+		size /= 2;
+	} while (size >= TMC_ETR_PERF_MIN_BUF_SIZE);
+
+	kfree(etr_perf);
+	return ERR_PTR(-ENOMEM);
+
+done:
+	etr_perf->etr_buf = etr_buf;
+	return etr_perf;
+}
+
+
+static void *tmc_alloc_etr_buffer(struct coresight_device *csdev,
+				  int cpu, void **pages, int nr_pages,
+				  bool snapshot)
+{
+	struct etr_perf_buffer *etr_perf;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (cpu == -1)
+		cpu = smp_processor_id();
+
+	etr_perf = tmc_etr_setup_perf_buf(drvdata, cpu_to_node(cpu),
+					  nr_pages, pages, snapshot);
+	if (IS_ERR(etr_perf)) {
+		dev_dbg(drvdata->dev, "Unable to allocate ETR buffer\n");
+		return NULL;
+	}
+
+	etr_perf->snapshot = snapshot;
+	etr_perf->nr_pages = nr_pages;
+	etr_perf->pages = pages;
+
+	return etr_perf;
+}
+
+static void tmc_free_etr_buffer(void *config)
+{
+	struct etr_perf_buffer *etr_perf = config;
+
+	if (etr_perf->etr_buf)
+		tmc_free_etr_buf(etr_perf->etr_buf);
+	kfree(etr_perf);
+}
+
+/*
+ * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
+ * buffer to the perf ring buffer.
+ */
+static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
+{
+	long bytes, to_copy;
+	long pg_idx, pg_offset, src_offset;
+	unsigned long head = etr_perf->head;
+	char **dst_pages, *src_buf;
+	struct etr_buf *etr_buf = etr_perf->etr_buf;
+
+	head = etr_perf->head;
+	pg_idx = head >> PAGE_SHIFT;
+	pg_offset = head & (PAGE_SIZE - 1);
+	dst_pages = (char **)etr_perf->pages;
+	src_offset = etr_buf->offset;
+	to_copy = etr_buf->len;
+
+	while (to_copy > 0) {
+		/*
+		 * In one iteration, we can copy minimum of :
+		 *  1) what is available in the source buffer,
+		 *  2) what is available in the source buffer, before it
+		 *     wraps around.
+		 *  3) what is available in the destination page.
+		 * in one iteration.
+		 */
+		bytes = tmc_etr_buf_get_data(etr_buf, src_offset, to_copy,
+					     &src_buf);
+		if (WARN_ON_ONCE(bytes <= 0))
+			break;
+		bytes = min(bytes, (long)(PAGE_SIZE - pg_offset));
+
+		memcpy(dst_pages[pg_idx] + pg_offset, src_buf, bytes);
+
+		to_copy -= bytes;
+
+		/* Move destination pointers */
+		pg_offset += bytes;
+		if (pg_offset == PAGE_SIZE) {
+			pg_offset = 0;
+			if (++pg_idx == etr_perf->nr_pages)
+				pg_idx = 0;
+		}
+
+		/* Move source pointers */
+		src_offset += bytes;
+		if (src_offset >= etr_buf->size)
+			src_offset -= etr_buf->size;
+	}
+}
+
+/*
+ * tmc_update_etr_buffer : Update the perf ring buffer with the
+ * available trace data. We use software double buffering at the moment.
+ *
+ * TODO: Add support for reusing the perf ring buffer.
+ */
+static unsigned long
+tmc_update_etr_buffer(struct coresight_device *csdev,
+		      struct perf_output_handle *handle,
+		      void *config)
+{
+	bool lost = false;
+	unsigned long flags, size = 0;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etr_perf_buffer *etr_perf = config;
+	struct etr_buf *etr_buf = etr_perf->etr_buf;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (WARN_ON(drvdata->perf_data != etr_perf)) {
+		lost = true;
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		goto out;
+	}
+
+	CS_UNLOCK(drvdata->base);
+
+	tmc_flush_and_stop(drvdata);
+	tmc_sync_etr_buf(drvdata);
+
+	CS_LOCK(drvdata->base);
+	/* Reset perf specific data */
+	drvdata->perf_data = NULL;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	size = etr_buf->len;
+	tmc_etr_sync_perf_buffer(etr_perf);
+
+	/*
+	 * Update handle->head in snapshot mode. Also update the size to the
+	 * hardware buffer size if there was an overflow.
+	 */
+	if (etr_perf->snapshot) {
+		handle->head += size;
+		if (etr_buf->full)
+			size = etr_buf->size;
+	}
+
+	lost |= etr_buf->full;
+out:
+	if (lost)
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+	return size;
+}
+
 static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 {
-	/* We don't support perf mode yet ! */
-	return -EINVAL;
+	int rc = 0;
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct perf_output_handle *handle = data;
+	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	/*
+	 * There can be only one writer per sink in perf mode. If the sink
+	 * is already open in SYSFS mode, we can't use it.
+	 */
+	if (drvdata->mode != CS_MODE_DISABLED || WARN_ON(drvdata->perf_data)) {
+		rc = -EBUSY;
+		goto unlock_out;
+	}
+
+	if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
+		rc = -EINVAL;
+		goto unlock_out;
+	}
+
+	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
+	drvdata->perf_data = etr_perf;
+	drvdata->mode = CS_MODE_PERF;
+	tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
+
+unlock_out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return rc;
 }
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev,
@@ -1148,6 +1389,9 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.enable		= tmc_enable_etr_sink,
 	.disable	= tmc_disable_etr_sink,
+	.alloc_buffer	= tmc_alloc_etr_buffer,
+	.update_buffer	= tmc_update_etr_buffer,
+	.free_buffer	= tmc_free_etr_buffer,
 };
 
 const struct coresight_ops tmc_etr_cs_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 872f63e3651b..487c53701e9c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -170,6 +170,7 @@ struct etr_buf {
  * @trigger_cntr: amount of words to store after a trigger.
  * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
  *		device configuration register (DEVID)
+ * @perf_data:	PERF buffer for ETR.
  * @sysfs_data:	SYSFS buffer for ETR.
  */
 struct tmc_drvdata {
@@ -191,6 +192,7 @@ struct tmc_drvdata {
 	u32			trigger_cntr;
 	u32			etr_caps;
 	struct etr_buf		*sysfs_buf;
+	void			*perf_data;
 };
 
 struct etr_buf_operations {
-- 
2.7.4

