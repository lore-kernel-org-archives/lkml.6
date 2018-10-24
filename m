Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B91C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42EA2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NohBNGrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42EA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeJXWjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:39:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45794 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJXWjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:39:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id o19-v6so2281536pll.12;
        Wed, 24 Oct 2018 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6sHBfP9gsisosiAyL61rxIONGHARsdgEPnA2SMm3lI8=;
        b=NohBNGrEmeL1L6y1DDxQWQ84zAt0aoZrSgihNvk3+NS5KzMGw5GgITpt2q3WuxvErW
         99sg6+/V7YNMNsTpD+V1QXhb9zxvYhklSpDUB6Y6SPBlGe96O6NoEDQ4zKPwwzZt91po
         Df4OEyv0spdTiFHPjKLmD0bAcZPDVPsir9El8n8nhJvJD1+hXEHhKqykkOCSe+stXT7U
         fdYAwk8LLk1qhnizO9gjGqUccFMBlKQBLaOKwu0Pyg4ElMHqm1FCBsFmD0egu2rnL7SN
         caaahsKlvZAS5fJ2ZKKbLaH1792Yks/oID4rMuE8f2TYLJ5pETmRWoIpVP6JP/0F3GTp
         tEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6sHBfP9gsisosiAyL61rxIONGHARsdgEPnA2SMm3lI8=;
        b=OQKOaMFSnQ5v7T75NR7vHqsLJqR3kin4W7hpyU3Mj7wPR8JYjrQKYKm/wBN790zjqR
         R6srp0zxEL3NogMl7WW5Txzdc6gUKuC2UyjGfKkr9znz3A10fnXaYDtjb0cpIVLGl+Fh
         gUJHYrVF69aJD52GIOwEIq00UsjbYqFiJlDIhapHk5jVeXwBTFlrd1r0Fx12TM1UlQfa
         5YD0zKDgqtBhxxtEWuB59YePe/D74wmgiVBYHLjwDRquW2rlwkWG19HLhwb3ay+LFlrq
         cbdcKVDb1XF/DxCnF4cgFiIhaEKEXHbw9F3wuG1U5Jive2m4dwwcXNRX/5aYvAxhp479
         nQtQ==
X-Gm-Message-State: AGRZ1gLd5i5m2xwb3YYVwTUwiEyGsRBVfs3ns1K9TY+X7yTPYoSte/PR
        82I0V0Mwuvd0X95CebPv/jI=
X-Google-Smtp-Source: AJdET5eYgwB2g1UthLDjxZWk5q3m7N493UGc2R/Tqrtw7ZFEpyylW/dqCfpwAq7TyfTT1MWBG+1cww==
X-Received: by 2002:a17:902:4e:: with SMTP id 72-v6mr2665712pla.204.1540390249782;
        Wed, 24 Oct 2018 07:10:49 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id t4-v6sm955140pfb.44.2018.10.24.07.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 07:10:49 -0700 (PDT)
Date:   Wed, 24 Oct 2018 19:40:42 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181024141037.GA17297@nishad>
References: <20181023190437.GA12974@nishad>
 <20181024065249.GA19150@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181024065249.GA19150@x220.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 08:52:49AM +0200, Slawomir Stepien wrote:
