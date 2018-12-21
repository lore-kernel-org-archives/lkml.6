Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D511C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC72A21905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y5j1IZG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403782AbeLUCPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:15:36 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11673 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeLUCPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:15:36 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1c4cc10001>; Thu, 20 Dec 2018 18:15:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Dec 2018 18:15:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Dec 2018 18:15:35 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 02:15:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 02:15:35 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1c40f70000>; Thu, 20 Dec 2018 17:25:16 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 0/3] HW Command Queue support for Tegra SDMMC
Date:   Thu, 20 Dec 2018 17:25:06 -0800
Message-ID: <1545355509-6914-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545358529; bh=aaSnbL4eGvdYFH7b2ggmhWrZuqvFNA6cvrjtDhBxGds=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Y5j1IZG0W0BMA8BS2aNeotfEBMadsf+z7tKJVUi/LWrjUprwURHclGEfPfRiTDKYg
         6u2tN3H4rDwSOFfae+K8IqEJIuPJ2noGDd6KbEZBODYvwqb7e8hbpchHl2AV1wOLSN
         1yBEeCcUqIXHJqs8ptHCmm8+y/Gq8FukjgiSLnKV1f1KqfKEHut/LldqAZqxJjBAEI
         /6ipOb1+2qqzivrWmWZsHm1/x0AC7GtbaW/iE1XpyR+OWJMspn1V97ZizEj5u7g0Iw
         imqNHZ/FYd1x67C0/1l6zhEPSUDwMSJ7W9uM7aDdKNSTAEYZqGMmsMupwrkmxllUhp
         t7mX2YwP1oriQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is for HW Command Queue support for Tegra SDMMC.

Patch[3] adds HW Command Queue support for Tegra SDMMC and has
dependencies on other patches in this series as explained below.

Patch[2] SDMMC address range:
This patch defines exact register space for all the SDMMC
Controllers. Controllers supporting command queue are having
CQHCI register space from offset 0xF000.
Patch[3] uses address range of sdmmc controllers to identify command
queue supported controllers

Patch[1] Fix V4 Mode enable:
V4 Mode need to be enabled to select Host Version 4.0 mode for HW Command
queue support with Tegra SDHCI.

Sowjanya Komatineni (3):
  mmc: sdhci: Fix sdhci_do_enable_v4_mode
  arm64: dtsi: Fix SDMMC address range
  mmc: tegra: HW Command Queue Support for Tegra SDMMC

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |   6 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |   4 +-
 drivers/mmc/host/Kconfig                 |   1 +
 drivers/mmc/host/sdhci-tegra.c           | 138 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                 |   4 +-
 5 files changed, 145 insertions(+), 8 deletions(-)

-- 
2.7.4

