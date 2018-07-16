Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9645208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UAvU7yUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9645208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeGPKo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:44:28 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60968 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeGPKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LVF5MR3G1OJHNPibGomcG6ohfs68MmufWQ2VeSIX9v0=; b=UAvU7yULDvevclamD5DUJiM32
        5Wy/DusQQXF8wpW2OEbRF2XlqcIQDO+rnD7z50Sk4VqDe83ALQvxA98TpiZE/t0jk0KUe8pXI3pLs
        EdYWlDUSIpW1QUnEyJOD1fqXcVnhYfbQsuBYoDQ6qZQiMdbw2M3glDLhy+T8duHuWL+04=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:51386)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ff0ZO-0003nV-91; Mon, 16 Jul 2018 11:17:30 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1ff0ZL-0004UX-9n; Mon, 16 Jul 2018 11:17:27 +0100
Date:   Mon, 16 Jul 2018 11:17:25 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Tali Perry <tali.perry1@gmail.com>
Cc:     sboyd@kernel.org, brendanhiggins@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, weiyongjunl@huawei.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, raltherr@google.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/1] clk: npcm7xx: get fixed clocks from DT
Message-ID: <20180716101725.GD17271@n2100.armlinux.org.uk>
References: <20180716101007.11721-1-tali.perry1@gmail.com>
 <20180716101007.11721-2-tali.perry1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716101007.11721-2-tali.perry1@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 01:10:07PM +0300, Tali Perry wrote:
> Nuvoton NPCM7XX Clock Controller
> fix base address and of_clk_get_by_name error handling.
>     Also update error messages to be more informative.
>     
>     In case clk_base allocation is erronoeous the return value is null.
>     Also fix handling of of_clk_get_by_name returns an error. 
>     Print a better error message pointing to the dt-binding documention.
> 
> This patch is re-submitted since it was already pushed to main 
> (just the diff, without the full driver which is already in 
> master branch.)
> 
> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> ---
>  drivers/clk/clk-npcm7xx.c | 102 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 87 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
> index 740af90a9508..6ff97f79fcd7 100644
> --- a/drivers/clk/clk-npcm7xx.c
> +++ b/drivers/clk/clk-npcm7xx.c
> @@ -8,17 +8,25 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
> +#include <linux/rational.h>
>  #include <linux/bitfield.h>
> -
>  #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
>  
> +#include <asm/cp15.h>

Why do you need this include?

> +
> +

Why do you need all these additional blank lines in this file, it makes
this diff harder to review.  If you wish to reformat the file, please
split the reformatting out as a separate patch.

Thanks.

