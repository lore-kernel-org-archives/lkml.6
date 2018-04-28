Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeD1PIa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 11:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbeD1PIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 11:08:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C84721E92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 28 Apr 2018 16:07:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 7/7] iio: adc: stm32-dfsdm: add check on
 spi-max-frequency
Message-ID: <20180428160754.298afa0b@archlinux>
In-Reply-To: <1519390261-25453-8-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
        <1519390261-25453-8-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 13:51:01 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> spi-max-frequency is requested for SPI master mode (only), to tune output
> clock. It may happen requested frequency isn't reachable.
> Add explicit check, so probe fails with error in this case. Otherwise,
> output clock may simply be silently turned off (conversions fail).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index e50efdc..1d0d823 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -227,6 +227,11 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>  	}
>  
>  	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
> +	if (!priv->spi_clk_out_div) {
> +		/* spi_clk_out_div == 0 means ckout is OFF */
> +		dev_err(&pdev->dev, "spi-max-frequency not achievable\n");
> +		return -EINVAL;
> +	}
>  	priv->dfsdm.spi_master_freq = spi_freq;
>  
>  	if (rem) {
