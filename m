Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC84C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223B3208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223B3208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeH0ON4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:13:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:46070 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeH0ON4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:13:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 03:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="86675592"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by orsmga002.jf.intel.com with ESMTP; 27 Aug 2018 03:27:48 -0700
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
 <20180827100826.GA18542@ulmo>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <095142c4-2697-d9e1-4930-a39e27b7ef40@intel.com>
Date:   Mon, 27 Aug 2018 13:26:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827100826.GA18542@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/18 13:08, Thierry Reding wrote:
> On Fri, Aug 10, 2018 at 09:13:57PM +0300, Aapo Vienamo wrote:
>> Hi all,
>> This series implements support for HS400 signaling on Tegra210 and
>> Tegra186. This includes programming the DQS trimmer values, implementing
>> enhanced strobe and HS400 delay line calibration.
>>
>> This series depends on the "Tegra SDHCI add support for HS200 and UHS
>> signaling" series.
>>
>> Changelog:
>> v2:
>> 	- Document in dt-bindings which controllers support HS400
>> 	- Use val instead of reg in tegra_sdhci_set_dqs_trim()
>> 	- Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
>> 	  value" commit message
>> 	- Add spaces around << in tegra_sdhci_set_dqs_trim()
>> 	- Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
>> 	  message more detailed
>> 	- Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
>> 	- Add blank lines around if-else-block in
>> 	  tegra_sdhci_hs400_enhanced_strobe()
>> 	- Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
>> 	- Make commit message of "mmc: tegra: Implement HS400 delay line
>> 	  calibration" more detailed
>>
>> Aapo Vienamo (8):
>>   dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
>>   mmc: tegra: Parse and program DQS trim value
>>   mmc: tegra: Implement HS400 enhanced strobe
>>   mmc: tegra: Implement HS400 delay line calibration
>>   arm64: dts: tegra186: Add SDMMC4 DQS trim value
>>   arm64: dts: tegra210: Add SDMMC4 DQS trim value
>>   arm64: dts: tegra186: Enable HS400
>>   arm64: dts: tegra210: Enable HS400
>>
>>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
>>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
>>  drivers/mmc/host/sdhci-tegra.c                     | 84 +++++++++++++++++++++-
>>  4 files changed, 89 insertions(+), 3 deletions(-)
> 
> Adrian,
> 
> any chance you could take a brief look at these? They are a prerequisite
> for the 2-patch series ("[PATCH 0/2] Tegra SDHCI rerun pad calibration
> periodically") that you already acked.

Sure, I'll try and have a look today.
