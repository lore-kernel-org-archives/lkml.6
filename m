Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F6BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF1C217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FI/KdH3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfAVSLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:11:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35428 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAVSLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:11:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so11868133plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w2HxLo0zTdY2xYNYUVAZCND3mlCXe1W0iz7EyzmW3zA=;
        b=FI/KdH3RKgeLXUHbaFZIgCH6VzqCe6b72MaEcYzUU+yXdZ/kD3ay8TojNyezCwIitG
         1v4Z7aLBdjfy2wAdId7EIaxA++MPtdYuUIH3zB5hyIhQYkSrTIzLLQ0DhNyRhBolsfcl
         z0AC6bs6Rkbz6jiqnl248D4O2eSviJUf7PPI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w2HxLo0zTdY2xYNYUVAZCND3mlCXe1W0iz7EyzmW3zA=;
        b=WrQQIC/Qbzxgez03Xbv1HHjVEIW0E6yJp1J6IF1inajdvkosCrtJ9y8gd6Zy7nrC0+
         5Bs2TLpuBoYa76qqSe4TnnttK6viy02C2vAnSzBe/Fy5CAARsawHqfAA3TdbGTR/ZWCz
         USvXgIC4XZr7kiXJaA8pcVdhi3vOhamra4Pt9Yc7jqekqQIEdYpvZ0tiDpTSn1nJHdl3
         rf7ORjPRhNmALcUdjSs+el9fuubTQZhoPvjfOVda028xLWP+UdloO+VyQm7yrpwLt+Cg
         u31AlD3RVASPnNFeov1FuWrGspsaDQ6U+FNIN+fj0GsrnfSNsFw8IdTf33P/lXhlELnR
         E8YQ==
X-Gm-Message-State: AJcUukfZwqDCrxrSORQ3Pm4YEJ5ejjJn4ubid8C1iLBobyd/EKfXwl+h
        vhBnMA92YlGOyDIliguwUS8TSw==
X-Google-Smtp-Source: ALg8bN4ggbRu69VnBu5YDNIjbHtDpky7lakWWZW3cxtTnvc9FM0dJ+MlzUHXBN67l7kT/vqJbrkgCw==
X-Received: by 2002:a17:902:e10a:: with SMTP id cc10mr35698716plb.165.1548180710633;
        Tue, 22 Jan 2019 10:11:50 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:11:50 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Subject: [PATCH v2 2/7] coresight: perf: Add "sinks" group to PMU directory
Date:   Tue, 22 Jan 2019 11:11:39 -0700
Message-Id: <20190122181144.26645-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "sinks" directory entry so that users can see all the sinks
available in the system in a single place.  Individual sink are added
as they are registered with the coresight bus.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 76 +++++++++++++++++++
 .../hwtracing/coresight/coresight-etm-perf.h  |  6 +-
 drivers/hwtracing/coresight/coresight.c       | 18 +++++
 include/linux/coresight.h                     |  7 +-
 4 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f21eb28b6782..c68a0036532c 100644
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
 
@@ -479,6 +490,71 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 	return 0;
 }
 
+static ssize_t etm_perf_sink_name_show(struct device *dev,
+				       struct device_attribute *dattr,
+				       char *buf)
+{
+	/* See function coresight_get_sink_by_id() to know where this is used */
+	u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
+}
+
+int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+{
+	int ret;
+	struct device *pmu_dev = etm_pmu.dev;
+	struct device *pdev = csdev->dev.parent;
+	struct device_attribute *dattr;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return -EINVAL;
+
+	if (csdev->dattr != NULL)
+		return -EINVAL;
+
+	if (!etm_perf_up)
+		return -EPROBE_DEFER;
+
+	dattr = kzalloc(sizeof(*dattr), GFP_KERNEL);
+	dattr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
+	dattr->attr.mode = 0444;
+	dattr->show = etm_perf_sink_name_show;
+	csdev->dattr = dattr;
+
+	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
+				      &dattr->attr, "sinks");
+
+	if (!ret)
+		return 0;
+
+	csdev->dattr = NULL;
+	kfree(dattr->attr.name);
+	kfree(dattr);
+
+	return ret;
+}
+
+void etm_perf_del_symlink_sink(struct coresight_device *csdev)
+{
+	struct device *pmu_dev = etm_pmu.dev;
+	struct device_attribute *dattr = csdev->dattr;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return;
+
+	if (!dattr)
+		return;
+
+	sysfs_remove_file_from_group(&pmu_dev->kobj,
+				     &dattr->attr, "sinks");
+	csdev->dattr = NULL;
+	kfree(dattr->attr.name);
+	kfree(dattr);
+}
+
 static int __init etm_perf_init(void)
 {
 	int ret;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index da7d9336a15c..015213abe00a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -59,6 +59,8 @@ struct etm_event_data {
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
+int etm_perf_add_symlink_sink(struct coresight_device *csdev);
+void etm_perf_del_symlink_sink(struct coresight_device *csdev);
 static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 {
 	struct etm_event_data *data = perf_get_aux(handle);
@@ -70,7 +72,9 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 #else
 static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
 { return -EINVAL; }
-
+int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+{ return -EINVAL; }
+void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
 static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 {
 	return NULL;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 2b0df1a0a8df..d7fa90be6f42 100644
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
+		ret = etm_perf_add_symlink_sink(csdev);
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
@@ -1185,6 +1202,7 @@ EXPORT_SYMBOL_GPL(coresight_register);
 
 void coresight_unregister(struct coresight_device *csdev)
 {
+	etm_perf_del_symlink_sink(csdev);
 	/* Remove references of that device in the topology */
 	coresight_remove_conns(csdev);
 	device_unregister(&csdev->dev);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 46c67a764877..a42fac83eac9 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -154,8 +154,9 @@ struct coresight_connection {
  * @orphan:	true if the component has connections that haven't been linked.
  * @enable:	'true' if component is currently part of an active path.
  * @activated:	'true' only if a _sink_ has been activated.  A sink can be
-		activated but not yet enabled.  Enabling for a _sink_
-		happens when a source has been selected for that it.
+ *		activated but not yet enabled.  Enabling for a _sink_
+ *		appens when a source has been selected for that it.
+ * @dattr:	Device attribute for sink representation under PMU directory.
  */
 struct coresight_device {
 	struct coresight_connection *conns;
@@ -168,7 +169,9 @@ struct coresight_device {
 	atomic_t *refcnt;
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
+	/* sink specific fields */
 	bool activated;	/* true only if a sink is part of a path */
+	struct device_attribute *dattr;
 };
 
 #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
-- 
2.17.1

