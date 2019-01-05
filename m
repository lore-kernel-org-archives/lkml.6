Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED29AC43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FD621848
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546711038;
	bh=GZ4Rkh5ZX0K2TlPIydtaiDLNXVssN1alN0ZDZXn4NN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JjhtTTF0uTTJSsbxeP039WcFcx92i7SKrv2u+6AyBlUeKaaQARCDFm3/xSy2rwiOm
	 TsPDeusP57Fx2lnwgKGzOHDlp/6h4xK3sbPylHp+w6Xc1fDjPut3IiE6JkvL7xTJFG
	 1Mo9wPSmV7+jMtQFL3i7aivWiTvAvj7pAgjf1t84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfAER5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfAER5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:57:17 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B51A206B7;
        Sat,  5 Jan 2019 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546711037;
        bh=GZ4Rkh5ZX0K2TlPIydtaiDLNXVssN1alN0ZDZXn4NN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hHWpS6NqOP4T4ParZmdjRBVzEbLiBvMFexcrFy+KtLuFuIKHMyRlU20jClOdR61cd
         W26UvVGIZ65SzuytfZhti04wB5S/UOq1a6+7/VJFYtYQhcUzPtuMrOUQKaXFSKFtYo
         4sKlmURzJiiZWHmPJd9065ZGcGifNE42fhltALcI=
Date:   Sat, 5 Jan 2019 17:57:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v2 4/4] staging: iio: adt7316: fix the dac write
 calculation
Message-ID: <20190105175712.7e5075e1@archlinux>
In-Reply-To: <20181223045743.10716-5-jeremyfertic@gmail.com>
References: <20181223045743.10716-1-jeremyfertic@gmail.com>
        <20181223045743.10716-5-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 21:57:43 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> The lsb calculation is not masking the correct bits from the user input.
> Subtract 1 from (1 << offset) to correctly set up the mask to be applied
> to user input.
> 
> The lsb register stores its value starting at the bit 7 position.
> adt7316_store_DAC() currently assumes the value is at the other end of the
> register. Shift the lsb value before storing it in a new variable lsb_reg,
> and write this variable to the lsb register.
> 
> Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Applied to the togreg branch fo iio.git and pushed out as testing for the
autobuilders to play with it.

I cc'd Shreeya on all of these.   It would be helpful if you both cc'd
the other one on any future series. Cross review also good given you are both
working with this part!

thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index d7f3d68e525b..6f7891b567b9 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1431,7 +1431,7 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
>  static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
>  				 int channel, const char *buf, size_t len)
>  {
> -	u8 msb, lsb, offset;
> +	u8 msb, lsb, lsb_reg, offset;
>  	u16 data;
>  	int ret;
>  
> @@ -1449,9 +1449,13 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
>  		return -EINVAL;
>  
>  	if (chip->dac_bits > 8) {
> -		lsb = data & (1 << offset);
> +		lsb = data & ((1 << offset) - 1);
> +		if (chip->dac_bits == 12)
> +			lsb_reg = lsb << ADT7316_DA_12_BIT_LSB_SHIFT;
> +		else
> +			lsb_reg = lsb << ADT7316_DA_10_BIT_LSB_SHIFT;
>  		ret = chip->bus.write(chip->bus.client,
> -			ADT7316_DA_DATA_BASE + channel * 2, lsb);
> +			ADT7316_DA_DATA_BASE + channel * 2, lsb_reg);
>  		if (ret)
>  			return -EIO;
>  	}

