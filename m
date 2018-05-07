Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeEGRVt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeEGRVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:21:47 -0400
Date: Mon, 7 May 2018 18:21:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH v2 2/3] iio: adc: stm32-adc: add support for STM32MP1
Message-ID: <20180507182141.6f9f0580@archlinux>
In-Reply-To: <1525247091-18143-3-git-send-email-fabrice.gasnier@st.com>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
        <1525247091-18143-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018 09:44:50 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
> Introduce new compatible to handle variants of this hardware such as
> vregready flag, trigger list, interrupts, clock rate.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/stm32-adc-core.c | 66 +++++++++++++++++++++++++++++-----------
>  drivers/iio/adc/stm32-adc.c      | 47 +++++++++++++++++++++++++---
>  2 files changed, 91 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 40be7d9..ca432e7 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -34,9 +34,6 @@
>  #define STM32F4_ADC_ADCPRE_SHIFT	16
>  #define STM32F4_ADC_ADCPRE_MASK		GENMASK(17, 16)
>  
> -/* STM32 F4 maximum analog clock rate (from datasheet) */
> -#define STM32F4_ADC_MAX_CLK_RATE	36000000
> -
>  /* STM32H7 - common registers for all ADC instances */
>  #define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
>  #define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
> @@ -51,9 +48,6 @@
>  #define STM32H7_CKMODE_SHIFT		16
>  #define STM32H7_CKMODE_MASK		GENMASK(17, 16)
>  
> -/* STM32 H7 maximum analog clock rate (from datasheet) */
> -#define STM32H7_ADC_MAX_CLK_RATE	36000000
> -
>  /**
>   * stm32_adc_common_regs - stm32 common registers, compatible dependent data
>   * @csr:	common status register offset
> @@ -74,15 +68,17 @@ struct stm32_adc_common_regs {
>   * stm32_adc_priv_cfg - stm32 core compatible configuration data
>   * @regs:	common registers for all instances
>   * @clk_sel:	clock selection routine
> + * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
>   */
>  struct stm32_adc_priv_cfg {
>  	const struct stm32_adc_common_regs *regs;
>  	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
> +	u32 max_clk_rate_hz;
>  };
>  
>  /**
>   * struct stm32_adc_priv - stm32 ADC core private data
> - * @irq:		irq for ADC block
> + * @irq:		irq(s) for ADC block
>   * @domain:		irq domain reference
>   * @aclk:		clock reference for the analog circuitry
>   * @bclk:		bus clock common for all ADCs, depends on part used
> @@ -91,7 +87,7 @@ struct stm32_adc_priv_cfg {
>   * @common:		common data for all ADC instances
>   */
>  struct stm32_adc_priv {
> -	int				irq;
> +	int				irq[STM32_ADC_MAX_ADCS];
>  	struct irq_domain		*domain;
>  	struct clk			*aclk;
>  	struct clk			*bclk;
> @@ -133,7 +129,7 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
> -		if ((rate / stm32f4_pclk_div[i]) <= STM32F4_ADC_MAX_CLK_RATE)
> +		if ((rate / stm32f4_pclk_div[i]) <= priv->cfg->max_clk_rate_hz)
>  			break;
>  	}
>  	if (i >= ARRAY_SIZE(stm32f4_pclk_div)) {
> @@ -222,7 +218,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  			if (ckmode)
>  				continue;
>  
> -			if ((rate / div) <= STM32H7_ADC_MAX_CLK_RATE)
> +			if ((rate / div) <= priv->cfg->max_clk_rate_hz)
>  				goto out;
>  		}
>  	}
> @@ -242,7 +238,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  		if (!ckmode)
>  			continue;
>  
> -		if ((rate / div) <= STM32H7_ADC_MAX_CLK_RATE)
> +		if ((rate / div) <= priv->cfg->max_clk_rate_hz)
>  			goto out;
>  	}
>  
> @@ -328,11 +324,24 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
>  			       struct stm32_adc_priv *priv)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	unsigned int i;
> +
> +	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
> +		priv->irq[i] = platform_get_irq(pdev, i);
> +		if (priv->irq[i] < 0) {
> +			/*
> +			 * At least one interrupt must be provided, make others
> +			 * optional:
> +			 * - stm32f4/h7 shares a common interrupt.
> +			 * - stm32mp1, has one line per ADC (either for ADC1,
> +			 *   ADC2 or both).
> +			 */
> +			if (i && priv->irq[i] == -ENXIO)
> +				continue;
> +			dev_err(&pdev->dev, "failed to get irq\n");
>  
> -	priv->irq = platform_get_irq(pdev, 0);
> -	if (priv->irq < 0) {
> -		dev_err(&pdev->dev, "failed to get irq\n");
> -		return priv->irq;
> +			return priv->irq[i];
> +		}
>  	}
>  
>  	priv->domain = irq_domain_add_simple(np, STM32_ADC_MAX_ADCS, 0,
> @@ -343,8 +352,12 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
>  		return -ENOMEM;
>  	}
>  
> -	irq_set_chained_handler(priv->irq, stm32_adc_irq_handler);
> -	irq_set_handler_data(priv->irq, priv);
> +	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
> +		if (priv->irq[i] < 0)
> +			continue;
> +		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
> +		irq_set_handler_data(priv->irq[i], priv);
> +	}
>  
>  	return 0;
>  }
> @@ -353,11 +366,17 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
>  				 struct stm32_adc_priv *priv)
>  {
>  	int hwirq;
> +	unsigned int i;
>  
>  	for (hwirq = 0; hwirq < STM32_ADC_MAX_ADCS; hwirq++)
>  		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
>  	irq_domain_remove(priv->domain);
> -	irq_set_chained_handler(priv->irq, NULL);
> +
> +	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
> +		if (priv->irq[i] < 0)
> +			continue;
> +		irq_set_chained_handler(priv->irq[i], NULL);
> +	}
>  }
>  
>  static int stm32_adc_probe(struct platform_device *pdev)
> @@ -497,11 +516,19 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
>  	.regs = &stm32f4_adc_common_regs,
>  	.clk_sel = stm32f4_adc_clk_sel,
> +	.max_clk_rate_hz = 36000000,
>  };
>  
>  static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
>  	.regs = &stm32h7_adc_common_regs,
>  	.clk_sel = stm32h7_adc_clk_sel,
> +	.max_clk_rate_hz = 36000000,
> +};
> +
> +static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
> +	.regs = &stm32h7_adc_common_regs,
> +	.clk_sel = stm32h7_adc_clk_sel,
> +	.max_clk_rate_hz = 40000000,
>  };
>  
>  static const struct of_device_id stm32_adc_of_match[] = {
> @@ -512,6 +539,9 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  		.compatible = "st,stm32h7-adc-core",
>  		.data = (void *)&stm32h7_adc_priv_cfg
>  	}, {
> +		.compatible = "st,stm32mp1-adc-core",
> +		.data = (void *)&stm32mp1_adc_priv_cfg
> +	}, {
>  	},
>  };
>  MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 9a2583ca..3784118 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -84,6 +84,7 @@
>  #define STM32H7_ADC_CALFACT2		0xC8
>  
>  /* STM32H7_ADC_ISR - bit fields */
> +#define STM32MP1_VREGREADY		BIT(12)
>  #define STM32H7_EOC			BIT(2)
>  #define STM32H7_ADRDY			BIT(0)
>  
> @@ -249,6 +250,7 @@ struct stm32_adc_regspec {
>   * @adc_info:		per instance input channels definitions
>   * @trigs:		external trigger sources
>   * @clk_required:	clock is required
> + * @has_vregready:	vregready status flag presence
>   * @selfcalib:		optional routine for self-calibration
>   * @prepare:		optional prepare routine (power-up, enable)
>   * @start_conv:		routine to start conversions
> @@ -261,6 +263,7 @@ struct stm32_adc_cfg {
>  	const struct stm32_adc_info	*adc_info;
>  	struct stm32_adc_trig_info	*trigs;
>  	bool clk_required;
> +	bool has_vregready;
>  	int (*selfcalib)(struct stm32_adc *);
>  	int (*prepare)(struct stm32_adc *);
>  	void (*start_conv)(struct stm32_adc *, bool dma);
> @@ -695,8 +698,12 @@ static void stm32h7_adc_stop_conv(struct stm32_adc *adc)
>  	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32H7_DMNGT_MASK);
>  }
>  
> -static void stm32h7_adc_exit_pwr_down(struct stm32_adc *adc)
> +static int stm32h7_adc_exit_pwr_down(struct stm32_adc *adc)
>  {
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	int ret;
> +	u32 val;
> +
>  	/* Exit deep power down, then enable ADC voltage regulator */
>  	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
>  	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
> @@ -705,7 +712,20 @@ static void stm32h7_adc_exit_pwr_down(struct stm32_adc *adc)
>  		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_BOOST);
>  
>  	/* Wait for startup time */
> -	usleep_range(10, 20);
> +	if (!adc->cfg->has_vregready) {
> +		usleep_range(10, 20);
> +		return 0;
> +	}
> +
> +	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_ISR, val,
> +					   val & STM32MP1_VREGREADY, 100,
> +					   STM32_ADC_TIMEOUT_US);
> +	if (ret) {
> +		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
> +		dev_err(&indio_dev->dev, "Failed to exit power down\n");
> +	}
> +
> +	return ret;
>  }
>  
>  static void stm32h7_adc_enter_pwr_down(struct stm32_adc *adc)
> @@ -888,7 +908,9 @@ static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>  	int ret;
>  	u32 val;
>  
> -	stm32h7_adc_exit_pwr_down(adc);
> +	ret = stm32h7_adc_exit_pwr_down(adc);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Select calibration mode:
> @@ -952,7 +974,10 @@ static int stm32h7_adc_prepare(struct stm32_adc *adc)
>  {
>  	int ret;
>  
> -	stm32h7_adc_exit_pwr_down(adc);
> +	ret = stm32h7_adc_exit_pwr_down(adc);
> +	if (ret)
> +		return ret;
> +
>  	stm32_adc_writel(adc, STM32H7_ADC_DIFSEL, adc->difsel);
>  
>  	ret = stm32h7_adc_enable(adc);
> @@ -1944,9 +1969,23 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  	.smp_cycles = stm32h7_adc_smp_cycles,
>  };
>  
> +static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
> +	.regs = &stm32h7_adc_regspec,
> +	.adc_info = &stm32h7_adc_info,
> +	.trigs = stm32h7_adc_trigs,
> +	.has_vregready = true,
> +	.selfcalib = stm32h7_adc_selfcalib,
> +	.start_conv = stm32h7_adc_start_conv,
> +	.stop_conv = stm32h7_adc_stop_conv,
> +	.prepare = stm32h7_adc_prepare,
> +	.unprepare = stm32h7_adc_unprepare,
> +	.smp_cycles = stm32h7_adc_smp_cycles,
> +};
> +
>  static const struct of_device_id stm32_adc_of_match[] = {
>  	{ .compatible = "st,stm32f4-adc", .data = (void *)&stm32f4_adc_cfg },
>  	{ .compatible = "st,stm32h7-adc", .data = (void *)&stm32h7_adc_cfg },
> +	{ .compatible = "st,stm32mp1-adc", .data = (void *)&stm32mp1_adc_cfg },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
