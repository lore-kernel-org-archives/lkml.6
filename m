Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A89C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE9821836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeLPOEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:04:43 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:55152 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 09:04:43 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 3CFDF9E7B45;
        Sun, 16 Dec 2018 14:04:37 +0000 (GMT)
Date:   Sun, 16 Dec 2018 14:04:36 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6] iio: light: isl29018: add optional vcc regulator
 operation support
Message-ID: <20181216140436.6f2b37dc@archlinux>
In-Reply-To: <20181216124413.40c6a63c@archlinux>
References: <1544681529-22268-1-git-send-email-Anson.Huang@nxp.com>
        <20181216124413.40c6a63c@archlinux>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018 12:44:13 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 13 Dec 2018 06:18:07 +0000
> Anson Huang <anson.huang@nxp.com> wrote:
> 
> > The light sensor's power supply could be controlled by regulator
> > on some platforms, such as i.MX6Q-SABRESD board, the light sensor
> > isl29023's power supply is controlled by a GPIO fixed regulator,
> > need to make sure the regulator is enabled before any operation of
> > sensor, this patch adds optional vcc regulator operation support.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Sorry, I've been sleep walking through these and missed the big obvious
thing.

These shouldn't be optional regulators at all.  If one isn't specified
we do want to fall back to a stub regulator.

Just because we can't see or control the power supply doesn't mean it
shouldn't be there.

The exception to this is where we have a regulator providing a voltage
reference where there is an alternative internal reference.
In those cases there might be nothing connected to the pin and hence
it really is 'optional'.  We want to do something else if it's not
there.  Power supplies are just invisible, not optional and the
regulator framework has always handled that for us.

Jonathan

> > ---
> > ChangeLog since V5:
> > 	Since the dt-binding doc states the power supply name is "vdd" and many dts files already using
> > 	"vcc" as the power supply name, althoug it does NOT match the datasheet which has "vdd", to make
> > 	it NOT breaking existing dtb files, just use "vcc" as the regulator name.
> > ---
> >  drivers/iio/light/isl29018.c | 47 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 44 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> > index b45400f..76c3a48 100644
> > --- a/drivers/iio/light/isl29018.c
> > +++ b/drivers/iio/light/isl29018.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/delay.h>
> >  #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -95,6 +96,7 @@ struct isl29018_chip {
> >  	struct isl29018_scale	scale;
> >  	int			prox_scheme;
> >  	bool			suspended;
> > +	struct regulator	*vcc_reg;
> >  };
> >  
> >  static int isl29018_set_integration_time(struct isl29018_chip *chip,
> > @@ -735,6 +737,19 @@ static int isl29018_probe(struct i2c_client *client,
> >  
> >  	mutex_init(&chip->lock);
> >  
> > +	chip->vcc_reg = devm_regulator_get_optional(&client->dev, "vcc");
> > +	if (!IS_ERR(chip->vcc_reg)) {
> > +		err = regulator_enable(chip->vcc_reg);
> > +		if (err) {
> > +			dev_err(&client->dev, "failed to enable VCC regulator\n");
> > +			return err;
> > +		}
> > +	} else {
> > +		err = PTR_ERR(chip->vcc_reg);
> > +		if (err != -ENODEV)
> > +			return err;
> > +	}
> > +
> >  	chip->type = dev_id;
> >  	chip->calibscale = 1;
> >  	chip->ucalibscale = 0;
> > @@ -747,12 +762,12 @@ static int isl29018_probe(struct i2c_client *client,
> >  	if (IS_ERR(chip->regmap)) {
> >  		err = PTR_ERR(chip->regmap);
> >  		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
> > -		return err;
> > +		goto disable_regulator;
> >  	}
> >  
> >  	err = isl29018_chip_init(chip);
> >  	if (err)
> > -		return err;
> > +		goto disable_regulator;
> >  
> >  	indio_dev->info = isl29018_chip_info_tbl[dev_id].indio_info;
> >  	indio_dev->channels = isl29018_chip_info_tbl[dev_id].channels;
> > @@ -761,13 +776,22 @@ static int isl29018_probe(struct i2c_client *client,
> >  	indio_dev->dev.parent = &client->dev;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> > -	return devm_iio_device_register(&client->dev, indio_dev);
> > +	err = devm_iio_device_register(&client->dev, indio_dev);
> > +	if (!err)
> > +		return 0;  
> Don't make this change.  It makes the code less readable.  
> 
> Right now you don't turn the regulator off in remove at all and
> you definitely should.
> 
> You should not be mixing managed and unmanaged calls.
> This is because you will end up with race conditions.  Here the
> regulators are disabled before the automated unwinding calls
> device unregister.  Hence we have a window in which the power
> is turned off but the userspace interfaces are still there.
> 
> Weird crashes likely to follow!
> 
> Two options:
> 1) For everything after the power on change from devm to non
> devm and do the unwinding.
> 2) Use devm_add_action_or_reset to automatically handle
> the unwinding of the regulator enable.  The result being that
> it is back in the right place order wise.
> 
> 
> 
> > +
> > +disable_regulator:
> > +	if (!IS_ERR(chip->vcc_reg))
> > +		regulator_disable(chip->vcc_reg);
> > +
> > +	return err;
> >  }
> >  
> >  #ifdef CONFIG_PM_SLEEP
> >  static int isl29018_suspend(struct device *dev)
> >  {
> >  	struct isl29018_chip *chip = iio_priv(dev_get_drvdata(dev));
> > +	int ret;
> >  
> >  	mutex_lock(&chip->lock);
> >  
> > @@ -777,6 +801,14 @@ static int isl29018_suspend(struct device *dev)
> >  	 * So we do not have much to do here.
> >  	 */
> >  	chip->suspended = true;
> > +	if (!IS_ERR(chip->vcc_reg)) {
> > +		ret = regulator_disable(chip->vcc_reg);
> > +		if (ret) {
> > +			dev_err(dev, "failed to disable VCC regulator\n");
> > +			mutex_unlock(&chip->lock);
> > +			return ret;
> > +		}
> > +	}
> >  
> >  	mutex_unlock(&chip->lock);
> >  
> > @@ -790,6 +822,15 @@ static int isl29018_resume(struct device *dev)
> >  
> >  	mutex_lock(&chip->lock);
> >  
> > +	if (!IS_ERR(chip->vcc_reg)) {
> > +		err = regulator_enable(chip->vcc_reg);
> > +		if (err) {
> > +			dev_err(dev, "failed to enable VCC regulator\n");
> > +			mutex_unlock(&chip->lock);
> > +			return err;
> > +		}
> > +	}
> > +
> >  	err = isl29018_chip_init(chip);
> >  	if (!err)
> >  		chip->suspended = false;  
> 

