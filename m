Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86A8C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96406223DF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546710918;
	bh=ze70YVLrHSkambMqyHRknCK+tPO5y2Rm3lOFhnUerbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NeiAPvQPCoN9LaAO4viQcPVftFFkvF5ABLtYdo3sWSPdKvaIRXg9S0MrO8FRzKk0h
	 Vkux5Mk0VUkzzwh63as1KwGtElKrxUPLLybm3Iy3QqMLInqpoy/6zve3xycPmpsxsS
	 RUUTPap8uvfQeC/9i7F43hLJWjb0ULRqaPzoc3Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfAERzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbfAERzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:55:16 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA3222314;
        Sat,  5 Jan 2019 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546710916;
        bh=ze70YVLrHSkambMqyHRknCK+tPO5y2Rm3lOFhnUerbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M6kqzt0OB4GtDInuhFF3oB2CWfTOGAeRSvzbwt1gfwUCCvk/Z7psSsyus7YDpQAi5
         uz5Ob7T9UC0b5gUiBS+2Vj/YRMsVDwMq0BPS/0F780xZiYa8CPrS/2wFKGy7bT4Q55
         GB3gHAhahMHPp+dDw85f6QGTVNr5L4WUKTjn132w=
Date:   Sat, 5 Jan 2019 17:55:11 +0000
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
Subject: Re: [PATCH v2 3/4] staging: iio: adt7316: fix the dac read
 calculation
Message-ID: <20190105175511.2edcb939@archlinux>
In-Reply-To: <20181223045743.10716-4-jeremyfertic@gmail.com>
References: <20181223045743.10716-1-jeremyfertic@gmail.com>
        <20181223045743.10716-4-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 21:57:42 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> The calculation of the current dac value is using the wrong bits of the
> dac lsb register. Create two macros to shift the lsb register value into
> lsb position, depending on whether the dac is 10 or 12 bit. Initialize
> data to 0 so, with an 8 bit dac, the msb register value can be bitwise
> ORed with data.
> 
> Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 80cc3420036b..d7f3d68e525b 100644
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
> @@ -1392,7 +1394,7 @@ static IIO_DEVICE_ATTR(ex_analog_temp_offset, 0644,
>  static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
>  				int channel, char *buf)
>  {
> -	u16 data;
> +	u16 data = 0;
>  	u8 msb, lsb, offset;
>  	int ret;
>  
> @@ -1417,7 +1419,11 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
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

