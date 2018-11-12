Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41469C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED84E216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JA9LE5QB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bnElktRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED84E216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbeKLQvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:51:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeKLQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:51:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2771607B9; Mon, 12 Nov 2018 06:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542005977;
        bh=279VxUZikspctIiP7PmUIdta/48p+DRp82QQ3eJw8YQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JA9LE5QB3KNe2563Jjv9qLPG//DFZyVzxEgphORji4DEv5vQNTMlnTrEVxKkqvsHl
         uNsf27RNIZEo9TPiZj+ld2Xd/nXuVfeWw+jL8FB4bCTXj53TxPy+BoDrTC8cEVmnfk
         RrDXcfOhu+WKR8Q/gTJqwdg/MM1gc4bF7v6IwYcY=
Received: from [10.252.220.119] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8829601C3;
        Mon, 12 Nov 2018 06:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542005976;
        bh=279VxUZikspctIiP7PmUIdta/48p+DRp82QQ3eJw8YQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bnElktRfxKKDuXy3MjcWMmMPnOKz6K91v0S6wKIB53xnSZgzHG0FRHC0Hmy6eeRCf
         apsBLvj++cevBjXqvBCHi6u1+o62NINMmet4lgKDO0jAGdYdxV3xanSBW2r5oVLD0F
         +HaQOfhg8Rx30LB6DLVIMv1X/sDuQNmvKcAZba/8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8829601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V4 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated
 dynamically
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1542003767-10028-1-git-send-email-vbadigan@codeaurora.org>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <3bd9e31b-8cff-f7b6-6136-695ef4961f63@codeaurora.org>
Date:   Mon, 12 Nov 2018 12:29:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542003767-10028-1-git-send-email-vbadigan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please ignore this patch set. Right patch-set is V5. 
https://patchwork.kernel.org/project/linux-mmc/list/?series=41661

Sorry for the inconvenience.

Thanks

Veera


On 11/12/2018 11:52 AM, Veerabhadrarao Badiganti wrote:
> On few SDHCI-MSM controllers, the host controller's clock tuning
> circuit may go out of sync if controller clocks are gated which
> eventually will result in data CRC, command CRC/timeout errors.
> To overcome this h/w limitation, the DLL needs to be re-initialized
> and restored with its old settings once clocks are ungated.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>   drivers/mmc/host/sdhci-msm.c | 78 +++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 67 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3cc8bfe..4cac593 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -232,6 +232,7 @@ struct sdhci_msm_variant_ops {
>    */
>   struct sdhci_msm_variant_info {
>   	bool mci_removed;
> +	bool restore_dll_config;
>   	const struct sdhci_msm_variant_ops *var_ops;
>   	const struct sdhci_msm_offset *offset;
>   };
> @@ -256,6 +257,7 @@ struct sdhci_msm_host {
>   	bool pwr_irq_flag;
>   	u32 caps_0;
>   	bool mci_removed;
> +	bool restore_dll_config;
>   	const struct sdhci_msm_variant_ops *var_ops;
>   	const struct sdhci_msm_offset *offset;
>   };
> @@ -1025,6 +1027,48 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>   	return ret;
>   }
>   
> +static bool sdhci_msm_is_tuning_needed(struct sdhci_host *host)
> +{
> +	struct mmc_ios *ios = &host->mmc->ios;
> +
> +	/*
> +	 * Tuning is required for SDR104, HS200 and HS400 cards and
> +	 * if clock frequency is greater than 100MHz in these modes.
> +	 */
> +	if (host->clock <= CORE_FREQ_100MHZ ||
> +	    !(ios->timing == MMC_TIMING_MMC_HS400 ||
> +	    ios->timing == MMC_TIMING_MMC_HS200 ||
> +	    ios->timing == MMC_TIMING_UHS_SDR104) ||
> +	    ios->enhanced_strobe)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int sdhci_msm_restore_sdr_dll_config(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	/*
> +	 * SDR DLL comes into picture only for timing modes which needs
> +	 * tuning.
> +	 */
> +	if (!sdhci_msm_is_tuning_needed(host))
> +		return 0;
> +
> +	/* Reset the tuning block */
> +	ret = msm_init_cm_dll(host);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore the tuning block */
> +	ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
> +
> +	return ret;
> +}
> +
>   static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   {
>   	struct sdhci_host *host = mmc_priv(mmc);
> @@ -1035,14 +1079,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>   
> -	/*
> -	 * Tuning is required for SDR104, HS200 and HS400 cards and
> -	 * if clock frequency is greater than 100MHz in these modes.
> -	 */
> -	if (host->clock <= CORE_FREQ_100MHZ ||
> -	    !(ios.timing == MMC_TIMING_MMC_HS400 ||
> -	    ios.timing == MMC_TIMING_MMC_HS200 ||
> -	    ios.timing == MMC_TIMING_UHS_SDR104))
> +	if (!sdhci_msm_is_tuning_needed(host))
>   		return 0;
>   
>   	/*
> @@ -1069,7 +1106,6 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   		if (rc)
>   			return rc;
>   
> -		msm_host->saved_tuning_phase = phase;
>   		rc = mmc_send_tuning(mmc, opcode, NULL);
>   		if (!rc) {
>   			/* Tuning is successful at this tuning point */
> @@ -1094,6 +1130,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   		rc = msm_config_cm_dll_phase(host, phase);
>   		if (rc)
>   			return rc;
> +		msm_host->saved_tuning_phase = phase;
>   		dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
>   			 mmc_hostname(mmc), phase);
>   	} else {
> @@ -1616,7 +1653,6 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>   };
>   
>   static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
> -	.mci_removed = false,
>   	.var_ops = &mci_var_ops,
>   	.offset = &sdhci_msm_mci_offset,
>   };
> @@ -1627,9 +1663,17 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>   	.offset = &sdhci_msm_v5_offset,
>   };
>   
> +static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
> +	.mci_removed = true,
> +	.restore_dll_config = true,
> +	.var_ops = &v5_var_ops,
> +	.offset = &sdhci_msm_v5_offset,
> +};
> +
>   static const struct of_device_id sdhci_msm_dt_match[] = {
>   	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
>   	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
> +	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
>   	{},
>   };
>   
> @@ -1689,6 +1733,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>   	var_info = of_device_get_match_data(&pdev->dev);
>   
>   	msm_host->mci_removed = var_info->mci_removed;
> +	msm_host->restore_dll_config = var_info->restore_dll_config;
>   	msm_host->var_ops = var_info->var_ops;
>   	msm_host->offset = var_info->offset;
>   
> @@ -1928,9 +1973,20 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>   	struct sdhci_host *host = dev_get_drvdata(dev);
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
>   
> -	return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>   				       msm_host->bulk_clks);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Whenever core-clock is gated dynamically, it's needed to
> +	 * restore the SDR DLL settings when the clock is ungated.
> +	 */
> +	if (msm_host->restore_dll_config && msm_host->clk_rate)
> +		return sdhci_msm_restore_sdr_dll_config(host);
> +
> +	return 0;
>   }
>   #endif
>   

