Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30377C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA50920851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FJcpC09A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA50920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeKTTjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:39:55 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9259 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeKTTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:39:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3cfd60000>; Tue, 20 Nov 2018 01:11:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 01:11:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 01:11:49 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 09:11:44 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 09:11:44 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bf3cfcf0000>; Tue, 20 Nov 2018 01:11:44 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH] thermal: tegra: add get_trend ops
Date:   Tue, 20 Nov 2018 17:11:17 +0800
Message-ID: <1542705077-29697-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542705110; bh=+E1NbiGuq4oVI9X/GrWNd7E/FXlVxO/Ck8VXurrSRwA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=FJcpC09AuvBSNO3rFEkHCeZ/COeU3HE63eRddHOyTs+Toi9VunPUtkzIaDfoOg9eL
         0H9FmqMwDmxgJ7mwq6ex+Ln4n2tZawo0t4RRXPYHFy9WABVGAbTG2+e0ZUKuVUh7+f
         FNc7NceYmdHUYOxrEM3CQ0sSWGa8eeWTgTBSV1oWKm+amAzcdFzpYCw7EQdOHPVTUe
         FAq3POAp1Y3jh7WyXJguJ9ayAzY0oAsJZgwa6o7jHxlCPiq19GQd+TUDcgpBPCKzLD
         QjLmC7IgE1+kSTkQkFvjS+JOIqyP7TzpJkG9/37IsIdTiMJATKmSylz4IcQRtLiauo
         g2bWr5GfBpCfA==
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
index ed28110a3535..d2951fbe2b7c 100644
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

