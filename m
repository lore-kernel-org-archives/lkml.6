Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeEONnv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:43:51 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:27891 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeEONns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:43:48 -0400
Subject: Re: [PATCH v10 03/27] clk: davinci: psc: allow for dev == NULL
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-4-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <2f1056b3-6d29-0651-1d7d-9c74cd50861c@ti.com>
Date: Tue, 15 May 2018 19:12:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509172606.29387-4-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
> @@ -261,10 +263,14 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
>  	lpsc->pd = pd;
>  	lpsc->flags = flags;
>  
> -	ret = devm_clk_hw_register(dev, &lpsc->hw);
> +	ret = clk_hw_register(dev, &lpsc->hw);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
>  
> +	/* for now, genpd is only registered when using device-tree */
> +	if (!dev || !dev->of_node)
> +		return lpsc;
> +
>  	/* genpd attach needs a way to look up this clock */
>  	ret = clk_hw_register_clkdev(&lpsc->hw, name, best_dev_name(dev));
>  
> @@ -378,11 +384,11 @@ __davinci_psc_register_clocks(struct device *dev,
>  	struct regmap *regmap;
>  	int i, ret;
>  
> -	psc = devm_kzalloc(dev, sizeof(*psc), GFP_KERNEL);
> +	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
>  	if (!psc)
>  		return ERR_PTR(-ENOMEM);
>  
> -	clks = devm_kmalloc_array(dev, num_clks, sizeof(*clks), GFP_KERNEL);
> +	clks = kmalloc_array(num_clks, sizeof(*clks), GFP_KERNEL);
>  	if (!clks)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -396,14 +402,14 @@ __davinci_psc_register_clocks(struct device *dev,
>  	for (i = 0; i < num_clks; i++)
>  		clks[i] = ERR_PTR(-ENOENT);
>  
> -	pm_domains = devm_kcalloc(dev, num_clks, sizeof(*pm_domains), GFP_KERNEL);
> +	pm_domains = kcalloc(num_clks, sizeof(*pm_domains), GFP_KERNEL);
>  	if (!pm_domains)
>  		return ERR_PTR(-ENOMEM);
>  
>  	psc->pm_data.domains = pm_domains;
>  	psc->pm_data.num_domains = num_clks;
>  
> -	regmap = devm_regmap_init_mmio(dev, base, &davinci_psc_regmap_config);
> +	regmap = regmap_init_mmio(dev, base, &davinci_psc_regmap_config);
>  	if (IS_ERR(regmap))
>  		return ERR_CAST(regmap);

Here and in the PLL driver, you have dropped the devm_* variants (like
agreed upon), but not added any error path handling. For the clocks
needed for boot, its probably fine, but the same code path is used for
non-essential clocks too. Just from a code completeness perspective, it
will be nice to see the error path correctly handled.

Apart from that both 1/27 and 3/27 look good to me.

Thanks,
Sekhar
