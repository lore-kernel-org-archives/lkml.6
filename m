Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61768C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF1720832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8hfGFdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF1720832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeK2JEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:04:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34393 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeK2JEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:04:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so10109716pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xnEBPlZvLoiwiqqm9S9JUInQL+RU7pyQ/G1YI/wchKg=;
        b=S8hfGFdHktHmbFUcmAAAToL1GHM1166VP0cPbnSTtGAShRAN8OGq7+DzzlKUPc1kwm
         q9tTlNGl+LwEQxzx0YOB8iSxeNATA+URaq8VoYLMLfwpyHTC4jdI4KnTuEVdJ+ZjLypr
         DaZFMb38dcGUgHztaRy4p8mUcekTLvtnA3v0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xnEBPlZvLoiwiqqm9S9JUInQL+RU7pyQ/G1YI/wchKg=;
        b=oXc2Zmna+s4TAuRjsyhwuNUL8vGxQOySWnBUhO/kYgxRBnCt/K9J6YmW/ScPsCSQ6J
         hcgqldaPcWHijPG3UlNxB1zbF88CtPl9AjshrxpDtIiVJyJ/AkgZ/1HzezWWIZGxHFlo
         VY6EYn8QJEhg0VF8PeVuGrrKdzERuDDAzJ++dQv187378wTlt1zSVFOZJUcucn0ELn+z
         c4bqBU5JdMUHVv1LOG3K+Z7db+qs+RZmVJyPvHeEuecObMvo2JoZ7trOWzfFgtBgVtms
         0LZdN3w6DNCR7LuaBY2oknFyR+QTR18fhzGNJw5iED+A790yYvfKkCREoCV6cGeDQyI/
         Hgjw==
X-Gm-Message-State: AGRZ1gInzalu48WPNDcDa1miFrxEO0q+euNxGTdvK6ZsnHkwDZ+GrOoU
        pnVRmP2+9g2En+gMXKjd13ssMQ==
X-Google-Smtp-Source: AFSGD/VTqOtldnj9pe2KJoP34Vc0OFhJx1V7S4OgdE7ZM1hQW814zi1v+8XgzQumlJn7+9spqWHTEg==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr34369774pga.202.1543442487192;
        Wed, 28 Nov 2018 14:01:27 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 12sm8698051pgd.35.2018.11.28.14.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:01:26 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink selection
Date:   Wed, 28 Nov 2018 15:01:16 -0700
Message-Id: <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
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
 drivers/hwtracing/coresight/coresight-etm-perf.c | 58 +++++++++++++++++++-----
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f21eb28b6782..0fbff912d515 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -14,6 +14,7 @@
 #include <linux/perf_event.h>
 #include <linux/percpu-defs.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -177,6 +178,26 @@ static void etm_free_aux(void *data)
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
@@ -190,18 +211,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
 
@@ -454,6 +468,25 @@ static void etm_addr_filters_sync(struct perf_event *event)
 	filters->nr_filters = i;
 }
 
+static void *etm_drv_config_validate(struct perf_event *event, char *cstr)
+{
+	char drv_config[NAME_MAX];
+	struct device *dev;
+	struct coresight_device *sink;
+
+	strncpy(drv_config, cstr, NAME_MAX);
+
+	/* Look for the device with that name on the CS bus. */
+	dev = bus_find_device_by_name(&coresight_bustype, NULL, drv_config);
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
@@ -498,6 +531,7 @@ static int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.drv_config_validate	= etm_drv_config_validate;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
-- 
2.7.4

