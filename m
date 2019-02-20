Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F10C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90B72147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550658037;
	bh=z2pN6gqw9dJSz+KlwnI2Ir4v6pm/sy9t0RnyvQTcVSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GQSZixo/AXNI0izeCeBE/52yg2GLON7I6Lk1pUFtq0rvA+mNFojGQVHeoyHsoZJfl
	 5xirfq3NFzk9+k9ngbHo8vydFMSOh/1jyIr+UJ0uJVmDKKSPCrgiWu+pZL2UxQoKfW
	 R/bwGzzrXguOzabCzlcl1nCHsrGvDTxA/Gs958Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfBTKUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfBTKUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:20:33 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804472146E;
        Wed, 20 Feb 2019 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550658032;
        bh=z2pN6gqw9dJSz+KlwnI2Ir4v6pm/sy9t0RnyvQTcVSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VoMTkp4QFdHB86sd4C4X0Zpw9PuRHlo8j4QJLuRRqyPy3mg2+ovZlZ5fjoh6Zxs4e
         OYqUk/v8KQWFik/Yuyb4hWWQ+mTK0pXiLdjJXagV7H2IHtLlFpbPamQdSbUE866T/4
         1m/Mmiwopgbtqw8F2lSjvi11pzC8xugTXjTN87c0=
Date:   Wed, 20 Feb 2019 10:20:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/6] iio: imu: adis16480: Use the default data ready pin
 configuration
Message-ID: <20190220102002.5f918e74@archlinux>
In-Reply-To: <1550596338-24220-2-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
        <1550596338-24220-2-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 19:12:13 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The FNCTIO_CTRL register, Bits[3:0] provide three configuration options
> for the data ready function: on/off, polarity, and DIOx line. The
> factory default assigns DIO2 as a positive polarity, data ready signal.
> 
> The adis16480_enable_irq() function, overwrites this configuration when
> it enables/disables the data ready pin by only setting BIT[3].
> As a result, the data ready signal becomes DIO1 pin which is assigned as
> negative polarity.
> 
> This patch reads the FNCTIO_CTRL register and creates a mask, such that
> only data ready enable (BIT[3]) will be modified when
> adis16480_enable_irq function is called.

So this is potentially a problem.  As I read this, we just changed the default.
So a device that has been relying on this 'bug' for a long time will now
not work as it will be expecting the interrupt on the wrong physical pin.

So, whilst it might seem logical to let the device stay with it's default
we can't do it because the defacto Linux default is the other choice.

The delights of having to support old 'bugs' :)

Jonathan
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  drivers/iio/imu/adis16480.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index a27fe20..d222188 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -9,6 +9,7 @@
>   *
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> @@ -107,6 +108,10 @@
>  #define ADIS16480_FIR_COEF_C(x)			ADIS16480_FIR_COEF(0x09, (x))
>  #define ADIS16480_FIR_COEF_D(x)			ADIS16480_FIR_COEF(0x0B, (x))
>  
> +/* ADIS16480_REG_FNCTIO_CTRL */
> +#define ADIS16480_DRDY_EN_MSK		BIT(3)
> +#define ADIS16480_DRDY_EN(x)		FIELD_PREP(ADIS16480_DRDY_EN_MSK, x)
> +
>  struct adis16480_chip_info {
>  	unsigned int num_channels;
>  	const struct iio_chan_spec *channels;
> @@ -741,8 +746,17 @@ static int adis16480_stop_device(struct iio_dev *indio_dev)
>  
>  static int adis16480_enable_irq(struct adis *adis, bool enable)
>  {
> -	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL,
> -		enable ? BIT(3) : 0);
> +	uint16_t val;
> +	int ret;
> +
> +	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val &= ~ADIS16480_DRDY_EN_MSK;
> +	val |= ADIS16480_DRDY_EN(enable);
> +
> +	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
>  }
>  
>  static int adis16480_initial_setup(struct iio_dev *indio_dev)

