Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6AAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8252083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8252083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeGZNgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:36:04 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16640 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbeGZNgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:36:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b59bc520000>; Thu, 26 Jul 2018 05:19:30 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 26 Jul 2018 05:19:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 26 Jul 2018 05:19:24 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 12:19:28 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 26 Jul 2018 12:19:28 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b59bc4d0001>; Thu, 26 Jul 2018 05:19:28 -0700
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
Subject: [PATCH v2 00/10] Tegra SDHCI enable 1.8 V signaling on Tegar210 and Tegra186
Date:   Thu, 26 Jul 2018 15:19:10 +0300
Message-ID: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Reconfigure pad voltages as part of mmc voltage switching on
controllers with adjustable voltages. Allow for reconfiguration of the
signaling voltage of SDMMC1 on Tegra210 P2597 and fix SDMMC4 signaling
voltage regulator configuration on Tegra210 P2180.

This series depends on the "Tegra PMC pinctrl pad configuration" series posted
earlier.

Changelog:
v2:
	- Change the pinctrl bindings commit title
	- Use IS_ERR in tegra_sdhci_init_pinctrl_info()
	- Add nvidia,only-1-8-v property
	- Disable UHS modes in case the pad and regulator configuration
	  is invalid

Aapo Vienamo (10):
  dt-bindings: mmc: tegra: Add pad voltage control properties
  dt-bindings: mmc: tegra: Add nvidia,only-1-8-v property
  mmc: tegra: Reconfigure pad voltages during voltage switching
  arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
  arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
  arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
  arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
  arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
  arm64: dts: tegra210: Add nvidia,only-1-8-v to sdmmc4
  arm64: dts: tegra186: Add nvidia,only-1-8-v to sdmmc4

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  24 ++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  41 ++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  12 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   1 -
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  28 +++++
 drivers/mmc/host/sdhci-tegra.c                     | 140 +++++++++++++++++++--
 6 files changed, 222 insertions(+), 24 deletions(-)

-- 
2.7.4

