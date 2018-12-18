Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1EBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8DA214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y5XMRa7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeLRHfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:36 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8332 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeLRHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:29 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a33a0000>; Mon, 17 Dec 2018 23:35:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Dec 2018 23:35:27 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:27 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:26 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:26 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a33c0003>; Mon, 17 Dec 2018 23:35:26 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 08/12] thermal: tegra: add set_trips functionality
Date:   Tue, 18 Dec 2018 15:34:40 +0800
Message-ID: <1545118484-23641-10-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118522; bh=u2OYZNinTQ1fZrpMzhX6dJsjGJrrM6FirRY0bECh3r0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Y5XMRa7JmPG7rO/DzDpTcnHUvWxMpVUeJH9IzLlMY57IM+XwkC9tMK0mNFSkgdz7p
         GL+PMyQlFnEG2KRumqomC9nVYnhrYsXAvhztSCmGNGc6amEe0fZZMs0Cs9QXGJn/2i
         oCgl2wnoKfgwGb7ibyOrzZvLbXn/LZVjnpkMqrOJpXQqjeGV/VyHIK5abxTfOpI5he
         DCKUifXKI0l8O9TvYutzpv2hec+SlDw12+UvASgHj9Hq3qi5N9VuHJTaxPI4BDLsga
         i12zKWCSWIJFBOr7xiZDPuk09DAFNV1Q915TewS+f0i215ofDzYxPFW36LM6LIXX8f
         p/S355Su7jing==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement set_trips ops to set passive trip points.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c          | 64 ++++++++++++++++++++++++++++++-
 drivers/thermal/tegra/soctherm.h          | 10 +++++
 drivers/thermal/tegra/tegra124-soctherm.c |  7 +++-
 drivers/thermal/tegra/tegra132-soctherm.c |  7 +++-
 drivers/thermal/tegra/tegra210-soctherm.c |  7 +++-
 5 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index c66fdd546ef0..eefbb29b3b7d 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -87,8 +87,6 @@
 #define THERMCTL_LVL0_DN_STATS			0x14
 
 #define THERMCTL_INTR_STATUS			0x84
-#define THERMCTL_INTR_ENABLE			0x88
-#define THERMCTL_INTR_DISABLE			0x8c
 
 #define TH_INTR_MD0_MASK			BIT(25)
 #define TH_INTR_MU0_MASK			BIT(24)
@@ -265,6 +263,8 @@ struct tegra_soctherm {
 	struct soctherm_throt_cfg throt_cfgs[THROTTLE_SIZE];
 
 	struct dentry *debugfs_dir;
+
+	struct mutex thermctl_lock;
 };
 
 /**
@@ -542,9 +542,59 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 	return 0;
 }
 
+static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
+{
+	u32 r;
+
+	/* multiple zones could be handling and setting trips at once */
+	mutex_lock(&zn->ts->thermctl_lock);
+	r = readl(zn->ts->regs + THERMCTL_INTR_ENABLE);
+	r = REG_SET_MASK(r, zn->sg->thermctl_isr_mask, TH_INTR_UP_DN_EN);
+	writel(r, zn->ts->regs + THERMCTL_INTR_ENABLE);
+	mutex_unlock(&zn->ts->thermctl_lock);
+}
+
+static void thermal_irq_disable(struct tegra_thermctl_zone *zn)
+{
+	u32 r;
+
+	/* multiple zones could be handling and setting trips at once */
+	mutex_lock(&zn->ts->thermctl_lock);
+	r = readl(zn->ts->regs + THERMCTL_INTR_DISABLE);
+	r = REG_SET_MASK(r, zn->sg->thermctl_isr_mask, 0);
+	writel(r, zn->ts->regs + THERMCTL_INTR_DISABLE);
+	mutex_unlock(&zn->ts->thermctl_lock);
+}
+
+static int tegra_thermctl_set_trips(void *data, int lo, int hi)
+{
+	struct tegra_thermctl_zone *zone = data;
+	u32 r;
+
+	thermal_irq_disable(zone);
+
+	r = readl(zone->ts->regs + zone->sg->thermctl_lvl0_offset);
+	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_EN_MASK, 0);
+	writel(r, zone->ts->regs + zone->sg->thermctl_lvl0_offset);
+
+	lo = enforce_temp_range(zone->dev, lo) / zone->ts->soc->thresh_grain;
+	hi = enforce_temp_range(zone->dev, hi) / zone->ts->soc->thresh_grain;
+	dev_dbg(zone->dev, "%s hi:%d, lo:%d\n", __func__, hi, lo);
+
+	r = REG_SET_MASK(r, zone->sg->thermctl_lvl0_up_thresh_mask, hi);
+	r = REG_SET_MASK(r, zone->sg->thermctl_lvl0_dn_thresh_mask, lo);
+	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_EN_MASK, 1);
+	writel(r, zone->ts->regs + zone->sg->thermctl_lvl0_offset);
+
+	thermal_irq_enable(zone);
+
+	return 0;
+}
+
 static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 	.set_trip_temp = tegra_thermctl_set_trip_temp,
