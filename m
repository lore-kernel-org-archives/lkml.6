Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE46AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F93C21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnHx5iJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F93C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbeIUBDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45620 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388779AbeIUBDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so71053pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/cufbapRdtpm9uJwj2FU3UqUyWMulu2ZwmwOUUarkR0=;
        b=HnHx5iJH38dagwRLuzloFX6WVt158NVGcnSNc9YrY3xkiYhFOp1KgJHkXLZguQFuaP
         989/RAuOz+ygOEQuuyN7V9/4tr/xmKVuKxw1iI5KdRPYsic9TH1mIVkMTjqTzMw3d1Oc
         yn0VAQ32bs03S2USVaM/39k3rcDcx7iXHy8D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/cufbapRdtpm9uJwj2FU3UqUyWMulu2ZwmwOUUarkR0=;
        b=IBgoRM/CuXicWbrfznsxGi76h6s7j+sbFAlMFuYMhY3LvD+53miu7S0Lei4Aj5kGF7
         8EufDISGFGK4U4GcCqkyq6DKceIhv67PMSra07y4fWDyZTpbYTGnrusQ8QnoGQ7MWhL9
         NgJ6smB3uDZIT0DcrzU2+EGSe0yKK3iQArs1SqZluEkHNSB/F+6U4rplY0Jkrkn/elxw
         /Zpxy8qNEyyaMOVwQG0uMWiO4gTTS4okS4JNtE2BB1qN0S3m2QjVohlnHfPKeJH77Gb7
         QVPEszyxR3GFKaUPoy32UT3rIsvy1vhdf6u0eZFHfyINkUrcGI2XyTcYBoIgRmOoD7oi
         2/tg==
X-Gm-Message-State: APzg51Bsstvo83trhPZ3vEijeqd8ZP2gPVf+kYVCCtoSKa2hii71xcXP
        s5rVcQaIV4CehNBA2jTl+/q8jg==
X-Google-Smtp-Source: ANB0Vdbak7YYbRZPxvsNHpx9Cj1HujPIwguLqklfs3s3MCM0xReAImOYaozFn5TgXZAm4HEqYTk+MQ==
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr42784560pfb.94.1537471122978;
        Thu, 20 Sep 2018 12:18:42 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:41 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/44] coresight: perf: Allow tracing on hotplugged CPUs
Date:   Thu, 20 Sep 2018 13:17:49 -0600
Message-Id: <1537471099-19781-15-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

At the moment, if there is no CPU specified for a given
event, we use cpu_online_mask and try to build path for
each of the CPUs in the mask. This could prevent any CPU
that is turned online later to be used for the tracing.

This patch changes to use the cpu_present_mask and tries
to build path for as much CPUs as possible ignoring the
failures in building path for some of the CPUs. If ever
we try to trace on those CPUs, we fail the operation.

Based on a patch from Mathieu Poirier.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 44 ++++++++++++++++--------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6beb662d230c..afe7e7fc1a93 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -127,11 +127,9 @@ static void free_event_data(struct work_struct *work)
 
 	event_data = container_of(work, struct etm_event_data, work);
 	mask = &event_data->mask;
-	/*
-	 * First deal with the sink configuration.  See comment in
-	 * etm_setup_aux() about why we take the first available path.
-	 */
-	if (event_data->snk_config) {
+
+	/* Free the sink buffers, if there are any */
+	if (event_data->snk_config && !WARN_ON(cpumask_empty(mask))) {
 		cpu = cpumask_first(mask);
 		sink = coresight_get_sink(etm_event_cpu_path(event_data, cpu));
 		if (sink_ops(sink)->free_buffer)
@@ -166,7 +164,7 @@ static void *alloc_event_data(int cpu)
 	if (cpu != -1)
 		cpumask_set_cpu(cpu, mask);
 	else
-		cpumask_copy(mask, cpu_online_mask);
+		cpumask_copy(mask, cpu_present_mask);
 
 	/*
 	 * Each CPU has a single path between source and destination.  As such
@@ -218,19 +216,32 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
 	 */
 	sink = coresight_get_enabled_sink(true);
-	if (!sink)
+	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
 	mask = &event_data->mask;
 
-	/* Setup the path for each CPU in a trace session */
+	/*
+	 * Setup the path for each CPU in a trace session. We try to build
+	 * trace path for each CPU in the mask. If we don't find an ETM
+	 * for the CPU or fail to build a path, we clear the CPU from the
+	 * mask and continue with the rest. If ever we try to trace on those
+	 * CPUs, we can handle it and fail the session.
+	 */
 	for_each_cpu(cpu, mask) {
 		struct list_head *path;
 		struct coresight_device *csdev;
 
 		csdev = per_cpu(csdev_src, cpu);
-		if (!csdev)
-			goto err;
+		/*
+		 * If there is no ETM associated with this CPU clear it from
+		 * the mask and continue with the rest. If ever we try to trace
+		 * on this CPU, we handle it accordingly.
+		 */
+		if (!csdev) {
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
 
 		/*
 		 * Building a path doesn't enable it, it simply builds a
@@ -238,17 +249,20 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 		 * referenced later when the path is actually needed.
 		 */
 		path = coresight_build_path(csdev, sink);
-		if (IS_ERR(path))
-			goto err;
+		if (IS_ERR(path)) {
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
 
 		*etm_event_cpu_path_ptr(event_data, cpu) = path;
 	}
 
-	if (!sink_ops(sink)->alloc_buffer)
+	/* If we don't have any CPUs ready for tracing, abort */
+	cpu = cpumask_first(mask);
+	if (cpu >= nr_cpu_ids)
 		goto err;
 
-	cpu = cpumask_first(mask);
-	/* Get the AUX specific data from the sink buffer */
+	/* Allocate the sink buffer for this session */
 	event_data->snk_config =
 			sink_ops(sink)->alloc_buffer(sink, cpu, pages,
 						     nr_pages, overwrite);
-- 
2.7.4

