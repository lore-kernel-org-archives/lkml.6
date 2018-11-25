Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6813120867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zA2cE7Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6813120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeKYVeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbeKYVeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:34:12 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F352084E;
        Sun, 25 Nov 2018 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543142604;
        bh=dJ3HZ4GvUlWqY07oNOgodpeyqcm6N2Iq2wX+yYcc1Z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zA2cE7Mq4nfnoflQdhLezoRzmQb8hFmLOSrlDRoSSQ/Yeux/aVPJfR3v6olczA3wh
         j8TO0vbld61Cmairk2L8KW2ohcir1JTQ6Awfm7sOfKc3q5T4POro4GbBMTa+5Heml+
         vj6oP9peECwcQVk4sRKTY1J5gkbHhcjhe5Z1Guao=
Date:   Sun, 25 Nov 2018 10:43:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: adc: meson-saradc: fix internal clock names
Message-ID: <20181125104320.06d65625@archlinux>
In-Reply-To: <20181122220111.28808-2-martin.blumenstingl@googlemail.com>
References: <20181122220111.28808-1-martin.blumenstingl@googlemail.com>
        <20181122220111.28808-2-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 23:01:11 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Before this patch we are registering the internal clocks (for example on
> Meson8b, where the SAR ADC IP block implements the divider and gate
> clocks) with the following names:
> - /soc/cbus@c1100000/adc@8680#adc_div
> - /soc/cbus@c1100000/adc@8680#adc_en
> 
> This is bad because the common clock framework uses the clock to create
> a directory in <debugfs>/clk. With such name, the directory creation
> (silently) fails and the debugfs entry ends up being created at the
> debugfs root.
> 
> With this change, the new clock names are:
> - c1108680.adc#adc_div
> - c1108680.adc#adc_en
> 
> This matches the clock naming scheme used in the PWM, Ethernet and MMC
> drivers. It also fixes the problem with debugfs.
> The idea is shamelessly taken from commit b96e9eb62841c5 ("pwm: meson:
> Fix mux clock names").
> 
> Fixes: 3921db46a8c5bc ("iio: Convert to using %pOF instead of full_name")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
As this is debugfs I am not going to push this through the fast path.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 6155d26091eb..729becb2d3d9 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -656,8 +656,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  	struct clk_init_data init;
>  	const char *clk_parents[1];
>  
> -	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_div",
> -				   indio_dev->dev.of_node);
> +	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
> +				   dev_name(indio_dev->dev.parent));
>  	if (!init.name)
>  		return -ENOMEM;
>  
> @@ -678,8 +678,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  	if (WARN_ON(IS_ERR(priv->adc_div_clk)))
>  		return PTR_ERR(priv->adc_div_clk);
>  
> -	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_en",
> -				   indio_dev->dev.of_node);
> +	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_en",
> +				   dev_name(indio_dev->dev.parent));
>  	if (!init.name)
>  		return -ENOMEM;
>  

