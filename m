Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67B6C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B840D21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544960738;
	bh=Y/6thFYvlIRLgXsiCfX9HYMUbncgupeIWrOqHrZX73U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r8Mt2g5tkF3qhMehELbHIr8MD+yAz9FbGp8d6UU0xqkBW7UqCzIfIwQbfZuEK/aZB
	 zcr7quRJNWTVx6DchWJMg8HMPZBJ2OQ1cigWSke6O0Dr7q5adm6XsLJC2o1BWrT+N4
	 5KYS8Am8d3l0nyZWu4mzZRKTZFKtxTZShJ91WctI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeLPLpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbeLPLph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:45:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35CE3217FB;
        Sun, 16 Dec 2018 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544960736;
        bh=Y/6thFYvlIRLgXsiCfX9HYMUbncgupeIWrOqHrZX73U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=infhno3XaAzCK8HkeH/hb99Xjj0Ke+PxLNTJwk01Bhas+bkGTw+FqDF0FEDPgQVzi
         ZruVT3PnyjRwZYXtKYYVL332CAD4kQNmF3ehxZBiG45yszbb7ZyWkQBBABWj6R2bZj
         QgFFM6VaMy4/WEgK1wZi0i6+8w4QukvXNsBJsn0w=
Date:   Sun, 16 Dec 2018 11:45:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] staging: iio: adt7316: fix the dac read
 calculation
Message-ID: <20181216114531.67bab793@archlinux>
In-Reply-To: <20181212005503.28054-6-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-6-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:54:57 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> The calculation of the current dac value is using the wrong bits of the
> dac lsb register. Create two macros to shift the lsb register value into
> lsb position, depending on whether the dac is 10 or 12 bit. Initialize
> data to 0 so, with an 8 bit dac, the msb register value can be bitwise
> ORed with data.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
This looks good, but with the previous 2 patches under discussion I'll
hold this one for v2.

Thanks

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index eee7c04f93f4..b7d12d003ddc 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -47,6 +47,8 @@
>  #define ADT7516_MSB_AIN3		0xA
>  #define ADT7516_MSB_AIN4		0xB
>  #define ADT7316_DA_DATA_BASE		0x10
> +#define ADT7316_DA_10_BIT_LSB_SHIFT	6
> +#define ADT7316_DA_12_BIT_LSB_SHIFT	4
>  #define ADT7316_DA_MSB_DATA_REGS	4
>  #define ADT7316_LSB_DAC_A		0x10
>  #define ADT7316_MSB_DAC_A		0x11
> @@ -1403,7 +1405,7 @@ static IIO_DEVICE_ATTR(ex_analog_temp_offset, 0644,
>  static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
>  				int channel, char *buf)
>  {
> -	u16 data;
> +	u16 data = 0;
>  	u8 msb, lsb, offset;
>  	int ret;
>  
> @@ -1428,7 +1430,11 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
>  	if (ret)
>  		return -EIO;
>  
> -	data = (msb << offset) + (lsb & ((1 << offset) - 1));
> +	if (chip->dac_bits == 12)
> +		data = lsb >> ADT7316_DA_12_BIT_LSB_SHIFT;
> +	else if (chip->dac_bits == 10)
> +		data = lsb >> ADT7316_DA_10_BIT_LSB_SHIFT;
> +	data |= msb << offset;
>  
>  	return sprintf(buf, "%d\n", data);
>  }

