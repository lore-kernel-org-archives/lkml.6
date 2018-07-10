Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A08C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DFD208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DFD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeGJLI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:08:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:3841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeGJLIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:08:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 04:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="scan'208";a="55389551"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga007.jf.intel.com with ESMTP; 10 Jul 2018 04:08:50 -0700
Subject: Re: [PATCH RFC 1/2] mmc: sdhci: Allow platform controlled voltage
 switching
To:     Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
References: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
 <1529583826-42020-2-git-send-email-vviswana@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <53c6d61f-47f5-2e4e-8280-6f76f707799e@intel.com>
Date:   Tue, 10 Jul 2018 14:07:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1529583826-42020-2-git-send-email-vviswana@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/18 15:23, Vijay Viswanath wrote:
> Some controllers can have internal mechanism to inform the SW that it
> is ready for voltage switching. For such controllers, changing voltage
> before the HW is ready can result in various issues.
> 
> Add a quirk, which can be used by drivers of such controllers.
> 
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 20 +++++++++++++++-----
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1c828e0..f0346d4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1615,7 +1615,8 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  		     unsigned short vdd)
>  {
> -	if (IS_ERR(host->mmc->supply.vmmc))
> +	if (IS_ERR(host->mmc->supply.vmmc) ||
> +			(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))

I think you should provide your own ->set_power() instead of this

>  		sdhci_set_power_noreg(host, mode, vdd);
>  	else
>  		sdhci_set_power_reg(host, mode, vdd);
> @@ -2009,7 +2010,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		ctrl &= ~SDHCI_CTRL_VDD_180;
>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>  
> -		if (!IS_ERR(mmc->supply.vqmmc)) {
> +		if (!IS_ERR(mmc->supply.vqmmc) &&
> +				!(host->quirks2 &
> +					SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {

And your own ->start_signal_voltage_switch()

>  			ret = mmc_regulator_set_vqmmc(mmc, ios);
>  			if (ret) {
>  				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
> @@ -2032,7 +2035,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  	case MMC_SIGNAL_VOLTAGE_180:
>  		if (!(host->flags & SDHCI_SIGNALING_180))
>  			return -EINVAL;
> -		if (!IS_ERR(mmc->supply.vqmmc)) {
> +		if (!IS_ERR(mmc->supply.vqmmc) &&
> +			!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
>  			ret = mmc_regulator_set_vqmmc(mmc, ios);
>  			if (ret) {
>  				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
> @@ -3485,7 +3489,10 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	 * the host can take the appropriate action if regulators are not
>  	 * available.
>  	 */
> -	ret = mmc_regulator_get_supply(mmc);
> +	if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))

Since we expect mmc_regulator_get_supply() to have been called, this could be:

	if (!mmc->supply.vmmc) {
		ret = mmc_regulator_get_supply(mmc);
		enable_vqmmc = true;
	} else {
		ret = 0;
	}

> +		ret = mmc_regulator_get_supply(mmc);
> +	else
> +		ret = 0;
>  	if (ret)
>  		return ret;
>  
> @@ -3736,7 +3743,10 @@ int sdhci_setup_host(struct sdhci_host *host)
>  
>  	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>  	if (!IS_ERR(mmc->supply.vqmmc)) {
> -		ret = regulator_enable(mmc->supply.vqmmc);
> +		if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))

And this could be:

		if (enable_vqmmc)
			ret = regulator_enable(mmc->supply.vqmmc);
		else
			ret = 0;

However, you still need to ensure regulator_disable(mmc->supply.vqmmc) is
only called if regulator_enable() was called.

> +			ret = regulator_enable(mmc->supply.vqmmc);
> +		else
> +			ret = 0;
>  		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
>  						    1950000))
>  			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f8..3b0c97a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -450,6 +450,8 @@ struct sdhci_host {
>   * obtainable timeout.
>   */
>  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
> +/* Regulator voltage changes are being done from platform layer */
> +#define SDHCI_QUIRK2_INTERNAL_PWR_CTL				(1<<18)

So maybe the quirk is not needed.

>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

