Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48904C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE77F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kciNjGja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE77F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeLNJuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:50:09 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10582 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbeLNJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:50:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c137cca0000>; Fri, 14 Dec 2018 01:50:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Dec 2018 01:50:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Dec 2018 01:50:05 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 09:50:05 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:50:05 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c137cca0003>; Fri, 14 Dec 2018 01:50:04 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v6 3/4] thermal: tegra: parse sensor id before sensor register
Date:   Fri, 14 Dec 2018 17:49:52 +0800
Message-ID: <1544780993-20744-4-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544780993-20744-1-git-send-email-wni@nvidia.com>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544781002; bh=nWT8IrVMku4kJkV9k0/1Ook9xqT9hpmJKbC602i8z5Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kciNjGjaQdqcdRRceLZE1lHp+SYxdpg2Ytj8xK0+66ybZlfx/FWFFyqJ5DvhBxL5n
         DNogZUTI43DZQ5R29etFjgODA9wCBw+uFmwVLYm4zkZMafjs6l2c1X5E9uB68aXm5i
         ypEbLAHDIrW9JDraaDJ0F0PIN0RzGnBatPweBSL1cF+l0y/KJs61TpH58poZh7/l7v
         +fYHVhFXWIbAOs+34y40QF9CFHJcm2WSJ9qFIFLLLtOPA5bUNcuIjS3H/2iTnM79Hm
         moAHJ51KxI0eKq2jleGRwwkY+MBFr0CnwJVwjM1kgthT+r0MGN34SBAq7vfGkTHb4y
         n8ZXyCv86W68w==
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
 drivers/thermal/tegra/soctherm.c | 45 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index fd2703c0cfc5..6bee31cd4621 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1224,6 +1224,41 @@ static void soctherm_init(struct platform_device *pdev)
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
+			of_node_put(sensor_np);
+			ret = true;
+			break;
+		}
+	}
+
+	of_node_put(np);
+
+	return ret;
+}
+
 static const struct of_device_id tegra_soctherm_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 	{
@@ -1365,13 +1400,16 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
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
 
@@ -1434,6 +1472,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
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

