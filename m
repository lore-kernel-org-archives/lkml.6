Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8652146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550679518;
	bh=ASqfysCwL+tC33N/uzRs0kWMrQM+XaI/iaFEtun+8nU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=udP4eP+Oz8chgjqAURWZ32RVKf/L5xXBLub6b25zkX1pGE6V20yrjPX40F+0aQyLL
	 +KLrsHADJ4Iy3ZQiQ8BAp/6ugGshQ44leFTmA9QAkeDjxcFqEu+o25Kb8Xbiigyya4
	 1XYQPQlzZrMbJattvPPPSna+bkSuHFgBwDTA+qj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfBTQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfBTQSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:18:36 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF41F20880;
        Wed, 20 Feb 2019 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550679514;
        bh=ASqfysCwL+tC33N/uzRs0kWMrQM+XaI/iaFEtun+8nU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FbkdnERMaVjd78abn0Mig7QSsFA6tqWzJ61tmk+Ifpk7EeE+qe8Dd6ahm2djqaaFr
         o1Ia1y0eMOAhhrTbf8uJMbTazPa1yC8qnECi9NNsAFVV922e5RH30tVvy1jqX03B1e
         YFxw2FBLUAdhy9Tem8JIaEFifKJBjT34ZDOro1vw=
Date:   Wed, 20 Feb 2019 16:18:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] iio: accel: bma180: convert to devm
Message-ID: <20190220161828.0c6fcd8e@archlinux>
In-Reply-To: <900f59b94ef2e1b5559b363c0d1af4fefccd0366.1550671256.git.hns@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com>
        <900f59b94ef2e1b5559b363c0d1af4fefccd0366.1550671256.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 15:00:52 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> This simplifies the code a little.
It does, but at the cost of introducing potential race conditions.
Please don't do this.  See below for why and a suggestion on how
to resolve things if you want to make this change safely.

Jonathan
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/iio/accel/bma180.c | 56 ++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 248be67e4f41..3f5ee2d495d3 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -738,7 +738,7 @@ static int bma180_probe(struct i2c_client *client,
>  
>  	ret = data->part_info->chip_config(data);
>  	if (ret < 0)
> -		goto err_chip_disable;
> +		goto err;
>  
>  	mutex_init(&data->mutex);
>  	indio_dev->dev.parent = &client->dev;
> @@ -748,12 +748,25 @@ static int bma180_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bma180_info;
>  
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +			bma180_trigger_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
> +		goto err;
> +	}
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "unable to register iio device\n");
> +		goto err;
> +	}
> +
>  	if (client->irq > 0) {
> -		data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> -			indio_dev->id);
> +		data->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +			indio_dev->name, indio_dev->id);
>  		if (!data->trig) {
>  			ret = -ENOMEM;
> -			goto err_chip_disable;
> +			goto err;
>  		}
>  
>  		ret = devm_request_irq(&client->dev, client->irq,
> @@ -761,7 +774,7 @@ static int bma180_probe(struct i2c_client *client,
>  			"bma180_event", data->trig);
>  		if (ret) {
>  			dev_err(&client->dev, "unable to request IRQ\n");
> -			goto err_trigger_free;
> +			goto err;
>  		}
>  
>  		data->trig->dev.parent = &client->dev;
> @@ -769,34 +782,14 @@ static int bma180_probe(struct i2c_client *client,
>  		iio_trigger_set_drvdata(data->trig, indio_dev);
>  		indio_dev->trig = iio_trigger_get(data->trig);
>  
> -		ret = iio_trigger_register(data->trig);
> +		ret = devm_iio_trigger_register(&client->dev, data->trig);
>  		if (ret)
> -			goto err_trigger_free;
> -	}
> -
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -			bma180_trigger_handler, NULL);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
> -		goto err_trigger_unregister;
> -	}
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "unable to register iio device\n");
> -		goto err_buffer_cleanup;
> +			goto err;
>  	}
>  
>  	return 0;
>  
> -err_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -err_trigger_unregister:
> -	if (data->trig)
> -		iio_trigger_unregister(data->trig);
> -err_trigger_free:
> -	iio_trigger_free(data->trig);
> -err_chip_disable:
> +err:
>  	data->part_info->chip_disable(data);
>  
>  	return ret;
> @@ -807,13 +800,6 @@ static int bma180_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct bma180_data *data = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	if (data->trig) {
> -		iio_trigger_unregister(data->trig);
> -		iio_trigger_free(data->trig);
> -	}
> -
Now we disable the device before removing it's userspace interface.
Not a good idea.

Generally I will insist on the remove order always being the precise
opposite of probe simply because it is obviously correct.
That includes cases which can be simply argued to be fine (not
this one which isn't). The reason is readability trumps saving
a few lines of code and it's a lot easier to check a probe and
remove function against each other if the order is maintained.

Of course, there are ways to do this by making all the unwind
managed, but you haven't done this here.
devm_add_action_or_reset is handy for this if you want to do it.

>  	mutex_lock(&data->mutex);
>  	data->part_info->chip_disable(data);
>  	mutex_unlock(&data->mutex);

