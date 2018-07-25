Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B89C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D9220882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D9220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeGYPSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:18:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:11472 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbeGYPSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:18:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 07:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,401,1526367600"; 
   d="scan'208";a="77727214"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2018 07:06:00 -0700
Subject: Re: [PATCH V1 3/3] mmc: sdhci-msm: Use internal voltage control
To:     Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, evgreen@chromium.org, dianders@google.com,
        sayalil@codeaurora.org
References: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
 <1532083566-43215-4-git-send-email-vviswana@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0a5317f1-b75a-5286-2a53-2fe14b67a77a@intel.com>
Date:   Wed, 25 Jul 2018 17:04:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1532083566-43215-4-git-send-email-vviswana@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/18 13:46, Vijay Viswanath wrote:
> Some sdhci-msm controllers require that voltage switching be done after
> the HW is ready for it. The HW informs its readiness through power irq.
> The voltage switching should happen only then.
> 
> Use the quirk for internal voltage switching and then control the
> voltage switching using power irq.
> 
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 220 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 209 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index a0dc3e1..47732a2 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -43,7 +43,9 @@
>  #define CORE_PWRCTL_IO_LOW	BIT(2)
>  #define CORE_PWRCTL_IO_HIGH	BIT(3)
>  #define CORE_PWRCTL_BUS_SUCCESS BIT(0)
> +#define CORE_PWRCTL_BUS_FAIL    BIT(1)
>  #define CORE_PWRCTL_IO_SUCCESS	BIT(2)
> +#define CORE_PWRCTL_IO_FAIL     BIT(3)
>  #define REQ_BUS_OFF		BIT(0)
>  #define REQ_BUS_ON		BIT(1)
>  #define REQ_IO_LOW		BIT(2)
> @@ -236,6 +238,14 @@ struct sdhci_msm_variant_info {
>  	const struct sdhci_msm_offset *offset;
>  };
>  
> +/* Holds voltage regulator information to be used by the driver*/
> +struct sdhci_msm_vreg_info {
> +	bool vmmc_load;
> +	u32 vmmc_level[2];
> +	bool vqmmc_load;
> +	u32 vqmmc_level[2];
> +};

Kernel style is not to introduce structures that are only ever wholly
contained within one other structure i.e. the members of struct
sdhci_msm_vreg_info could just be in struct sdhci_msm_host instead.

