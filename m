Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90542C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56845223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Vu33SjCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56845223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbeKMUDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:03:49 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7713 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbeKMUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:03:49 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5beaa2110001>; Tue, 13 Nov 2018 02:06:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 13 Nov 2018 02:06:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 13 Nov 2018 02:06:27 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 10:06:27 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 13 Nov 2018 10:06:27 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5beaa2210000>; Tue, 13 Nov 2018 02:06:26 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 3/3] thermal: tegra: fix memory allocation
Date:   Tue, 13 Nov 2018 18:06:07 +0800
Message-ID: <1542103567-5521-4-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542103567-5521-1-git-send-email-wni@nvidia.com>
References: <1542103567-5521-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542103570; bh=8nBqymvQ6Qtdv79G+fvJHJGiahRJFTaQXHo5R88mI8w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Vu33SjCfH/fUfiKhPbZsXROU5+ZgtX32lwa9Eqa5VbelXn+mTU+kXOWPU37WCzSP9
         Ln5b/DaYt0EX3Xj5MxvnOTN0Mi+lpoN+p8+AiLTyOy2jsKWrN4ceWuWR7VpMXOqNcJ
         ctWt65DtQu98EIKzreZ3x+QbktwZPWf4qfQnViI79qgm5CBTCE3dJEDmlzA4VpSVlA
         5wETPWN0aD2TyBWSFK4AFAqIaYuoT0xBV0wXzCXmIm1idnGGAPwQRF3jtON3yfkQpy
         ru/+GdFdrjeXAJrswdAj2nbSO9KAyUehttfohJqzppFQHsoRwfBRCsElWZ7oj1L+xh
         h4vRGNKMl1S8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory allocation to store the pointers to
thermal_zone_device.

Signed-off-by: Wei Ni <wni@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 161ef242bcca..96ca10789f17 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1339,7 +1339,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	}
 
 	tegra->thermctl_tzs = devm_kcalloc(&pdev->dev,
-					   soc->num_ttgs, sizeof(*z),
+					   soc->num_ttgs, sizeof(z),
 					   GFP_KERNEL);
 	if (!tegra->thermctl_tzs)
 		return -ENOMEM;
-- 
2.7.4

