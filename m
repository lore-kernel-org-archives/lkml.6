Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7276420869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rt3OazhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeLSUhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:37:42 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9692 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbeLSUhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:37:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1aab030001>; Wed, 19 Dec 2018 12:33:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Dec 2018 12:33:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Dec 2018 12:33:18 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 20:33:12 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 20:33:12 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 20:33:12 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1aab080000>; Wed, 19 Dec 2018 12:33:12 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2] DMA Block size configuration prior to CQE
Date:   Wed, 19 Dec 2018 12:33:03 -0800
Message-ID: <1545251584-2105-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545251855; bh=B+3Py9+CGrFGhWh2GQyKvV5vrWF1UcGLtAivI+eHcUQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=rt3OazhNU9KKXZNzUmKqfpubCi+TSR62wLHA9QA+1+NiiqQZqAUsjZ0nHLSy8vpf1
         8AR506v0XwfjfAwzey3fVbYQCn/rqRr/Y9W5t3wKI+5axd0owzCo2arqKZHJwPP9HM
         RTbzP+7Wp/xwZrhaUhc4KIuozl5yrARdaP8idirODmRTamT6hrjRR+v3Zz6I88sHog
         tIlMC/CEaptVszWayVnkYkhV/kfB2tsO//03tvEwpqXlCFTWt3UaQlr2GGyCjVhOZF
         xDQxRmFIhk8WcXooYorlR3ls4+0lONUhnwaDyI3drLxqPyCb/tAxdJoledsEgJgtLy
         1QW+u/4zcPXDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per eMMC5.1 Spec Section 6.6.39.1, DMA Block size should be to 512 B
before enabling command queue.

Tegra SDHCI Host design strictly follows this sequence preventing write
access to SDHCI_BLOCK_SIZE when CQE is set in CQHCI_CFG. Writing to
SDHCI_BLOCK_SIZE register when CQE is enabled results in crash.

This patch is needed for enabling HW Command queue for Tegra SDHCI.

Note: couple more patches are needed for enabling HW CMDQ on Tegra SDHCI.
Based on patch review feedback from Ulf on the other HW Command queue
patch, I will resend new patch series with all these dependency patches
together along with covering letter.

[0] DMA Config prior to CQE
    https://lkml.org/lkml/2018/12/14/1062
[1] SDMMC address range
    https://lkml.org/lkml/2018/12/14/1323
[2] Fix sdhci_do_enable_v4_mode
    https://lkml.org/lkml/2018/12/14/72
[3] Add HW Command Queue for Tegra SDHCI
    https://patchwork.kernel.org/patch/10731915/

Sowjanya Komatineni (1):
  mmc: cqhci: DMA Configuration prior to CQE

 drivers/mmc/host/cqhci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.7.4

