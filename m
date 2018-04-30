Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeD3HtC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:49:02 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3359 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeD3Hs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:48:59 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 30 Apr 2018 00:48:56 -0700
Date: Mon, 30 Apr 2018 10:48:54 +0300
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Dmitry Osipenko <digetx@gmail.com>
CC: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] clk: tegra20: Add DEV1/DEV2 OSC dividers
Message-ID: <20180430074854.GM6835@tbergstrom-lnx.Nvidia.com>
References: <20180426235818.10018-1-digetx@gmail.com>
 <20180426235818.10018-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180426235818.10018-2-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL102.nvidia.com
 (10.26.138.15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 02:58:15AM +0300, Dmitry Osipenko wrote:
> CDEV1/CDEV2 clocks could have corresponding oscillator clock divider as
> a parent. Add these dividers in order to be able to provide that parent
> option.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index 0ee56dd04cec..16cf4108f2ff 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -26,6 +26,8 @@
>  #include "clk.h"
>  #include "clk-id.h"
>  
> +#define MISC_CLK_ENB 0x48
> +
>  #define OSC_CTRL 0x50
>  #define OSC_CTRL_OSC_FREQ_MASK (3<<30)
>  #define OSC_CTRL_OSC_FREQ_13MHZ (0<<30)
> @@ -831,6 +833,16 @@ static void __init tegra20_periph_clk_init(void)
>  				    periph_clk_enb_refcnt);
>  	clks[TEGRA20_CLK_PEX] = clk;
>  
> +	/* cdev1 OSC divider */
> +	clk_register_divider(NULL, "cdev1_osc_div", "clk_m",
> +			     0, clk_base + MISC_CLK_ENB, 20, 2,
> +			     CLK_DIVIDER_POWER_OF_TWO, NULL);
> +

I don't know if this divider can be changed glitchlessly so to be safe,
I would mark this readonly, so add the CLK_DIVIDER_READ_ONLY flag.

> +	/* cdev2 OSC divider */
> +	clk_register_divider(NULL, "cdev2_osc_div", "clk_m",
> +			     0, clk_base + MISC_CLK_ENB, 22, 2,
> +			     CLK_DIVIDER_POWER_OF_TWO, NULL);
> +
>  	/* cdev1 */
>  	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL, 0, 26000000);
>  	clk = tegra_clk_register_periph_gate("cdev1", "cdev1_fixed", 0,
> -- 
> 2.17.0
> 

Peter.
