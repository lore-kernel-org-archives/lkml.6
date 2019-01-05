Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A38C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17DE218E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546710693;
	bh=yqVQEvMOZsZvvEswMo+hDEcfXbu20+aDs2m213ULL9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xqmFz9CPd9jDn9fKCcKMFifpxbHP3SlK85gJ21jA2uph9Nduy1uZB/hRJmYtz1WTW
	 mXCjt5oy5FefCJlzvfYcmW7ZVj6aowpJYJvdl2pm2XLMguFVp5ub2gauF5aVMi0PcJ
	 aTASTpTzkdCY6SV4327/lWQ/9DwU58F32w5HJOgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfAERvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfAERvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:51:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC60B218EA;
        Sat,  5 Jan 2019 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546710690;
        bh=yqVQEvMOZsZvvEswMo+hDEcfXbu20+aDs2m213ULL9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hGZi5bPJMpMSbpC3+fYocZxQMBf8nyMv1KZR+FypL7qFly1oau6ZV7oRSvteR/VwS
         s6yRW89zOI9H/HGX3CBkzc0H50P19f8yKAlW3tdv3VSJsEASbLeLbyGfLsRhck/83N
         fQZvKhcJ+XhtZW8G0qTWD59zfO0OeUq5/bVwBb1w=
Date:   Sat, 5 Jan 2019 17:51:25 +0000
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
Subject: Re: [PATCH v2 1/4] staging: iio: adt7316: fix dac_bits assignment
Message-ID: <20190105175125.6c3626a7@archlinux>
In-Reply-To: <20181223045743.10716-2-jeremyfertic@gmail.com>
References: <20181223045743.10716-1-jeremyfertic@gmail.com>
        <20181223045743.10716-2-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ CC Shreeya who is working on the same driver.

On Sat, 22 Dec 2018 21:57:40 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> The value of dac_bits is used in adt7316_show_DAC() and adt7316_store_DAC(),
> and it should be either 8, 10, or 12 bits depending on the device in use. The
> driver currently only assigns a value to dac_bits in
> adt7316_store_da_high_resolution(). The purpose of the dac high resolution
> option is not to change dac resolution for normal operation. Instead, it
> is specific to an optional feature where one or two of the four dacs can
> be set to output voltage proportional to temperature. If the user chooses
> to set dac a and/or dac b to output voltage proportional to temperature,
> the da_high_resolution attribute can optionally be enabled to use 10 bit
> resolution rather than the default 8 bits. This is only available on the
> 10 and 12 bit dac devices. If the user attempts to read or write dacs a
> or b under these settings, the driver's current behaviour is to return an
> error. Dacs c and d continue to operate normally under these conditions.
> With the above in mind, remove the dac_bits assignments from this function
> since the value of dac_bits as used in the driver is not dependent on this
> dac high resolution option.
> 
> Since the dac_bits assignments discussed above are currently the only ones
> in this driver, the default value of dac_bits is 0. This results in incorrect
> calculations when the dacs are read or written in adt7316_show_DAC() and
> adt7316_store_DAC(). To correct this, assign a value to dac_bits in
> adt7316_probe() to ensure correct operation as soon as the device is
> registered and available to userspace.
> 
> Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with.  The driver has been broken a long time and
is undergoing a lot of churn at the moment, so I'm not going to rush
this in even though it's a fix.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/addac/adt7316.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 9db49aa186bb..e17c1cb12c94 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -652,17 +652,10 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
>  	u8 config3;
>  	int ret;
>  
> -	chip->dac_bits = 8;
> -
> -	if (buf[0] == '1') {
> +	if (buf[0] == '1')
>  		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
> -		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> -			chip->dac_bits = 12;
> -		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> -			chip->dac_bits = 10;
> -	} else {
> +	else
>  		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
> -	}
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
>  	if (ret)
> @@ -2145,6 +2138,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	else
>  		return -ENODEV;
>  
> +	if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> +		chip->dac_bits = 12;
> +	else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> +		chip->dac_bits = 10;
> +	else
> +		chip->dac_bits = 8;
> +
>  	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac", GPIOD_OUT_LOW);
>  	if (IS_ERR(chip->ldac_pin)) {
>  		ret = PTR_ERR(chip->ldac_pin);

