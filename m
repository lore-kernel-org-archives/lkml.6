Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD0AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B392D2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jpv2Yyg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B392D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeKESwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:52:00 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6275 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKESwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:52:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be00e480000>; Mon, 05 Nov 2018 01:32:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 05 Nov 2018 01:33:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Nov 2018 01:33:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 09:33:10 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Nov 2018 09:33:10 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5be00e540000>; Mon, 05 Nov 2018 01:33:10 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 3/4] thermal: tegra: fix memory allocation
Date:   Mon, 5 Nov 2018 17:32:33 +0800
Message-ID: <1541410354-19090-4-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541410354-19090-1-git-send-email-wni@nvidia.com>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541410376; bh=C4fnQckN6Sd/pqit2s5lJD28cF6hUr2nh/oL11UV6g0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Jpv2Yyg40rU+5h9/whjIH6T0fP/RRhzPLN/4jJtmovhN+H3OvzhUSuIKyHZnWdw4U
         8gQazZ82F0109RFK3ACprl7alS0F9YXF1nBfXJ8znpLi/YoHNPkJ+GnDPkAjDHzQ0+
         U/lFs5oQU32vf7MtL6iXDBvPzMqOdHrlWbnrkk62iS8lU4ttG4FDF8fT37sfENJO+2
         3FQLLAMJnuRMUegGsfmAjTPpU4aWE0VGyQ7Gp50k6ctSKrEZhkTUGwPXfB0IkVb+xU
         k6K7UXZZrSOlX0SnFvE0HbcE9vR5rk1aRvXbfSyR0HxSbkkranf5s+LzDB3YFTHa38
         uqjKx43HbjMxA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory allocation to store the pointers to
thermal_zone_device.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 39a8bda07ac4..3042837364e8 100644
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

