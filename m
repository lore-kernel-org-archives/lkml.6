Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950CDC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D2C21A4E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500101;
	bh=QEo7PX5rqLv9Krp/ERlLOSOHnE2pgLqC2t4JZ7FlVxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Dt70wFmdR/JHlnkjd9cVNPG2S6XFb1tWFYKb4CnwR/jJYe+PYZW5OvrkJCXWhtj/K
	 RqU2fH7KOpuF1xIrPvbgVMLla8VT4G8AW6zLUBuvAawiQYPEi5AmlyKg63RuQik6Kj
	 YfmW981K2bv2xTUxZ17WLY2Jjn3s0gTegdO9e/1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392584AbeLVRfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeLVRfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:35:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D351721A47;
        Sat, 22 Dec 2018 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545500099;
        bh=QEo7PX5rqLv9Krp/ERlLOSOHnE2pgLqC2t4JZ7FlVxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F+TrF3CLABRrBlt0zMVyWn3U2vknA7Kjh2TCM6SVBxD8FAM5LfGowHdCc1u4XKZRK
         3mpzwIlbnlAhImDbfLCCeMInEcIE7YGbAZjBCOLymt5N9vxpMHKC+iwtiRM/pjCkvU
         kcrmBAzmSfxn+tU/wZo8xShn3NLuG5mG07TRyYEI=
Date:   Sat, 22 Dec 2018 17:34:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ad9523: fix a missing check of return value
Message-ID: <20181222173454.5387f5bc@archlinux>
In-Reply-To: <20181220072122.40469-1-kjlu@umn.edu>
References: <20181220072122.40469-1-kjlu@umn.edu>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 01:21:22 -0600
Kangjie Lu <kjlu@umn.edu> wrote:

> If ad9523_write() fails, indio_dev may get incorrect data. The fix
> inserts a check for the return value of ad9523_write(), and it fails,
> returns an error.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/ad9523.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index f3f94fbdd20a..3f9be69499ec 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -943,11 +943,14 @@ static int ad9523_setup(struct iio_dev *indio_dev)
>  		}
>  	}
>  
> -	for_each_clear_bit(i, &active_mask, AD9523_NUM_CHAN)
> -		ad9523_write(indio_dev,
> +	for_each_clear_bit(i, &active_mask, AD9523_NUM_CHAN) {
> +		ret = ad9523_write(indio_dev,
>  			     AD9523_CHANNEL_CLOCK_DIST(i),
>  			     AD9523_CLK_DIST_DRIVER_MODE(TRISTATE) |
>  			     AD9523_CLK_DIST_PWR_DOWN_EN);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = ad9523_write(indio_dev, AD9523_POWER_DOWN_CTRL, 0);
>  	if (ret < 0)