+	.set_trips = tegra_thermctl_set_trips,
 };
 
 static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
@@ -661,6 +711,15 @@ static irqreturn_t soctherm_thermal_isr(int irq, void *dev_id)
 	struct tegra_soctherm *ts = dev_id;
 	u32 r;
 
+	/* Case for no lock:
+	 * Although interrupts are enabled in set_trips, there is still no need
+	 * to lock here because the interrupts are disabled before programming
+	 * new trip points. Hence there cant be a interrupt on the same sensor.
+	 * An interrupt can however occur on a sensor while trips are being
+	 * programmed on a different one. This beign a LEVEL interrupt won't
+	 * cause a new interrupt but this is taken care of by the re-reading of
+	 * the STATUS register in the thread function.
+	 */
 	r = readl(ts->regs + THERMCTL_INTR_STATUS);
 	writel(r, ts->regs + THERMCTL_INTR_DISABLE);
 
@@ -1523,6 +1582,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (!tegra)
 		return -ENOMEM;
 
+	mutex_init(&tegra->thermctl_lock);
 	dev_set_drvdata(&pdev->dev, tegra);
 
 	tegra->soc = soc;
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index c05c7e37e968..70501e73d586 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
  *
@@ -29,6 +30,14 @@
 #define THERMCTL_THERMTRIP_CTL			0x80
 /* BITs are defined in device file */
 
+#define THERMCTL_INTR_ENABLE			0x88
+#define THERMCTL_INTR_DISABLE			0x8c
+#define TH_INTR_UP_DN_EN			0x3
+#define THERM_IRQ_MEM_MASK			(TH_INTR_UP_DN_EN << 24)
+#define THERM_IRQ_GPU_MASK			(TH_INTR_UP_DN_EN << 16)
+#define THERM_IRQ_CPU_MASK			(TH_INTR_UP_DN_EN << 8)
+#define THERM_IRQ_TSENSE_MASK			(TH_INTR_UP_DN_EN << 0)
+
 #define SENSOR_PDIV				0x1c0
 #define SENSOR_PDIV_CPU_MASK			(0xf << 12)
 #define SENSOR_PDIV_GPU_MASK			(0xf << 8)
@@ -70,6 +79,7 @@ struct tegra_tsensor_group {
 	u32 thermtrip_enable_mask;
 	u32 thermtrip_any_en_mask;
 	u32 thermtrip_threshold_mask;
+	u32 thermctl_isr_mask;
 	u16 thermctl_lvl0_offset;
 	u32 thermctl_lvl0_up_thresh_mask;
 	u32 thermctl_lvl0_dn_thresh_mask;
diff --git a/drivers/thermal/tegra/tegra124-soctherm.c b/drivers/thermal/tegra/tegra124-soctherm.c
index 36768630f78c..20ad27f4d1a1 100644
--- a/drivers/thermal/tegra/tegra124-soctherm.c
+++ b/drivers/thermal/tegra/tegra124-soctherm.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -55,6 +56,7 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_cpu = {
 	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA124_THERMTRIP_CPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_CPU_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_CPU_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -73,6 +75,7 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
 	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA124_THERMTRIP_GPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_GPU_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -89,6 +92,7 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
 	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA124_THERMTRIP_TSENSE_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_TSENSE_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_TSENSE_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
 	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -107,6 +111,7 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
 	.thermtrip_any_en_mask = TEGRA124_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA124_THERMTRIP_MEM_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA124_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_MEM_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
 	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
diff --git a/drivers/thermal/tegra/tegra132-soctherm.c b/drivers/thermal/tegra/tegra132-soctherm.c
index 97fa30501eb1..b76308fdad9e 100644
--- a/drivers/thermal/tegra/tegra132-soctherm.c
+++ b/drivers/thermal/tegra/tegra132-soctherm.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -55,6 +56,7 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_cpu = {
 	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA132_THERMTRIP_CPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_CPU_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_CPU_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -73,6 +75,7 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_gpu = {
 	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA132_THERMTRIP_GPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_GPU_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -89,6 +92,7 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_pll = {
 	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA132_THERMTRIP_TSENSE_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_TSENSE_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_TSENSE_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
 	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -107,6 +111,7 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_mem = {
 	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA132_THERMTRIP_MEM_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_MEM_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
 	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index 0a0c3cec7134..d31b50050faa 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -56,6 +57,7 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_cpu = {
 	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA210_THERMTRIP_CPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_CPU_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_CPU_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -74,6 +76,7 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_gpu = {
 	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA210_THERMTRIP_GPU_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_GPU_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -90,6 +93,7 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_pll = {
 	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA210_THERMTRIP_TSENSE_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_TSENSE_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_TSENSE_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
 	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
@@ -108,6 +112,7 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_mem = {
 	.thermtrip_any_en_mask = TEGRA210_THERMTRIP_ANY_EN_MASK,
 	.thermtrip_enable_mask = TEGRA210_THERMTRIP_MEM_EN_MASK,
 	.thermtrip_threshold_mask = TEGRA210_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_MEM_MASK,
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
 	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
-- 
2.7.4

