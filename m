Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEFR4v (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 13:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbeEFR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 13:56:44 -0400
Date: Sun, 6 May 2018 18:56:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Add support for stm32mp1
Message-ID: <20180506185637.494494b3@archlinux>
In-Reply-To: <1525266323-4922-1-git-send-email-fabrice.gasnier@st.com>
References: <1525266323-4922-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018 15:05:23 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add support for DFSDM (Digital Filter For Sigma Delta Modulators)
> to STM32MP1. This variant is close to STM32H7 DFSDM, it implements
> 6 filter instances. Registers map is also increased.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Looks good to me. I'd like to give a little more time for others
to comment however.  Give me a poke if I seem to have forgotten
about it.

Jonathan

> ---
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt         |  7 +++++--
>  drivers/iio/adc/stm32-dfsdm-core.c                  | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> index ed7520d..75ba25d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> @@ -8,14 +8,16 @@ It is mainly targeted for:
>  - PDM microphones (audio digital microphone)
>  
>  It features up to 8 serial digital interfaces (SPI or Manchester) and
> -up to 4 filters on stm32h7.
> +up to 4 filters on stm32h7 or 6 filters on stm32mp1.
>  
>  Each child node match with a filter instance.
>  
>  Contents of a STM32 DFSDM root node:
>  ------------------------------------
>  Required properties:
> -- compatible: Should be "st,stm32h7-dfsdm".
> +- compatible: Should be one of:
> +  "st,stm32h7-dfsdm"
> +  "st,stm32mp1-dfsdm"
>  - reg: Offset and length of the DFSDM block register set.
>  - clocks: IP and serial interfaces clocking. Should be set according
>  		to rcc clock ID and "clock-names".
> @@ -45,6 +47,7 @@ Required properties:
>  	"st,stm32-dfsdm-adc" for sigma delta ADCs
>  	"st,stm32-dfsdm-dmic" for audio digital microphone.
>  - reg: Specifies the DFSDM filter instance used.
> +	Valid values are from 0 to 3 on stm32h7, 0 to 5 on stm32mp1.
>  - interrupts: IRQ lines connected to each DFSDM filter instance.
>  - st,adc-channels:	List of single-ended channels muxed for this ADC.
>  			valid values:
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index e50efdc..d924e6c 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -25,6 +25,8 @@ struct stm32_dfsdm_dev_data {
>  
>  #define STM32H7_DFSDM_NUM_FILTERS	4
>  #define STM32H7_DFSDM_NUM_CHANNELS	8
> +#define STM32MP1_DFSDM_NUM_FILTERS	6
> +#define STM32MP1_DFSDM_NUM_CHANNELS	8
>  
>  static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
>  {
> @@ -61,6 +63,21 @@ static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
>  	.regmap_cfg = &stm32h7_dfsdm_regmap_cfg,
>  };
>  
> +static const struct regmap_config stm32mp1_dfsdm_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = 0x7fc,
> +	.volatile_reg = stm32_dfsdm_volatile_reg,
> +	.fast_io = true,
> +};
> +
> +static const struct stm32_dfsdm_dev_data stm32mp1_dfsdm_data = {
> +	.num_filters = STM32MP1_DFSDM_NUM_FILTERS,
> +	.num_channels = STM32MP1_DFSDM_NUM_CHANNELS,
> +	.regmap_cfg = &stm32mp1_dfsdm_regmap_cfg,
> +};
> +
>  struct dfsdm_priv {
>  	struct platform_device *pdev; /* platform device */
>  
> @@ -243,6 +260,10 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>  		.compatible = "st,stm32h7-dfsdm",
>  		.data = &stm32h7_dfsdm_data,
>  	},
> +	{
> +		.compatible = "st,stm32mp1-dfsdm",
> +		.data = &stm32mp1_dfsdm_data,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
