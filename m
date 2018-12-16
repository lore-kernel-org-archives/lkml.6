Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E238C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3EB21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544960882;
	bh=0RmhPlYhRloPOberTFh5JtK5N6gYp1Z19h586rMpmSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RdcOMYOjoWKS+3/JkmkvBuL+1G/pVNOX4bHd82tKcL8eYB5eJMqHiCo5vXUwwcgWJ
	 0xVyRaHvGP68yhcmrGpGCu4Paufw+baa5geqDneMWzdqWdp3lq+lcmL1jelM8lxhjL
	 aKa2WjTrf7ouQBPXM4THhxDU0ENeiHi3FXtdfhDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbeLPLsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbeLPLsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:48:01 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE684217FB;
        Sun, 16 Dec 2018 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544960880;
        bh=0RmhPlYhRloPOberTFh5JtK5N6gYp1Z19h586rMpmSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zstsRZGSYKZjvUOGe4uwecO1oKEP7oIZRphEgahI88ikon8j8vqHTEj30t2PGxOZ2
         wlhTkDMZsg9ffWrkut3tMEoe95lt8T+q99NHgnBPDpFj2rvDNnBJitQ1jiQSf0p9qM
         VGkXRx1b8YrNEcm7AGIxSuphWB5SmIspMdpYtHm0=
Date:   Sun, 16 Dec 2018 11:47:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] staging: iio: adt7316: fix the dac write
 calculation
Message-ID: <20181216114755.675f3de3@archlinux>
In-Reply-To: <20181212005503.28054-7-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-7-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:54:58 -0700
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
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Looks right to me.

Wow this driver had some impressively wrong maths in it ;)
Glad you are fixing this up.

I'll pick up in v2.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index b7d12d003ddc..77ef3c209b67 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1442,7 +1442,7 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
>  static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
>  				 int channel, const char *buf, size_t len)
>  {
> -	u8 msb, lsb, offset;
> +	u8 msb, lsb, lsb_reg, offset;
>  	u16 data;
>  	int ret;
>  
> @@ -1460,9 +1460,13 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
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

