Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84705C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470CA20C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470CA20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbeHVOXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:23:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:51820 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbeHVOXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:23:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2018 03:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,273,1531810800"; 
   d="scan'208";a="79096954"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2018 03:58:38 -0700
Subject: Re: [PATCH 2/2] mmc: tegra: Implement periodic pad calibration
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
 <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3bdbaef6-522d-92ea-c0d1-1aea9fd069d9@intel.com>
Date:   Wed, 22 Aug 2018 13:56:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/18 12:23, Aapo Vienamo wrote:
> Rerun the pad calibration procedure before sdhci_request() if
> the 100 ms recalibration interval has been exceeded.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 94624ec..ef18a0c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -30,6 +30,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/ktime.h>
>  
>  #include "sdhci-pltfm.h"
>  
> @@ -122,6 +123,7 @@ struct sdhci_tegra {
>  	struct pinctrl_state *pinctrl_state_1v8;
>  
>  	struct sdhci_tegra_autocal_offsets autocal_offsets;
> +	ktime_t last_calib;
>  
>  	u32 default_tap;
>  	u32 default_trim;
> @@ -533,6 +535,22 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>  		autocal->pull_down_hs400 = autocal->pull_down_1v8;
>  }
>  
> +static void tegra_sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	ktime_t since_calib = ktime_sub(ktime_get(), tegra_host->last_calib);
> +
> +	/* 100 ms calibration interval is specified in the TRM */
> +	if (ktime_to_ms(since_calib) > 100) {
> +		tegra_sdhci_pad_autocalib(host);
> +		tegra_host->last_calib = ktime_get();
> +	}
> +
> +	sdhci_request(mmc, mrq);
> +}
> +
>  static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1014,6 +1032,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  				sdhci_tegra_start_signal_voltage_switch;
>  	}
>  
> +	/* Hook to periodically rerun pad calibration */
> +	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> +		host->mmc_host_ops.request = tegra_sdhci_request;
> +
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  			tegra_sdhci_hs400_enhanced_strobe;
>  
> 

