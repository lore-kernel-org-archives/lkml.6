Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A60C20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A60C20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeHaLef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:34:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:59586 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbeHaLef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:34:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 00:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="87842044"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2018 00:22:14 -0700
Subject: Re: [PATCH v3 00/38] Tegra SDHCI add support for HS200 and UHS
 signaling
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20180830150639.21048-1-avienamo@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c0b484dc-bfb1-244b-f40e-e6511b8888ba@intel.com>
Date:   Fri, 31 Aug 2018 10:20:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/18 18:06, Aapo Vienamo wrote:
> Hi all,
> 
> This series implements support for faster signaling modes on Tegra
> SDHCI controllers. This series consist of several parts: changes
> required for 1.8 V signaling and pad control, pad calibration, and
> tuning. Following earlies patch sets have been merged into this
> larger set: "Tegra PMC pinctrl pad configuration", "Tegra SDHCI enable
> 1.8 V signaling on Tegar210 and Tegra186", "Tegra SDHCI update the
> padautocal procedure". Also the patches for enabling SDHCI tuning
> are added.

For sdhci-related patches 11 thru' 27

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> 
> Changelog:
> v3:
> 	- Remove tegra_sdhci_writew() from tegra210_sdhci_ops to prevent
> 	  incorrect access to SDHCI_TRANSFER_MODE on Tegra210.
> 	- Drop "mmc: sdhci: Add a quirk to skip clearing the transfer
> 	  mode register on tuning". This is no longer needed since it
> 	  was effectively a workaround to the behavior caused by
> 	  tegra_sdhci_writew() on Tegra210.
> 	- Implement disabling of the card clock during issuing of the
> 	  tuning command in tegra210_sdhci_writew().
> 	- Drop "mmc: sdhci: Add a quirk to disable card clock during
> 	  tuning". This is now implemented in the sdhci-tegra driver.
> 	
> v2:
> 	- Fix grammar in PMC device tree bindings docs
> 	- Remove a stray line from tegra sdhci bindings
> 	- Cosmetic changes to PMC pinctrl driver
> 	- Fix a typo in "soc/tegra: pmc: Implement
> 	  tegra_io_pad_is_powered()" commit message
> 	- Declare mask and value on the same line in
> 	  tegra_io_pad_is_powered()
> 	- Move the call to tegra_sdhci_is_pad_and_regulator_valid() to
> 	  inside the if condition in tegra_sdhci_reset()
> 	- Use usleep_range() in tegra_sdhci_configure_cal_pad()
> 	- Move sdhci_writel() out of the enable if-else body in
> 	  tegra_sdhci_configure_cal_pad()
> 	- Add a delay before starting polling in
> 	  tegra_sdhci_pad_autocalib()
> 	- Use usleep_range() in tegra_sdhci_set_tap()
> 	- Rename orig_enabled to status in
> 	  tegra_sdhci_configure_card_clk()
> 	- Fix if condition wrapping alignment in tegra_sdhci_set_tap()
> 
> v1:
> 	- Probe the regulator voltage capabilities to determine whether pinctrl
> 	  is needed in tegra_sdhci_r eset
> 	- Don't remove tegra_sdhci_voltage_switch()
> 	- Use dev_warn() in tegra_sdhci_init_pinctrl_info()
> 	- Don't change start_signal_voltage_switch callback if pinctrl info
> 	  invalid
> 	- Only call udelay(1) on enable in tegra_sdhci_configure_cal_pad()
> 	- Add nvidia, prefix to pad autocal offset dt props in the example
> 
> See the original patch sets for earlier changelogs.
> 
> 
> Aapo Vienamo (38):
>   dt-bindings: Add Tegra PMC pad configuration bindings
>   dt-bindings: mmc: tegra: Add pad voltage control properties
>   dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
>   dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
>   soc/tegra: pmc: Fix pad voltage configuration for Tegra186
>   soc/tegra: pmc: Factor out DPD register bit calculation
>   soc/tegra: pmc: Implement tegra_io_pad_is_powered()
>   soc/tegra: pmc: Use X macro to generate IO pad tables
>   soc/tegra: pmc: Remove public pad voltage APIs
>   soc/tegra: pmc: Implement pad configuration via pinctrl
>   mmc: tegra: Reconfigure pad voltages during voltage switching
>   mmc: tegra: Poll for calibration completion
>   mmc: tegra: Set calibration pad voltage reference
>   mmc: tegra: Power on the calibration pad
>   mmc: tegra: Disable card clock during pad calibration
>   mmc: tegra: Program pad autocal offsets from dt
>   mmc: tegra: Perform pad calibration after voltage switch
>   mmc: tegra: Enable pad calibration on Tegra210 and Tegra186
>   mmc: tegra: Add a workaround for tap value change glitch
>   mmc: tegra: Parse default trim and tap from dt
>   mmc: tegra: Configure default tap values
>   mmc: tegra: Configure default trim value on reset
>   mmc: tegra: Use standard SDHCI tuning on Tegra210 and Tegra186
>   mmc: tegra: Remove tegra_sdhci_writew() from tegra210_sdhci_ops
>   mmc: tegra: Disable card clock during tuning cmd on Tegra210
>   mmc: tegra: Enable UHS and HS200 modes for Tegra210
>   mmc: tegra: Enable UHS and HS200 modes for Tegra186
>   arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
>   arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
>   arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
>   arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
>   arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
>   arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
>   arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
>   arm64: dts: tegra210: Add SDHCI tap and trim values
>   arm64: dts: tegra186: Add SDHCI tap and trim values
>   arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
>   arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4
> 
>  .../arm/tegra/nvidia,tegra186-pmc.txt         |  93 +++
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt | 103 ++++
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt     |  68 ++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  74 +++
>  .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |  12 +-
>  .../arm64/boot/dts/nvidia/tegra210-p2597.dtsi |   1 -
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  55 ++
>  drivers/mmc/host/sdhci-tegra.c                | 583 ++++++++++++++++--
>  drivers/soc/tegra/pmc.c                       | 511 +++++++++++----
>  .../pinctrl/pinctrl-tegra-io-pad.h            |  18 +
>  include/soc/tegra/pmc.h                       |  20 +-
>  11 files changed, 1328 insertions(+), 210 deletions(-)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
> 