> +
>  struct sdhci_msm_host {
>  	struct platform_device *pdev;
>  	void __iomem *core_mem;	/* MSM SDCC mapped address */
> @@ -258,6 +268,8 @@ struct sdhci_msm_host {
>  	bool mci_removed;
>  	const struct sdhci_msm_variant_ops *var_ops;
>  	const struct sdhci_msm_offset *offset;
> +	struct sdhci_msm_vreg_info vreg_info;
> +	bool pltfm_init_done;
>  };
>  
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> @@ -1314,11 +1326,13 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_host *mmc = host->mmc;
>  	u32 irq_status, irq_ack = 0;
> -	int retry = 10;
> +	int retry = 10, ret = 0;
>  	u32 pwr_state = 0, io_level = 0;
>  	u32 config;
>  	const struct sdhci_msm_offset *msm_offset = msm_host->offset;
> +	struct sdhci_msm_vreg_info vreg_info = msm_host->vreg_info;
>  
>  	irq_status = msm_host_readl(msm_host, host,
>  			msm_offset->core_pwrctl_status);
> @@ -1351,14 +1365,91 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  
>  	/* Handle BUS ON/OFF*/
>  	if (irq_status & CORE_PWRCTL_BUS_ON) {
> -		pwr_state = REQ_BUS_ON;
> -		io_level = REQ_IO_HIGH;
> -		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +		if (!IS_ERR(mmc->supply.vmmc)) {
> +			if (vreg_info.vmmc_load)
> +				ret = regulator_set_load(mmc->supply.vmmc,
> +						vreg_info.vmmc_level[1]);
> +			ret |= mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> +					mmc->ios.vdd);

Or-ing error numbers seems a bit weird.  The code is a bit crammed also,
so I suggest adding helper functions.  For example consider something like:

static int sdhci_msm_set_vmmc(struct sdhci_msm_host *msm_host,
			      struct mmc_host *mmc, int level)
{
	int load = msm_host->vmmc_level[level];
	int ret;

	if (IS_ERR(mmc->supply.vmmc))
		return 0;

	if (msm_host->vmmc_load) {
		ret = regulator_set_load(mmc->supply.vmmc, load);
		if (ret)
			goto out;
	}

	ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
out:
	if (ret)
		pr_err("%s: vmmc failed: %d\n", mmc_hostname(mmc), ret);

	return ret;
}

> +			if (ret)
> +				pr_err("%s: vmmc enable failed: %d\n",
> +						mmc_hostname(mmc), ret);
> +		}
> +
> +		if (!IS_ERR(mmc->supply.vqmmc) && !ret) {
> +			struct mmc_ios ios;
> +
> +			if (vreg_info.vqmmc_load)
> +				ret = regulator_set_load(mmc->supply.vqmmc,
> +						vreg_info.vqmmc_level[1]);
> +			/*
> +			 * The IO voltage regulator maynot always support
> +			 * a voltage close to vdd. Set IO voltage based on
> +			 * capability of the regulator.
> +			 */
> +			if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
> +				ios.signal_voltage = MMC_SIGNAL_VOLTAGE_330;
> +			else if (msm_host->caps_0 & CORE_1_8V_SUPPORT)
> +				ios.signal_voltage = MMC_SIGNAL_VOLTAGE_180;
> +			if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
> +				pr_err("%s: %s: setting signal voltage: %d\n",
> +						mmc_hostname(mmc), __func__,
> +						ios.signal_voltage);

Why pr_err()?

> +				ret |= mmc_regulator_set_vqmmc(mmc, &ios);

Again I suggest createing a helper function and not or-ing error numbers.

> +			}
> +
> +			if (!ret)
> +				ret = regulator_enable(mmc->supply.vqmmc);
> +			if (ret)
> +				pr_err("%s: vqmmc enable failed: %d\n",
> +						mmc_hostname(mmc), ret);
> +		}
> +		if (!ret) {
> +			pwr_state = REQ_BUS_ON;
> +			io_level = REQ_IO_HIGH;
> +			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +		} else {
> +			pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
> +					mmc_hostname(mmc), ret, irq_status);
> +			irq_ack |= CORE_PWRCTL_BUS_FAIL;
> +		}
>  	}
>  	if (irq_status & CORE_PWRCTL_BUS_OFF) {
> -		pwr_state = REQ_BUS_OFF;
> -		io_level = REQ_IO_LOW;
> -		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +		/*
> +		 * During platform initialization, we may get BUS_OFF request
> +		 * and turn off the supply. EMMC devices expect Power off
> +		 * notification before being turned off. So wait till platform
> +		 * initialization is over to actually turn off power.
> +		 */
> +		if (!IS_ERR(mmc->supply.vmmc) && msm_host->pltfm_init_done) {
> +			if (vreg_info.vmmc_load)
> +				ret = regulator_set_load(mmc->supply.vmmc,
> +						vreg_info.vmmc_level[0]);
> +			ret |= mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> +					mmc->ios.vdd);
> +			if (ret)
> +				pr_err("%s: vmmc disabling failed: %d\n",
> +						mmc_hostname(mmc), ret);
> +		}

So with the function above, that would be:

		if (msm_host->pltfm_init_done)
			ret = sdhci_msm_set_vmmc(msm_host, mmc, 0)

