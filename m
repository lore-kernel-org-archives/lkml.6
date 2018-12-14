Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D360C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2497A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GRdAji/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2497A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeLNJuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:50:10 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16072 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbeLNJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:50:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c137ccb0000>; Fri, 14 Dec 2018 01:50:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Dec 2018 01:50:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Dec 2018 01:50:07 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 09:50:07 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:50:07 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c137ccd0000>; Fri, 14 Dec 2018 01:50:06 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v6 4/4] thermal: tegra: add get_trend ops
Date:   Fri, 14 Dec 2018 17:49:53 +0800
Message-ID: <1544780993-20744-5-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544780993-20744-1-git-send-email-wni@nvidia.com>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544781003; bh=qgc9OiWJ+azan6W/2X7/HJEt1+FS33W/FwXeDUxQfE8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GRdAji/VXAIK4aSJZeEVevkBmoOBkRT0PjJvc9PraSV6cw5Ya6WX6aayXdne/y+p6
         2YZukZgHf+/pz0AsM0go9tEIzynDNhH29MQ9bhG0UhlebYhK75a6m2LhK9EZEcKzkK
         9eBT+JSMLFRZ5780tbUDBQHah2urOpUTxym0nPsdq1ZyKUhic3yefPTaHRT47SQhH3
         CapyWiEe9lxpiAU+GyC4xaytbD6j9AqvK8ukfphOxATmBGRingwFlCM+G+Q2NWEMnx
         78CpRWjc5HGUs6O9KAndsvAW6Wl1/zctJK7B2w5NChuaUwscg45Ionvk7toAb+QEdP
         IETt18DHyHYyg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for get_trend ops that allows soctherm
sensors to be used with the step-wise governor.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 6bee31cd4621..330bffd38fdd 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -488,9 +488,43 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 	return 0;
 }
 
+static int tegra_thermctl_get_trend(void *data, int trip,
+				    enum thermal_trend *trend)
+{
+	struct tegra_thermctl_zone *zone = data;
+	struct thermal_zone_device *tz = zone->tz;
+	int trip_temp, temp, last_temp, ret;
+
+	if (!tz)
+		return -EINVAL;
+
+	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
+	if (ret)
+		return ret;
+
+	mutex_lock(&tz->lock);
+	temp = tz->temperature;
+	last_temp = tz->last_temperature;
+	mutex_unlock(&tz->lock);
+
+	if (temp > trip_temp) {
+		if (temp >= last_temp)
+			*trend = THERMAL_TREND_RAISING;
+		else
+			*trend = THERMAL_TREND_STABLE;
+	} else if (temp < trip_temp) {
+		*trend = THERMAL_TREND_DROPPING;
+	} else {
+		*trend = THERMAL_TREND_STABLE;
+	}
+
+	return 0;
+}
+
 static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 	.set_trip_temp = tegra_thermctl_set_trip_temp,
+	.get_trend = tegra_thermctl_get_trend,
 };
 
 static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
-- 
2.7.4

