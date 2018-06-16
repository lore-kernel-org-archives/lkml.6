Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF2AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78812208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFyJmKUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78812208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756867AbeFPSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 14:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752587AbeFPSF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 14:05:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 074BF2087E;
        Sat, 16 Jun 2018 18:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529172327;
        bh=16LoKHHZ3Y20F+neKHN1J3a/5E5tr6koIyufwGiWbXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AFyJmKULKTpiIkEBBmdxutUE3Ge0gRwsojJJUYNFjEk3qhV+Ec1ZZPfR6OWoC4YkJ
         XxsVzTQnuaNbO9bumaJ6PlPJy2fplSIUvaLeIGZu0o1ivDHk6Zvvj5Qi8ScuufrIei
         8zV1DCEWwd1oNu9yep1f2KyrN9omwluhwElz/3lg=
Date:   Sat, 16 Jun 2018 19:05:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Karim Eshapa <karim.eshapa@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:iio:accel:adis16203: sign extend function
 rather code duplication
Message-ID: <20180616190520.7996a010@archlinux>
In-Reply-To: <20180612164838.22961-1-karim.eshapa@gmail.com>
References: <20180612164838.22961-1-karim.eshapa@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 18:48:38 +0200
Karim Eshapa <karim.eshapa@gmail.com> wrote:

> Use sign_extend32 kernel function instead of code duplication.
> This function is also safe for 16 bits.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16203.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index b3e4571340ab..5cc96c8086b5 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -168,7 +168,6 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adis *st = iio_priv(indio_dev);
>  	int ret;
> -	int bits;
>  	u8 addr;
>  	s16 val16;
>  
> @@ -202,14 +201,11 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		bits = 14;
>  		addr = adis16203_addresses[chan->scan_index];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, 13);
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;

