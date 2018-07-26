Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF4C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBDE2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBDE2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGZOMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:12:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55066 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbeGZOMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:12:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E360E15BE;
        Thu, 26 Jul 2018 05:55:16 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F2743F6A8;
        Thu, 26 Jul 2018 05:55:15 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 11/13] coresight: perf: Add helper to retrieve sink configuration
Date:   Thu, 26 Jul 2018 13:54:49 +0100
Message-Id: <1532609691-16863-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can always find the sink configuration for a given perf_output_handle.
Add a helper to retrieve the sink configuration for a given
perf_output_handle. This will be used to get rid of the set_buffer()
call back.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 14 -------------
 drivers/hwtracing/coresight/coresight-etm-perf.h | 26 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index ad87441..16b83d8 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -23,20 +23,6 @@
 static struct pmu etm_pmu;
 static bool etm_perf_up;
 
-/**
- * struct etm_event_data - Coresight specifics associated to an event
- * @work:		Handle to free allocated memory outside IRQ context.
- * @mask:		Hold the CPU(s) this event was set for.
- * @snk_config:		The sink configuration.
- * @path:		An array of path, each slot for one CPU.
- */
-struct etm_event_data {
-	struct work_struct work;
-	cpumask_t mask;
-	void *snk_config;
-	struct list_head * __percpu *path;
-};
-
 static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 4197df4..da7d933 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -7,6 +7,7 @@
 #ifndef _CORESIGHT_ETM_PERF_H
 #define _CORESIGHT_ETM_PERF_H
 
+#include <linux/percpu-defs.h>
 #include "coresight-priv.h"
 
 struct coresight_device;
@@ -42,14 +43,39 @@ struct etm_filters {
 	bool			ssstatus;
 };
 
+/**
+ * struct etm_event_data - Coresight specifics associated to an event
+ * @work:		Handle to free allocated memory outside IRQ context.
+ * @mask:		Hold the CPU(s) this event was set for.
+ * @snk_config:		The sink configuration.
+ * @path:		An array of path, each slot for one CPU.
+ */
+struct etm_event_data {
+	struct work_struct work;
+	cpumask_t mask;
+	void *snk_config;
+	struct list_head * __percpu *path;
+};
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
+static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
+{
+	struct etm_event_data *data = perf_get_aux(handle);
 
+	if (data)
+		return data->snk_config;
+	return NULL;
+}
 #else
 static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
 { return -EINVAL; }
 
+static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_CORESIGHT */
 
 #endif
-- 
2.7.4

