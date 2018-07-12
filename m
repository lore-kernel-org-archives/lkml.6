Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F07C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B65820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B65820BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeGLNCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:02:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:58919 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbeGLNCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:02:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 05:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="244688994"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2018 05:52:49 -0700
Subject: Re: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
 changing frequency
To:     Stefan Agner <stefan@agner.ch>, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180712080725.14250-1-stefan@agner.ch>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ae108a16-80ca-0e44-d6d4-e122debc06b1@intel.com>
Date:   Thu, 12 Jul 2018 15:51:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180712080725.14250-1-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/18 11:07, Stefan Agner wrote:
> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
> is set to 0. However, it could be that the stack asks for a frequency
> change while clocks are on. In that case the function clears the
> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
> enabled! This causes a short period of time where the clock is
> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
> 
> For older IP variants the driver disables clock by clearing some bits
> in ESDHC_SYSTEM_CONTROL.
> 
> Make sure to disable card clock before changing frequency for uSDHC
> IP variants too.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 85fd5a8b0b6d..acacd8481473 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  	int div = 1;
>  	u32 temp, val;
>  
> +	if (esdhc_is_usdhc(imx_data)) {
> +		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> +			host->ioaddr + ESDHC_VENDOR_SPEC);
> +	}
> +
>  	if (clock == 0) {
>  		host->mmc->actual_clock = 0;
> -
> -		if (esdhc_is_usdhc(imx_data)) {
> -			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> -			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -					host->ioaddr + ESDHC_VENDOR_SPEC);
> -		}
>  		return;
>  	}
>  
> 

