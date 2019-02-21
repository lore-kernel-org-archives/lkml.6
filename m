Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04520836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NV1MchX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfBUKTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:19:02 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11581 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfBUKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:19:00 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6e7b100001>; Thu, 21 Feb 2019 02:18:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 02:18:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 Feb 2019 02:18:58 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:18:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:18:57 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6e7b0f000a>; Thu, 21 Feb 2019 02:18:57 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 02/12] thermal: tegra: support hw and sw shutdown
Date:   Thu, 21 Feb 2019 18:18:37 +0800
Message-ID: <1550744327-4677-3-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550744336; bh=UFbw5w6tmbAGlMzmAzjYd7LNldPDbfalgtfrmvmvW50=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=NV1MchX6ji6+/KPGuvjoW53lFfid+vvoCSA4tf/F1+rCk9xWxOuPrABbvwHqBWa43
         f+vkqNTg9xtM8YddJTckesYbSaC5Lgoc10XVi2cs/bBldJmDPAj3LUn8o+r3WfyHBh
         YtjS358Z2xqSxUNeN0oYNa8mGpCahPgm01pbrOWEsnReaGqDWZYsIYc9M1cR6GfLmE
         IV1ZV/kedAnz9g8n2R7MYKOAGJjygukJdt/Gpc5YVv3hGwKqC0O17Ku2gmq5aGp2ty
         nmKsqJuanFAG8TX3igyROuZkTDjh99+NuPqJc/lFMkWBg8vd/qmmr83a7k+D5gTLlJ
         UI4ZYzPaju3Fg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the critical trip points in thermal framework are the only
way to specify a temperature at which HW should shutdown. This is
insufficient for certain platforms which would want an orderly
software shutdown in addition to HW shutdown.

This change support to parse "nvidia, thermtrips" property,
it allows soctherm DT to specify thermtrip temperatures so that
critical trip points framework can be used for doing software
shutdown.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c          | 99 ++++++++++++++++++++++++++-----
 drivers/thermal/tegra/soctherm.h          |  6 ++
 drivers/thermal/tegra/tegra210-soctherm.c |  8 +++
 3 files changed, 98 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 45b41b885f49..4bb6c097c028 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -446,6 +446,24 @@ find_throttle_cfg_by_name(struct tegra_soctherm *ts, const char *name)
 	return NULL;
 }
 