> On paź 24, 2018 00:34, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> 
> Hi Nishad
> 
> Few more comments from me below.
> 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v3:
> >  - Use a pointer to pointer for gpio_desc in
> >    struct ad2s1210_gpio as it will be used to
> >    modify a pointer.
> >  - Use dot notation to initialize the structure.
> >  - Use a pointer variable to avoid writing gpios[i].
> > Changes in v2:
> >  - Use the spi_device struct embedded in st instead
> >    of passing it as an argument to ad2s1210_setup_gpios().
> >  - Use an array of structs to reduce redundant code in
> >    in ad2s1210_setup_gpios().
> >  - Remove ad2s1210_free_gpios() as devm API is being used.
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 92 ++++++++++++++-----------
> >  drivers/staging/iio/resolver/ad2s1210.h |  3 -
> >  2 files changed, 50 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index ac13b99bd9cb..fbf0cc722979 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -15,7 +15,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> >  
> >  #include <linux/iio/iio.h>
> > @@ -69,10 +69,21 @@ enum ad2s1210_mode {
> >  
> >  static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
> >  
> > +struct ad2s1210_gpio {
> > +	struct gpio_desc **ptr;
> > +	const char *name;
> > +	unsigned long flags;
> > +};
> > +
> >  struct ad2s1210_state {
> >  	const struct ad2s1210_platform_data *pdata;
> >  	struct mutex lock;
> >  	struct spi_device *sdev;
> > +	struct gpio_desc *sample;
> > +	struct gpio_desc *a0;
> > +	struct gpio_desc *a1;
> > +	struct gpio_desc *res0;
> > +	struct gpio_desc *res1;
> >  	unsigned int fclkin;
> >  	unsigned int fexcit;
> >  	bool hysteresis;
> > @@ -91,8 +102,8 @@ static const int ad2s1210_mode_vals[4][2] = {
> >  static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
> >  				     struct ad2s1210_state *st)
> >  {
> > -	gpio_set_value(st->pdata->a[0], ad2s1210_mode_vals[mode][0]);
> > -	gpio_set_value(st->pdata->a[1], ad2s1210_mode_vals[mode][1]);
> > +	gpiod_set_value(st->a0, ad2s1210_mode_vals[mode][0]);
> > +	gpiod_set_value(st->a1, ad2s1210_mode_vals[mode][1]);
> >  	st->mode = mode;
> >  }
> >  
> > @@ -152,8 +163,8 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
> >  
> >  static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
> >  {
> > -	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
> > -			  gpio_get_value(st->pdata->res[1]);
> > +	int resolution = (gpiod_get_value(st->res0) << 1) |
> > +			  gpiod_get_value(st->res1);
> >  
> >  	return ad2s1210_resolution_value[resolution];
> >  }
> > @@ -164,10 +175,10 @@ static const int ad2s1210_res_pins[4][2] = {
> >  
> >  static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
> >  {
> > -	gpio_set_value(st->pdata->res[0],
> > -		       ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> > -	gpio_set_value(st->pdata->res[1],
> > -		       ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
> > +	gpiod_set_value(st->res0,
> > +			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> > +	gpiod_set_value(st->res1,
> > +			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
> >  }
> >  
> >  static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
> > @@ -401,15 +412,15 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
> >  	int ret;
> >  
> >  	mutex_lock(&st->lock);
> > -	gpio_set_value(st->pdata->sample, 0);
> > +	gpiod_set_value(st->sample, 0);
> >  	/* delay (2 * tck + 20) nano seconds */
> >  	udelay(1);
> > -	gpio_set_value(st->pdata->sample, 1);
> > +	gpiod_set_value(st->sample, 1);
> >  	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
> >  	if (ret < 0)
> >  		goto error_ret;
> > -	gpio_set_value(st->pdata->sample, 0);
> > -	gpio_set_value(st->pdata->sample, 1);
> > +	gpiod_set_value(st->sample, 0);
> > +	gpiod_set_value(st->sample, 1);
> >  error_ret:
> >  	mutex_unlock(&st->lock);
> >  
> > @@ -466,7 +477,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
> >  	s16 vel;
> >  
> >  	mutex_lock(&st->lock);
> > -	gpio_set_value(st->pdata->sample, 0);
> > +	gpiod_set_value(st->sample, 0);
> >  	/* delay (6 * tck + 20) nano seconds */
> >  	udelay(1);
> >  
> > @@ -512,7 +523,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
> >  	}
> >  
> >  error_ret:
> > -	gpio_set_value(st->pdata->sample, 1);
> > +	gpiod_set_value(st->sample, 1);
> >  	/* delay (2 * tck + 20) nano seconds */
> >  	udelay(1);
> >  	mutex_unlock(&st->lock);
> > @@ -630,30 +641,32 @@ static const struct iio_info ad2s1210_info = {
> >  
> >  static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> >  {
> > -	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
> > -	struct gpio ad2s1210_gpios[] = {
> > -		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
> > -		{ st->pdata->a[0], flags, "a0" },
> > -		{ st->pdata->a[1], flags, "a1" },
> > -		{ st->pdata->res[0], flags, "res0" },
> > -		{ st->pdata->res[0], flags, "res1" },
> > +	int ret, i;
> > +	struct spi_device *spi = st->sdev;
> > +	struct ad2s1210_gpio *pin;
> > +	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
> > +
> > +	struct ad2s1210_gpio gpios[] = {
> > +		{.ptr = &st->sample, .name = "sample", .flags = GPIOD_IN},
> > +		{.ptr = &st->a0, .name = "a0", .flags = flags},
> > +		{.ptr = &st->a1, .name = "a1", .flags = flags},
> > +		{.ptr = &st->res0, .name = "res0", .flags = flags},
> > +		{.ptr = &st->res1, .name = "res1", .flags = flags},
> >  	};
> 
> I think that you should add spaces after { and before }. It's the file style
> from what I see.

Ok. I'll do that.
> 
> >  
> > -	return gpio_request_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> > -}
> > -
> > -static void ad2s1210_free_gpios(struct ad2s1210_state *st)
> > -{
> > -	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
> > -	struct gpio ad2s1210_gpios[] = {
> > -		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
> > -		{ st->pdata->a[0], flags, "a0" },
> > -		{ st->pdata->a[1], flags, "a1" },
> > -		{ st->pdata->res[0], flags, "res0" },
> > -		{ st->pdata->res[0], flags, "res1" },
> > -	};
> > +	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> > +		pin = &gpios[i];
> > +		*pin->ptr = devm_gpiod_get(&spi->dev, pin->name,
> > +					   pin->flags);
> 
> This can now fit into one line.
> 
> > +		if (IS_ERR(pin->ptr)) {
> 
> Here you are checking the wrong pointer. Also notice the line below.
> 

Yes. I'll change that.
> > +			ret = PTR_ERR(pin->ptr);
> > +			dev_err(&spi->dev, "Failed to request %s GPIO: %d\n",
> > +				pin->name, ret);
> 
> Please notice how other dev_err looks like in this code. Align the message to
> the existing format.
> 

Ok. I'll do that.
> > +			return ret;
> > +		}
> > +	}
> >  
> > -	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> > +	return 0;
> >  }
> >  
> >  static int ad2s1210_probe(struct spi_device *spi)
> > @@ -692,7 +705,7 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret)
> > -		goto error_free_gpios;
> > +		return ret;
> >  
> >  	st->fclkin = spi->max_speed_hz;
> >  	spi->mode = SPI_MODE_3;
> > @@ -700,10 +713,6 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  	ad2s1210_initial(st);
> >  
> >  	return 0;
> > -
> > -error_free_gpios:
> > -	ad2s1210_free_gpios(st);
> > -	return ret;
> >  }
> >  
> >  static int ad2s1210_remove(struct spi_device *spi)
> > @@ -711,7 +720,6 @@ static int ad2s1210_remove(struct spi_device *spi)
> >  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> >  
> >  	iio_device_unregister(indio_dev);
> > -	ad2s1210_free_gpios(iio_priv(indio_dev));
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
> > index e9b2147701fc..63d479b20a6c 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.h
> > +++ b/drivers/staging/iio/resolver/ad2s1210.h
> > @@ -12,9 +12,6 @@
> >  #define _AD2S1210_H
> >  
> >  struct ad2s1210_platform_data {
> > -	unsigned int		sample;
> > -	unsigned int		a[2];
> > -	unsigned int		res[2];
> >  	bool			gpioin;
> >  };
> >  #endif /* _AD2S1210_H */
> 
> -- 
> Slawomir Stepien

Thanks for the review.

regards,
Nishad
