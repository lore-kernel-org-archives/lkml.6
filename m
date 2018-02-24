Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeBXM7y (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 07:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeBXM7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 07:59:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7388C21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Feb 2018 12:59:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 3/7] iio: adc: stm32-dfsdm: fix clock source selection
Message-ID: <20180224125947.5c5734a9@archlinux>
In-Reply-To: <1519390261-25453-4-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
        <1519390261-25453-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 13:50:57 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add missing clock source selection. In case "audio" clock is provided,
> it's unused currently: "dfsdm" clock is wrongly used by default.
> 
> Fixes: bed73904e76f ("IIO: ADC: add stm32 DFSDM core support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 0635f93..e50efdc 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -83,7 +83,7 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
>  {
>  	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
>  	struct device *dev = &priv->pdev->dev;
> -	unsigned int clk_div = priv->spi_clk_out_div;
> +	unsigned int clk_div = priv->spi_clk_out_div, clk_src;
>  	int ret;
>  
>  	if (atomic_inc_return(&priv->n_active_ch) == 1) {
> @@ -100,6 +100,14 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
>  			}
>  		}
>  
> +		/* select clock source, e.g. 0 for "dfsdm" or 1 for "audio" */
> +		clk_src = priv->aclk ? 1 : 0;
> +		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
> +					 DFSDM_CHCFGR1_CKOUTSRC_MASK,
> +					 DFSDM_CHCFGR1_CKOUTSRC(clk_src));
> +		if (ret < 0)
> +			goto disable_aclk;
> +
>  		/* Output the SPI CLKOUT (if clk_div == 0 clock if OFF) */
>  		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
>  					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
