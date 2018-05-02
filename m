Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeEBHiW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeEBHiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:38:19 -0400
Date: Wed, 2 May 2018 15:38:08 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>, Jacky Bai <ping.bai@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Message-ID: <20180502073807.GE3443@dragon>
References: <20180418124908.3079-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418124908.3079-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

Do you see this problem on i.MX6 ULL?  What's your take on Stefan's fix?

Shawn

On Wed, Apr 18, 2018 at 02:49:08PM +0200, Stefan Agner wrote:
> On i.MX6 ULL using PLL3 seems to cause a freeze when setting
> the parent to IMX6UL_CLK_PLL3_USB_OTG. This only seems to appear
> since commit 6f9575e55632 ("clk: imx: Add CLK_IS_CRITICAL flag
> for busy divider and busy mux"), probably because the clock is
> now forced to be on.
> 
> Fixes: 6f9575e55632("clk: imx: Add CLK_IS_CRITICAL flag for busy divider and busy mux")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> This addresses a regression ssen on v4.17-rc1 where the kernel
> boots during clock initialization, see also:
> https://patchwork.kernel.org/patch/10295927/
> 
>  drivers/clk/imx/clk-imx6ul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index 114ecbb94ec5..12320118f8de 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -464,7 +464,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  	clk_set_rate(clks[IMX6UL_CLK_AHB], 99000000);
>  
>  	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
> -	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL], clks[IMX6UL_CLK_PLL3_USB_OTG]);
> +	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL], clks[IMX6UL_CLK_OSC]);
>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_CLK2]);
>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH_PRE], clks[IMX6UL_CLK_PLL2_BUS]);
>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_PRE]);
> -- 
> 2.17.0
> 
