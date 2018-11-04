Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D66C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A00120854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKFbS39y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A00120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbeKEB6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbeKEB6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:58:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADFB2082D;
        Sun,  4 Nov 2018 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541349754;
        bh=/Rr/9BDAf4/EUShQJw9say9D0Aa4l00tFbSCi18LtZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MKFbS39yahfm5/YjCD2kOofY4W4ol9pJOsKx65lCEVGbO1w/eojmizxVFi4ff1uYR
         DKTo7ogyjfFMSJJMfqsRbToK9wDTX4Q9tY1gCH3uGurYZ0CyZ8xZxpA/BA1C4rwnpj
         dAfwIpV+KZZI8wo2ezCdwZIFHPSSlZTVryafsc3M=
Date:   Sun, 4 Nov 2018 16:42:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 4/6] staging:iio:ad2s90: Move device registration to
 the end of probe
Message-ID: <20181104164229.128d2f17@archlinux>
In-Reply-To: <20181103224948.31014-5-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-5-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Nov 2018 19:49:46 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, devm_iio_device_register was being called before the
> spi_setup call and the spi_device's max_speed_hz and mode assignments.
> This could lead to a race condition since the driver was still being
> set up after it was already made ready to use. To fix it, this patch
> moves the device registration to the end of ad2s90_probe.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied.  This is definitely looking more like a 'modern' IIO driver.
All sorts of less than sensible things like this used to be done
when all of us were new to drivers.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 54ad85bd9dc6..8f79cccf4814 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -79,10 +79,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  	indio_dev->num_channels = 1;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	/* need 600ns between CS and the first falling edge of SCLK */
>  	spi->max_speed_hz = 830000;
>  	spi->mode = SPI_MODE_3;
> @@ -93,7 +89,7 @@ static int ad2s90_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	return 0;
> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  
>  static const struct spi_device_id ad2s90_id[] = {

