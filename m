Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE8FC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D04D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LcttF7mU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeLSXmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:42:25 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16934 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeLSXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:42:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1ad7570002>; Wed, 19 Dec 2018 15:42:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Dec 2018 15:42:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Dec 2018 15:42:21 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 23:42:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 23:42:21 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1ad75c0003>; Wed, 19 Dec 2018 15:42:20 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 1/4] mmc: sdhci: Fix sdhci_do_enable_v4_mode
Date:   Wed, 19 Dec 2018 15:42:15 -0800
Message-ID: <1545262938-20636-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545262935; bh=5VPjgfovQQgJ4LTnW17IjsU5AYDEFqzz9p8BEOlX2C4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=LcttF7mUkdDL/u7BClTAqxtXXNMdzCKgB+XAv8Hfsy9gJO1le3aU+AK6zS9ijgV9D
         1CaRBRP1DfkAX/TqhUMD3jnJA5Fm2Sf4S2oRtr75z5iJgfwCLuhWnI16yru8YZOsCu
         rxer/mWiEUVOeo8x0uwRYlNc9+nzXPBS4xG+pLEr1xcWS7DtKpPkWUdalXN4uu+/E2
         BwonqSlMf8IPsm7w94Quxli8ynVApY9O5PhVmFTdElbp5v9v5Hwr6/+2sF6tWvggzA
         2/n0D00IoZIWj0V2+dwqszd58sPKW0za6ur/ZgK8dDy/EmZiF1uc6VfNUyFcZkQVOy
         PmMapwr6f1dDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4_MODE is Bit-15 of SDHCI_HOST_CONTROL2 register.
Need to perform word access to this register.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae53fa2e..fde984d10619 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -127,12 +127,12 @@ static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
 {
 	u16 ctrl2;
 
-	ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	if (ctrl2 & SDHCI_CTRL_V4_MODE)
 		return;
 
 	ctrl2 |= SDHCI_CTRL_V4_MODE;
-	sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
 }
 
 /*
-- 
2.7.4

