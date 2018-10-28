Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B27C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213E920870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyI5gnsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213E920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJ2BZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ2BZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:25:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBA4420831;
        Sun, 28 Oct 2018 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540744842;
        bh=vU9+Jx0JkAc/sb4nvuerh78nzxvVBp/YrmoMigp7JGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IyI5gnsPWT4bH8zeY9/uhU96O59bLMGH8Zme4XH6Me+Y7QagldpyQASum100e0rGz
         d4WvnhNX3srqBDqEzaXR2/ByLOPFJinGfFWXM6fgeoZjsHAVVzXBgtC9GW5Savd4Gx
         psVJdO5kZrpDQDMEVsQq0fOrIJwavdXr5fpPYdZw=
Date:   Sun, 28 Oct 2018 16:40:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/6] staging:iio:ad2s90: Make read_raw return
 spi_read's error code
Message-ID: <20181028164038.0c920358@archlinux>
In-Reply-To: <20181027020005.3140-2-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
        <20181027020005.3140-2-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 23:00:00 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, when spi_read returned an error code inside ad2s90_read_raw,
> the code was ignored and IIO_VAL_INT was returned. This patch makes the
> function return the error code returned by spi_read when it fails.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Hi Matheus,

One quick process note is that it takes people a while to get around to reviewing
a series, so whilst it's tempting to very quickly send out a fix the moment
someone points out something that needs fixing, it is perhaps better to wait
at least a few days to see if you can pick up a few more reviews before you
do a V2.

A few comments on this one inline.  I think it can be done 'slightly'
(and I mean only slightly) nicer than the version you have.  Result is the
same though.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 59586947a936..11fac9f90148 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -35,12 +35,15 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>  	struct ad2s90_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->lock);
> +
Unconnected change.  I'm not against the change in principle but please
group white space tidying up in it's own patch.

>  	ret = spi_read(st->sdev, st->rx, 2);
> -	if (ret)
> -		goto error_ret;
> +	if (ret < 0) {
> +		mutex_unlock(&st->lock);
> +		return ret;
I'd actually prefer to keep the return path the same as before as then
it is easy (if the function gets more complex in future) to be sure
that all paths unlock the mutex.  
> +	}
> +
>  	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>  
> -error_ret:
>  	mutex_unlock(&st->lock);
>  
>  	return IIO_VAL_INT;
The 'standard' if slightly nasty way of doing this is:

	return ret ? ret : IIO_VAL_INT;

