Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757639AbeD1PIQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 11:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeD1PIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 11:08:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B63121DEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 28 Apr 2018 16:07:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 6/7] iio: adc: stm32-dfsdm: add check on max filter id
Message-ID: <20180428160706.2aafad5b@archlinux>
In-Reply-To: <1519390261-25453-7-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
        <1519390261-25453-7-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 13:51:00 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> reg property should be checked against number of available filters.
> BTW, dfsdm->num_fls wasn't used. But it can be used for this purpose.
> This prevents using data out of allocated dfsdm->fl_list array.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 57bcb45..1b78bec 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1111,8 +1111,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, adc);
>  
>  	ret = of_property_read_u32(dev->of_node, "reg", &adc->fl_id);
> -	if (ret != 0) {
> -		dev_err(dev, "Missing reg property\n");
> +	if (ret != 0 || adc->fl_id >= adc->dfsdm->num_fls) {
> +		dev_err(dev, "Missing or bad reg property\n");
>  		return -EINVAL;
>  	}
>  
