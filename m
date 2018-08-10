Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626E3C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2126121EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2126121EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeHJUjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:39:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18983 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJUjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:39:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4a10000>; Fri, 10 Aug 2018 11:08:33 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:08:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Aug 2018 11:08:48 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:08:47 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:08:47 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4ad0001>; Fri, 10 Aug 2018 11:08:47 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS signaling
Date:   Fri, 10 Aug 2018 21:08:02 +0300
Message-ID: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series implements support for faster signaling modes on Tegra
SDHCI controllers. This series consist of several parts: changes
requried for 1.8 V signaling and pad control, pad calibration, and
tuning. Following earlies patch sets have been merged into this
larger set: "Tegra PMC pinctrl pad configuration", "Tegra SDHCI enable
1.8 V signaling on Tegar210 and Tegra186", "Tegra SDHCI update the
padautocal procedure". Also the patches for enabling SDHCI tuning
are added.

Changelog:
v2:
	- Fix grammar in PMC device tree bindings docs
	- Remove a stray line from tegra sdhci bindings
	- Cosmetic changes to PMC pinctrl driver
	- Fix a typo in "soc/tegra: pmc: Implement
	  tegra_io_pad_is_powered()" commit message
	- Declare mask and value on the same line in
	  tegra_io_pad_is_powered()
	- Move the call to tegra_sdhci_is_pad_and_regulator_valid() to
	  inside the if condition in tegra_sdhci_reset()
	- Use usleep_range() in tegra_sdhci_configure_cal_pad()
	- Move sdhci_writel() out of the enable if-else body in
	  tegra_sdhci_configure_cal_pad()
	- Add a delay before starting polling in
	  tegra_sdhci_pad_autocalib()
	- Use usleep_range() in tegra_sdhci_set_tap()
	- Rename orig_enabled to status in
	  tegra_sdhci_configure_card_clk()
	- Fix if condition wrapping alignment in tegra_sdhci_set_tap()

v1:
	- Probe the regulator voltage capabilities to determine whether pinctrl
	  is needed in tegra_sdhci_r eset
	- Don't remove tegra_sdhci_voltage_switch()
	- Use dev_warn() in tegra_sdhci_init_pinctrl_info()
	- Don't change start_signal_voltage_switch callback if pinctrl info
	  invalid
	- Only call udelay(1) on enable in tegra_sdhci_configure_cal_pad()
	- Add nvidia, prefix to pad autocal offset dt props in the example

See the original patch sets for earlier changelogs.

Aapo Vienamo (40):
  dt-bindings: Add Tegra PMC pad configuration bindings
  dt-bindings: mmc: tegra: Add pad voltage control properties
  dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
  dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
  soc/tegra: pmc: Fix pad voltage configuration for Tegra186
  soc/tegra: pmc: Factor out DPD register bit calculation
  soc/tegra: pmc: Implement tegra_io_pad_is_powered()
  soc/tegra: pmc: Use X macro to generate IO pad tables
  soc/tegra: pmc: Remove public pad voltage APIs
  soc/tegra: pmc: Implement pad configuration via pinctrl
  mmc: sdhci: Add a quirk to skip clearing the transfer mode register on
    tuning
  mmc: tegra: Reconfigure pad voltages during voltage switching
  mmc: tegra: Poll for calibration completion
  mmc: tegra: Set calibration pad voltage reference
  mmc: tegra: Power on the calibration pad
  mmc: tegra: Disable card clock during pad calibration
  mmc: tegra: Program pad autocal offsets from dt
  mmc: tegra: Perform pad calibration after voltage switch
  mmc: tegra: Enable pad calibration on Tegra210 and Tegra186
  mmc: tegra: Add a workaround for tap value change glitch
  mmc: tegra: Parse default trim and tap from dt
  mmc: tegra: Configure default tap values
  mmc: tegra: Configure default trim value on reset
  mmc: tegra: Use standard SDHCI tuning on Tegra210 and Tegra186
  mmc: sdhci: Add a quirk to disable card clock during tuning
  mmc: tegra: Enable workaround for tuning transfer mode bug
  mmc: tegra: Set SDHCI_QUIRK2_TUNE_DIS_CARD_CLK on Tegra210
  mmc: tegra: Enable UHS and HS200 modes for Tegra210
  mmc: tegra: Enable UHS and HS200 modes for Tegra186
  arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
  arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
  arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
  arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
  arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
  arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
  arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
  arm64: dts: tegra210: Add SDHCI tap and trim values
  arm64: dts: tegra186: Add SDHCI tap and trim values
  arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
  arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  93 ++++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 ++++
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  68 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  74 +++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  12 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   1 -
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  55 ++
 drivers/mmc/host/sdhci-tegra.c                     | 556 +++++++++++++++++++--
 drivers/mmc/host/sdhci.c                           |  21 +
 drivers/mmc/host/sdhci.h                           |   4 +
 drivers/soc/tegra/pmc.c                            | 511 ++++++++++++++-----
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 +
 include/soc/tegra/pmc.h                            |  20 +-
 13 files changed, 1324 insertions(+), 212 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

-- 
2.7.4

