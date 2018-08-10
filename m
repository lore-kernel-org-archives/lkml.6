Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9BC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0902722449
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0902722449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeHJUpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:45:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11854 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeHJUpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:45:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd5e50000>; Fri, 10 Aug 2018 11:13:57 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:14:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Aug 2018 11:14:05 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:14:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:14:11 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd5f00000>; Fri, 10 Aug 2018 11:14:11 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Date:   Fri, 10 Aug 2018 21:13:57 +0300
Message-ID: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series implements support for HS400 signaling on Tegra210 and
Tegra186. This includes programming the DQS trimmer values, implementing
enhanced strobe and HS400 delay line calibration.

This series depends on the "Tegra SDHCI add support for HS200 and UHS
signaling" series.

Changelog:
v2:
	- Document in dt-bindings which controllers support HS400
	- Use val instead of reg in tegra_sdhci_set_dqs_trim()
	- Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
	  value" commit message
	- Add spaces around << in tegra_sdhci_set_dqs_trim()
	- Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
	  message more detailed
	- Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
	- Add blank lines around if-else-block in
	  tegra_sdhci_hs400_enhanced_strobe()
	- Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
	- Make commit message of "mmc: tegra: Implement HS400 delay line
	  calibration" more detailed

Aapo Vienamo (8):
  dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
  mmc: tegra: Parse and program DQS trim value
  mmc: tegra: Implement HS400 enhanced strobe
  mmc: tegra: Implement HS400 delay line calibration
  arm64: dts: tegra186: Add SDMMC4 DQS trim value
  arm64: dts: tegra210: Add SDMMC4 DQS trim value
  arm64: dts: tegra186: Enable HS400
  arm64: dts: tegra210: Enable HS400

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
 drivers/mmc/host/sdhci-tegra.c                     | 84 +++++++++++++++++++++-
 4 files changed, 89 insertions(+), 3 deletions(-)

-- 
2.7.4

