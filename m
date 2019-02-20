Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7960AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6A021848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550678495;
	bh=VA11CboM5qkJIYXUl341o3u+2dd0EkwKSbMV09NscyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XaStWqjl9bKeQONceItRqOsM/kBH6CxDejRXt308486w30tOBtjM0b5VfsXU4xh6S
	 McCGmjmQ2YGspfb93SzZA4PmF52BBN1BOXUiL2hh3w45Q+jZqlXVH1fAVSyfS6npty
	 5xR2JyxbRoKKwxO0FAwPaS8rpzOxqympwbM5b4rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfBTQBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfBTQBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:01:33 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E66A2147A;
        Wed, 20 Feb 2019 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550678492;
        bh=VA11CboM5qkJIYXUl341o3u+2dd0EkwKSbMV09NscyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ic3UeBuo4USauXxARH5ELp+4A6W5Gqjr3vsS/FQ0mhPrAAYjqfKXm7XYXdpNlgp7N
         bgHfCswhGft4dJw6rD2ovkDdkp6+kJCpK4mFGfYyiCT7fYlyJ4JqZQidmoWR/bygXc
         Bl2g+lbG0YNN3gVsfgUJcsmBqpJoH6n8EwA+TAeQ=
Date:   Wed, 20 Feb 2019 16:01:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: cros_ec: Fix gyro scale calculation
Message-ID: <20190220160126.12568f92@archlinux>
In-Reply-To: <20190220150300.3302-1-enric.balletbo@collabora.com>
References: <20190220150300.3302-1-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 16:03:00 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
> 
> Calculation was copied from IIO_DEGREE_TO_RAD, but offset added to avoid
> rounding error is wrong. It should be only half of the divider.
> 
> Fixes: c14dca07a31d ("iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

This one is kind of interesting. See below.

> ---
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 89cb0066a6e0..600942af9f9c 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -103,7 +103,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>  			 * Do not use IIO_DEGREE_TO_RAD to avoid precision
>  			 * loss. Round to the nearest integer.
>  			 */
> -			*val = div_s64(val64 * 314159 + 9000000ULL, 1000);
> +			*val = div_s64(val64 * 314159 + 500ULL, 1000);
That is only one of two divides going on.  Firstly we divide by 1000 here,
then we provide it in fractional form which means that the actual value you get
from sysfs etc is 
val/val2.  It's this one we are protecting against rounding error on I guess.
Now this is even less obviously because it's not 18000 either, but 
18000 * 2^CROS_EC_SENSOR_BITS.

Which ultimately means neither answer is correct. Hmm.
Not totally sure what the right answer actually is..

Jonathan

>  			*val2 = 18000 << (CROS_EC_SENSOR_BITS - 1);
>  			ret = IIO_VAL_FRACTIONAL;
>  			break;

