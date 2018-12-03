Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A42E20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0Y2zniI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A42E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeLCWzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:55:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33855 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeLCWzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:55:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so6409937pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vffhfUlrlCExin749UjB4Nm/CBeftT0GbW0095v/Xho=;
        b=g0Y2zniIHZPqzPi34F5QEJl2yeW/0zodTAfxbNORnXJt0S0KVyxJvSv4H1g1CLWEtm
         aROXaan93OC+wAYKmna1xkqior+VTPWlgj/X4hyf3FQiKsvn8NsHb/aTjW9pbXMU9nrX
         qPPwBX1Dx2qyas9w4R2jmHOAfQQA5z5UJnTQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vffhfUlrlCExin749UjB4Nm/CBeftT0GbW0095v/Xho=;
        b=il5RM6R+rlpAxbbO5qG3MXo05V5TseFF/RAE6zppffmdYXw7CqL6bAIMflwuKdbMlY
         kaYP6t7Qs7a0OG0bmIZRCqj5PGX6H+X72lidC5cRB7kMaVb3Z+H59LnQ6w1oCOAkl6LZ
         ODBNJhJG3iTsm2mU9VXfUqzLCXGqirnj5MQ+9Z2LFEi68F1ONrl62Fksz1hGBtTbwwLW
         QwXiS5ZmJH1FpqD0GsUj6QkdTUmZZKd5CLwuyiSVbRkshjbWdvPwfjRGZuhdRA2wBYPz
         ZYD2HD0LQqt1YygxH390UMDeqNY/9X2DCHjDfvoQBuGR/x51VYVi4nJO3T+M1C04Qdkn
         /GJQ==
X-Gm-Message-State: AA+aEWYRlNusXaENXOxJZ42G2e/bIvHay9GPI3iq3tvNU5BWMFFMvSEm
        wmmd3Pf1YyWldyf3zBnvD88sSg==
X-Google-Smtp-Source: AFSGD/WXjj84V5bsTkqdXGWIIhi0mIIVNlIc3VCFLbUOfb3zvj34cd+Ccm5uTI67MvRwm3S9IqExAw==
X-Received: by 2002:a63:e156:: with SMTP id h22mr13684257pgk.255.1543877705853;
        Mon, 03 Dec 2018 14:55:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v9sm20933057pfg.144.2018.12.03.14.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 14:55:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/6] coresight: Use PMU driver configuration for sink selection
Date:   Mon,  3 Dec 2018 15:54:54 -0700
Message-Id: <1543877696-17174-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
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

