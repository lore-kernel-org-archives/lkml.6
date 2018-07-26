Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B78C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763542089B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763542089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeGZNnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:43:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16372 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbeGZNnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:43:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b59be0e0000>; Thu, 26 Jul 2018 05:26:54 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 26 Jul 2018 05:27:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Jul 2018 05:27:03 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 12:27:02 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 26 Jul 2018 12:27:02 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b59be140000>; Thu, 26 Jul 2018 05:27:02 -0700
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
Subject: [PATCH v2 00/10] Tegra SDHCI update the pad autocal procedure
Date:   Thu, 26 Jul 2018 15:26:46 +0300
Message-ID: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Update the tegra_sdhci_pad_autocalib() pad drive strength calibration
procedure to match the ones specified in the TRMs of the more recent
SoCs. This was tested on Tegra186, Tegra210, and Tegra124, although it
should not break things older generations either.

This series depends on the "Tegra SDHCI enable 1.8 V signaling on
Tegar210 and Tegra186" series posted earlier.

Changelog:
v2:
	- Rename the series
	- Align the register macros
	- Use readl_poll_timeout() in tegra_sdhci_pad_autocalib()
	- Move SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD define to correc patch
	- Use !!(reg & SDHCI_CLOCK_CARD_EN) in
	  tegra_sdhci_configure_card_clk()
	- Add "nvidia," prefix to pad drive strength offset dt props
	- Read the drive strength properties as u32 instead of u8
	- Disable autocalibration if it times out

Aapo Vienamo (10):
  mmc: tegra: Poll for calibration completion
  mmc: tegra: Set calibration pad voltage reference
  mmc: tegra: Power on the calibration pad
  mmc: tegra: Disable card clock during pad calibration
  dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
  mmc: tegra: Program pad autocal offsets from dt
  arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
  arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
  mmc: tegra: Perform pad calibration after voltage switch
  mmc: tegra: Enable pad calibration on Tegra210 and Tegra186

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  34 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  20 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  12 +
 drivers/mmc/host/sdhci-tegra.c                     | 280 +++++++++++++++++++--
 4 files changed, 319 insertions(+), 27 deletions(-)

-- 
2.7.4

