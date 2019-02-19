Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AD1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250CE2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C2P3GGYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfBSE1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:27:32 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14039 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfBSE13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:27:29 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6b85b00000>; Mon, 18 Feb 2019 20:27:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 20:27:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 20:27:28 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 04:27:28 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 04:27:27 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 04:27:27 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6b85ad0003>; Mon, 18 Feb 2019 20:27:27 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <linux-tegra@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <rui.zhang@intel.com>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v8 3/3] thermal: tegra: add get_trend ops
Date:   Tue, 19 Feb 2019 12:27:04 +0800
Message-ID: <1550550424-7979-4-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550550424-7979-1-git-send-email-wni@nvidia.com>
References: <1550550424-7979-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550550448; bh=MXUJIjHbG+ZKGPfT8LRa84XRIYBLZT6uhPgUFP3p22U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=C2P3GGYGrEKAzKce/dS+a9LopiBFiBlS6ZEbZKklalIgLhwXa0A2sQaf6frhsvcwc
         MjP9N3vVym5qXC0T67OyPxKvMFhMPK0ARQ6XnCbudOP3nXH3YB5xun90Rzq20kqUFp
         PFr2jelkYjEuWd+emi0uSNV8dhC2ofWYYjwOWC42OeDwuVBF3WbcUkWheroAPIx2XM
         dnc4nT2odECcjDUMKgKFoD11cOAnJB0zVBgo/T06oFBADfCuJs1UuaX6ZBA+gxrouX
         TPJBQLpXvgFLD1+o8wrzb9/MNbJtb/HwfCnX0J3E6TI5qZlleBoCATp/DCCvy8A6Gw
         p6JZF8clpMlag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for get_trend ops that allows soctherm
sensors to be used with the step-wise governor.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index b1ead6ea4c73..70043a28eb7a 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -488,9 +488,41 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
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
+	temp = READ_ONCE(tz->temperature);
+	last_temp = READ_ONCE(tz->last_temperature);
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

