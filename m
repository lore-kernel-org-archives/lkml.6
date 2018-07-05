Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B44AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09F024049
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="chvJv8Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09F024049
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeGEWOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:14:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41509 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753690AbeGEWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:13:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id c21-v6so1963173pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kk6/eBloN+GMp0gLJQKhKtW9m+CvB3cMWKDmf3yGyio=;
        b=chvJv8Ds64iPM66o60/uixPQfAvmU4aIQ4uWC/54Y/t4B/38HSBLiuRzLQ2YLiUzwg
         Rvsnd4yy6dciFJvcldWdQfbmyNoIzjDYXja9EWgRfOj1nC1v58HC91n61EXJuu8zkjRV
         ox6RbuoL5ViOOy4HU15BzTRtAcS+Em0M2msGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kk6/eBloN+GMp0gLJQKhKtW9m+CvB3cMWKDmf3yGyio=;
        b=lHX9murhLgqkYSU2sWqw/wLrPU96hdTfrLl+LCkNCQQPmWH6xH74s1NQ5BvmPk58bR
         kIzFSa54Mq2OaDmDEegKlbHUa5NU5SiYxoIUzWoYFmES0nQuZeymcKebh9ZzcpSOcOga
         s+C8KPdnw55N3TGZCRBrahqxgDExo/E1wpcbUjtoEQFSpCx2fzwk+Pgs/wxo+faagfgi
         MqQ5b0cLgzdBJNIYK3T3ZG/j8I5Wq5B5dug/hW1QkOXb6J8GVmFGgiW7qn3jgj+FSQb+
         yaPraOjgyDemDy5pIZ3mzt8G+AMGZDW+yN8vl6dkeUeagyD/v+whsV7rCsVyGAhZJ+iK
         hcwg==
X-Gm-Message-State: APt69E3zRR5oDugeZDp2SEgIqp/Xp4VUZ2SvN65TgJhsYb7PVmD9InFd
        UV4nt5JjTCj8oT1DWkMOn2BVLA==
X-Google-Smtp-Source: AAOMgpdqBcI/nX3MAtHVsUBxHjI9pQUEJ2oeSfcKgy5Lf9sTxA7F7oU9gRQllMF8HJ+D9Lbl5q6TkA==
X-Received: by 2002:aa7:83d1:: with SMTP id j17-v6mr8214065pfn.236.1530828839257;
        Thu, 05 Jul 2018 15:13:59 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r89-v6sm13297486pfa.75.2018.07.05.15.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 15:13:58 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peterz@infradead.org, acme@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/7] coresight: Use PMU driver configuration for sink selection
Date:   Thu,  5 Jul 2018 16:13:44 -0600
Message-Id: <1530828827-11604-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
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
 drivers/hwtracing/coresight/coresight-etm-perf.c | 130 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |   4 +
 2 files changed, 122 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 0f5e03e4df22..5c2cce60da5e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/parser.h>
 #include <linux/perf_event.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -22,6 +23,8 @@
 static struct pmu etm_pmu;
 static bool etm_perf_up;
 
+#define CORESIGHT_DEVICE_MAX_NAME_LEN	256
+
 /**
  * struct etm_event_data - Coresight specifics associated to an event
  * @work:		Handle to free allocated memory outside IRQ context.
@@ -181,6 +184,74 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
+static char *etm_drv_config_sync(struct perf_event *event)
+{
+	char *sink;
+	int node = event->cpu == -1 ? -1 : cpu_to_node(event->cpu);
+	struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	sink = kmalloc_node(CORESIGHT_DEVICE_MAX_NAME_LEN, GFP_KERNEL, node);
+	if (!sink)
+		return NULL;
+
+	/*
+	 * Make sure we don't race with perf_drv_config_replace() in
+	 * kernel/events/core.c.
+	 */
+	raw_spin_lock(&drv_config->lock);
+	memcpy(sink, drv_config->config, CORESIGHT_DEVICE_MAX_NAME_LEN);
+	raw_spin_unlock(&drv_config->lock);
+
+	return sink;
+}
+
+static struct coresight_device *etm_event_get_sink(struct perf_event *event)
+{
+	struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	/*
+	 * Try the preferred method first, i.e getting the sink information
+	 * using the ioctl() method.
+	 */
+	if (drv_config->config) {
+		char *drv_config;
+		struct device *dev;
+		struct coresight_device *sink;
+
+		/*
+		 * Get sink from event->hw.drv_config.config - see
+		 * _perf_ioctl() _SET_DRV_CONFIG.
+		 */
+		drv_config = etm_drv_config_sync(event);
+		if (!drv_config)
+			goto out;
+
+		/* Look for the device of that name on the CS bus. */
+		dev = bus_find_device_by_name(&coresight_bustype, NULL,
+					      drv_config);
+		kfree(drv_config);
+
+		if (dev) {
+			sink = to_coresight_device(dev);
+			/* Put reference from 'bus_find_device()' */
+			put_device(dev);
+			return sink;
+		}
+	}
+
+	/*
+	 * No luck with the above method, so we are working with an older user
+	 * space.  See if a sink has been set using sysFS.  If this is the case
+	 * CPU-wide session will only be able to use a single sink.
+	 *
+	 * When operated from sysFS users are responsible to enable the sink
+	 * while from perf, the perf tools will do it based on the choice made
+	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
+	 */
+out:
+	return coresight_get_enabled_sink(true);
+}
+
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
@@ -194,18 +265,8 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
+	/* First get the sink to use for this event */
+	sink = etm_event_get_sink(event);
 	if (!sink)
 		goto err;
 
@@ -442,6 +503,49 @@ static void etm_addr_filters_sync(struct perf_event *event)
 	filters->nr_filters = i;
 }
 
+static const match_table_t config_tokens = {
+	{ ETM_CFG_SINK,		"%u.%s" },
+	{ ETM_CFG_NONE,		NULL },
+};
+
+static void *etm_drv_config_validate(struct perf_event *event, char *cstr)
+{
+	char *str, *to_parse, *sink = NULL;
+	int token, ret = -EINVAL;
+	substring_t args[MAX_OPT_ARGS];
+
+	to_parse = kstrdup(cstr, GFP_KERNEL);
+	if (!to_parse)
+		return ERR_PTR(-ENOMEM);
+
+	while ((str = strsep(&to_parse, " ,\n")) != NULL) {
+		if (!*str)
+			continue;
+
+		token = match_token(str, config_tokens, args);
+		switch (token) {
+		case ETM_CFG_SINK:
+			sink = kstrdup(str, GFP_KERNEL);
+			if (!sink) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			break;
+		default:
+			goto out;
+		}
+	}
+
+out:
+	kfree(to_parse);
+	return sink ? sink : ERR_PTR(ret);
+}
+
+static void etm_drv_config_free(void *drv_data)
+{
+	kfree(drv_data);
+}
+
 int etm_perf_symlink(struct coresight_device *csdev, bool link)
 {
 	char entry[sizeof("cpu9999999")];
@@ -486,6 +590,8 @@ static int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.drv_config_validate	= etm_drv_config_validate;
+	etm_pmu.drv_config_free		= etm_drv_config_free;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 4197df4faf5e..37a98230fc34 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -42,6 +42,10 @@ struct etm_filters {
 	bool			ssstatus;
 };
 
+enum etm_config_elem_type {
+	ETM_CFG_NONE = -1,
+	ETM_CFG_SINK,
+};
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
-- 
2.7.4

