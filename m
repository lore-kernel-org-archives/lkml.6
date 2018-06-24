Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F28C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D4B24F19
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z89dvwSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D4B24F19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeFXNlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeFXNlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:41:20 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8114824F16;
        Sun, 24 Jun 2018 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529847679;
        bh=hO+h+N0VzhAXknpRgHsOoUU2A617CjGn4uo+sOtju/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z89dvwSANfq5dlUwCwGdA1IX+/Irw5X01mi2sJd/jcPJ8qyWuFJs+ec1u7QKm05FF
         83Z0L2m6M76nIo4uNzQcXG9Z4izwb88u02MkboEyeIO7JTknWYf2MIiAPCwD5UFZLw
         L8Qf8gk6Mq7Bh0OuCZOmbweMxqa9JhyIcGgIcQgE=
Date:   Sun, 24 Jun 2018 14:41:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Matt Fornero <matt.fornero@mathworks.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: use timespec64 based interfaces for
 iio_get_time_ns()
Message-ID: <20180624144114.1b9887e4@archlinux>
In-Reply-To: <20180618153153.1903178-1-arnd@arndb.de>
References: <20180618153153.1903178-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 17:31:36 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> We have replacements for all the deprecated timespec based interfaces now,
> so this can finally convert iio_get_time_ns() to consistently use the
> nanosecond or timespec64 based interfaces instead, avoiding the y2038
> overflow.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Great!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to sanity check.

Thanks

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 19bdf3d2962a..fcbe92c34a3d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -207,35 +207,27 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
>   */
>  s64 iio_get_time_ns(const struct iio_dev *indio_dev)
>  {
> -	struct timespec tp;
> +	struct timespec64 tp;
>  
>  	switch (iio_device_get_clock(indio_dev)) {
>  	case CLOCK_REALTIME:
> -		ktime_get_real_ts(&tp);
> -		break;
> +		return ktime_get_real_ns();
>  	case CLOCK_MONOTONIC:
> -		ktime_get_ts(&tp);
> -		break;
> +		return ktime_get_ns();
>  	case CLOCK_MONOTONIC_RAW:
> -		getrawmonotonic(&tp);
> -		break;
> +		return ktime_get_raw_ns();
>  	case CLOCK_REALTIME_COARSE:
> -		tp = current_kernel_time();
> -		break;
> +		return ktime_to_ns(ktime_get_coarse_real());
>  	case CLOCK_MONOTONIC_COARSE:
> -		tp = get_monotonic_coarse();
> -		break;
> +		ktime_get_coarse_ts64(&tp);
> +		return timespec64_to_ns(&tp);
>  	case CLOCK_BOOTTIME:
> -		get_monotonic_boottime(&tp);
> -		break;
> +		return ktime_get_boot_ns();
>  	case CLOCK_TAI:
> -		timekeeping_clocktai(&tp);
> -		break;
> +		return ktime_get_tai_ns();
>  	default:
>  		BUG();
>  	}
> -
> -	return timespec_to_ns(&tp);
>  }
>  EXPORT_SYMBOL(iio_get_time_ns);
>  

