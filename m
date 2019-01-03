Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADD920815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oVNg2pT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfACKNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:13:23 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19171 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730818AbfACKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:13:19 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2de0340000>; Thu, 03 Jan 2019 02:13:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Jan 2019 02:13:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 03 Jan 2019 02:13:18 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 10:13:18 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 10:13:18 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 10:13:18 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2de03c0000>; Thu, 03 Jan 2019 02:13:17 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v7 2/3] thermal: tegra: fix memory allocation
Date:   Thu, 3 Jan 2019 18:12:48 +0800
Message-ID: <1546510369-28491-3-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546510369-28491-1-git-send-email-wni@nvidia.com>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546510388; bh=mfJ0UbyhFDpIIbPv2Zct+34m55gu5ZXsTwWqKRVEna8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oVNg2pT1J632G8rVfJ+MxWHEU1dzZBQfnyfiGiRwsvbrhaIPRPpdBzFaTQA59yJHZ
         JUiU9h9bgKTWh417xFOuDF/zImwxRpT7pI8BMGwEnMeKq5TC48dRr6T3ToPiAK1JvV
         uy4uERyrJJqopk1oqY3XPuYltjR5sz2rXSUeqzH1d5P2n7iQ7b1RRWUusA3/VpX9RQ
         8XW1Rywcg7zXc5oY1CGnpe2OA4Sbcc/FEPjNkD0OM4aW9Othggn3zu605Av/PcFTfl
         DFYIqnvSP3hOra2S9GDC6pfsGMQ9ULxJmeAmJVPJL8RcCA09fpvRxOubr08rZev9Wu
         aI6Nefs8cGAWQ==
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

