Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932880AbeCMLdB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:33:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41900 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932503AbeCMLc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:32:59 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>,
        Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH] clk: mvebu: cp110: Fix clock tree representation
References: <20180228140751.10819-1-gregory.clement@bootlin.com>
Date: Tue, 13 Mar 2018 12:32:47 +0100
In-Reply-To: <20180228140751.10819-1-gregory.clement@bootlin.com> (Gregory
        CLEMENT's message of "Wed, 28 Feb 2018 15:07:51 +0100")
Message-ID: <87bmfs1a8w.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
 On mer., févr. 28 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Thanks to new documentation, we have a better view of the clock tree.
> There were few mistakes in the first version of this driver, the main one
> being the parental link between the clocks. Actually the tree is more
> flat that we though. Most of the IP blocks require two clocks: one for
> the IP itself and one for accessing the registers, and unlike what we
> wrote there is no link between these two clocks.
>
> The other mistakes were about the name of the clocks: the root clock is
> not the Audio PLL but the PLL0, and what we called the EIP clock is named
> the x2 Core clock and is used by other IP block than the EIP ones.

Do you have any feedback on this patch?

I would like to have time to address them if you have any remark.

Else do you want a Pull Request or could you apply it directly?

The only other patch around the mvebu clocks was set a few days ago [1]
and seems to be eventually a fix patch. That means that there would be
only one patch in the Pull Request for 4.17, but I can do it if you
prefer.

Thanks,

Gregory

[1]: "[PATCH] clk: mvebu: armada-38x: add support for missing clocks"
https://lkml.org/lkml/2018/3/8/812


>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/clk/mvebu/cp110-system-controller.c | 94 ++++++++++++-----------------
>  1 file changed, 39 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
> index ca9a0a536174..75bf7b8f282f 100644
> --- a/drivers/clk/mvebu/cp110-system-controller.c
> +++ b/drivers/clk/mvebu/cp110-system-controller.c
> @@ -13,18 +13,17 @@
>  /*
>   * CP110 has 6 core clocks:
>   *
> - *  - APLL		(1 Ghz)
> - *    - PPv2 core	(1/3 APLL)
> - *    - EIP		(1/2 APLL)
> - *     - Core		(1/2 EIP)
> - *    - SDIO		(2/5 APLL)
> + *  - PLL0		(1 Ghz)
> + *    - PPv2 core	(1/3 PLL0)
> + *    - x2 Core		(1/2 PLL0)
> + *	- Core		(1/2 x2 Core)
> + *    - SDIO		(2/5 PLL0)
>   *
>   *  - NAND clock, which is either:
>   *    - Equal to SDIO clock
> - *    - 2/5 APLL
> + *    - 2/5 PLL0
>   *
> - * CP110 has 32 gatable clocks, for the various peripherals in the
> - * IP. They have fairly complicated parent/child relationships.
> + * CP110 has 32 gatable clocks, for the various peripherals in the IP.
>   */
>  
>  #define pr_fmt(fmt) "cp110-system-controller: " fmt
> @@ -53,9 +52,9 @@ enum {
>  #define CP110_CLK_NUM \
>  	(CP110_MAX_CORE_CLOCKS + CP110_MAX_GATABLE_CLOCKS)
>  
> -#define CP110_CORE_APLL			0
> +#define CP110_CORE_PLL0			0
>  #define CP110_CORE_PPV2			1
> -#define CP110_CORE_EIP			2
> +#define CP110_CORE_X2CORE		2
>  #define CP110_CORE_CORE			3
>  #define CP110_CORE_NAND			4
>  #define CP110_CORE_SDIO			5
> @@ -237,7 +236,7 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
>  	struct regmap *regmap;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> -	const char *ppv2_name, *apll_name, *core_name, *eip_name, *nand_name,
> +	const char *ppv2_name, *pll0_name, *core_name, *x2core_name, *nand_name,
>  		*sdio_name;
>  	struct clk_hw_onecell_data *cp110_clk_data;
>  	struct clk_hw *hw, **cp110_clks;
> @@ -263,20 +262,20 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
>  	cp110_clks = cp110_clk_data->hws;
>  	cp110_clk_data->num = CP110_CLK_NUM;
>  
> -	/* Register the APLL which is the root of the hw tree */
> -	apll_name = cp110_unique_name(dev, syscon_node, "apll");
> -	hw = clk_hw_register_fixed_rate(NULL, apll_name, NULL, 0,
> +	/* Register the PLL0 which is the root of the hw tree */
> +	pll0_name = cp110_unique_name(dev, syscon_node, "pll0");
> +	hw = clk_hw_register_fixed_rate(NULL, pll0_name, NULL, 0,
>  					1000 * 1000 * 1000);
>  	if (IS_ERR(hw)) {
>  		ret = PTR_ERR(hw);
> -		goto fail_apll;
> +		goto fail_pll0;
>  	}
>  
> -	cp110_clks[CP110_CORE_APLL] = hw;
> +	cp110_clks[CP110_CORE_PLL0] = hw;
>  
> -	/* PPv2 is APLL/3 */
> +	/* PPv2 is PLL0/3 */
>  	ppv2_name = cp110_unique_name(dev, syscon_node, "ppv2-core");
> -	hw = clk_hw_register_fixed_factor(NULL, ppv2_name, apll_name, 0, 1, 3);
> +	hw = clk_hw_register_fixed_factor(NULL, ppv2_name, pll0_name, 0, 1, 3);
>  	if (IS_ERR(hw)) {
>  		ret = PTR_ERR(hw);
>  		goto fail_ppv2;
> @@ -284,30 +283,32 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
>  
>  	cp110_clks[CP110_CORE_PPV2] = hw;
>  
> -	/* EIP clock is APLL/2 */
> -	eip_name = cp110_unique_name(dev, syscon_node, "eip");
> -	hw = clk_hw_register_fixed_factor(NULL, eip_name, apll_name, 0, 1, 2);
> +	/* X2CORE clock is PLL0/2 */
> +	x2core_name = cp110_unique_name(dev, syscon_node, "x2core");
> +	hw = clk_hw_register_fixed_factor(NULL, x2core_name, pll0_name,
> +					  0, 1, 2);
>  	if (IS_ERR(hw)) {
>  		ret = PTR_ERR(hw);
>  		goto fail_eip;
>  	}
>  
> -	cp110_clks[CP110_CORE_EIP] = hw;
> +	cp110_clks[CP110_CORE_X2CORE] = hw;
>  
> -	/* Core clock is EIP/2 */
> +	/* Core clock is X2CORE/2 */
>  	core_name = cp110_unique_name(dev, syscon_node, "core");
> -	hw = clk_hw_register_fixed_factor(NULL, core_name, eip_name, 0, 1, 2);
> +	hw = clk_hw_register_fixed_factor(NULL, core_name, x2core_name,
> +					  0, 1, 2);
>  	if (IS_ERR(hw)) {
>  		ret = PTR_ERR(hw);
>  		goto fail_core;
>  	}
>  
>  	cp110_clks[CP110_CORE_CORE] = hw;
> -	/* NAND can be either APLL/2.5 or core clock */
> +	/* NAND can be either PLL0/2.5 or core clock */
>  	nand_name = cp110_unique_name(dev, syscon_node, "nand-core");
>  	if (nand_clk_ctrl & NF_CLOCK_SEL_400_MASK)
>  		hw = clk_hw_register_fixed_factor(NULL, nand_name,
> -						   apll_name, 0, 2, 5);
> +						   pll0_name, 0, 2, 5);
>  	else
>  		hw = clk_hw_register_fixed_factor(NULL, nand_name,
>  						   core_name, 0, 1, 1);
> @@ -318,10 +319,10 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
>  
>  	cp110_clks[CP110_CORE_NAND] = hw;
>  
> -	/* SDIO clock is APLL/2.5 */
> +	/* SDIO clock is PLL0/2.5 */
>  	sdio_name = cp110_unique_name(dev, syscon_node, "sdio-core");
>  	hw = clk_hw_register_fixed_factor(NULL, sdio_name,
> -					  apll_name, 0, 2, 5);
> +					  pll0_name, 0, 2, 5);
>  	if (IS_ERR(hw)) {
>  		ret = PTR_ERR(hw);
>  		goto fail_sdio;
> @@ -341,40 +342,23 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
>  			continue;
>  
>  		switch (i) {
> -		case CP110_GATE_AUDIO:
> -		case CP110_GATE_COMM_UNIT:
> -		case CP110_GATE_EIP150:
> -		case CP110_GATE_EIP197:
> -		case CP110_GATE_SLOW_IO:
> -			parent = gate_name[CP110_GATE_MAIN];
> -			break;
> -		case CP110_GATE_MG:
> -			parent = gate_name[CP110_GATE_MG_CORE];
> -			break;
>  		case CP110_GATE_NAND:
>  			parent = nand_name;
>  			break;
> +		case CP110_GATE_MG:
> +		case CP110_GATE_GOP_DP:
>  		case CP110_GATE_PPV2:
>  			parent = ppv2_name;
>  			break;
>  		case CP110_GATE_SDIO:
>  			parent = sdio_name;
>  			break;
> -		case CP110_GATE_GOP_DP:
> -			parent = gate_name[CP110_GATE_SDMMC_GOP];
> -			break;
> -		case CP110_GATE_XOR1:
> -		case CP110_GATE_XOR0:
> -		case CP110_GATE_PCIE_X1_0:
> -		case CP110_GATE_PCIE_X1_1:
> +		case CP110_GATE_MAIN:
> +		case CP110_GATE_PCIE_XOR:
>  		case CP110_GATE_PCIE_X4:
> -			parent = gate_name[CP110_GATE_PCIE_XOR];
> -			break;
> -		case CP110_GATE_SATA:
> -		case CP110_GATE_USB3H0:
> -		case CP110_GATE_USB3H1:
> -		case CP110_GATE_USB3DEV:
> -			parent = gate_name[CP110_GATE_SATA_USB];
> +		case CP110_GATE_EIP150:
> +		case CP110_GATE_EIP197:
> +			parent = x2core_name;
>  			break;
>  		default:
>  			parent = core_name;
> @@ -413,12 +397,12 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
>  fail_nand:
>  	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_CORE]);
>  fail_core:
> -	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_EIP]);
> +	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_X2CORE]);
>  fail_eip:
>  	clk_hw_unregister_fixed_factor(cp110_clks[CP110_CORE_PPV2]);
>  fail_ppv2:
> -	clk_hw_unregister_fixed_rate(cp110_clks[CP110_CORE_APLL]);
> -fail_apll:
> +	clk_hw_unregister_fixed_rate(cp110_clks[CP110_CORE_PLL0]);
> +fail_pll0:
>  	return ret;
>  }
>  
> -- 
> 2.16.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
