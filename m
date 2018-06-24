Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30AFC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4619A24F13
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="feJIUfeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4619A24F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeFXNcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbeFXNcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:32:14 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6972D21757;
        Sun, 24 Jun 2018 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529847134;
        bh=GS0oHGQNE38um9ffxc4zQoEJq/Z6/i+L1FrzRNcIQq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=feJIUfeYrbEBZVHH89bdb5d0dU0co8nhfftG4Diblvz93KFZIIBDaln1yeqW5cunP
         Q/X2zfqKUqQsHFvJGWprr+vIrtRDsd10Zh4TRxawyP3kGtK9cI9V/XmDopwpLH2t8f
         teoWtlt/sS/rcN0crUpT1C5l6MnfhEuwoAXsaVnE=
Date:   Sun, 24 Jun 2018 14:32:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Karim Eshapa <karim.eshapa@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging:iio:accel:adis16240: sign extend function
 replace hard code duplication
Message-ID: <20180624143208.7686711d@archlinux>
In-Reply-To: <20180618174450.3399-1-karim.eshapa@gmail.com>
References: <20180618174450.3399-1-karim.eshapa@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 19:44:50 +0200
Karim Eshapa <karim.eshapa@gmail.com> wrote:

> Use sign_extend32 kernel function instead of code duplication,
> Safe also for 16 bit. and remove declaration of bits variable not needed.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>

Applied, thanks.

Jonathan

> ---
>  drivers/staging/iio/accel/adis16240.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index fff6d99089cc..24e525f1ef25 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -250,7 +250,6 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adis *st = iio_priv(indio_dev);
>  	int ret;
> -	int bits;
>  	u8 addr;
>  	s16 val16;
>  
> @@ -287,24 +286,18 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		bits = 10;
>  		addr = adis16240_addresses[chan->scan_index][0];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, 9);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PEAK:
> -		bits = 10;
>  		addr = adis16240_addresses[chan->scan_index][1];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, 9);
>  		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;

