Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1132C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3DD21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhwOpzvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3DD21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeIUBDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44253 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388833AbeIUBDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so4786084plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tFYB76CN7gcfQSlI2J2wI0x03dd/hmNnD3L0IdFWlMc=;
        b=HhwOpzvME2ykgvqdri2ZD/MCXcr5OgljKOlNVlT4bMz4JgLmS5QnlEM9FRS+bER9kI
         YvphspALxqog/dRp4XaC9O0nWISaLkZCFYuViU3QF32+cjiKRQ1hPl/vECvgmlH4uSsK
         u9F+UQcitGMTqn0MuYvgb9GLKKryBw57KViGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tFYB76CN7gcfQSlI2J2wI0x03dd/hmNnD3L0IdFWlMc=;
        b=icw1a1BnXGKcwuI8XrC1zmgbDVNsiWaKOjd99Xxc7aM1z4LJP/Qx4KoX2mBqfljcb3
         zlUHs/wC4dwX8al+7sJaADYnIWjPQScOc1J9l0q/oFkfxuXAerYebVd2RtHN2bLdB6/p
         0SDvmS8GdE5E+7YxAhPJinTt2UnZTRDMRWpmU/P0ZFj+a6vGx3dLFTlogvqWOGq0bHeN
         8uvDnV2xBWrQmpeW1ztrG2Qvcf0fM9q1I14VmYVpVe/G8AV/GeqXESNm9pwABbbKJwaN
         2qPMrFheV07t2B+kyxP7fefvFeM6lShXFNaKAZpemxyRKTXmA9u+Zq2S/Rfr7lM/4JbN
         yBJA==
X-Gm-Message-State: APzg51DdJSz3GFlJ9Uvf0Ei/BpIGt3w1mONHq4Fteo2dw9gb9zAPdgD9
        yfxQy7xBPJXlpWTc+ZqxLJ3uBg==
X-Google-Smtp-Source: ANB0VdYnT9dAdcIv+PYNJ/oyZminEGWZ1qj4u6PGTveI3LWBzXTuY7SHIAc03byT86+VD0VvHrd5OA==
X-Received: by 2002:a17:902:402:: with SMTP id 2-v6mr40336600ple.277.1537471130644;
        Thu, 20 Sep 2018 12:18:50 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:49 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 19/44] coresight: perf: Remove reset_buffer call back for sinks
Date:   Thu, 20 Sep 2018 13:17:54 -0600
Message-Id: <1537471099-19781-20-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Right now we issue an update_buffer() and reset_buffer() call backs
in succession when we stop tracing an event. The update_buffer is
supposed to check the status of the buffer and make sure the ring buffer
is updated with the trace data. And we store information about the
size of the data collected only to be consumed by the reset_buffer
callback which always follows the update_buffer. This was originally
designed for handling future IPs which could trigger a buffer overflow
interrupt. This patch gets rid of the reset_buffer callback altogether
and performs the actions in update_buffer, making it return the size
collected. We can always add the support for handling the overflow
interrupt case later.

This removes some not-so pretty hack (storing the new head in the
size field for snapshot mode) and cleans it up a little bit.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c    | 56 +++++------------------
 drivers/hwtracing/coresight/coresight-etm-perf.c |  9 +---
 drivers/hwtracing/coresight/coresight-tmc-etf.c  | 58 +++++-------------------
 include/linux/coresight.h                        |  6 +--
 4 files changed, 26 insertions(+), 103 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 3d4b6df32a06..dba75c905e57 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -319,37 +319,7 @@ static int etb_set_buffer(struct coresight_device *csdev,
 	return ret;
 }
 
