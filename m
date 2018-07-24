Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C654ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EC320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EC320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbeGXOrW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:47:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33693 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388338AbeGXOrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:47:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4A14A2073D; Tue, 24 Jul 2018 15:40:47 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id E5388203D9;
        Tue, 24 Jul 2018 15:40:36 +0200 (CEST)
Date:   Tue, 24 Jul 2018 15:40:37 +0200
From:   =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] Input: edt-ft5x06 - Add support for regulator
Message-ID: <20180724154037.25174c07@dell-desktop.home>
In-Reply-To: <20180723223926.GL100814@dtor-ws>
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
        <20180718182719.29663-2-mylene.josserand@bootlin.com>
        <20180718224645.ns7nvqxvqc6huxcz@core>
        <20180723223926.GL100814@dtor-ws>
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

Thank you for your review!

On Mon, 23 Jul 2018 15:39:26 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Thu, Jul 19, 2018 at 12:46:45AM +0200, Ondřej Jirman wrote:
> > Hello Mylène,
> > 
> > On Wed, Jul 18, 2018 at 08:27:17PM +0200, Mylène Josserand wrote:  
> > > Add the support of regulator to use it as VCC source.
> > > 
> > > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > > ---
> > >  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
> > >  drivers/input/touchscreen/edt-ft5x06.c             | 29 ++++++++++++++++++++++
> > >  2 files changed, 30 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > index 025cf8c9324a..48e975b9c1aa 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > @@ -30,6 +30,7 @@ Required properties:
> > >  Optional properties:
> > >   - reset-gpios: GPIO specification for the RESET input
> > >   - wake-gpios:  GPIO specification for the WAKE input
> > > + - vcc-supply:  Regulator that supplies the touchscreen
> > >  
> > >   - pinctrl-names: should be "default"
> > >   - pinctrl-0:   a phandle pointing to the pin settings for the
> > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > > index 1e18ca0d1b4e..aa94494b06b5 100644
> > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > @@ -39,6 +39,7 @@
> > >  #include <linux/input/mt.h>
> > >  #include <linux/input/touchscreen.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/regulator/consumer.h>
> > >  
> > >  #define WORK_REGISTER_THRESHOLD		0x00
> > >  #define WORK_REGISTER_REPORT_RATE	0x08
> > > @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
> > >  	struct touchscreen_properties prop;
> > >  	u16 num_x;
> > >  	u16 num_y;
> > > +	struct regulator *vcc;
> > >  
> > >  	struct gpio_desc *reset_gpio;
> > >  	struct gpio_desc *wake_gpio;
> > > @@ -991,6 +993,22 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
> > >  
> > >  	tsdata->max_support_points = chip_data->max_support_points;
> > >  
> > > +	tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
> > > +	if (IS_ERR(tsdata->vcc)) {
> > > +		error = PTR_ERR(tsdata->vcc);
> > > +		if (error != -EPROBE_DEFER)
> > > +			dev_err(&client->dev, "failed to request regulator: %d\n",
> > > +				error);
> > > +		return error;
> > > +	}
> > > +
> > > +	error = regulator_enable(tsdata->vcc);
> > > +	if (error < 0) {
> > > +		dev_err(&client->dev, "failed to enable vcc: %d\n",
> > > +			error);
> > > +		return error;
> > > +	}
> > > +
> > >  	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
> > >  						     "reset", GPIOD_OUT_HIGH);
> > >  	if (IS_ERR(tsdata->reset_gpio)) {  
> 
> You need to disable regulator here. We do not have
> devm_regulator_enable() (and Mark had some concerns about mixing managed
> and unmanaged APIs for regulators so we can't simply introduce it),
> so I'd recommend using devm_add_action_or_reset() and iunstall custom
> action to turn off regulator.

Yep, I see. Thank you about "devm_add_action_or_reset", I did not know
this function. I will add it in next version.

> 
> > > @@ -1120,20 +1138,31 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
> > >  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
> > >  {
> > >  	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> > >  
> > >  	if (device_may_wakeup(dev))
> > >  		enable_irq_wake(client->irq);
> > >  
> > > +	regulator_disable(tsdata->vcc);
> > > +  
> > 
> > How will the touchscreen wakeup the system with interrupt if you power it off
> > on suspend? Perhaps guard this with device_may_wakeup() too?   
> 
> Exactly, it should be in an "else" branch.
> 
> Thanks.
> 

I see, I will add it in v4.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
