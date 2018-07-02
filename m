Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F97C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C86624F57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0kO2NqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C86624F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeGBWl3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:41:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44074 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeGBWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:41:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id r1-v6so1098pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MeRc7xJj3ZW4F+ziFAe3DIXl5dMAluw3Bs5u+H+VrdA=;
        b=W0kO2NqSZVLscxE/sFSKBl1yVE7Bv51I4S47SM8GZXzO+J8YDCmVwG9/8fr0wtOD9o
         F1PUVruP2b/l/acc8/wboHLP1CuB6vmLVyqjagL/QchiajPqz/Utz8bB8b5NYe2O23hW
         tr/wsw/zKRqqYVUIEzGP/kVmyNBnee/ZDxY9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MeRc7xJj3ZW4F+ziFAe3DIXl5dMAluw3Bs5u+H+VrdA=;
        b=Ca9Yr7OQnZTCKIXsoCvHnHdCPq4gYNvP5kQirEb94JdXFTOYiWdsimGdEMXslCtd5s
         G5OzrZAjZHv50bx2OcjtwN+I+ESfiQL0cufFZSlgHv4E1IZ3Uyg8T4M5/78oHFAfBNBK
         r6nHzkfGzEU2bV1iQgdlqkcnH4Vuu1YMHIN/VyKCnS7J1+d4LKmcVgU53VdL4mgYKGvO
         fiJJAN4P+f4fakC/JuBSllaESMcYLRryTERMA7XXCksx84fxHlbn0u1gH8u3qcjy21/P
         7GWhDE8ciSv6N65TYmXXRIduyO/31rbvbjeNHjL8lGQrGTBpjKtpxw3eYVyw4AOQ96U1
         M27g==
X-Gm-Message-State: APt69E0VjXziTBD8grhIR657fR+DpMGK46xf/oGO2UYmQOEE4MhouQAE
        hfKi1zV7IvQItrVhGsHIbf0nzg==
X-Google-Smtp-Source: AAOMgpeAusoSYWa868GmG7sV2JaEUfXlMEQyjJ2SaafckjhA6oQiFgfzHFuOIb6V8YQhNDZugUmw/w==
X-Received: by 2002:a62:1f8c:: with SMTP id l12-v6mr18551793pfj.143.1530570827112;
        Mon, 02 Jul 2018 15:33:47 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p11-v6sm21764132pgu.16.2018.07.02.15.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 15:33:46 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peterz@infradead.org, acme@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        mathieu.poirier@linaro.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] coresight: Use PMU driver configuration for sink selection
Date:   Mon,  2 Jul 2018 16:33:30 -0600
Message-Id: <1530570810-28929-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the PMU driver configuration API to select a sink
for each event that is created (the old sysFS way of working is kept
around for backward compatibility).

By proceeding in this way a sink can be used by multiple sessions
without having to play games with entries in sysFS.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 128 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |  10 ++
 2 files changed, 126 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 0f5e03e4df22..37c8b97d0449 100644
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
@@ -81,10 +84,29 @@ static int etm_addr_filters_alloc(struct perf_event *event)
 	return 0;
 }
 
+static int etm_drv_config_alloc(struct perf_event *event)
+{
+	char *sink;
+	int node = event->cpu == -1 ? -1 : cpu_to_node(event->cpu);
+
+	sink = kzalloc_node(CORESIGHT_DEVICE_MAX_NAME_LEN, GFP_KERNEL, node);
+	if (!sink)
+		return -ENOMEM;
+
+	if (event->parent)
+		memcpy(sink, event->parent->hw.addr_filters,
+		       CORESIGHT_DEVICE_MAX_NAME_LEN);
+
+	event->hw.drv_config = sink;
+
+	return 0;
+}
+
 static void etm_event_destroy(struct perf_event *event)
 {
 	kfree(event->hw.addr_filters);
 	event->hw.addr_filters = NULL;
+	kfree(event->hw.drv_config);
 }
 
 static int etm_event_init(struct perf_event *event)
@@ -100,6 +122,10 @@ static int etm_event_init(struct perf_event *event)
 	if (ret)
 		goto out;
 
+	ret = etm_drv_config_alloc(event);
+	if (ret)
+		goto out;
+
 	event->destroy = etm_event_destroy;
 out:
 	return ret;
@@ -181,6 +207,38 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
+static struct coresight_device *etm_event_get_sink(struct perf_event *event)
+{
+	/*
+	 * Try the preferred method first, i.e passing the sink information
+	 * using the ioctl() method.
+	 */
+	if (event->hw.drv_config) {
+		struct device *dev;
+		struct coresight_device *sink;
+
+		dev = bus_find_device_by_name(&coresight_bustype, NULL,
+					      (char *)event->hw.drv_config);
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
+	return coresight_get_enabled_sink(true);
+}
+
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
@@ -194,18 +252,10 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
+	perf_event_drv_config_sync(event);
+
+	/* First get the sink to use for this event */
+	sink = etm_event_get_sink(event);
 	if (!sink)
 		goto err;
 
@@ -442,6 +492,57 @@ static void etm_addr_filters_sync(struct perf_event *event)
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
+static void etm_drv_config_sync(struct perf_event *event)
+{
+	struct perf_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	memcpy(event->hw.drv_config, drv_config->drv_config,
+	       CORESIGHT_DEVICE_MAX_NAME_LEN);
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
@@ -486,6 +587,9 @@ static int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.drv_config_validate	= etm_drv_config_validate;
+	etm_pmu.drv_config_sync		= etm_drv_config_sync;
+	etm_pmu.drv_config_free		= etm_drv_config_free;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 4197df4faf5e..175895c8d635 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -42,6 +42,16 @@ struct etm_filters {
 	bool			ssstatus;
 };
 
+enum etm_config_elem_type {
+	ETM_CFG_NONE = -1,
+	ETM_CFG_SINK,
+};
+
+struct etm_config_elem {
+	struct list_head		entry;
+	enum etm_config_elem_type	type;
+	void				*config;
+};
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
-- 
2.7.4

