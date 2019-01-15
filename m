Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C746CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA3A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b84Jmktb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391385AbfAOXIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:08:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44025 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387748AbfAOXHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:07:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so1989144plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XDWNDjej1vaQghEKuWRObLfufBBUVnZJNWEVf/9UfwU=;
        b=b84JmktbH4LgEz2UKivbHhzC09x3UMXzJaMj8si6l+upZCirCs1QoNgBzprVBbDy9w
         FBzU4OKP2qSRSptbvbFV2QWDV8g/43fxihmkXRshEECSB0uW5kShD9zVMOAupagb+fO0
         6GZki9k1wHHPDcr8WnLZ05pU620ghVn4IrqLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XDWNDjej1vaQghEKuWRObLfufBBUVnZJNWEVf/9UfwU=;
        b=cnjTvaq7D/0yj5zFe5HM+udZSIRrMr0yGeZerfQgL1eixlxOdNwEdwxq9ug7mLTd9y
         wUY7kWuDrg8JFTp2ArvxKmD2hE2XAN4aQIOwiwihXUop64cPhwqtjM3J2Vdtg8SxFiko
         nXKiKoz/HFq7DivSCTuHHiBxqAIzqLenmjjbhJPVac5rrls/WdHh4Md4VzEFQncmBrAb
         cUysK6NAc5+0PW7yfsQUqEX90LGLqldQ7z6zhInaJDgj3MbTwf22COngfVMBtgHgUnDK
         D3iSaCMQS9jWsJHP569C0H0cnMcuHiOqyyWf7zj5aFPPQof/zJHWCo8uxu7AAGINreTD
         7Ogg==
X-Gm-Message-State: AJcUukeGT3LWODMEwLjs8IHhL0Ng60tO07k8h8sjyV23jziTjhuKV4er
        k3cA7oXw5KNqX/d487yHt268FA==
X-Google-Smtp-Source: ALg8bN5+djzWfwdKN+1jr2ma77gjFXRvNidqYQRQLiVLUdyF0vHH/cEgLfKuCL/zbwxyDXXNiZ+QbA==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr6690582plk.282.1547593669668;
        Tue, 15 Jan 2019 15:07:49 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:07:48 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulose@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
Date:   Tue, 15 Jan 2019 16:07:37 -0700
Message-Id: <20190115230742.13730-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230742.13730-1-mathieu.poirier@linaro.org>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "sinks" directory entry so that users can see all the sinks
available in the system in a single place.  Individual sink are added
as they are registered with the coresight bus.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
 .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
 drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f21eb28b6782..292bd409a68c 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -14,6 +14,7 @@
 #include <linux/perf_event.h>
 #include <linux/percpu-defs.h>
 #include <linux/slab.h>
+#include <linux/stringhash.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
 	.attrs  = etm_config_formats_attr,
 };
 
+static struct attribute *etm_config_sinks_attr[] = {
+	NULL,
+};
+
+static const struct attribute_group etm_pmu_sinks_group = {
+	.name   = "sinks",
+	.attrs  = etm_config_sinks_attr,
+};
+
 static const struct attribute_group *etm_pmu_attr_groups[] = {
 	&etm_pmu_format_group,
+	&etm_pmu_sinks_group,
 	NULL,
 };
 
@@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 	return 0;
 }
 
+static ssize_t etm_perf_sink_name_show(struct device *dev,
+				       struct device_attribute *dattr,
+				       char *buf)
+{
+	/* See function coresight_sink_by_id() to know where this is used */
+	u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
+}
+
+int etm_perf_symlink_sink(struct coresight_device *csdev)
+{
+	struct device *pmu_dev = etm_pmu.dev;
+	struct device *pdev = csdev->dev.parent;
+	struct device_attribute *dev_attr;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return -EINVAL;
+
+	if (!etm_perf_up)
+		return -EPROBE_DEFER;
+
+	dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
+	dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
+	dev_attr->attr.mode = 0444;
+	dev_attr->show = etm_perf_sink_name_show;
+
+	return sysfs_add_file_to_group(&pmu_dev->kobj,
+				       &dev_attr->attr, "sinks");
+}
+
 static int __init etm_perf_init(void)
 {
 	int ret;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index da7d9336a15c..529a47285c0f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -59,6 +59,7 @@ struct etm_event_data {
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
+int etm_perf_symlink_sink(struct coresight_device *csdev);
 static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 {
 	struct etm_event_data *data = perf_get_aux(handle);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 2b0df1a0a8df..526f122a38ee 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 
+#include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 
 static DEFINE_MUTEX(coresight_mutex);
@@ -1167,6 +1168,22 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		goto err_out;
 	}
 
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		ret = etm_perf_symlink_sink(csdev);
+
+		if (ret) {
+			device_unregister(&csdev->dev);
+			/*
+			 * As with the above, all resources are free'd
+			 * explicitly via coresight_device_release() triggered
+			 * from put_device(), which is in turn called from
+			 * function device_unregister().
+			 */
+			goto err_out;
+		}
+	}
+
 	mutex_lock(&coresight_mutex);
 
 	coresight_fixup_device_conns(csdev);
-- 
2.17.1

