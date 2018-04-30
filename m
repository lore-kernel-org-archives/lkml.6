Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeD3HqR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:46:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3302 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeD3HqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:46:15 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Apr 2018 00:46:14 -0700
Date: Mon, 30 Apr 2018 10:46:09 +0300
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
Subject: Re: [PATCH v1 2/4] pinctrl: tegra20: Provide CDEV1/2 clock muxes
Message-ID: <20180430074609.GK6835@tbergstrom-lnx.Nvidia.com>
References: <20180426235818.10018-1-digetx@gmail.com>
 <20180426235818.10018-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180426235818.10018-3-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL102.nvidia.com
 (10.26.138.15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 02:58:16AM +0300, Dmitry Osipenko wrote:
> Muxing of pins MCLK1/2 determine the muxing of the corresponding clocks.
> Make pinctrl driver to provide clock muxes for the CDEV1/2 pingroups, so
> that main clk-controller driver could get an actual parent clock for the
> CDEV1/2 clocks.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c   | 11 ---------
>  drivers/pinctrl/tegra/pinctrl-tegra.h   | 11 +++++++++
>  drivers/pinctrl/tegra/pinctrl-tegra20.c | 30 ++++++++++++++++++++++++-
>  3 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
> index 72c718e66ebb..49c7c1499bc3 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -33,17 +33,6 @@
>  #include "../pinctrl-utils.h"
>  #include "pinctrl-tegra.h"
>  
> -struct tegra_pmx {
> -	struct device *dev;
> -	struct pinctrl_dev *pctl;
> -
> -	const struct tegra_pinctrl_soc_data *soc;
> -	const char **group_pins;
> -
> -	int nbanks;
> -	void __iomem **regs;
> -};
> -
>  static inline u32 pmx_readl(struct tegra_pmx *pmx, u32 bank, u32 reg)
>  {
>  	return readl(pmx->regs[bank] + reg);
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
> index 33b17cb1471e..aa33c20766c4 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.h
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
> @@ -16,6 +16,17 @@
>  #ifndef __PINMUX_TEGRA_H__
>  #define __PINMUX_TEGRA_H__
>  
> +struct tegra_pmx {
> +	struct device *dev;
> +	struct pinctrl_dev *pctl;
> +
> +	const struct tegra_pinctrl_soc_data *soc;
> +	const char **group_pins;
> +
> +	int nbanks;
> +	void __iomem **regs;
> +};
> +
>  enum tegra_pinconf_param {
>  	/* argument: tegra_pinconf_pull */
>  	TEGRA_PINCONF_PARAM_PULL,
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
> index 7e38ee9bae78..f31e39d797f9 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
> @@ -19,6 +19,7 @@
>   * more details.
>   */
>  
> +#include <linux/clk-provider.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -2231,9 +2232,36 @@ static const struct tegra_pinctrl_soc_data tegra20_pinctrl = {
>  	.drvtype_in_mux = false,
>  };
>  
> +static const char *cdev1_parents[4] = {

No need to have 4 here, just cdev1_parents[] will do. 

> +	"cdev1_osc_div", "pll_a_out0", "pll_m_out1", "audio",
> +};
> +
> +static const char *cdev2_parents[4] = {
> +	"cdev2_osc_div", "hclk", "pclk", "pll_p_out4",
> +};
> +

Same here.

> +static void tegra20_pinctrl_register_clock_muxes(struct platform_device *pdev)
> +{
> +	struct tegra_pmx *pmx = platform_get_drvdata(pdev);
> +
> +	clk_register_mux(NULL, "cdev1_mux", cdev1_parents, 4, 0,
> +			 pmx->regs[1] + 0x8, 2, 2, CLK_MUX_READ_ONLY, NULL);
> +
> +	clk_register_mux(NULL, "cdev2_mux", cdev2_parents, 4, 0,
> +			 pmx->regs[1] + 0x8, 4, 2, CLK_MUX_READ_ONLY, NULL);
> +}
> +
>  static int tegra20_pinctrl_probe(struct platform_device *pdev)
>  {
> -	return tegra_pinctrl_probe(pdev, &tegra20_pinctrl);
> +	int err;
> +
> +	err = tegra_pinctrl_probe(pdev, &tegra20_pinctrl);
> +	if (err)
> +		return err;
> +
> +	tegra20_pinctrl_register_clock_muxes(pdev);
> +
> +	return 0;
>  }
>  
>  static const struct of_device_id tegra20_pinctrl_of_match[] = {

Apart from these nitpicks:

Acked-By:  Peter De Schrijver <pdeschrijver@nvidia.com>
