Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1082086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLF6tOT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1082086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeKZAh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeKZAh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 19:37:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCED20865;
        Sun, 25 Nov 2018 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543153579;
        bh=TiAbr1Xpxzz7s/LCKpj2vIN1KLj+sbo/MQAArTBl/kA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eLF6tOT0BWKj+yKTTRkT7ME4cdbZYBqG2CQ9QdB8wOsL+JOZH+gNmF3ZDWn480X9K
         3lXelzJQOqIBXI4Mhbp+0kxYRJxUYbwfVy0kauJaJ5wPmqPdpfpHB0GHEwCsCudbEK
         hQict6h6MTGBgHQlXY+1nT9iHoq1f0AB3rPOjofg=
Date:   Sun, 25 Nov 2018 13:46:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_tscadc: Improve accuracy of
 measurement
Message-ID: <20181125134615.01d45e14@archlinux>
In-Reply-To: <20181119064236.28902-3-vigneshr@ti.com>
References: <20181119064236.28902-1-vigneshr@ti.com>
        <20181119064236.28902-3-vigneshr@ti.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 12:12:36 +0530
Vignesh R <vigneshr@ti.com> wrote:

> When performing single ended measurements with TSCADC, its recommended
> to set negative input (SEL_INM_SWC_3_0) of ADC step to ADC's VREFN in the
> corresponding STEP_CONFIGx register.
> Also, the positive(SEL_RFP_SWC_2_0) and negative(SEL_RFM_SWC_1_0)
> reference voltage for ADC step needs to be set to VREFP and VREFN
> respectively in STEP_CONFIGx register.
> Without these changes, there may be variation of as much as ~2% in the
> ADC's digital output which is bad for precise measurement.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
Given the header changes in mfd and the fact not much is going on with this
driver in IIO at the moment, I'm happy for this to go through the mfd tree.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-
>  include/linux/mfd/ti_am335x_tscadc.h | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index cafb1dcadc48..9d984f2a8ba7 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -142,7 +142,10 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  			stepconfig |= STEPCONFIG_MODE_SWCNT;
>  
>  		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
> -				stepconfig | STEPCONFIG_INP(chan));
> +				stepconfig | STEPCONFIG_INP(chan) |
> +				STEPCONFIG_INM_ADCREFM |
> +				STEPCONFIG_RFP_VREFP |
> +				STEPCONFIG_RFM_VREFN);
>  
>  		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
>  			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index b9a53e013bff..483168403ae5 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -78,6 +78,8 @@
>  #define STEPCONFIG_YNN		BIT(8)
>  #define STEPCONFIG_XNP		BIT(9)
>  #define STEPCONFIG_YPN		BIT(10)
> +#define STEPCONFIG_RFP(val)	((val) << 12)
> +#define STEPCONFIG_RFP_VREFP	(0x3 << 12)
>  #define STEPCONFIG_INM_MASK	(0xF << 15)
>  #define STEPCONFIG_INM(val)	((val) << 15)
>  #define STEPCONFIG_INM_ADCREFM	STEPCONFIG_INM(8)
> @@ -86,6 +88,8 @@
>  #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
>  #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
>  #define STEPCONFIG_FIFO1	BIT(26)
> +#define STEPCONFIG_RFM(val)	((val) << 23)
> +#define STEPCONFIG_RFM_VREFN	(0x3 << 23)
>  
>  /* Delay register */
>  #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)

