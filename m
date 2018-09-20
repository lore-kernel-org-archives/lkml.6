Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CFFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D35821531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQWIdICg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D35821531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbeIUBDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38261 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388760AbeIUBDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so4799733plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t+LSSda+KATOPPphXIMKmk0lSawpQVMOb7XobeDIV5o=;
        b=hQWIdICg51flFCbl4OsdDjQTPGGVlFhFsWi3MzOyqIgy0uOGSpna+Zol84PEAOMa0p
         auCGLm62I/vVHZVUENVXxblv/yJYz+Voezzz72+DefByCnFjZd1GE/Fgr/tod8qUWiN2
         fwR/w/F2NzJT9jfZ/rQTUdqcP/HaDsenC61vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t+LSSda+KATOPPphXIMKmk0lSawpQVMOb7XobeDIV5o=;
        b=YE5Jv2rCWb7bTW0oFuZ2GRUz8Mfkq0EvqFJZOEg85/Ic3k0+9AZqW/wGmHcjSdJ/ML
         nMEb+EknZh/XDyx9mev4HlfyBO/HVmwHWKGK1jLFM0tD1/+teCyoTqXkLoL9qU/YFijf
         llAELxgTYOyByaANYuUHsdxrnAF+WUtYlwTyaISXNlEX9WafB43VmZrPbnIM+cK3cSxN
         kvcSKFClE0Lv5nMxk/CQ+MMlVO9M+jdjYFuZD7QwQ9WGJvwlcH/qFTH7d59o2JAMg2zn
         Aoq4+10EoV2mlvPE5Z8+PzZWkGXmF8eG6EdfPbZq2xKP7+Wz9WZKJDbU8z6XJJjGHv84
         EuXw==
X-Gm-Message-State: APzg51BCagIzd4kHEJcjfgpJyiWxFTUCZo6LivZo6F0I4orrcv0ZTtkc
        QrF7HOE/4WkvOp9guKBHFVZj92uzETc=
X-Google-Smtp-Source: ANB0VdajJAfRQzQ4VM4KxJOVRKUdjsMlZgCWYY3kjXZBuj87PuB5bMDpX1ztszGERzMUjWKdd8ybDQ==
X-Received: by 2002:a17:902:24e1:: with SMTP id l30-v6mr40912333plg.315.1537471119734;
        Thu, 20 Sep 2018 12:18:39 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:38 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/44] coresight: perf: Fix per cpu path management
Date:   Thu, 20 Sep 2018 13:17:47 -0600
Message-Id: <1537471099-19781-13-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We create a coresight trace path for each online CPU when
we start the event. We rely on the number of online CPUs
and then go on to allocate an array matching the "number of
online CPUs" for holding the path and then uses normal
CPU id as the index to the array. This is problematic as
we could have some offline CPUs causing us to access beyond
the actual array size (e.g, on a dual SMP system, if CPU0 is
offline, CPU1 could be really accessing beyond the array).
The solution is to switch to per-cpu array for holding the path.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 55 +++++++++++++++++-------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 677695635211..6338dd180031 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/perf_event.h>
+#include <linux/percpu-defs.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -33,7 +34,7 @@ struct etm_event_data {
 	struct work_struct work;
 	cpumask_t mask;
 	void *snk_config;
-	struct list_head **path;
+	struct list_head * __percpu *path;
 };
 
 static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
@@ -61,6 +62,18 @@ static const struct attribute_group *etm_pmu_attr_groups[] = {
 	NULL,
 };
 
+static inline struct list_head **
+etm_event_cpu_path_ptr(struct etm_event_data *data, int cpu)
+{
+	return per_cpu_ptr(data->path, cpu);
+}
+
+static inline struct list_head *
+etm_event_cpu_path(struct etm_event_data *data, int cpu)
+{
+	return *etm_event_cpu_path_ptr(data, cpu);
+}
+
 static void etm_event_read(struct perf_event *event) {}
 
 static int etm_addr_filters_alloc(struct perf_event *event)
