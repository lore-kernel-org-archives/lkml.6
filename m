Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82521C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47036214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZNzEzdUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeLRHfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:24 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7754 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeLRHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:22 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a3300000>; Mon, 17 Dec 2018 23:35:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Dec 2018 23:35:20 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:19 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:19 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a3360000>; Mon, 17 Dec 2018 23:35:19 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 05/12] thermal: tegra: add support for gpu hw-throttle
Date:   Tue, 18 Dec 2018 15:34:37 +0800
Message-ID: <1545118484-23641-7-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118512; bh=Qxs6VPYSkw7e1bqFfbSaW12o9f78qSEo3/nEY67lpAY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZNzEzdUF5eM7Xv/fYb7IdmedWTNl1JpeQD1ZrcXoXVJIdRX8rnbiQMgXzk16su05d
         7bhoa5+5IsLs4RvPrwziG51F0vG3AyH7CyY640Xe1eB+CqhUFZvZKzedQJnnxRRI9+
         LKerNeahZmI0BtKoIkbZ5MuEd9j9gOe9Zos/6VWpnqCU0fC43zn02hOWwA2Lu+mmg2
         6zYgPsJiOAw49zBaCUbmg7HmBTuyg/ylMjC2OdsWR1ZQ3Zhz1vwC7981iQNuv9MW2b
         XBkag3uFcD6PE691OX4B5d7NqW4TIGOrAYvOPLF6MX9kuUERuKuNaSkAQF5E/jPLjY
         B3eJgM5rJd+XA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to trigger pulse skippers on the GPU
when a HOT trip point is triggered. The pulse skippers
can be signalled to throttle at low, medium and high
depths\levels.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 118 ++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 673c3ffa9001..d3cef88a3f22 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014 - 2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * Author:
  *	Mikko Perttunen <mperttunen@nvidia.com>
@@ -160,6 +161,15 @@
 /* get dividend from the depth */
 #define THROT_DEPTH_DIVIDEND(depth)	((256 * (100 - (depth)) / 100) - 1)
 
+/* gk20a nv_therm interface N:3 Mapping. Levels defined in tegra124-sochterm.h
+ * level	vector
+ * NONE		3'b000
+ * LOW		3'b001
+ * MED		3'b011
+ * HIGH		3'b111
+ */
+#define THROT_LEVEL_TO_DEPTH(level)	((0x1 << (level)) - 1)
+
 /* get THROT_PSKIP_xxx offset per LIGHT/HEAVY throt and CPU/GPU dev */
 #define THROT_OFFSET			0x30
 #define THROT_PSKIP_CTRL(throt, dev)	(THROT_PSKIP_CTRL_LITE_CPU + \
@@ -219,6 +229,7 @@ struct soctherm_throt_cfg {
 	u8 priority;
 	u8 cpu_throt_level;
 	u32 cpu_throt_depth;
+	u32 gpu_throt_level;
 	struct thermal_cooling_device *cdev;
 	bool init;
 };
@@ -974,6 +985,50 @@ static int soctherm_thermtrips_parse(struct platform_device *pdev)
 	return 0;
 }
 
