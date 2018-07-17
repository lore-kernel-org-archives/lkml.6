Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0DCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755B520850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1Z7HzqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755B520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeGQLao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:30:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42571 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeGQLao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:30:44 -0400
Received: by mail-pl0-f68.google.com with SMTP id f4-v6so299616plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y4rtkJd0kMW7LZyFUKzdA6ryx8QRXaRJLzwHOZDW0uc=;
        b=D1Z7HzqTD0LvDXwwwcQDzmnIX37+JPpX4l07WjvgsJtBFAnUYMEO4u+o5oYUxLzG2w
         hRIRkCbnfGsUnaz1/DjRWHNv3W8J0IbxfePM82JpUB8jhDPSWvJZUHboLXDG1uJC+dGT
         13NIitLuwGbBL6Een6a8cgepvCxt54vgve8m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y4rtkJd0kMW7LZyFUKzdA6ryx8QRXaRJLzwHOZDW0uc=;
        b=OsrwlvYEPz/+671IoKDYyZCLw35t7XyARQlyxzkAXqZXbokC0wMTuWHCEVUXFocxM2
         2QNX78E5MuhwcJ23os2BQ5WkhIiBxGNfRkxbg6VA51tOsMrN00Qirao5Paxe2wJyuQ3S
         oYBiwCpctIdiXN8qEsxX2HFyPZYjnviuOn1mXBHKLlmpPEcsWtqKFH4by2z7Ez5xJi7I
         YloyuNP0Qnp3c0xz7p2gHCLCNK0APgO05EAK228S4WbT+8NWBL8JJlS3RQTZMUzr9KMQ
         IQnMh5olgcjQ5+xCYV4VUUddpZBufhmkD2Z328kQ68trOY01jmfA2D8K7Ujt+naXDIPR
         EdGw==
X-Gm-Message-State: AOUpUlG7Su0f0jyUsuRw/eF88fmojl59LFo1USjRyE6ddJlYsACT3Kou
        ddMU0zQGAjPovAx3v+wl8s1L2g==
X-Google-Smtp-Source: AAOMgpfnr662Tp1M+RvS2G65WggB8SZ0AK4exoX3egYbOmRCflDhEwge6AJDeivMNEuWZtyocNb5/w==
X-Received: by 2002:a17:902:9883:: with SMTP id s3-v6mr1162407plp.194.1531825120337;
        Tue, 17 Jul 2018 03:58:40 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id y13-v6sm2128582pfi.131.2018.07.17.03.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 03:58:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: thermal: Allow multiple devices to share cooling map
Date:   Tue, 17 Jul 2018 16:24:16 +0530
Message-Id: <b5555967e713fd601bc74de0cab8ab45608399c4.1531824436.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A cooling map entry may now contain a list of phandles and their
arguments representing multiple devices which share the trip point.

This patch updates the thermal OF core to parse them properly.

Tested on Hikey960.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This is a follow up patch to the DT bindings patchset:

https://lkml.kernel.org/r/cover.1530766981.git.viresh.kumar@linaro.org

 drivers/thermal/of-thermal.c | 140 +++++++++++++++++++++++++----------
 1 file changed, 102 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 977a8307fbb1..79c06c4c861b 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -19,22 +19,33 @@
 /***   Private data structures to represent thermal device tree data ***/
 
 /**
- * struct __thermal_bind_param - a match between trip and cooling device
+ * struct __thermal_cooling_bind_param - a cooling device for a trip point
  * @cooling_device: a pointer to identify the referred cooling device
- * @trip_id: the trip point index
- * @usage: the percentage (from 0 to 100) of cooling contribution
  * @min: minimum cooling state used at this trip point
  * @max: maximum cooling state used at this trip point
  */
 
