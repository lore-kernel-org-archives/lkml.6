Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6875C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5BA2147E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxXxddJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5BA2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeHSTyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeHSTyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:54:03 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD75F20671;
        Sun, 19 Aug 2018 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534696920;
        bh=SkuNxo5pl2sZ9VXVBUdlSbwrS+jnmzrGX0TIug4TNsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HxXxddJ2eblRxWOrDx3bsVHSBb/NZaKIkceavSWYRwU5fjWo50DlcFaYM+wnIUV8l
         +RCqO++6O08ADguUq+Ske8v+lMBSOAcmzvyXXkK8b+C3jQi9yrg6FTlW/U/fgouLAd
         vR/popKSetBE7mqn0BXJcYcuzi9M1npJlQZRvfdc=
Date:   Sun, 19 Aug 2018 17:41:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] iio: dac: max5821: avoid using CONFIG_PM_SLEEP
Message-ID: <20180819174155.130eda69@archlinux>
In-Reply-To: <20180811084718.6697-1-marcus.folkesson@gmail.com>
References: <20180811084718.6697-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 10:47:18 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> This is already handled by SIMPLE_DEV_PM_OPS().
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
> Mutt still read the mail correct though.
> 
>  drivers/iio/dac/max5821.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index d0ecc1fdd8fc..f0cf6903dcd2 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -270,8 +270,7 @@ static int max5821_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int max5821_suspend(struct device *dev)
> +static int __maybe_unused max5821_suspend(struct device *dev)
>  {
>  	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
>  			 MAX5821_EXTENDED_DAC_A |
> @@ -281,7 +280,7 @@ static int max5821_suspend(struct device *dev)
>  	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
>  }
>  
> -static int max5821_resume(struct device *dev)
> +static int __maybe_unused max5821_resume(struct device *dev)
>  {
>  	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
>  			 MAX5821_EXTENDED_DAC_A |
> @@ -292,10 +291,6 @@ static int max5821_resume(struct device *dev)
>  }
>  
>  static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
> -#define MAX5821_PM_OPS (&max5821_pm_ops)
> -#else
> -#define MAX5821_PM_OPS NULL
> -#endif /* CONFIG_PM_SLEEP */
>  
>  static const struct iio_info max5821_info = {
>  	.read_raw = max5821_read_raw,
> @@ -392,7 +387,7 @@ static struct i2c_driver max5821_driver = {
>  	.driver = {
>  		.name	= "max5821",
>  		.of_match_table = max5821_of_match,
> -		.pm     = MAX5821_PM_OPS,
> +		.pm     = &max5821_pm_ops,
>  	},
>  	.probe		= max5821_probe,
>  	.remove		= max5821_remove,

