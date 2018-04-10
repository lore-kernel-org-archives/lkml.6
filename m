Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbeDJNco (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:32:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45286 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbeDJNcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:32:39 -0400
X-Google-Smtp-Source: AIpwx4+mQZkM2bcAb8KqvVacdCjz/WpElTUqrnIsUZFVf2smY/gVmlNqpA/hRCGvS88pwhsDOaBluA==
Date: Tue, 10 Apr 2018 15:32:36 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: renesas: rcar-gen2: Centralize quirks handling
Message-ID: <20180410133236.GU12256@bigcity.dyn.berto.se>
References: <1523365498-16789-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523365498-16789-1-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2018-04-10 15:04:58 +0200, Geert Uytterhoeven wrote:
> Introduce centralized quirks handling like on R-Car Gen3, and convert
> the RZ/G1C SD clock table handling over to it.
> 
> This makes it easier to add more quirks later, if/when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> To be queued in clk-renesas-for-v4.18.
> 
>  drivers/clk/renesas/rcar-gen2-cpg.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/renesas/rcar-gen2-cpg.c b/drivers/clk/renesas/rcar-gen2-cpg.c
> index 0c49f59d5074b1c4..daf88bc2cdae177b 100644
> --- a/drivers/clk/renesas/rcar-gen2-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen2-cpg.c
> @@ -261,9 +261,15 @@ static const struct clk_div_table cpg_sd01_div_table[] = {
>  static const struct rcar_gen2_cpg_pll_config *cpg_pll_config __initdata;
>  static unsigned int cpg_pll0_div __initdata;
>  static u32 cpg_mode __initdata;
> +static u32 cpg_quirks __initdata;
>  
> -static const struct soc_device_attribute soc_r8a77470[] = {
> -	{ .soc_id = "r8a77470" },
> +#define SD_SKIP_FIRST	BIT(0)		/* Skip first clock in SD table */
> +
> +static const struct soc_device_attribute cpg_quirks_match[] __initconst = {
> +	{
> +		.soc_id = "r8a77470",
> +		.data = (void *)SD_SKIP_FIRST,
> +	},
>  	{ /* sentinel */ }
>  };
>  
> @@ -333,7 +339,7 @@ struct clk * __init rcar_gen2_cpg_clk_register(struct device *dev,
>  
>  	case CLK_TYPE_GEN2_SD0:
>  		table = cpg_sd01_div_table;
> -		if (soc_device_match(soc_r8a77470))
> +		if (cpg_quirks & SD_SKIP_FIRST)
>  			table++;
>  
>  		shift = 4;
> @@ -341,7 +347,7 @@ struct clk * __init rcar_gen2_cpg_clk_register(struct device *dev,
>  
>  	case CLK_TYPE_GEN2_SD1:
>  		table = cpg_sd01_div_table;
> -		if (soc_device_match(soc_r8a77470))
> +		if (cpg_quirks & SD_SKIP_FIRST)
>  			table++;
>  
>  		shift = 0;
> @@ -372,9 +378,15 @@ struct clk * __init rcar_gen2_cpg_clk_register(struct device *dev,
>  int __init rcar_gen2_cpg_init(const struct rcar_gen2_cpg_pll_config *config,
>  			      unsigned int pll0_div, u32 mode)
>  {
> +	const struct soc_device_attribute *attr;
> +
>  	cpg_pll_config = config;
>  	cpg_pll0_div = pll0_div;
>  	cpg_mode = mode;
> +	attr = soc_device_match(cpg_quirks_match);
> +	if (attr)
> +		cpg_quirks = (uintptr_t)attr->data;
> +	pr_debug("%s: mode = 0x%x quirks = 0x%x\n", __func__, mode, cpg_quirks);
>  
>  	spin_lock_init(&cpg_lock);
>  
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
