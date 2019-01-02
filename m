Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD05C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8481A218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bBDkPJfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfABTgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:36:52 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10041 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfABTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:36:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2d12c80000>; Wed, 02 Jan 2019 11:36:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Jan 2019 11:36:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Jan 2019 11:36:51 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 19:36:50 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 19:36:50 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2d12d20000>; Wed, 02 Jan 2019 11:36:50 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V7 0/2] HW Command Queue support for Tegra SDMMC
Date:   Wed, 2 Jan 2019 11:36:46 -0800
Message-ID: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546457800; bh=HAXwg3XI/A5AwFM8/rn6uj7IR00IBWhMyKVjcpl3E5w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=bBDkPJfFTllqqgWv7Qc5O6CXLK7Y+iF+DjtHp2cCl51XPFABUEL+1qq9YfgpJkh6D
         pjX6hZ1Pvb1So7jnrcEomFnp0vir+4tDQ0JJFJ1Wi5gL4ohmZUWTKF15lhvNsuKsw8
         4GHhRx22WRpSgYcvwT8Ohowfp/xGUeLdugj3Zh91t6a8DLNHJW4mDNClWTlcBJLk9K
         pNGbHfrDKm/UEfQg727NJliO363EtZ7h/SFv6fK0438MZ23OLrZi4NbQnZodyC7oST
         OA71jzRheIfOF7jpe3Wik/Hn5CvA2wdLqayvoVxROhn5x+PnbyLorjDa+L2OtRWoQq
         XsJn51pRr9b6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is for HW Command Queue support for Tegra SDMMC.

Patch[2] adds HW Command Queue support for Tegra SDMMC and has
dependencies on other patches in this series as explained below.

Patch[1] SDMMC address range:
This patch defines exact register space for all the SDMMC
Controllers. Controllers supporting command queue are having
CQHCI register space from offset 0xF000.
Patch[2] uses address range of sdmmc controllers to identify command
queue supported controllers

Note: PATCH V7 has seperate DMA Type defined as per SD Host V4.20 spec.
Updated commit message to be more clear.

Sowjanya Komatineni (2):
  arm64: dtsi: Fix SDMMC address range
  mmc: tegra: HW Command Queue Support for Tegra SDMMC

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |   6 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |   4 +-
 drivers/mmc/host/Kconfig                 |   1 +
 drivers/mmc/host/sdhci-tegra.c           | 107 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                 |  16 +++--
 drivers/mmc/host/sdhci.h                 |   1 +
 6 files changed, 125 insertions(+), 10 deletions(-)

-- 
2.7.4

