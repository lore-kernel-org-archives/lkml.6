Return-Path: <jonathanh@nvidia.com>
X-Google-Smtp-Source: AH8x225ORe5zOKDhPCq8HIs6IHf3ewI1UbHSvzhw1jowdEO/eUjQ83Dk+J+2lSnDK71qfl6N2OHk
ARC-Seal: i=1; a=rsa-sha256; t=1518530095; cv=none;
        d=google.com; s=arc-20160816;
        b=T+odgv6lY5W82S8QKPG8/cOm3Z4H4nhpM2oXwBB/uzKVAlXZz1unwIbWHLsTLCZm+p
         HsCgYQiCAgRekDBPYbHCwRmIf94AUsZwAnydnz2ufR35SJ0tZ4TPkwPP19KaAYMDklRg
         TPGEGZ7TKQxaUxNouMxOV1KfK+Hd5teC7PG0ycPkEmG7CuKoijHGNY8BggkgY17NeOkA
         fAMuP2ZlSIUFmyVi6Tcy/tVQlISyAyLwctEDHuHEllExbmepbqqR85YLww37SYW5DgXz
         dHakCMlUI4+VMayMbI8JpZeVtGIQCjMfk/YLiJ+lCmDiBIQCAPuXlYENxHuNCrc0zQu7
         g7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=20lIa7AeRjoHmio+4PnJjUwtzW6J8pC+Vtz+jmjHx5c=;
        b=KFuxqQX4S+dQNR2iH8UMz5tBG1lsm3W4Xo0LGMR8HefDLlXFbNCW2UcXrUti3sdBtE
         DNZUcivcgxTY8UvivRSTsUfafo5/V4SfabTQQbUchR5Yys0vmf/THlwb6W6drSAvIs9R
         xeYEr1d7v4uY6o229wvZx1+a0bDXFCl2gJD1hQ75EgTnd4AwO7doHFUrALmRIlikRTmP
         /imOLSVVjNzoLlh94wCWVxUD0RGArsVR3Al+wgbtpTVFulj6wKJndgqtvyQK6gd6UbCp
         RkWnmSx8U4PV04I8PGlSTfmQvsvHQ5tZju4C4DPLnatAGEdwsIvLpNafMmZ3FCwOa1fv
         kcxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 13 Feb 2018 05:54:54 -0800
Subject: Re: [PATCH v6 4/4] soc/tegra: pmc: Use the new reset APIs to manage
 reset controllers
To: Philipp Zabel <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>
CC: Vivek Gautam <vivek.gautam@codeaurora.org>, Felipe Balbi
	<balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Thierry
 Reding" <treding@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20170619143408.15668-1-p.zabel@pengutronix.de>
 <20170619143408.15668-5-p.zabel@pengutronix.de>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <90ef269d-cb8f-414f-ad56-faa933ad2e8a@nvidia.com>
Date: Tue, 13 Feb 2018 13:54:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20170619143408.15668-5-p.zabel@pengutronix.de>
X-Originating-IP: [10.21.132.129]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1568095321375522325?=
X-GMAIL-MSGID: =?utf-8?q?1592294213184604030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 19/06/17 15:34, Philipp Zabel wrote:
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
> Make use of of_reset_control_array_get_exclusive() to manage
> an array of reset controllers available with the device.
> 
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> [p.zabel@pengutronix.de: switch to hidden reset control array]
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since v5: updated commit message, added missing SoB
> ---
>  drivers/soc/tegra/pmc.c | 82 ++++++++++++-------------------------------------
>  1 file changed, 20 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index e233dd5dcab3d..749b218147a19 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -124,8 +124,7 @@ struct tegra_powergate {
>  	unsigned int id;
>  	struct clk **clks;
>  	unsigned int num_clks;
> -	struct reset_control **resets;
> -	unsigned int num_resets;
> +	struct reset_control *reset;
>  };
>  
>  struct tegra_io_pad_soc {
> @@ -348,32 +347,14 @@ static int tegra_powergate_enable_clocks(struct tegra_powergate *pg)
>  	return err;
>  }
>  
> -static int tegra_powergate_reset_assert(struct tegra_powergate *pg)
> +static inline int tegra_powergate_reset_assert(struct tegra_powergate *pg)
>  {
> -	unsigned int i;
> -	int err;
> -
> -	for (i = 0; i < pg->num_resets; i++) {
> -		err = reset_control_assert(pg->resets[i]);
> -		if (err)
> -			return err;
> -	}
> -
> -	return 0;
> +	return reset_control_assert(pg->reset);
>  }
>  
> -static int tegra_powergate_reset_deassert(struct tegra_powergate *pg)
> +static inline int tegra_powergate_reset_deassert(struct tegra_powergate *pg)
>  {
> -	unsigned int i;
> -	int err;
> -
> -	for (i = 0; i < pg->num_resets; i++) {
> -		err = reset_control_deassert(pg->resets[i]);
> -		if (err)
> -			return err;
> -	}
> -
> -	return 0;
> +	return reset_control_deassert(pg->reset);
>  }
>  
>  static int tegra_powergate_power_up(struct tegra_powergate *pg,
> @@ -566,8 +547,7 @@ int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
>  	pg.id = id;
>  	pg.clks = &clk;
>  	pg.num_clks = 1;
> -	pg.resets = &rst;
> -	pg.num_resets = 1;
> +	pg.reset = IS_ERR(rst) ? NULL : rst;
>  
>  	err = tegra_powergate_power_up(&pg, false);
>  	if (err)
> @@ -755,45 +735,26 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
>  static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
>  					 struct device_node *np, bool off)
>  {
> -	struct reset_control *rst;
> -	unsigned int i, count;
>  	int err;
>  
> -	count = of_count_phandle_with_args(np, "resets", "#reset-cells");
> -	if (count == 0)
> -		return -ENODEV;
> -
> -	pg->resets = kcalloc(count, sizeof(rst), GFP_KERNEL);
> -	if (!pg->resets)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < count; i++) {
> -		pg->resets[i] = of_reset_control_get_by_index(np, i);
> -		if (IS_ERR(pg->resets[i])) {
> -			err = PTR_ERR(pg->resets[i]);
> -			goto error;
> -		}
> -
> -		if (off)
> -			err = reset_control_assert(pg->resets[i]);
> -		else
> -			err = reset_control_deassert(pg->resets[i]);
> -
> -		if (err) {
> -			reset_control_put(pg->resets[i]);
> -			goto error;
> -		}
> +	pg->reset = of_reset_control_array_get_exclusive(np);
> +	if (IS_ERR(pg->reset)) {
> +		pr_err("failed to get device resets\n");
> +		return PTR_ERR(pg->reset);
>  	}
>  
> -	pg->num_resets = count;
> +	if (off)
> +		err = reset_control_assert(pg->reset);
> +	else
> +		err = reset_control_deassert(pg->reset);
>  
> -	return 0;
> +	if (err)
> +		goto put_reset;
>  
> -error:
> -	while (i--)
> -		reset_control_put(pg->resets[i]);
> +	return 0;
>  
> -	kfree(pg->resets);
> +put_reset:
> +	reset_control_put(pg->reset);
>  
>  	return err;
>  }
> @@ -885,10 +846,7 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
>  	pm_genpd_remove(&pg->genpd);
>  
>  remove_resets:
> -	while (pg->num_resets--)
> -		reset_control_put(pg->resets[pg->num_resets]);
> -
> -	kfree(pg->resets);
> +	reset_control_put(pg->reset);
>  
>  remove_clks:
>  	while (pg->num_clks--)
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
