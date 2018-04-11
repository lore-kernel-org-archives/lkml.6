Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDKJH4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:07:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6722 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeDKJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:07:53 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Apr 2018 02:07:52 -0700
Subject: Re: [PATCH v2 4/5] soc/tegra: pmc: Use of_clk_get_parent_count()
 instead of open coding
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-5-git-send-email-geert+renesas@glider.be>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a96706de-f680-7ef2-53fd-d2cf07b6061b@nvidia.com>
Date: Wed, 11 Apr 2018 10:07:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523364701-15383-5-git-send-email-geert+renesas@glider.be>
X-Originating-IP: [10.21.132.129]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/04/18 13:51, Geert Uytterhoeven wrote:
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a very big number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH v2 1/5] clk: Extract OF clock helpers in
> <linux/of_clk.h>".
> 
> v2:
>   - of_clk_get_parent_count() was moved to <linux/of_clk.h>.
> ---
>  drivers/soc/tegra/pmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index d9fcdb592b3966a5..d8cb48a4b8eb1b78 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -31,6 +31,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_clk.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -725,7 +726,7 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
>  	unsigned int i, count;
>  	int err;
>  
> -	count = of_count_phandle_with_args(np, "clocks", "#clock-cells");
> +	count = of_clk_get_parent_count(np);
>  	if (count == 0)
>  		return -ENODEV;
>  
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
