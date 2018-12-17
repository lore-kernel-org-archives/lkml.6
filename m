Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EFAC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C0221473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+6xK+0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeLQRWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:22:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43950 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbeLQRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:21:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so6435618plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vffhfUlrlCExin749UjB4Nm/CBeftT0GbW0095v/Xho=;
        b=C+6xK+0a+lPk9/Jka+QJIqeB/MDgk+NIwssQyhCsdKazJTK6n7oJHufE+4M2VUaOta
         VuCjWVMB0oSrl6eYfOVL2IMEbPjH9hRfS3UyN2MKJx6Bz1TAu1BJaQ8+hJsCkFxVmDEG
         n4zktOwuQ/RU4YR/amHmjcaCwvJTzliiG4kyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vffhfUlrlCExin749UjB4Nm/CBeftT0GbW0095v/Xho=;
        b=ZDmWZeTLOvYyurwE3gfv3Jyqcj2P0tkCUkPmkC88w1XNIZTwmMFc7OpX9XA8Z+avz6
         N5jHFKgHkD+QBi13Q/T7XQK8YWzjV6qBeTddWOGhp5G+k9E684LJO8jfvZ7+HpL50yKX
         MhyKgDNo9zguGqSzzi1jAVuWkAELRlQHXrT8uBkXWPhdUwfHIhK05YPygcd9h0FE6FE0
         8I1tm/3xCdNcwlJ7bzMhME5zmIBaEXThWlyeaXmNUDKjONfdcJLpdupbYetpS1MDpo1I
         TSj2zOcjaicRJOvrzrH0z4qPOe8+dXKlgLVpBF/MmhD6pw5qkxumaKROlnrYRUpR+LJL
         PxQw==
X-Gm-Message-State: AA+aEWbKxPntRZyYmmtaT7oTC7q7vqEz/m3+pe9puGpqB0ieOe5f/Mlc
        FQlcY0QucqRPf4j8LVCA5FbE+g==
X-Google-Smtp-Source: AFSGD/X1mJFY5vQ8ap8ZO5bG0Nt30OZ01y2j7owN+iuOR/CNWZSqJBLbtJD4y18lnrO8kaEQbQ9LMw==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr13171952pln.204.1545067316335;
        Mon, 17 Dec 2018 09:21:56 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j6sm20526648pfg.126.2018.12.17.09.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 09:21:55 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for sink selection
Date:   Mon, 17 Dec 2018 10:21:44 -0700
Message-Id: <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the PMU driver configuration held in event::hw::drv_config
to select a sink for each event that is created (the old sysFS way of
working is kept around for backward compatibility).

By proceeding in this way a sink can be used by multiple sessions
without having to play games with entries in sysFS.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 74 ++++++++++++++++++++----
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f21eb28b6782..a7e1fdef07f2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/amba/bus.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
@@ -11,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/perf_event.h>
 #include <linux/percpu-defs.h>
 #include <linux/slab.h>
@@ -177,6 +179,26 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
+static struct coresight_device *etm_drv_config_sync(struct perf_event *event)
+{
+	struct coresight_device *sink = NULL;
+	struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	/*
+	 * Make sure we don't race with perf_drv_config_replace() in
+	 * kernel/events/core.c.
+	 */
+	raw_spin_lock(&drv_config->lock);
+
+	/* Copy what we got from user space if applicable. */
+	if (drv_config->config)
+		sink = drv_config->config;
+
+	raw_spin_unlock(&drv_config->lock);
+
+	return sink;
+}
+
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
@@ -190,18 +212,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
 
-	/*
-	 * In theory nothing prevent tracers in a trace session from being
-	 * associated with different sinks, nor having a sink per tracer.  But
-	 * until we have HW with this kind of topology we need to assume tracers
-	 * in a trace session are using the same sink.  Therefore go through
-	 * the coresight bus and pick the first enabled sink.
-	 *
-	 * When operated from sysFS users are responsible to enable the sink
-	 * while from perf, the perf tools will do it based on the choice made
-	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
-	 */
-	sink = coresight_get_enabled_sink(true);
+	/* First get the sink config from user space. */
+	sink = etm_drv_config_sync(event);
+	if (!sink)
+		sink = coresight_get_enabled_sink(true);
+
 	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
@@ -454,6 +469,40 @@ static void etm_addr_filters_sync(struct perf_event *event)
 	filters->nr_filters = i;
 }
 
+static int etm_drv_config_find_sink(struct device *dev, void *data)
+{
+	struct amba_device *adev = to_amba_device(dev->parent);
+	struct resource *res = &adev->res;
+	u64 value = *((u64 *)data);
+
+	/*
+	 * The HW mapping of a component is unique.  If the value we've been
+	 * given matches the component's start address, then we must have found
+	 * the device we are looking for.
+	 */
+	if (res->start == value)
+		return 1;
+
+	return 0;
+}
+
+static void *etm_drv_config_validate(struct perf_event *event, u64 value)
+{
+	struct device *dev;
+	struct coresight_device *sink;
+
+	/* Look for the device with a res->start equal to @value. */
+	dev = bus_find_device(&coresight_bustype, NULL,
+			      &value, etm_drv_config_find_sink);
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	sink = to_coresight_device(dev);
+	put_device(dev);
+
+	return sink;
+}
+
 int etm_perf_symlink(struct coresight_device *csdev, bool link)
 {
 	char entry[sizeof("cpu9999999")];
@@ -498,6 +547,7 @@ static int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.drv_config_validate	= etm_drv_config_validate;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
-- 
2.7.4

