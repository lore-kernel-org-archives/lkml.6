Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C3DC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA1220851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iknTI2Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA1220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLCFzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:55:36 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17067 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLCFzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:55:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c04c5530000>; Sun, 02 Dec 2018 21:55:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 02 Dec 2018 21:55:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 02 Dec 2018 21:55:32 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 05:55:31 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 05:55:31 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c04c5520000>; Sun, 02 Dec 2018 21:55:31 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v5 2/3] thermal: tegra: fix memory allocation
Date:   Mon, 3 Dec 2018 13:55:22 +0800
Message-ID: <1543816523-10525-3-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543816523-10525-1-git-send-email-wni@nvidia.com>
References: <1543816523-10525-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543816532; bh=mfJ0UbyhFDpIIbPv2Zct+34m55gu5ZXsTwWqKRVEna8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=iknTI2CmFF80+PZx0fvRdDiCsUvuNrxuiCR+CeIeBF8Y/jA2Tpo8IvRwKEwyzXfM3
         Rmtdivshg9UKPYDI88GKEAKRMMeRJQaVkYFgnLC0AoUn4x/kAc6URoaTTAru18Q/5A
         SVioet33STEdqKRQTQ0p2RUz3jDQWV0bLVmzuFFdFy//UL6R8kiHMOtFbYnpDTDu/G
         194zrz9VhoQQmEBNOVi93n0+WR8AM1JuuzfOjXy+RU7rt649HFtoE3lO7Ni9IQ0Fqx
         BLm6phnqzmhJWzEonZcPORfUzHVPkZvb7vm6nmNOtSE2cJVqQSLAmNS2UjtDaMaAEQ
         1iCGyBtwP8EQQ==
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
index f07de8258e93..fd2703c0cfc5 100644
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

