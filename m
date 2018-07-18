Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694EAECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1735C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ZqtWZwwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1735C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeGRX0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:26:53 -0400
Received: from vps.xff.cz ([195.181.215.36]:46866 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeGRX0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1531954006; bh=KwbBMOuo6vvvJBoFh/oOb+5t+HNefZoyoCZ0+BvnO7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqtWZwwLYNZnBqMfhFiyOcCG1dv4hO2WY9iTtZlFMhAXxxdIGcmdNQlTItuqepmM0
         faZGgjwJ//iJYcNgBueTtyrg8Zc3L8J8l7aGdj2YP1JC5rfY7QQjfzVwTcUPjX7i36
         JzgDtaTD9hoXB/2m/a6O/yKGwvMxT1aoUzHhw0yA=
Date:   Thu, 19 Jul 2018 00:46:45 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] Input: edt-ft5x06 - Add support for regulator
Message-ID: <20180718224645.ns7nvqxvqc6huxcz@core>
Mail-Followup-To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
 <20180718182719.29663-2-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718182719.29663-2-mylene.josserand@bootlin.com>
If-You-Cant-Reach-Me-Try: <https://megous.com/mail-form>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mylène,

On Wed, Jul 18, 2018 at 08:27:17PM +0200, Mylène Josserand wrote:
> Add the support of regulator to use it as VCC source.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
>  drivers/input/touchscreen/edt-ft5x06.c             | 29 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> index 025cf8c9324a..48e975b9c1aa 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> @@ -30,6 +30,7 @@ Required properties:
>  Optional properties:
>   - reset-gpios: GPIO specification for the RESET input
>   - wake-gpios:  GPIO specification for the WAKE input
> + - vcc-supply:  Regulator that supplies the touchscreen
>  
>   - pinctrl-names: should be "default"
>   - pinctrl-0:   a phandle pointing to the pin settings for the
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 1e18ca0d1b4e..aa94494b06b5 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -39,6 +39,7 @@
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
>  #include <linux/of_device.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define WORK_REGISTER_THRESHOLD		0x00
>  #define WORK_REGISTER_REPORT_RATE	0x08
> @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
>  	struct touchscreen_properties prop;
>  	u16 num_x;
>  	u16 num_y;
> +	struct regulator *vcc;
>  
>  	struct gpio_desc *reset_gpio;
>  	struct gpio_desc *wake_gpio;
> @@ -991,6 +993,22 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  
>  	tsdata->max_support_points = chip_data->max_support_points;
>  
> +	tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
> +	if (IS_ERR(tsdata->vcc)) {
> +		error = PTR_ERR(tsdata->vcc);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&client->dev, "failed to request regulator: %d\n",
> +				error);
> +		return error;
> +	}
> +
> +	error = regulator_enable(tsdata->vcc);
> +	if (error < 0) {
> +		dev_err(&client->dev, "failed to enable vcc: %d\n",
> +			error);
> +		return error;
> +	}
> +
>  	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
>  						     "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(tsdata->reset_gpio)) {
> @@ -1120,20 +1138,31 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
>  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
>  
>  	if (device_may_wakeup(dev))
>  		enable_irq_wake(client->irq);
>  
> +	regulator_disable(tsdata->vcc);
> +

How will the touchscreen wakeup the system with interrupt if you power it off
on suspend? Perhaps guard this with device_may_wakeup() too? 

>  	return 0;
>  }
>  
>  static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> +	int ret;
>  
>  	if (device_may_wakeup(dev))
>  		disable_irq_wake(client->irq);
>  
> +	ret = regulator_enable(tsdata->vcc);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable vcc: %d\n", ret);
> +		return ret;
> +	}
> +

Ditto.

Regards,
  o.

>  	return 0;
>  }
>  
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
