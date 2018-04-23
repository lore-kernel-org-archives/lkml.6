Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbeDWGnh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:43:37 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:36397 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbeDWGnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:43:33 -0400
Subject: Re: [PATCH] phy: exynos-mipi-video: Simplify code by using
 regmap_update_bits()
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
References: <CGME20180416161949epcas1p11b738f30a12bd2f62ad9422f7c4e7ed6@epcas1p1.samsung.com>
 <20180416161938.26958-1-s.nawrocki@samsung.com>
CC: <krzk@kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <b.zolnierkie@samsung.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b4eb154e-8acf-1eae-de27-ce3f6a93a47f@ti.com>
Date: Mon, 23 Apr 2018 12:13:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180416161938.26958-1-s.nawrocki@samsung.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 16 April 2018 09:49 PM, Sylwester Nawrocki wrote:
> There is no functional change, just replacing regmap_read()/modify/
> regmap_write() with regmap_update_bits() function calls.

merged, thanks!

-Kishon

> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/phy/samsung/phy-exynos-mipi-video.c | 34 ++++++++++++-----------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos-mipi-video.c b/drivers/phy/samsung/phy-exynos-mipi-video.c
> index c198886f80a3..00d89599c67d 100644
> --- a/drivers/phy/samsung/phy-exynos-mipi-video.c
> +++ b/drivers/phy/samsung/phy-exynos-mipi-video.c
> @@ -231,33 +231,27 @@ struct exynos_mipi_video_phy {
>  static int __set_phy_state(const struct exynos_mipi_phy_desc *data,
>  			   struct exynos_mipi_video_phy *state, unsigned int on)
>  {
> -	u32 val;
> +	struct regmap *enable_map = state->regmaps[data->enable_map];
> +	struct regmap *resetn_map = state->regmaps[data->resetn_map];
>  
>  	spin_lock(&state->slock);
>  
>  	/* disable in PMU sysreg */
>  	if (!on && data->coupled_phy_id >= 0 &&
> -	    state->phys[data->coupled_phy_id].phy->power_count == 0) {
> -		regmap_read(state->regmaps[data->enable_map], data->enable_reg,
> -			    &val);
> -		val &= ~data->enable_val;
> -		regmap_write(state->regmaps[data->enable_map], data->enable_reg,
> -			     val);
> -	}
> -
> +	    state->phys[data->coupled_phy_id].phy->power_count == 0)
> +		regmap_update_bits(enable_map, data->enable_reg,
> +				   data->enable_val, 0);
>  	/* PHY reset */
> -	regmap_read(state->regmaps[data->resetn_map], data->resetn_reg, &val);
> -	val = on ? (val | data->resetn_val) : (val & ~data->resetn_val);
> -	regmap_write(state->regmaps[data->resetn_map], data->resetn_reg, val);
> -
> +	if (on)
> +		regmap_update_bits(resetn_map, data->resetn_reg,
> +				   data->resetn_val, data->resetn_val);
> +	else
> +		regmap_update_bits(resetn_map, data->resetn_reg,
> +				   data->resetn_val, 0);
>  	/* enable in PMU sysreg */
> -	if (on) {
> -		regmap_read(state->regmaps[data->enable_map], data->enable_reg,
> -			    &val);
> -		val |= data->enable_val;
> -		regmap_write(state->regmaps[data->enable_map], data->enable_reg,
> -			     val);
> -	}
> +	if (on)
> +		regmap_update_bits(enable_map, data->enable_reg,
> +				   data->enable_val, data->enable_val);
>  
>  	spin_unlock(&state->slock);
>  
> 