+static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
+{
+	int i, temp = min_low_temp;
+	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
+
+	if (id >= TEGRA124_SOCTHERM_SENSOR_NUM)
+		return temp;
+
+	if (tt) {
+		for (i = 0; i < ts->soc->num_ttgs; i++) {
+			if (tt[i].id == id)
+				return tt[i].temp;
+		}
+	}
+
+	return temp;
+}
+
 static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 {
 	struct tegra_thermctl_zone *zone = data;
@@ -464,7 +482,16 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 		return ret;
 
 	if (type == THERMAL_TRIP_CRITICAL) {
-		return thermtrip_program(dev, sg, temp);
+		/*
+		 * If thermtrips property is set in DT,
+		 * doesn't need to program critical type trip to HW,
+		 * if not, program critical trip to HW.
+		 */
+		if (min_low_temp == tsensor_group_thermtrip_get(ts, sg->id))
+			return thermtrip_program(dev, sg, temp);
+		else
+			return 0;
+
 	} else if (type == THERMAL_TRIP_HOT) {
 		int i;
 
@@ -523,7 +550,8 @@ static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
  * @dev: struct device * of the SOC_THERM instance
  *
  * Configure the SOC_THERM HW trip points, setting "THERMTRIP"
- * "THROTTLE" trip points , using "critical" or "hot" type trip_temp
+ * "THROTTLE" trip points , using "thermtrips", "critical" or "hot"
+ * type trip_temp
  * from thermal zone.
  * After they have been configured, THERMTRIP or THROTTLE will take
  * action when the configured SoC thermal sensor group reaches a
@@ -545,28 +573,23 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 {
 	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	struct soctherm_throt_cfg *stc;
-	int i, trip, temperature;
-	int ret;
+	int i, trip, temperature, ret;
 
-	ret = tz->ops->get_crit_temp(tz, &temperature);
-	if (ret) {
-		dev_warn(dev, "thermtrip: %s: missing critical temperature\n",
-			 sg->name);
-		goto set_throttle;
-	}
+	/* Get thermtrips. If missing, try to get critical trips. */
+	temperature = tsensor_group_thermtrip_get(ts, sg->id);
+	if (min_low_temp == temperature)
+		if (tz->ops->get_crit_temp(tz, &temperature))
+			temperature = max_high_temp;
 
 	ret = thermtrip_program(dev, sg, temperature);
 	if (ret) {
-		dev_err(dev, "thermtrip: %s: error during enable\n",
-			sg->name);
+		dev_err(dev, "thermtrip: %s: error during enable\n", sg->name);
 		return ret;
 	}
 
-	dev_info(dev,
-		 "thermtrip: will shut down when %s reaches %d mC\n",
+	dev_info(dev, "thermtrip: will shut down when %s reaches %d mC\n",
 		 sg->name, temperature);
 
-set_throttle:
 	ret = get_hot_temp(tz, &trip, &temperature);
 	if (ret) {
 		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
@@ -897,6 +920,50 @@ static const struct thermal_cooling_device_ops throt_cooling_ops = {
 	.set_cur_state = throt_set_cdev_state,
 };
 
+static int soctherm_thermtrips_parse(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
+	const int max_num_prop = ts->soc->num_ttgs * 2;
+	u32 *tlb;
+	int i, j, n, ret;
+
+	if (!tt)
+		return -ENOMEM;
+
+	n = of_property_count_u32_elems(dev->of_node, "nvidia,thermtrips");
+	if (n <= 0) {
+		dev_info(dev,
+			 "missing thermtrips, will use critical trips as shut down temp\n");
+		return n;
+	}
+
+	n = min(max_num_prop, n);
+
+	tlb = devm_kcalloc(&pdev->dev, max_num_prop, sizeof(u32), GFP_KERNEL);
+	if (!tlb)
+		return -ENOMEM;
+	ret = of_property_read_u32_array(dev->of_node, "nvidia,thermtrips",
+					 tlb, n);
+	if (ret) {
+		dev_err(dev, "invalid num ele: thermtrips:%d\n", ret);
+		return ret;
+	}
+
+	i = 0;
+	for (j = 0; j < n; j = j + 2) {
+		if (tlb[j] >= TEGRA124_SOCTHERM_SENSOR_NUM)
+			continue;
+
+		tt[i].id = tlb[j];
+		tt[i].temp = tlb[j+1];
+		i++;
+	}
+
+	return 0;
+}
+
 /**
  * soctherm_init_hw_throt_cdev() - Parse the HW throttle configurations
  * and register them as cooling devices.
@@ -1338,6 +1405,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	soctherm_thermtrips_parse(pdev);
+
 	soctherm_init_hw_throt_cdev(pdev);
 
 	soctherm_init(pdev);
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index e96ca73fd780..c05c7e37e968 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -92,6 +92,11 @@ struct tegra_tsensor {
 	const struct tegra_tsensor_group *group;
 };
 
+struct tsensor_group_thermtrips {
+	u8 id;
+	u32 temp;
+};
+
 struct tegra_soctherm_fuse {
 	u32 fuse_base_cp_mask, fuse_base_cp_shift;
 	u32 fuse_base_ft_mask, fuse_base_ft_shift;
@@ -113,6 +118,7 @@ struct tegra_soctherm_soc {
 	const int thresh_grain;
 	const unsigned int bptt;
 	const bool use_ccroc;
+	struct tsensor_group_thermtrips *thermtrips;
 };
 
 int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index ad53169a8e95..0a0c3cec7134 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -203,6 +203,13 @@ static const struct tegra_soctherm_fuse tegra210_soctherm_fuse = {
 	.fuse_spare_realignment = 0,
 };
 
+struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] = {
+	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
+	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
+	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
+	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
+};
+
 const struct tegra_soctherm_soc tegra210_soctherm = {
 	.tsensors = tegra210_tsensors,
 	.num_tsensors = ARRAY_SIZE(tegra210_tsensors),
@@ -212,4 +219,5 @@ const struct tegra_soctherm_soc tegra210_soctherm = {
 	.thresh_grain = TEGRA210_THRESH_GRAIN,
 	.bptt = TEGRA210_BPTT,
 	.use_ccroc = false,
+	.thermtrips = tegra210_tsensor_thermtrips,
 };
-- 
2.7.4

