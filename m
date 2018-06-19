Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6715AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B26A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B26A20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937301AbeFSF7e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:59:34 -0400
Received: from www381.your-server.de ([78.46.137.84]:46415 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeFSF7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:59:32 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1fV9fr-0002sa-6D; Tue, 19 Jun 2018 07:59:27 +0200
Received: from [188.174.124.246] (helo=[192.168.178.37])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fV9fq-0009yq-VA; Tue, 19 Jun 2018 07:59:27 +0200
Subject: Re: [PATCH] staging:iio:adc:ad7816: Backward resources cleanups in
 probe
To:     Karim Eshapa <karim.eshapa@gmail.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180618233851.7992-1-karim.eshapa@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0e5bb02e-a19a-3b6a-f1a6-98bb89a6d9b8@metafoo.de>
Date:   Tue, 19 Jun 2018 07:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618233851.7992-1-karim.eshapa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.99.3/24676/Tue Jun 19 06:38:11 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 01:38 AM, Karim Eshapa wrote:
> Backward cleanups for all resources allocated in probing
> in case of failure at any regestering or allocation step.

Hi,

Thanks for the patch.

Resources that are allocated with devm_ are freed automatically in case of
an error, so this patch should not be necessary.

> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index bf76a8620bdb..5ff14c830451 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -373,7 +373,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	if (ret) {
>  		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
>  			chip->rdwr_pin);
> -		return ret;
> +		goto device_free;
>  	}
>  	gpio_direction_input(chip->rdwr_pin);
>  	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
> @@ -381,7 +381,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	if (ret) {
>  		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
>  			chip->convert_pin);
> -		return ret;
> +		goto free_rdwr_pin;
>  	}
>  	gpio_direction_input(chip->convert_pin);
>  	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
> @@ -389,7 +389,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	if (ret) {
>  		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
>  			chip->busy_pin);
> -		return ret;
> +		goto free_convert_pin;
>  	}
>  	gpio_direction_input(chip->busy_pin);
>  
> @@ -407,17 +407,29 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  						indio_dev->name,
>  						indio_dev);
>  		if (ret)
> -			return ret;
> +			goto free_busy_pin;
>  	}
>  
>  	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
>  	if (ret)
> -		return ret;
> +		goto free_dev_irq;
>  
>  	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
>  		 indio_dev->name);
>  
>  	return 0;
> +free_dev_irq:
> +	devm_free_irq(&spi_dev->dev, spi_dev->irq, indio_dev);
> +free_busy_pin:
> +	devm_gpio_free(&spi_dev->dev, chip->busy_pin);
> +free_convert_pin:
> +	devm_gpio_free(&spi_dev->dev, chip->convert_pin);
> +free_rdwr_pin:
> +	devm_gpio_free(&spi_dev->dev, chip->rdwr_pin);
> +device_free:
> +	devm_iio_device_free(&spi_dev->dev, indio_dev);
> +
> +	return ret;
>  }
>  
>  static const struct spi_device_id ad7816_id[] = {
> 

