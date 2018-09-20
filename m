Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B74AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2901121534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjbVGU+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2901121534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbeIUBDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45627 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbeIUBDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so71196pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6VQi4FU61Vxvp1EwdXAGZbebJQpL3twyYGpw+OSrQg=;
        b=UjbVGU+/i/R5jriobSJ2un+YtD1Bbqf4pqcxRd0ycVSsNOanq3DZQ076VFPFdZ3QB/
         tClcrcCsRn0zLDMNPrzWfXRyVJj74tffpD9Oke4yKBykOczpnUOW/7hNxVIh4/y7g75u
         MDhAe2HUvA1IYUcM0uJZHfZUi0IfmuSKAWy8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o6VQi4FU61Vxvp1EwdXAGZbebJQpL3twyYGpw+OSrQg=;
        b=jJ5O7OAk/3SwZgs/dhXP2wP2jHVJjoYhUuWsO+XmB7P9A9qtrr8GwX5jqem+jb4B9i
         pl2hOPS9hEMWDU4DkRtbEi1yj066Kq85RgUxXCFeUVcZ/q61+zAanTVPfafqJHfypdgo
         HiVxFNtOAtRMBrusyP7LgehYDAIlWSChIWZ00vM61h+sb971pnBHCSmwlSfhWJufYaIX
         15Sd4TncYdB+zkoygCNb/GlOqXeBOljRYLMTfb9tL++tVDpWotTDLZLiFpakLfgZSrQp
         ZEoQhUEknWn5lhULkWmLoqQvGIwrioiDKYML37yZe4OkLLqctiEIk6/cmcaztoA8qsdF
         hKxg==
X-Gm-Message-State: APzg51D4jbckbisE8U2Oaoc8Ms3lTy3YTQnzr8X1xeYg/RwtSD7aXvDa
        PF8sMPCtYY49L+WjDmL0cmEQQQ==
X-Google-Smtp-Source: ANB0VdbfSbLfSf8Q7O2TnXoJ2J9ElkV232IaCIde35BIYioVVma79gBGZeOSprgAOxwzLfgzzanoIQ==
X-Received: by 2002:a63:6d4f:: with SMTP id i76-v6mr37802383pgc.215.1537471132265;
        Thu, 20 Sep 2018 12:18:52 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:51 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 20/44] coresight: perf: Add helper to retrieve sink configuration
Date:   Thu, 20 Sep 2018 13:17:55 -0600
Message-Id: <1537471099-19781-21-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We can always find the sink configuration for a given perf_output_handle.
Add a helper to retrieve the sink configuration for a given
perf_output_handle. This will be used to get rid of the set_buffer()
call back.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 14 -------------
 drivers/hwtracing/coresight/coresight-etm-perf.h | 26 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index ad87441f65d7..16b83d8b2ac2 100644
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
index 4197df4faf5e..da7d9336a15c 100644
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