-static unsigned long etb_reset_buffer(struct coresight_device *csdev,
-				      struct perf_output_handle *handle,
-				      void *sink_config)
-{
-	unsigned long size = 0;
-	struct cs_buffers *buf = sink_config;
-
-	if (buf) {
-		/*
-		 * In snapshot mode ->data_size holds the new address of the
-		 * ring buffer's head.  The size itself is the whole address
-		 * range since we want the latest information.
-		 */
-		if (buf->snapshot)
-			handle->head = local_xchg(&buf->data_size,
-						  buf->nr_pages << PAGE_SHIFT);
-
-		/*
-		 * Tell the tracer PMU how much we got in this run and if
-		 * something went wrong along the way.  Nobody else can use
-		 * this cs_buffers instance until we are done.  As such
-		 * resetting parameters here and squaring off with the ring
-		 * buffer API in the tracer PMU is fine.
-		 */
-		size = local_xchg(&buf->data_size, 0);
-	}
-
-	return size;
-}
-
-static void etb_update_buffer(struct coresight_device *csdev,
+static unsigned long etb_update_buffer(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config)
 {
@@ -358,13 +328,13 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	u8 *buf_ptr;
 	const u32 *barrier;
 	u32 read_ptr, write_ptr, capacity;
-	u32 status, read_data, to_read;
-	unsigned long offset;
+	u32 status, read_data;
+	unsigned long offset, to_read;
 	struct cs_buffers *buf = sink_config;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	if (!buf)
-		return;
+		return 0;
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
@@ -469,18 +439,17 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	writel_relaxed(0x0, drvdata->base + ETB_RAM_WRITE_POINTER);
 
 	/*
-	 * In snapshot mode all we have to do is communicate to
-	 * perf_aux_output_end() the address of the current head.  In full
-	 * trace mode the same function expects a size to move rb->aux_head
-	 * forward.
+	 * In snapshot mode we have to update the handle->head to point
+	 * to the new location.
 	 */
-	if (buf->snapshot)
-		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
-	else
-		local_add(to_read, &buf->data_size);
-
+	if (buf->snapshot) {
+		handle->head = (cur * PAGE_SIZE) + offset;
+		to_read = buf->nr_pages << PAGE_SHIFT;
+	}
 	etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
+
+	return to_read;
 }
 
 static const struct coresight_ops_sink etb_sink_ops = {
@@ -489,7 +458,6 @@ static const struct coresight_ops_sink etb_sink_ops = {
 	.alloc_buffer	= etb_alloc_buffer,
 	.free_buffer	= etb_free_buffer,
 	.set_buffer	= etb_set_buffer,
-	.reset_buffer	= etb_reset_buffer,
 	.update_buffer	= etb_update_buffer,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6db76ce6ba5f..ad87441f65d7 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -369,15 +369,8 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		if (!sink_ops(sink)->update_buffer)
 			return;
 
-		sink_ops(sink)->update_buffer(sink, handle,
+		size = sink_ops(sink)->update_buffer(sink, handle,
 					      event_data->snk_config);
-
-		if (!sink_ops(sink)->reset_buffer)
-			return;
-
-		size = sink_ops(sink)->reset_buffer(sink, handle,
-						    event_data->snk_config);
-
 		perf_aux_output_end(handle, size);
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 434003a43346..31a98f915641 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -349,36 +349,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 	return ret;
 }
 
-static unsigned long tmc_reset_etf_buffer(struct coresight_device *csdev,
-					  struct perf_output_handle *handle,
-					  void *sink_config)
-{
-	long size = 0;
-	struct cs_buffers *buf = sink_config;
-
-	if (buf) {
-		/*
-		 * In snapshot mode ->data_size holds the new address of the
-		 * ring buffer's head.  The size itself is the whole address
-		 * range since we want the latest information.
-		 */
-		if (buf->snapshot)
-			handle->head = local_xchg(&buf->data_size,
-						  buf->nr_pages << PAGE_SHIFT);
-		/*
-		 * Tell the tracer PMU how much we got in this run and if
-		 * something went wrong along the way.  Nobody else can use
-		 * this cs_buffers instance until we are done.  As such
-		 * resetting parameters here and squaring off with the ring
-		 * buffer API in the tracer PMU is fine.
-		 */
-		size = local_xchg(&buf->data_size, 0);
-	}
-
-	return size;
-}
-
-static void tmc_update_etf_buffer(struct coresight_device *csdev,
+static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 				  struct perf_output_handle *handle,
 				  void *sink_config)
 {
@@ -387,17 +358,17 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	const u32 *barrier;
 	u32 *buf_ptr;
 	u64 read_ptr, write_ptr;
-	u32 status, to_read;
-	unsigned long offset;
+	u32 status;
+	unsigned long offset, to_read;
 	struct cs_buffers *buf = sink_config;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	if (!buf)
-		return;
+		return 0;
 
 	/* This shouldn't happen */
 	if (WARN_ON_ONCE(drvdata->mode != CS_MODE_PERF))
-		return;
+		return 0;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -486,18 +457,14 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 		}
 	}
 
-	/*
-	 * In snapshot mode all we have to do is communicate to
-	 * perf_aux_output_end() the address of the current head.  In full
-	 * trace mode the same function expects a size to move rb->aux_head
-	 * forward.
-	 */
-	if (buf->snapshot)
-		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
-	else
-		local_add(to_read, &buf->data_size);
-
+	/* In snapshot mode we have to update the head */
+	if (buf->snapshot) {
+		handle->head = (cur * PAGE_SIZE) + offset;
+		to_read = buf->nr_pages << PAGE_SHIFT;
+	}
 	CS_LOCK(drvdata->base);
+
+	return to_read;
 }
 
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
@@ -506,7 +473,6 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.alloc_buffer	= tmc_alloc_etf_buffer,
 	.free_buffer	= tmc_free_etf_buffer,
 	.set_buffer	= tmc_set_etf_buffer,
-	.reset_buffer	= tmc_reset_etf_buffer,
 	.update_buffer	= tmc_update_etf_buffer,
 };
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 41e1f4333bf2..8e52682b1e90 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -186,7 +186,6 @@ struct coresight_device {
  * @alloc_buffer:	initialises perf's ring buffer for trace collection.
  * @free_buffer:	release memory allocated in @get_config.
  * @set_buffer:		initialises buffer mechanic before a trace session.
- * @reset_buffer:	finalises buffer mechanic after a trace session.
  * @update_buffer:	update buffer pointers after a trace session.
  */
 struct coresight_ops_sink {
@@ -198,10 +197,7 @@ struct coresight_ops_sink {
 	int (*set_buffer)(struct coresight_device *csdev,
 			  struct perf_output_handle *handle,
 			  void *sink_config);
-	unsigned long (*reset_buffer)(struct coresight_device *csdev,
-				      struct perf_output_handle *handle,
-				      void *sink_config);
-	void (*update_buffer)(struct coresight_device *csdev,
+	unsigned long (*update_buffer)(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config);
 };
-- 
2.7.4

