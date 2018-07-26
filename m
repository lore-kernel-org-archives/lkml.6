Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E757C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95E22088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95E22088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbeGZOMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:12:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55052 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbeGZOL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:11:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 517C815B2;
        Thu, 26 Jul 2018 05:55:15 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F15663F6A8;
        Thu, 26 Jul 2018 05:55:13 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 10/13] coresight: perf: Remove reset_buffer call back for sinks
Date:   Thu, 26 Jul 2018 13:54:48 +0100
Message-Id: <1532609691-16863-11-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/hwtracing/coresight/coresight-etb10.c    | 56 +++++------------------
 drivers/hwtracing/coresight/coresight-etm-perf.c |  9 +---
 drivers/hwtracing/coresight/coresight-tmc-etf.c  | 58 +++++-------------------
 include/linux/coresight.h                        |  6 +--
 4 files changed, 26 insertions(+), 103 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 474c247..60bfc7b 100644
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
index 6db76ce..ad87441 100644
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
index 434003a..31a98f9 100644
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
index d828a6e..eafe4d1 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -191,7 +191,6 @@ struct coresight_device {
  * @alloc_buffer:	initialises perf's ring buffer for trace collection.
  * @free_buffer:	release memory allocated in @get_config.
  * @set_buffer:		initialises buffer mechanic before a trace session.
- * @reset_buffer:	finalises buffer mechanic after a trace session.
  * @update_buffer:	update buffer pointers after a trace session.
  */
 struct coresight_ops_sink {
@@ -203,10 +202,7 @@ struct coresight_ops_sink {
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

