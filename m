Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9008C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872422082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNNQb2sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872422082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeKEBvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbeKEBvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:51:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D50A20685;
        Sun,  4 Nov 2018 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541349382;
        bh=HA11KbklDGjRG7ZRlUKHlCo1NR36W7Bnsry/yU2eYZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GNNQb2shBcHRozohM0LU+SWc2H4V8ahrweG/ucHXtOGQqvNuvPWIer5JtWZC5nGZq
         jZ3qkufiQJRu7Vp5GsN5YAZpMr82fn3L21/J5aj3wpnS+RuDHtgsoesbyx7qkpdomH
         8gXuWKiiTH0nw8MlQ1M+sgwnRS0AkyHfTV6b+ueM=
Date:   Sun, 4 Nov 2018 16:36:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 1/6] staging:iio:ad2s90: Make read_raw return
 spi_read's error code
Message-ID: <20181104163616.7c864dcc@archlinux>
In-Reply-To: <20181103224948.31014-2-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-2-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Nov 2018 19:49:43 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, when spi_read returned an error code inside ad2s90_read_raw,
> the code was ignored and IIO_VAL_INT was returned. This patch makes the
> function return the error code returned by spi_read when it fails.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 59586947a936..ba55de29ef36 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -36,11 +36,12 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&st->lock);
>  	ret = spi_read(st->sdev, st->rx, 2);
> -	if (ret)
> -		goto error_ret;
> +	if (ret < 0) {
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
>  	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>  
> -error_ret:
>  	mutex_unlock(&st->lock);
>  
>  	return IIO_VAL_INT;

