Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D51C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B1420857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="rg4Pr4iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B1420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbeGaLV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:21:29 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55546 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbeGaLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:21:29 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DFB2F5C01C4;
        Tue, 31 Jul 2018 11:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533030117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hTLy/O62J38uZxycpkxLvjBKO0T+J7akpVTFCtnW9s=;
        b=rg4Pr4iOOcEND0VUs7gWUzH1U/9tkz/IGHGOLBlhJez3MVuj27StXCGaAlCuLcx2+sYYKT
        Kzywetu228KktSTIrKE5VSASm7MjFw+rrHLgfMrrCME7w3qefyFr9pbKI41CH/JX9X7eec
        2MG58DX4pvBLd7qP7xZBwtkKUVgInRA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 11:41:57 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH v2 03/10] mmc: tegra: Power on the calibration pad
In-Reply-To: <1532608016-14319-4-git-send-email-avienamo@nvidia.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
 <1532608016-14319-4-git-send-email-avienamo@nvidia.com>
Message-ID: <e4319add2110282f8ddc4c3016512516@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2018 14:26, Aapo Vienamo wrote:
> Automatic pad drive strength calibration is performed on a separate pad
> identical to the ones used for driving the actual bus. Power on the
> calibration pad during the calibration procedure and power it off
> afterwards to save power.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 51eda20..363490e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -53,6 +53,7 @@
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
>  
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
> @@ -241,11 +242,30 @@ static void tegra_sdhci_reset(struct sdhci_host
> *host, u8 mask)
>  	tegra_host->ddr_signaling = false;
>  }
>  
> +static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Enable or disable the additional I/O pad used by the drive strength
> +	 * calibration process.
> +	 */
> +	reg = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	if (enable)
> +		reg |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
> +	else
> +		reg &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	udelay(1);

Is this necessary on enable and disable?

If it only necessary on enable, I suggest to move it after the call to:
tegra_sdhci_configure_cal_pad(host, true);

--
Stefan

> +}
> +
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
>  	u32 reg;
>  	int ret;
>  
> +	tegra_sdhci_configure_cal_pad(host, true);
> +
>  	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>  	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
>  	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> @@ -255,6 +275,8 @@ static void tegra_sdhci_pad_autocalib(struct
> sdhci_host *host)
>  				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
>  				 1, 10000);
>  
> +	tegra_sdhci_configure_cal_pad(host, false);
> +
>  	if (ret)
>  		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>  }
