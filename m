Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67570C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC3225557
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr7ftdJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC3225557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeF3PS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbeF3PSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:18:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6601B24B6F;
        Sat, 30 Jun 2018 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530371933;
        bh=1vXvLAD+G/EcD0JkHumyQXiDhnmWfoLlG/Gm/I10RHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tr7ftdJP2QcpHS41ucTT6Vo2RJkyDtYoQryu5HWIR1gEzdzjk3U68RQLpBYwgIex+
         l0SEJV38BtlO/R5wQzP8i6VaybnifIqca7uejP7kI3q+iKYjVdQbALHVPkOH3kgaS/
         mpVc5jr1Jd76m5IPubP4B+XVUcLQRb8etNrxdLko=
Date:   Sat, 30 Jun 2018 16:18:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH 4/5] iio: adc: ti_am335x_adc: Disable ADC during suspend
 unconditionally
Message-ID: <20180630161848.1e72deea@archlinux>
In-Reply-To: <20180630103318.25355-5-vigneshr@ti.com>
References: <20180630103318.25355-1-vigneshr@ti.com>
        <20180630103318.25355-5-vigneshr@ti.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018 16:03:17 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Parent MFD device takes care of enabling ADC interface whenever
> touchscreen is marked wakeup capable. Therefore, unconditionally disable
> ADC interface during system suspend to save power in case of system with
> just ADC and no TSC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

This sounds like a sensible change to me.   Is it applicable without the
rest of the series?  If so I'll take it through IIO.  If the answer
is that it needs to go with the rest then

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 80df5a377d30..cafb1dcadc48 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -693,16 +693,12 @@ static int __maybe_unused tiadc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> -	struct ti_tscadc_dev *tscadc_dev;
>  	unsigned int idle;
>  
> -	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
> -	if (!device_may_wakeup(tscadc_dev->dev)) {
> -		idle = tiadc_readl(adc_dev, REG_CTRL);
> -		idle &= ~(CNTRLREG_TSCSSENB);
> -		tiadc_writel(adc_dev, REG_CTRL, (idle |
> -				CNTRLREG_POWERDOWN));
> -	}
> +	idle = tiadc_readl(adc_dev, REG_CTRL);
> +	idle &= ~(CNTRLREG_TSCSSENB);
> +	tiadc_writel(adc_dev, REG_CTRL, (idle |
> +			CNTRLREG_POWERDOWN));
>  
>  	return 0;
>  }

