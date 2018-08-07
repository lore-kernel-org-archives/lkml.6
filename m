Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B163C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D567C208E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D567C208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbeHGJMv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:12:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50256 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbeHGJMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:12:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DB9E2207D4; Tue,  7 Aug 2018 08:59:53 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-99-143.w90-88.abo.wanadoo.fr [90.88.4.143])
        by mail.bootlin.com (Postfix) with ESMTPSA id 93AD92072C;
        Tue,  7 Aug 2018 08:59:43 +0200 (CEST)
Date:   Tue, 7 Aug 2018 08:59:44 +0200
From:   =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v4 1/3] Input: edt-ft5x06 - Add support for regulator
Message-ID: <20180807085944.337bf20b@dell-desktop.home>
In-Reply-To: <20180726004732.GD80336@dtor-ws>
References: <20180725073410.730-1-mylene.josserand@bootlin.com>
        <20180725073410.730-2-mylene.josserand@bootlin.com>
        <20180726004732.GD80336@dtor-ws>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

Thank you again for the review.

On Wed, 25 Jul 2018 17:47:32 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Mylène,
> 
> On Wed, Jul 25, 2018 at 09:34:08AM +0200, Mylène Josserand wrote:
> > Add the support of regulator to use it as VCC source.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
> >  drivers/input/touchscreen/edt-ft5x06.c             | 43 ++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > index 025cf8c9324a..48e975b9c1aa 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > @@ -30,6 +30,7 @@ Required properties:
> >  Optional properties:
> >   - reset-gpios: GPIO specification for the RESET input
> >   - wake-gpios:  GPIO specification for the WAKE input
> > + - vcc-supply:  Regulator that supplies the touchscreen
> >  
> >   - pinctrl-names: should be "default"
> >   - pinctrl-0:   a phandle pointing to the pin settings for the
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > index 1e18ca0d1b4e..dcde719094f7 100644
> > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/input/mt.h>
> >  #include <linux/input/touchscreen.h>
> >  #include <linux/of_device.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #define WORK_REGISTER_THRESHOLD		0x00
> >  #define WORK_REGISTER_REPORT_RATE	0x08
> > @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
> >  	struct touchscreen_properties prop;
> >  	u16 num_x;
> >  	u16 num_y;
> > +	struct regulator *vcc;
> >  
> >  	struct gpio_desc *reset_gpio;
> >  	struct gpio_desc *wake_gpio;
> > @@ -963,6 +965,13 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
> >  	}
> >  }
> >  
> > +static void edt_ft5x06_disable_regulator(void *arg)
> > +{
> > +	struct edt_ft5x06_ts_data *data = arg;
> > +
> > +	regulator_disable(data->vcc);
> > +}
> > +
> >  static int edt_ft5x06_ts_probe(struct i2c_client *client,
> >  					 const struct i2c_device_id *id)
> >  {
> > @@ -991,6 +1000,28 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
> >  
> >  	tsdata->max_support_points = chip_data->max_support_points;
> >  
> > +	tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
> > +	if (IS_ERR(tsdata->vcc)) {
> > +		error = PTR_ERR(tsdata->vcc);
> > +		if (error != -EPROBE_DEFER)
> > +			dev_err(&client->dev, "failed to request regulator: %d\n",
> > +				error);
> > +		return error;
> > +	}
> > +
> > +	error = regulator_enable(tsdata->vcc);
> > +	if (error < 0) {
> > +		dev_err(&client->dev, "failed to enable vcc: %d\n",
> > +			error);
> > +		return error;
> > +	}  
> 
> It is better to put the chip into reset and then power up the regulatori
> and take it out of the reset, rather than power up and then toggle reset
> on and off.

okay, thanks, I will update it.

> 
> > +
> > +	error = devm_add_action_or_reset(&client->dev,
> > +					 edt_ft5x06_disable_regulator,
> > +					 tsdata);
> > +	if (error)
> > +		return error;
> > +
> >  	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
> >  						     "reset", GPIOD_OUT_HIGH);
> >  	if (IS_ERR(tsdata->reset_gpio)) {
> > @@ -1120,9 +1151,12 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
> >  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> > +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> >  
> >  	if (device_may_wakeup(dev))
> >  		enable_irq_wake(client->irq);
> > +	else
> > +		regulator_disable(tsdata->vcc);
> >  
> >  	return 0;
> >  }
> > @@ -1130,9 +1164,18 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
> >  static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> > +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> > +	int ret;
> >  
> >  	if (device_may_wakeup(dev))
> >  		disable_irq_wake(client->irq);
> > +	else {
> > +		ret = regulator_enable(tsdata->vcc);
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to enable vcc: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}  
> 
> I believe I mentioned in other review that once you powered up the
> device, you need to restore its settings, include switching to factory
> mode, if it was in factory mode, and restoring threshold/gain/offset
> settings.

Yes, I will update the driver with that but as I told you in a previous
mail, I can't test the suspend/resume :(

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