> +		if (!IS_ERR(mmc->supply.vqmmc) && msm_host->pltfm_init_done &&
> +				!ret) {
> +			if (vreg_info.vqmmc_load)
> +				ret = regulator_set_load(mmc->supply.vqmmc,
> +						vreg_info.vqmmc_level[0]);
> +			ret |= regulator_disable(mmc->supply.vqmmc);
> +			if (ret)
> +				pr_err("%s: vqmmc disabling failed: %d\n",
> +						mmc_hostname(mmc), ret);
> +		}
> +		if (!ret) {
> +			pwr_state = REQ_BUS_OFF;
> +			io_level = REQ_IO_LOW;
> +			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +		} else {
> +			pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
> +					mmc_hostname(mmc), ret, irq_status);
> +			irq_ack |= CORE_PWRCTL_BUS_FAIL;
> +		}
>  	}
>  	/* Handle IO LOW/HIGH */
>  	if (irq_status & CORE_PWRCTL_IO_LOW) {
> @@ -1370,6 +1461,15 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  		irq_ack |= CORE_PWRCTL_IO_SUCCESS;
>  	}
>  
> +	if (io_level && !IS_ERR(mmc->supply.vqmmc) && !pwr_state) {
> +		ret = mmc_regulator_set_vqmmc(mmc, &mmc->ios);
> +		if (ret)
> +			pr_err("%s: IO_level setting failed(%d). signal_voltage: %d, vdd: %d irq_status: 0x%08x\n",
> +					mmc_hostname(mmc), ret,
> +					mmc->ios.signal_voltage, mmc->ios.vdd,
> +					irq_status);
> +	}
> +
>  	/*
>  	 * The driver has to acknowledge the interrupt, switch voltages and
>  	 * report back if it succeded or not to this register. The voltage
> @@ -1415,10 +1515,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  		msm_host->curr_pwr_state = pwr_state;
>  	if (io_level)
>  		msm_host->curr_io_level = io_level;
> -
>  	pr_debug("%s: %s: Handled IRQ(%d), irq_status=0x%x, ack=0x%x\n",
> -		mmc_hostname(msm_host->mmc), __func__, irq, irq_status,
> -		irq_ack);
> +			mmc_hostname(msm_host->mmc), __func__,
> +			irq, irq_status, irq_ack);

Seem to be some unrelated whitespace changes here.

>  }
>  
>  static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
> @@ -1563,6 +1662,13 @@ static void sdhci_msm_writeb(struct sdhci_host *host, u8 val, int reg)
>  		sdhci_msm_check_power_status(host, req_type);
>  }
>  
> +static void sdhci_msm_set_power(struct sdhci_host *host, unsigned char mode,
> +		     unsigned short vdd)
> +{
> +	sdhci_set_power_noreg(host, mode, vdd);

Why not just have .set_power = sdhci_set_power_noreg()

> +
> +}
> +
>  static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  {
>  	struct mmc_host *mmc = msm_host->mmc;
> @@ -1605,6 +1711,91 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>  }
>  
> +static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
> +{
> +	int ret = 0;
> +
> +	ret = mmc_regulator_get_supply(msm_host->mmc);
> +	if (ret)
> +		return ret;
> +	if (device_property_read_u32_array(&msm_host->pdev->dev,
> +			"vmmc-current-level",
> +			msm_host->vreg_info.vmmc_level, 2) >= 0)
> +		msm_host->vreg_info.vmmc_load = true;
> +	if (device_property_read_u32_array(&msm_host->pdev->dev,
> +			"vqmmc-current-level",
> +			msm_host->vreg_info.vqmmc_level, 2) >= 0)
> +		msm_host->vreg_info.vqmmc_load = true;
> +
> +	sdhci_msm_set_regulator_caps(msm_host);
> +
> +	return 0;
> +
> +}
> +
> +static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
> +				      struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u16 ctrl;
> +
> +	/*
> +	 * Signal Voltage Switching is only applicable for Host Controllers
> +	 * v3.00 and above.
> +	 */
> +	if (host->version < SDHCI_SPEC_300)
> +		return 0;
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		if (!(host->flags & SDHCI_SIGNALING_330))
> +			return -EINVAL;
> +		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
> +		ctrl &= ~SDHCI_CTRL_VDD_180;
> +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +		/* 3.3V regulator output should be stable within 5 ms */
> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		if (!(ctrl & SDHCI_CTRL_VDD_180))
> +			return 0;
> +
> +		pr_warn("%s: 3.3V regulator output did not became stable\n",
> +			mmc_hostname(mmc));
> +
> +		return -EAGAIN;
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		if (!(host->flags & SDHCI_SIGNALING_180))
> +			return -EINVAL;
> +
> +		/*
> +		 * Enable 1.8V Signal Enable in the Host Control2
> +		 * register
> +		 */
> +		ctrl |= SDHCI_CTRL_VDD_180;
> +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +		/* 1.8V regulator output should be stable within 5 ms */
> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		if (ctrl & SDHCI_CTRL_VDD_180)
> +			return 0;
> +
> +		pr_warn("%s: 1.8V regulator output did not became stable\n",
> +			mmc_hostname(mmc));
> +
> +		return -EAGAIN;
> +	case MMC_SIGNAL_VOLTAGE_120:
> +		if (!(host->flags & SDHCI_SIGNALING_120))
> +			return -EINVAL;
> +		return 0;
> +	default:
> +		/* No signal voltage switch required */
> +		return 0;
> +	}
> +
> +}
> +
>  static const struct sdhci_msm_variant_ops mci_var_ops = {
>  	.msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
>  	.msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
> @@ -1644,6 +1835,7 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
>  	.write_w = sdhci_msm_writew,
>  	.write_b = sdhci_msm_writeb,
> +	.set_power = sdhci_msm_set_power,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
> @@ -1672,6 +1864,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> +	host->mmc_host_ops.start_signal_voltage_switch =
> +		sdhci_msm_start_signal_voltage_switch;

Perhaps put this where the other mmc_host_ops assignment is.

>  	host->sdma_boundary = 0;
>  	pltfm_host = sdhci_priv(host);
>  	msm_host = sdhci_pltfm_priv(pltfm_host);
> @@ -1819,6 +2013,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  				msm_offset->core_vendor_spec_capabilities0);
>  	}
>  
> +	ret = sdhci_msm_register_vreg(msm_host);
> +	if (ret == -EPROBE_DEFER)

Why not just:

	if (ret)

> +		goto clk_disable;
> +
>  	/*
>  	 * Power on reset state may trigger power irq if previous status of
>  	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
> @@ -1867,7 +2065,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto pm_runtime_disable;
> -	sdhci_msm_set_regulator_caps(msm_host);
> +	msm_host->pltfm_init_done = true;
>  
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
> 