@@ -120,23 +133,26 @@ static void free_event_data(struct work_struct *work)
 	 */
 	if (event_data->snk_config) {
 		cpu = cpumask_first(mask);
-		sink = coresight_get_sink(event_data->path[cpu]);
+		sink = coresight_get_sink(etm_event_cpu_path(event_data, cpu));
 		if (sink_ops(sink)->free_buffer)
 			sink_ops(sink)->free_buffer(event_data->snk_config);
 	}
 
 	for_each_cpu(cpu, mask) {
-		if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
-			coresight_release_path(event_data->path[cpu]);
+		struct list_head **ppath;
+
+		ppath = etm_event_cpu_path_ptr(event_data, cpu);
+		if (!(IS_ERR_OR_NULL(*ppath)))
+			coresight_release_path(*ppath);
+		*ppath = NULL;
 	}
 
-	kfree(event_data->path);
+	free_percpu(event_data->path);
 	kfree(event_data);
 }
 
 static void *alloc_event_data(int cpu)
 {
-	int size;
 	cpumask_t *mask;
 	struct etm_event_data *event_data;
 
@@ -147,7 +163,6 @@ static void *alloc_event_data(int cpu)
 
 	/* Make sure nothing disappears under us */
 	get_online_cpus();
-	size = num_online_cpus();
 
 	mask = &event_data->mask;
 	if (cpu != -1)
@@ -164,8 +179,8 @@ static void *alloc_event_data(int cpu)
 	 * unused memory when dealing with single CPU trace scenarios is small
 	 * compared to the cost of searching through an optimized array.
 	 */
-	event_data->path = kcalloc(size,
-				   sizeof(struct list_head *), GFP_KERNEL);
+	event_data->path = alloc_percpu(struct list_head *);
+
 	if (!event_data->path) {
 		kfree(event_data);
 		return NULL;
@@ -213,6 +228,7 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 
 	/* Setup the path for each CPU in a trace session */
 	for_each_cpu(cpu, mask) {
+		struct list_head *path;
 		struct coresight_device *csdev;
 
 		csdev = per_cpu(csdev_src, cpu);
@@ -224,9 +240,11 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 		 * list of devices from source to sink that can be
 		 * referenced later when the path is actually needed.
 		 */
-		event_data->path[cpu] = coresight_build_path(csdev, sink);
-		if (IS_ERR(event_data->path[cpu]))
+		path = coresight_build_path(csdev, sink);
+		if (IS_ERR(path))
 			goto err;
+
+		*etm_event_cpu_path_ptr(event_data, cpu) = path;
 	}
 
 	if (!sink_ops(sink)->alloc_buffer)
@@ -255,6 +273,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct etm_event_data *event_data;
 	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
+	struct list_head *path;
 
 	if (!csdev)
 		goto fail;
@@ -267,8 +286,9 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (!event_data)
 		goto fail;
 
+	path = etm_event_cpu_path(event_data, cpu);
 	/* We need a sink, no need to continue without one */
-	sink = coresight_get_sink(event_data->path[cpu]);
+	sink = coresight_get_sink(path);
 	if (WARN_ON_ONCE(!sink || !sink_ops(sink)->set_buffer))
 		goto fail_end_stop;
 
@@ -278,7 +298,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 		goto fail_end_stop;
 
 	/* Nothing will happen without a path */
-	if (coresight_enable_path(event_data->path[cpu], CS_MODE_PERF))
+	if (coresight_enable_path(path, CS_MODE_PERF))
 		goto fail_end_stop;
 
 	/* Tell the perf core the event is alive */
@@ -306,6 +326,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
 	struct etm_event_data *event_data = perf_get_aux(handle);
+	struct list_head *path;
 
 	if (event->hw.state == PERF_HES_STOPPED)
 		return;
@@ -313,7 +334,11 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	if (!csdev)
 		return;
 
-	sink = coresight_get_sink(event_data->path[cpu]);
+	path = etm_event_cpu_path(event_data, cpu);
+	if (!path)
+		return;
+
+	sink = coresight_get_sink(path);
 	if (!sink)
 		return;
 
@@ -344,7 +369,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	}
 
 	/* Disabling the path make its elements available to other sessions */
-	coresight_disable_path(event_data->path[cpu]);
+	coresight_disable_path(path);
 }
 
 static int etm_event_add(struct perf_event *event, int mode)
-- 
2.7.4

