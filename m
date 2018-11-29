Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD1B20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="o2Bf06yR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD1B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeK2VOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:14:53 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17960 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeK2VOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:14:52 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bffbafd0000>; Thu, 29 Nov 2018 02:10:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 29 Nov 2018 02:10:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 29 Nov 2018 02:10:03 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 29 Nov
 2018 10:10:03 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 29 Nov
 2018 10:10:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Nov 2018 10:10:02 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bffbaf70002>; Thu, 29 Nov 2018 02:10:01 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v4 3/3] thermal: tegra: parse sensor id before sensor register
Date:   Thu, 29 Nov 2018 18:09:43 +0800
Message-ID: <1543486183-2868-4-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543486183-2868-1-git-send-email-wni@nvidia.com>
References: <1543486183-2868-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543486205; bh=1vLS67MRV1cSQ3NTjEgx5+FLaSxsY9XT5a4ufZClFco=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=o2Bf06yRjGx8jDzso5+SKHvBIi3U1y7Gbtp4L9xizFIvKksu3WNdXylNnAgQkBohF
         FTNqwkav1NHMqZTWf4tD5wCh6wl+Ma7kn+2J1vRcDcIgzMZFwHDkLTOhT3+/TiRwnl
         2xA3b/5dXGXAqJ/eNBCrDykvNSnaVee49wvHMqcx3CwBDR7dmA8NUsaaMmCTbX13G1
         nolpuo5Frn2BCez1ucl3HCcCeQkiXE6nyizE0FWclnvApT3+Y9uhNm+CtuFaRnQrEV
         pzhKKKN7PHWxIYW9bhKH209/m9HgkZ5hNVYxYl9CVwDGdCeC+ejMRGQQ20+NM4Je3r
         JY7wHmo106eLg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since different platforms may not support all 4
sensors, so the sensor registration may be failed.
Add codes to parse dt to find sensor id which
need to be registered. So that the registration
can be successful on all platform.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 46 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 375cadbc24cd..bdc660f2794a 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1224,6 +1224,42 @@ static void soctherm_init(struct platform_device *pdev)
 	tegra_soctherm_throttle(&pdev->dev);
 }
 
+static bool tegra_soctherm_find_sensor_id(unsigned int sensor_id)
+{
+	bool ret = false;
+	struct of_phandle_args sensor_specs;
+	struct device_node *np, *sensor_np;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return ret;
+
+	sensor_np = of_get_next_child(np, NULL);
+	for_each_available_child_of_node(np, sensor_np) {
+		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
+						 "#thermal-sensor-cells",
+						 0, &sensor_specs))
+			continue;
+
+		if (sensor_specs.args_count != 1) {
+			WARN(sensor_specs.args_count != 1,
+			     "%s: wrong cells in sensor specifier %d\n",
+			     sensor_specs.np->name, sensor_specs.args_count);
+			continue;
+		}
+
+		if (sensor_specs.args[0] == sensor_id) {
+			ret = true;
+			break;
+		}
+	}
+
+	of_node_put(np);
+	of_node_put(sensor_np);
+
+	return ret;
+}
+
 static const struct of_device_id tegra_soctherm_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 	{
@@ -1365,13 +1401,16 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		zone->sg = soc->ttgs[i];
 		zone->ts = tegra;
 
+		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
+			continue;
+
 		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
 							 soc->ttgs[i]->id, zone,
 							 &tegra_of_thermal_ops);
 		if (IS_ERR(z)) {
 			err = PTR_ERR(z);
-			dev_err(&pdev->dev, "failed to register sensor: %d\n",
-				err);
+			dev_err(&pdev->dev, "failed to register sensor %s: %d\n",
+				soc->ttgs[i]->name, err);
 			goto disable_clocks;
 		}
 
@@ -1434,6 +1473,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
 		struct thermal_zone_device *tz;
 
 		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
+		if (!tz)
+			continue;
+
 		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
 		if (err) {
 			dev_err(&pdev->dev,
-- 
2.7.4

