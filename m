Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755122AbeCSBdN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:33:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40526 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbeCSBdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:33:10 -0400
X-Google-Smtp-Source: AG47ELtARb3rHigxOlWMsiaFT5hapOZ9dv0g0xmKy+CRa7HARpllmRLxSw87m6drJ5QIkssUlQcApw==
Subject: Re: [PATCH v2 2/5] soc: mediatek: update power domain data of MT2712
To: Weiyi Lu <weiyi.lu@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
Cc: James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
 <20180312070342.4335-4-weiyi.lu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <dda77bd3-cbf2-1954-bc52-7f851ec4844f@gmail.com>
Date: Mon, 19 Mar 2018 02:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312070342.4335-4-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/12/2018 08:03 AM, Weiyi Lu wrote:
> 1. split MFG power domain into MFG/MFG_SC1/MFG_SC2/MFG_SC3
> according to MT2712 ECO design change
> 2. add subdomain support for MT2712
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Pushed to v4.16-next/soc

Thanks!

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 42 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 59bd749c2f25..edf8fd6c2c85 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -664,12 +664,48 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.name = "mfg",
>  		.sta_mask = PWR_STATUS_MFG,
>  		.ctl_offs = SPM_MFG_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(19, 16),
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(16, 16),
>  		.clk_id = {CLK_MFG},
>  		.bus_prot_mask = BIT(14) | BIT(21) | BIT(23),
>  		.active_wakeup = true,
>  	},
> +	[MT2712_POWER_DOMAIN_MFG_SC1] = {
> +		.name = "mfg_sc1",
> +		.sta_mask = BIT(22),
> +		.ctl_offs = 0x02c0,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(16, 16),
> +		.clk_id = {CLK_NONE},
> +		.active_wakeup = true,
> +	},
> +	[MT2712_POWER_DOMAIN_MFG_SC2] = {
> +		.name = "mfg_sc2",
> +		.sta_mask = BIT(23),
> +		.ctl_offs = 0x02c4,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(16, 16),
> +		.clk_id = {CLK_NONE},
> +		.active_wakeup = true,
> +	},
> +	[MT2712_POWER_DOMAIN_MFG_SC3] = {
> +		.name = "mfg_sc3",
> +		.sta_mask = BIT(30),
> +		.ctl_offs = 0x01f8,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(16, 16),
> +		.clk_id = {CLK_NONE},
> +		.active_wakeup = true,
> +	},
> +};
> +
> +static const struct scp_subdomain scp_subdomain_mt2712[] = {
> +	{MT2712_POWER_DOMAIN_MM, MT2712_POWER_DOMAIN_VDEC},
> +	{MT2712_POWER_DOMAIN_MM, MT2712_POWER_DOMAIN_VENC},
> +	{MT2712_POWER_DOMAIN_MM, MT2712_POWER_DOMAIN_ISP},
> +	{MT2712_POWER_DOMAIN_MFG, MT2712_POWER_DOMAIN_MFG_SC1},
> +	{MT2712_POWER_DOMAIN_MFG_SC1, MT2712_POWER_DOMAIN_MFG_SC2},
> +	{MT2712_POWER_DOMAIN_MFG_SC2, MT2712_POWER_DOMAIN_MFG_SC3},
>  };
>  
>  /*
> @@ -905,6 +941,8 @@ static const struct scp_soc_data mt2701_data = {
>  static const struct scp_soc_data mt2712_data = {
>  	.domains = scp_domain_data_mt2712,
>  	.num_domains = ARRAY_SIZE(scp_domain_data_mt2712),
> +	.subdomains = scp_subdomain_mt2712,
> +	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt2712),
>  	.regs = {
>  		.pwr_sta_offs = SPM_PWR_STATUS,
>  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> 