>  struct npcm7xx_clk_pll {
>  	struct clk_hw	hw;
>  	void __iomem	*pllcon;
> @@ -27,6 +35,9 @@ struct npcm7xx_clk_pll {
>  
>  #define to_npcm7xx_clk_pll(_hw) container_of(_hw, struct npcm7xx_clk_pll, hw)
>  
> +struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
> +	const char *parent_name, unsigned long flags);
> +
>  #define PLLCON_LOKI	BIT(31)
>  #define PLLCON_LOKS	BIT(30)
>  #define PLLCON_FBDV	GENMASK(27, 16)
> @@ -44,7 +55,8 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
>  	u64 ret;
>  
>  	if (parent_rate == 0) {
> -		pr_err("%s: parent rate is zero", __func__);
> +		pr_err("%s: parent rate is zero. reg=%x\n", __func__,
> +			(u32)(pll->pllcon));
>  		return 0;
>  	}
>  
> @@ -61,13 +73,13 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
>  	return ret;
>  }
>  
> -static const struct clk_ops npcm7xx_clk_pll_ops = {
> +const struct clk_ops npcm7xx_clk_pll_ops = {
>  	.recalc_rate = npcm7xx_clk_pll_recalc_rate,
>  };
>  
> -static struct clk_hw *
> -npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
> -			 const char *parent_name, unsigned long flags)
> +
> +struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
> +	const char *parent_name, unsigned long flags)
>  {
>  	struct npcm7xx_clk_pll *pll;
>  	struct clk_init_data init;
> @@ -78,7 +90,8 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
>  	if (!pll)
>  		return ERR_PTR(-ENOMEM);
>  
> -	pr_debug("%s reg, name=%s, p=%s\n", __func__, name, parent_name);
> +	pr_debug("%s reg, reg=0x%x, name=%s, p=%s\n",
> +		__func__, (unsigned int)pllcon, name, parent_name);
>  
>  	init.name = name;
>  	init.ops = &npcm7xx_clk_pll_ops;
> @@ -100,6 +113,7 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
>  	return hw;
>  }
>  
> +
>  #define NPCM7XX_CLKEN1          (0x00)
>  #define NPCM7XX_CLKEN2          (0x28)
>  #define NPCM7XX_CLKEN3          (0x30)
> @@ -129,6 +143,7 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
>  #define NPCM7XX_SECCNT          (0x68)
>  #define NPCM7XX_CNTR25M         (0x6C)
>  
> +
>  struct npcm7xx_clk_gate_data {
>  	u32 reg;
>  	u8 bit_idx;
> @@ -204,6 +219,7 @@ struct npcm7xx_clk_pll_data {
>  	int onecell_idx;
>  };
>  
> +
>  /*
>   * Single copy of strings used to refer to clocks within this driver indexed by
>   * above enum.
> @@ -255,6 +271,7 @@ struct npcm7xx_clk_pll_data {
>  #define NPCM7XX_CLK_S_USB_BRIDGE  "usb_bridge"
>  #define NPCM7XX_CLK_S_PCI         "pci"
>  
> +
>  static u32 pll_mux_table[] = {0, 1, 2, 3};
>  static const char * const pll_mux_parents[] __initconst = {
>  	NPCM7XX_CLK_S_PLL0,
> @@ -311,6 +328,7 @@ static const char * const dvcssel_mux_parents[] __initconst = {
>  	NPCM7XX_CLK_S_PLL2,
>  };
>  
> +
>  static const struct npcm7xx_clk_pll_data npcm7xx_plls[] __initconst = {
>  	{NPCM7XX_PLLCON0, NPCM7XX_CLK_S_PLL0, NPCM7XX_CLK_S_REFCLK, 0, -1},
>  
> @@ -324,6 +342,7 @@ static const struct npcm7xx_clk_pll_data npcm7xx_plls[] __initconst = {
>  	NPCM7XX_CLK_S_REFCLK, 0, -1},
>  };
>  
> +
>  static const struct npcm7xx_clk_mux_data npcm7xx_muxes[] __initconst = {
>  	{0, GENMASK(1, 0), cpuck_mux_table, NPCM7XX_CLK_S_CPU_MUX,
>  	cpuck_mux_parents, ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL,
> @@ -368,6 +387,7 @@ static const struct npcm7xx_clk_div_fixed_data npcm7xx_divs_fx[] __initconst = {
>  	{ 1, 2, NPCM7XX_CLK_S_PLL2_DIV2, NPCM7XX_CLK_S_PLL2, 0, -1},
>  };
>  
> +
>  /* configurable dividers: */
>  static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
>  	{NPCM7XX_CLKDIV1, 28, 3, NPCM7XX_CLK_S_ADC,
> @@ -435,6 +455,7 @@ static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
>  
>  };
>  
> +
>  static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst = {
>  	{NPCM7XX_CLKEN1, 31, "smb1-gate", NPCM7XX_CLK_S_APB2, 0},
>  	{NPCM7XX_CLKEN1, 30, "smb0-gate", NPCM7XX_CLK_S_APB2, 0},
> @@ -536,17 +557,23 @@ static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst = {
>  	{NPCM7XX_CLKEN3, 0, "pwmm1-gate", NPCM7XX_CLK_S_APB3, 0},
>  };
>  
> +
> +
>  static DEFINE_SPINLOCK(npcm7xx_clk_lock);
>  
> +
>  static void __init npcm7xx_clk_init(struct device_node *clk_np)
>  {
>  	struct clk_hw_onecell_data *npcm7xx_clk_data;
>  	void __iomem *clk_base;
>  	struct resource res;
>  	struct clk_hw *hw;
> +	struct clk *clk;
>  	int ret;
>  	int i;
>  
> +	clk_base = NULL;
> +
>  	ret = of_address_to_resource(clk_np, 0, &res);
>  	if (ret) {
>  		pr_err("%s: failed to get resource, ret %d\n", clk_np->name,
> @@ -554,20 +581,52 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
>  		return;
>  	}
>  
> +
>  	clk_base = ioremap(res.start, resource_size(&res));
>  	if (!clk_base)
>  		goto npcm7xx_init_error;
>  
> +
>  	npcm7xx_clk_data = kzalloc(sizeof(*npcm7xx_clk_data->hws) *
>  		NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL);
> -	if (!npcm7xx_clk_data)
> +
> +	npcm7xx_clk_data->num = 0;
> +
> +	if (!npcm7xx_clk_data->hws) {
> +		pr_err("Can't alloc npcm7xx_clk_data\n");
>  		goto npcm7xx_init_np_err;
> +	}
>  
>  	npcm7xx_clk_data->num = NPCM7XX_NUM_CLOCKS;
>  
>  	for (i = 0; i < NPCM7XX_NUM_CLOCKS; i++)
>  		npcm7xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
>  
> +	/* Read fixed clocks. These 3 clocks must be defined in DT */
> +	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_REFCLK);
> +	if (IS_ERR(clk)) {
> +		pr_err("failed to find external REFCLK on device tree, err=%ld\n",
> +			PTR_ERR(clk));
> +		clk_put(clk);
> +		goto npcm7xx_init_fail_no_clk_on_dt;
> +	}
> +
> +	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_SYSBYPCK);
> +	if (IS_ERR(clk)) {
> +		pr_err("failed to find external SYSBYPCK on device tree, err=%ld\n",
> +			PTR_ERR(clk));
> +		clk_put(clk);
> +		goto npcm7xx_init_fail_no_clk_on_dt;
> +	}
> +
> +	clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_MCBYPCK);
> +	if (IS_ERR(clk)) {
> +		pr_err("failed to find external MCBYPCK on device tree, err=%ld\n",
> +			PTR_ERR(clk));
> +		clk_put(clk);
> +		goto npcm7xx_init_fail_no_clk_on_dt;
> +	}
> +
>  	/* Register plls */
>  	for (i = 0; i < ARRAY_SIZE(npcm7xx_plls); i++) {
>  		const struct npcm7xx_clk_pll_data *pll_data = &npcm7xx_plls[i];
> @@ -584,16 +643,18 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
>  	}
>  
>  	/* Register fixed dividers */
> -	hw = clk_hw_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,
> +	clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,
>  			NPCM7XX_CLK_S_PLL1, 0, 1, 2);
> -	if (IS_ERR(hw)) {
> +	if (IS_ERR(clk)) {
>  		pr_err("npcm7xx_clk: Can't register fixed div\n");
>  		goto npcm7xx_init_fail;
>  	}
>  
> -	hw = clk_hw_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
> +
> +	clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
>  			NPCM7XX_CLK_S_PLL2, 0, 1, 2);
> -	if (IS_ERR(hw)) {
> +
> +	if (IS_ERR(clk)) {
>  		pr_err("npcm7xx_clk: Can't register div2\n");
>  		goto npcm7xx_init_fail;
>  	}
> @@ -618,7 +679,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
>  			npcm7xx_clk_data->hws[mux_data->onecell_idx] = hw;
>  	}
>  
> -	/* Register clock dividers specified in npcm7xx_divs */
> +	/* Register clock dividers specified in npcm7xx_divs. */
>  	for (i = 0; i < ARRAY_SIZE(npcm7xx_divs); i++) {
>  		const struct npcm7xx_clk_div_data *div_data = &npcm7xx_divs[i];
>  
> @@ -642,15 +703,26 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
>  	if (ret)
>  		pr_err("failed to add DT provider: %d\n", ret);
>  
> +
>  	of_node_put(clk_np);
>  
>  	return;
>  
> +npcm7xx_init_fail_no_clk_on_dt:
> +	pr_err("see Documentation/devicetree/bindings/clock/");
> +	pr_err("nuvoton,npcm750-clk.txt  for details\n");
>  npcm7xx_init_fail:
> -	kfree(npcm7xx_clk_data->hws);
> +	if (npcm7xx_clk_data->num)
> +		kfree(npcm7xx_clk_data->hws);
>  npcm7xx_init_np_err:
> -	iounmap(clk_base);
> +	if (clk_base != NULL)
> +		iounmap(clk_base);
>  npcm7xx_init_error:
>  	of_node_put(clk_np);
> +	pr_err("clk setup fail\n");
>  }
> +
>  CLK_OF_DECLARE(npcm7xx_clk_init, "nuvoton,npcm750-clk", npcm7xx_clk_init);
> +
> +
> +
> -- 
> 2.14.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
