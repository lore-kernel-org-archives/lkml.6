Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CFDC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C91520892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544283878;
	bh=l8glTKhBBsZAnbzO+iP52uUxqDqUB9ncEI08JIpnamw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=litEnTaZu/ixWZVf/+48CLI+Y/N02P2nfdIq9D8l2FJgFCewA6xEO9oxW5beL28rf
	 SDRijgT+uFHwlA/DgEJNKqGBoGEY55ynvzFJKb/DKHLj72xyY3sKTBH0P80cwQb+J0
	 J3ep+P9WyV4OKZgU1bLqbHdktye+ndM7krm51oKQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C91520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLHPoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbeLHPoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:44:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB03320672;
        Sat,  8 Dec 2018 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544283876;
        bh=l8glTKhBBsZAnbzO+iP52uUxqDqUB9ncEI08JIpnamw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nSdGXsB29mQKNMM+RPyxyDQKwmP4S1eaIp42hKUQ6FtTHZiIvgeVkhGqT0cZrlWZq
         bJ5Sr6c2zD5+oc0LwOxtGi6b5TvWS5Jomx8BDWeS0WOVACS6G9esrNba8j0VHp3sND
         00/aVnP1h3ljbGU9Ih7YXz0F5Vmvg6zvz1QXt6uU=
Date:   Sat, 8 Dec 2018 15:44:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] iio: dac: ad5686: fix bit shift read register
Message-ID: <20181208154432.34e248bd@archlinux>
In-Reply-To: <20181206135315.22805-1-mircea.caprioru@analog.com>
References: <20181206135315.22805-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 15:53:15 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch solves the register readback issue with the bit shift. When the
> dac resolution was lower than the register size (ex. 12 bits out of 16
> bits) the readback value was not shifted with the difference in bits and
> the value was higher. Also a mask is applied on the read value in order to
> get the value relative to the actual bit size.
> 
> Fixes: 0357e488b8 ("iio:dac:ad5686: Refactor the driver")
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
This seems obvious, but a little strange we've not noticed it
before.    Ah well.  Given the time in the cycle I'm going to
take it for the next merge window rather than rushing it it.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5686.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 54ff76b93366..a332b93ca2c4 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -128,7 +128,8 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&indio_dev->mlock);
>  		if (ret < 0)
>  			return ret;
> -		*val = ret;
> +		*val = (ret >> chan->scan_type.shift) &
> +			GENMASK(chan->scan_type.realbits - 1, 0);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_mv;

