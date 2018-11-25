Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DC3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0312086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRbszNhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0312086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeKZAIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbeKZAIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 19:08:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89EB20868;
        Sun, 25 Nov 2018 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543151859;
        bh=QGfXxsOdbAo+37EwoOmajI+DB0G6LVoFTF2mQEe+tn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vRbszNhOM+wit0aEb/lJrf0wx+PPmXI44Wp7ax+Lv3aBxO9LDB1NhOt3xdgrGeZwN
         ow/vqAAnLolWmxwJR3i0vxxx6aAvBy5pieICUFann4mpV3AvpvrZVicGMpgARQFlia
         vzuWxrrS3PgOMhw/2xvmE2eXuDwcwlcsYmmasj+A=
Date:   Sun, 25 Nov 2018 13:17:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 3/3] iio: adc: stm32-adc: switch off running adc when
 going to low power
Message-ID: <20181125131735.616d6cf9@archlinux>
In-Reply-To: <1542708752-26163-4-git-send-email-fabrice.gasnier@st.com>
References: <1542708752-26163-1-git-send-email-fabrice.gasnier@st.com>
        <1542708752-26163-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 11:12:32 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Switch off ADC when going to low power mode, in case it has been left
> running in buffer mode. Then re-enable it when resuming.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
My suspicion is that we have other drivers not correctly handing this
case, but as far as I can see you have it well covered here.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 79 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 63 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 32c9c61..2a9891c 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1518,7 +1518,7 @@ static int stm32_adc_dma_start(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
> +static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
> @@ -1542,10 +1542,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  		goto err_clr_trig;
>  	}
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret < 0)
> -		goto err_stop_dma;
> -
>  	/* Reset adc buffer index */
>  	adc->bufi = 0;
>  
> @@ -1556,9 +1552,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  
>  	return 0;
>  
> -err_stop_dma:
> -	if (adc->dma_chan)
> -		dmaengine_terminate_all(adc->dma_chan);
>  err_clr_trig:
>  	stm32_adc_set_trig(indio_dev, NULL);
>  err_pm_put:
> @@ -1568,20 +1561,30 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
> +static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __stm32_adc_buffer_postenable(indio_dev);
> +	if (ret < 0)
> +		iio_triggered_buffer_predisable(indio_dev);
> +
> +	return ret;
> +}
> +
> +static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
> -	int ret;
>  
>  	adc->cfg->stop_conv(adc);
>  	if (!adc->dma_chan)
>  		stm32_adc_conv_irq_disable(adc);
>  
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		dev_err(&indio_dev->dev, "predisable failed\n");
> -
>  	if (adc->dma_chan)
>  		dmaengine_terminate_all(adc->dma_chan);
>  
> @@ -1590,6 +1593,17 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
> +}
> +
> +static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +
> +	__stm32_adc_buffer_predisable(indio_dev);
> +
> +	ret = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret < 0)
> +		dev_err(&indio_dev->dev, "predisable failed\n");
>  
>  	return ret;
>  }
> @@ -2013,6 +2027,40 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_PM_SLEEP)
> +static int stm32_adc_suspend(struct device *dev)
> +{
> +	struct stm32_adc *adc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		__stm32_adc_buffer_predisable(indio_dev);
> +
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int stm32_adc_resume(struct device *dev)
> +{
> +	struct stm32_adc *adc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	int ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!iio_buffer_enabled(indio_dev))
> +		return 0;
> +
> +	ret = stm32_adc_update_scan_mode(indio_dev,
> +					 indio_dev->active_scan_mask);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __stm32_adc_buffer_postenable(indio_dev);
> +}
> +#endif
> +
>  #if defined(CONFIG_PM)
>  static int stm32_adc_runtime_suspend(struct device *dev)
>  {
> @@ -2026,8 +2074,7 @@ static int stm32_adc_runtime_resume(struct device *dev)
>  #endif
>  
>  static const struct dev_pm_ops stm32_adc_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(stm32_adc_suspend, stm32_adc_resume)
>  	SET_RUNTIME_PM_OPS(stm32_adc_runtime_suspend, stm32_adc_runtime_resume,
>  			   NULL)
>  };