-struct __thermal_bind_params {
+struct __thermal_cooling_bind_param {
 	struct device_node *cooling_device;
-	unsigned int trip_id;
-	unsigned int usage;
 	unsigned long min;
 	unsigned long max;
 };
 
+/**
+ * struct __thermal_bind_param - a match between trip and cooling device
+ * @tcbp: a pointer to an array of cooling devices
+ * @count: number of elements in array
+ * @trip_id: the trip point index
+ * @usage: the percentage (from 0 to 100) of cooling contribution
+ */
+
+struct __thermal_bind_params {
+	struct __thermal_cooling_bind_param *tcbp;
+	unsigned int count;
+	unsigned int trip_id;
+	unsigned int usage;
+};
+
 /**
  * struct __thermal_zone - internal representation of a thermal zone
  * @mode: current thermal zone device mode (enabled/disabled)
@@ -192,25 +203,31 @@ static int of_thermal_bind(struct thermal_zone_device *thermal,
 			   struct thermal_cooling_device *cdev)
 {
 	struct __thermal_zone *data = thermal->devdata;
-	int i;
+	struct __thermal_bind_params *tbp;
+	struct __thermal_cooling_bind_param *tcbp;
+	int i, j;
 
 	if (!data || IS_ERR(data))
 		return -ENODEV;
 
 	/* find where to bind */
 	for (i = 0; i < data->num_tbps; i++) {
-		struct __thermal_bind_params *tbp = data->tbps + i;
+		tbp = data->tbps + i;
 
-		if (tbp->cooling_device == cdev->np) {
-			int ret;
+		for (j = 0; j < tbp->count; j++) {
+			tcbp = tbp->tcbp + j;
 
-			ret = thermal_zone_bind_cooling_device(thermal,
+			if (tcbp->cooling_device == cdev->np) {
+				int ret;
+
+				ret = thermal_zone_bind_cooling_device(thermal,
 						tbp->trip_id, cdev,
-						tbp->max,
-						tbp->min,
+						tcbp->max,
+						tcbp->min,
 						tbp->usage);
-			if (ret)
-				return ret;
+				if (ret)
+					return ret;
+			}
 		}
 	}
 
@@ -221,22 +238,28 @@ static int of_thermal_unbind(struct thermal_zone_device *thermal,
 			     struct thermal_cooling_device *cdev)
 {
 	struct __thermal_zone *data = thermal->devdata;
-	int i;
+	struct __thermal_bind_params *tbp;
+	struct __thermal_cooling_bind_param *tcbp;
+	int i, j;
 
 	if (!data || IS_ERR(data))
 		return -ENODEV;
 
 	/* find where to unbind */
 	for (i = 0; i < data->num_tbps; i++) {
-		struct __thermal_bind_params *tbp = data->tbps + i;
+		tbp = data->tbps + i;
+
+		for (j = 0; j < tbp->count; j++) {
+			tcbp = tbp->tcbp + j;
 
-		if (tbp->cooling_device == cdev->np) {
-			int ret;
+			if (tcbp->cooling_device == cdev->np) {
+				int ret;
 
-			ret = thermal_zone_unbind_cooling_device(thermal,
-						tbp->trip_id, cdev);
-			if (ret)
-				return ret;
+				ret = thermal_zone_unbind_cooling_device(thermal,
+							tbp->trip_id, cdev);
+				if (ret)
+					return ret;
+			}
 		}
 	}
 
@@ -652,8 +675,9 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 					   int ntrips)
 {
 	struct of_phandle_args cooling_spec;
+	struct __thermal_cooling_bind_param *__tcbp;
 	struct device_node *trip;
-	int ret, i;
+	int ret, i, count;
 	u32 prop;
 
 	/* Default weight. Usage is optional */
@@ -680,20 +704,44 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 		goto end;
 	}
 
-	ret = of_parse_phandle_with_args(np, "cooling-device", "#cooling-cells",
-					 0, &cooling_spec);
-	if (ret < 0) {
+	count = of_count_phandle_with_args(np, "cooling-device",
+					   "#cooling-cells");
+	if (!count) {
 		pr_err("missing cooling_device property\n");
 		goto end;
 	}
-	__tbp->cooling_device = cooling_spec.np;
-	if (cooling_spec.args_count >= 2) { /* at least min and max */
-		__tbp->min = cooling_spec.args[0];
-		__tbp->max = cooling_spec.args[1];
-	} else {
-		pr_err("wrong reference to cooling device, missing limits\n");
+
+	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
+	if (!__tcbp)
+		goto end;
+
+	for (i = 0; i < count; i++) {
+		ret = of_parse_phandle_with_args(np, "cooling-device",
+				"#cooling-cells", i, &cooling_spec);
+		if (ret < 0) {
+			pr_err("missing cooling_device property\n");
+			goto free_tcbp;
+		}
+
+		__tcbp[i].cooling_device = cooling_spec.np;
+
+		if (cooling_spec.args_count >= 2) { /* at least min and max */
+			__tcbp[i].min = cooling_spec.args[0];
+			__tcbp[i].max = cooling_spec.args[1];
+		} else {
+			pr_err("wrong reference to cooling device, missing limits\n");
+		}
 	}
 
+	__tbp->tcbp= __tcbp;
+	__tbp->count = count;
+
+	goto end;
+
+free_tcbp:
+	for (i = i - 1; i >= 0; i--)
+		of_node_put(__tcbp[i].cooling_device);
+	kfree(__tcbp);
 end:
 	of_node_put(trip);
 
@@ -900,8 +948,16 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	return tz;
 
 free_tbps:
-	for (i = i - 1; i >= 0; i--)
-		of_node_put(tz->tbps[i].cooling_device);
+	for (i = i - 1; i >= 0; i--) {
+		struct __thermal_bind_params *tbp = tz->tbps + i;
+		int j;
+
+		for (j = 0; j < tbp->count; j++)
+			of_node_put(tbp->tcbp[j].cooling_device);
+
+		kfree(tbp->tcbp);
+	}
+
 	kfree(tz->tbps);
 free_trips:
 	for (i = 0; i < tz->ntrips; i++)
@@ -917,10 +973,18 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 static inline void of_thermal_free_zone(struct __thermal_zone *tz)
 {
-	int i;
+	struct __thermal_bind_params *tbp;
+	int i, j;
+
+	for (i = 0; i < tz->num_tbps; i++) {
+		tbp = tz->tbps + i;
+
+		for (j = 0; j < tbp->count; j++)
+			of_node_put(tbp->tcbp[j].cooling_device);
+
+		kfree(tbp->tcbp);
+	}
 
-	for (i = 0; i < tz->num_tbps; i++)
-		of_node_put(tz->tbps[i].cooling_device);
 	kfree(tz->tbps);
 	for (i = 0; i < tz->ntrips; i++)
 		of_node_put(tz->trips[i].np);
-- 
2.18.0.rc1.242.g61856ae69a2c

