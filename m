Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568B0ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E91720869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d6HRKgJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E91720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeKESv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:51:57 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6271 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeKESv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:51:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be00e440001>; Mon, 05 Nov 2018 01:32:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 05 Nov 2018 01:32:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Nov 2018 01:32:59 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 09:33:06 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Nov 2018 09:33:06 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5be00e500000>; Mon, 05 Nov 2018 01:33:06 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 1/4] thermal: tegra: continue if sensor register fails
Date:   Mon, 5 Nov 2018 17:32:31 +0800
Message-ID: <1541410354-19090-2-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541410354-19090-1-git-send-email-wni@nvidia.com>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541410372; bh=YE/S17OzKcjiqh7ysTGXR48lrMGkSFYZxxuKOvxpNYU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=d6HRKgJOTs+SZiVjk+xfi2YYIVMEEtQTQvjb8Ej727aj+FPrI9eiaRyaUrUsOBq8G
         EpiqBhpeOHjtEU/PWmqKaYziQRrgW9+cD64r0pFIcSflAPAqRf0+5TYowf8P940t/M
         zx3U5xiRlV5HqCtyWGYiDyAvOq26eovlO/RB4B/exBC67GhcUSFyFCzOqawRG7CsYm
         IXWRzi1iyLwUw16qi4wA9tAFMAGij4+fUPa0RxC1U512jFWkIIZd26Cu46GaJJHLGa
         g6R+qjhGqDmyW9gph232BY9T8ui3axvI2HGKi5p4sYdLObXZ5XZEpDRoNKkZAkPqvo
         YOTDdEkG0kmzg==
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
 drivers/thermal/tegra/soctherm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110a3535..b708300303ff 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1370,9 +1370,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 							 &tegra_of_thermal_ops);
 		if (IS_ERR(z)) {
 			err = PTR_ERR(z);
-			dev_err(&pdev->dev, "failed to register sensor: %d\n",
+			dev_warn(&pdev->dev, "failed to register sensor: %d\n",
 				err);
-			goto disable_clocks;
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

