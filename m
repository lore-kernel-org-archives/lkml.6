Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8F0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7579021773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfBLIKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:10:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:32618 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfBLIKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:10:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 00:10:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="137909219"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2019 00:09:59 -0800
Subject: Re: [PATCH v2 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>
References: <20190211132342.31009-1-thomas.petazzoni@bootlin.com>
 <20190211132342.31009-2-thomas.petazzoni@bootlin.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <93ab7f86-8b07-8eef-c4b5-29bfe5e4e7b5@intel.com>
Date:   Tue, 12 Feb 2019 10:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211132342.31009-2-thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/19 3:23 PM, Thomas Petazzoni wrote:
> Even though SDHCI controllers may have a dedicated WP pin that can be
> queried using the SDHCI_PRESENT_STATE register, some platforms may
> chose to use a separate regular GPIO to route the WP signal. Such a
> GPIO is typically represented using the wp-gpios property in the
> Device Tree.
> 
> Unfortunately, the current sdhci_check_ro() function does not make use
> of such GPIO when available: it either uses a host controller specific
> ->get_ro() operation, or uses the SDHCI_PRESENT_STATE. Several host
> controller specific ->get_ro() functions are implemented just to check
> a WP GPIO state.
> 
> Instead of pushing this to more controller-specific implementations,
> let's handle this in the core SDHCI code, just like it is already done
> for the CD GPIO in sdhci_get_cd().
> 
> The below patch simply changes sdhci_check_ro() to use the value of
> the WP GPIO if available. We need to adjust the prototype of the
> function to use a mmc_host* as argument instead of sdhci_host*, since
> the mmc_can_gpio_ro() and mmc_gpio_get_ro() helpers take a mmc_host*.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
> Changes since v1:
> 
>  - As suggested by Adrian Hunter, call the ->get_ro() if it exists
>    before falling back to using mmc_gpio_get_ro(). Indeed, if the
>    controller-specific code has implemented a ->get_ro() callback, it
>    should take precedence over what the SDHCI core does.
> 
>    Due to this change, I have not added Thierry Redding Reviewed-by.
> 
>  - Fix typo in the commit log noticed by Thierry Redding.
> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index df05352b6a4a..e6682ea5f7c0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2022,8 +2022,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>  	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
>  
> -static int sdhci_check_ro(struct sdhci_host *host)
> +static int sdhci_check_ro(struct mmc_host *mmc)

Please let's not change the parameter.

>  {
> +	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
>  	int is_readonly;
>  
> @@ -2033,6 +2034,8 @@ static int sdhci_check_ro(struct sdhci_host *host)
>  		is_readonly = 0;
>  	else if (host->ops->get_ro)
>  		is_readonly = host->ops->get_ro(host);
> +	else if (mmc_can_gpio_ro(mmc))
> +		is_readonly = mmc_gpio_get_ro(mmc);

Just make it 'host->mmc' instead of 'mmc'

>  	else
>  		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
>  				& SDHCI_WRITE_PROTECT);
> @@ -2052,11 +2055,11 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>  	int i, ro_count;
>  
>  	if (!(host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT))
> -		return sdhci_check_ro(host);
> +		return sdhci_check_ro(mmc);
>  
>  	ro_count = 0;
>  	for (i = 0; i < SAMPLE_COUNT; i++) {
> -		if (sdhci_check_ro(host)) {
> +		if (sdhci_check_ro(mmc)) {
>  			if (++ro_count > SAMPLE_COUNT / 2)
>  				return 1;
>  		}
> 