+static int soctherm_throt_cfg_parse(struct device *dev,
+				    struct device_node *np,
+				    struct soctherm_throt_cfg *stc)
+{
+	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	int ret;
+	u32 val;
+
+	ret = of_property_read_u32(np, "nvidia,priority", &val);
+	if (ret) {
+		dev_err(dev, "throttle-cfg: %s: invalid priority\n", stc->name);
+		return -EINVAL;
+	}
+	stc->priority = val;
+
+	ret = of_property_read_u32(np, ts->soc->use_ccroc ?
+				   "nvidia,cpu-throt-level" :
+				   "nvidia,cpu-throt-percent", &val);
+	if (!ret) {
+		if (ts->soc->use_ccroc &&
+		    val <= TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
+			stc->cpu_throt_level = val;
+		else if (!ts->soc->use_ccroc && val <= 100)
+			stc->cpu_throt_depth = val;
+		else
+			goto err;
+	} else {
+		goto err;
+	}
+
+	ret = of_property_read_u32(np, "nvidia,gpu-throt-level", &val);
+	if (!ret && val <= TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
+		stc->gpu_throt_level = val;
+	else
+		goto err;
+
+	return 0;
+
+err:
+	dev_err(dev, "throttle-cfg: %s: no throt prop or invalid prop\n",
+		stc->name);
+	return -EINVAL;
+}
+
 /**
  * soctherm_init_hw_throt_cdev() - Parse the HW throttle configurations
  * and register them as cooling devices.
@@ -984,8 +1039,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	struct device_node *np_stc, *np_stcc;
 	const char *name;
-	u32 val;
-	int i, r;
+	int i;
 
 	for (i = 0; i < THROTTLE_SIZE; i++) {
 		ts->throt_cfgs[i].name = throt_names[i];
@@ -1003,6 +1057,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 	for_each_child_of_node(np_stc, np_stcc) {
 		struct soctherm_throt_cfg *stc;
 		struct thermal_cooling_device *tcd;
+		int err;
 
 		name = np_stcc->name;
 		stc = find_throttle_cfg_by_name(ts, name);
@@ -1012,37 +1067,10 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			continue;
 		}
 
-		r = of_property_read_u32(np_stcc, "nvidia,priority", &val);
-		if (r) {
-			dev_info(dev,
-				 "throttle-cfg: %s: missing priority\n", name);
+
+		err = soctherm_throt_cfg_parse(dev, np_stcc, stc);
+		if (err)
 			continue;
-		}
-		stc->priority = val;
-
-		if (ts->soc->use_ccroc) {
-			r = of_property_read_u32(np_stcc,
-						 "nvidia,cpu-throt-level",
-						 &val);
-			if (r) {
-				dev_info(dev,
-					 "throttle-cfg: %s: missing cpu-throt-level\n",
-					 name);
-				continue;
-			}
-			stc->cpu_throt_level = val;
-		} else {
-			r = of_property_read_u32(np_stcc,
-						 "nvidia,cpu-throt-percent",
-						 &val);
-			if (r) {
-				dev_info(dev,
-					 "throttle-cfg: %s: missing cpu-throt-percent\n",
-					 name);
-				continue;
-			}
-			stc->cpu_throt_depth = val;
-		}
 
 		tcd = thermal_of_cooling_device_register(np_stcc,
 							 (char *)name, ts,
@@ -1186,6 +1214,28 @@ static void throttlectl_cpu_mn(struct tegra_soctherm *ts,
 }
 
 /**
+ * throttlectl_gpu_level_select() - selects throttling level for GPU
+ * @throt: the LIGHT/HEAVY of throttle event id
+ *
+ * This function programs soctherm's interface to GK20a NV_THERM to select
+ * pre-configured "Low", "Medium" or "Heavy" throttle levels.
+ *
+ * Return: boolean true if HW was programmed
+ */
+static void throttlectl_gpu_level_select(struct tegra_soctherm *ts,
+					 enum soctherm_throttle_id throt)
+{
+	u32 r, level, throt_vect;
+
+	level = ts->throt_cfgs[throt].gpu_throt_level;
+	throt_vect = THROT_LEVEL_TO_DEPTH(level);
+	r = readl(ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_GPU));
+	r = REG_SET_MASK(r, THROT_PSKIP_CTRL_ENABLE_MASK, 1);
+	r = REG_SET_MASK(r, THROT_PSKIP_CTRL_VECT_GPU_MASK, throt_vect);
+	writel(r, ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_GPU));
+}
+
+/**
  * soctherm_throttle_program() - programs pulse skippers' configuration
  * @throt: the LIGHT/HEAVY of the throttle event id.
  *
@@ -1207,6 +1257,8 @@ static void soctherm_throttle_program(struct tegra_soctherm *ts,
 	else
 		throttlectl_cpu_mn(ts, throt);
 
+	throttlectl_gpu_level_select(ts, throt);
+
 	r = REG_SET_MASK(0, THROT_PRIORITY_LITE_PRIO_MASK, stc.priority);
 	writel(r, ts->regs + THROT_PRIORITY_CTRL(throt));
 
-- 
2.7.4

