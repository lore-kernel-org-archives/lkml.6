Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78169ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209FC20846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209FC20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeGPUcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:32:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2551 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeGPUcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:32:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4cf9fe0000>; Mon, 16 Jul 2018 13:03:10 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 16 Jul 2018 13:03:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 16 Jul 2018 13:03:13 -0700
Received: from [10.26.11.196] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 16 Jul
 2018 20:03:11 +0000
Subject: Re: [PATCH] mmc: tegra: Force correct divider calculation on DDR50/52
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>
CC:     <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <16caa6d0-4368-8931-a77c-23fb76bee200@nvidia.com>
Date:   Mon, 16 Jul 2018 21:03:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/07/18 15:34, Aapo Vienamo wrote:
> Tegra SDHCI controllers require the SDHCI clock divider to be configured
> to divide the clock by two in DDR50/52 modes. Incorrectly configured
> clock divider results in corrupted data.
> 
> Prevent the possibility of incorrectly calculating the divider value due
> to clock rate rounding or low parent clock frequency by not assigning
> host->max_clk to clk_get_rate() on tegra_sdhci_set_clock().
> 
> See the comments for further details.
> 
> Fixes: a8e326a ("mmc: tegra: implement module external clock change")
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index ddf00166..908b23e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -210,9 +210,24 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  	if (!clock)
>  		return sdhci_set_clock(host, clock);
>  
> +	/*
> +	 * In DDR50/52 modes the Tegra SDHCI controllers require the SDHCI 
> +	 * divider to be configured to divided the host clock by two. The SDHC
> +	 * clock divider is calculated as part of sdhci_set_clock() by
> +	 * sdhci_calc_clk(). The divider is calculated from host->max_clk and
> +	 * the requested clock rate.
> +	 *
> +	 * By setting the host->max_clk to clock * 2 the divider calculation
> +	 * will always result in the correct value for DDR50/52 modes,
> +	 * regardless of clock rate rounding, which may happen if the value
> +	 * from clk_get_rate() is used.
> +	 */
>  	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
>  	clk_set_rate(pltfm_host->clk, host_clk);
> -	host->max_clk = clk_get_rate(pltfm_host->clk);
> +	if (tegra_host->ddr_signaling)
> +		host->max_clk = host_clk;
> +	else
> +		host->max_clk = clk_get_rate(pltfm_host->clk);
>  
>  	sdhci_set_clock(host, clock);
>  

I see what you are saying, but should we be concerned that we are not
getting the rate we are requesting in the first place?

Maybe it would help if you could provide a specific example showing a
case where we request rate X and get Y, and then this leads to a bad
rate Z later.
 
Cheers
Jon

-- 
nvpublic
