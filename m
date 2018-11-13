Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF27FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EEE223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OU8GSXWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EEE223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbeKMUDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:03:46 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15594 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbeKMUDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:03:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5beaa2280000>; Tue, 13 Nov 2018 02:06:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 13 Nov 2018 02:06:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 13 Nov 2018 02:06:23 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 10:06:23 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 10:06:23 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 13 Nov 2018 10:06:23 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5beaa21d0000>; Tue, 13 Nov 2018 02:06:22 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 1/3] thermal: tegra: continue if sensor register fails
Date:   Tue, 13 Nov 2018 18:06:05 +0800
Message-ID: <1542103567-5521-2-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542103567-5521-1-git-send-email-wni@nvidia.com>
References: <1542103567-5521-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542103592; bh=wh+6aFiP4fPQoSQeJZeVk6+n0tLre9/VfwW2MJg4tTg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OU8GSXWqq0x2ZRIOtlnyauDU/wkVn+EG1lYYjh+070kznFpcjVg8ysaYqY15Y0k6s
         s1qpY0Hue/b1egzYMDtxOU7ipjZN+3+ZVT1lHue+vLZEZu9cUKiyylf6PVdDAHlbX3
         9+Q+zBKxT1uNuheeVEj2NDaHwzbT0UzfklxSSURf0frX/p6boCDYBSF2D0azwEk4lN
         RKJ1XwR4q1DU1BLuxZaqrqomeVQwd8onq6feuXwP/MyeH6ZQju3l3wFtxL7xmy4JRq
         7kshaNwowI+Q4kD1paK4gJZT8NxIuXcS2LvMPRUKuuuFbDu//NWZNtZQlC7zDy6jIP
         b1smwDa1IJ0TA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't bail when a sensor fails to register with the
thermal zone and allow other sensors to register.
This allows other sensors to register with thermal
framework even if one sensor fails registration.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110a3535..a824d2e63af3 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1370,9 +1370,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 							 &tegra_of_thermal_ops);
 		if (IS_ERR(z)) {
 			err = PTR_ERR(z);
-			dev_err(&pdev->dev, "failed to register sensor: %d\n",
-				err);
-			goto disable_clocks;
+			dev_warn(&pdev->dev, "failed to register sensor %s: %d\n",
+				 soc->ttgs[i]->name, err);
+			continue;
 		}
 
 		zone->tz = z;
@@ -1434,6 +1434,8 @@ static int __maybe_unused soctherm_resume(struct device *dev)
 		struct thermal_zone_device *tz;
 
 		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
+		if (!tz)
+			continue;
 		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
 		if (err) {
 			dev_err(&pdev->dev,
-- 
2.7.4

