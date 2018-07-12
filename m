Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782CCC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6FE213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6FE213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbeGLNi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:38:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbeGLNi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:38:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5A343B83A128D;
        Thu, 12 Jul 2018 21:29:08 +0800 (CST)
Received: from localhost (10.202.226.43) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Thu, 12 Jul 2018
 21:29:03 +0800
Date:   Thu, 12 Jul 2018 14:28:53 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
CC:     Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180712142853.00005f64@huawei.com>
In-Reply-To: <CAJCx=g=ud98YWOAhepZOV_D_s8pfNx_PnyXis=WjX1O_XkzRvQ@mail.gmail.com>
References: <1531311229-3586-1-git-send-email-himanshujha199640@gmail.com>
        <CAJCx=g=ud98YWOAhepZOV_D_s8pfNx_PnyXis=WjX1O_XkzRvQ@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 17:40:07 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Wed, Jul 11, 2018 at 5:13 AM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> > Bosch BME680 is a 4-in-1 sensor with temperature, pressure, humidity
> > and gas sensing capability. It supports both I2C and SPI communication
> > protocol for effective data communication.
> >
> > The device supports two modes:
> >
> > 1. Sleep mode
> > 2. Forced mode
> >
> > The measurements only takes place when forced mode is triggered and a
> > single TPHG cycle is performed by the sensor. The sensor automatically
> > goes to sleep after afterwards.
> >
> > The device has various calibration constants/parameters programmed into
> > devices' non-volatile memory(NVM) during production and can't be altered
> > by the user. These constants are used in the compensation functions to
> > get the required compensated readings along with the raw data. The
> > compensation functions/algorithms are provided by Bosch Sensortec GmbH
> > via their API[1]. As these don't change during the measurement cycle,
> > therefore we read and store them at the probe. The default configs
> > supplied by Bosch are also set at probe.
> >
> > 0-day tested with build success.
> >
> > GSoC-2018: https://summerofcode.withgoogle.com/projects/#6691473790074880
> > Mentor: Daniel Baluta
> > [1] https://github.com/BoschSensortec/BME680_driver
> > Datasheet:
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME680-DS001-00.pdf
> >
> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > ---
> >
> > v3:
> >    -moved files to chemical directory instead of a dedicated directory.
> >    -read calibration parameters serially with endian conversions.
> >    -drop some return ret.
> >    -removed few unnecessary casts safely.
> >    -added 'u' suffix to explicitly specify unsigned for large values
> >     and thereby fixing comiler warning.
> >    -left aligned all comments.
> >    -added a comment explaining heater stability failure.
> >
> > v2:
> >    -Used devm_add_action() to add a generic remove method for
> >     both I2C & SPI driver.
> >    -Introduction of compensation functions.
> >    -chip initialisation routines moved to respective I2C and SPI
> >     driver.
> >    -Introduction of gas sensing rountines.
> >    -Simplified Kconfig to reduce various options.
> >
> >  drivers/iio/chemical/Kconfig       |  25 +
> >  drivers/iio/chemical/Makefile      |   3 +
> >  drivers/iio/chemical/bme680.h      |  99 ++++
> >  drivers/iio/chemical/bme680_core.c | 946 +++++++++++++++++++++++++++++++++++++
> >  drivers/iio/chemical/bme680_i2c.c  |  83 ++++
> >  drivers/iio/chemical/bme680_spi.c  | 123 +++++
> >  6 files changed, 1279 insertions(+)
> >  create mode 100644 drivers/iio/chemical/bme680.h
> >  create mode 100644 drivers/iio/chemical/bme680_core.c
> >  create mode 100644 drivers/iio/chemical/bme680_i2c.c
> >  create mode 100644 drivers/iio/chemical/bme680_spi.c
> >
> > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > index 5cb5be7..24790a8 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -21,6 +21,31 @@ config ATLAS_PH_SENSOR
> >          To compile this driver as module, choose M here: the
> >          module will be called atlas-ph-sensor.
> >
> > +config BME680
> > +       tristate "Bosch Sensortec BME680 sensor driver"
> > +       depends on (I2C || SPI)
> > +       select REGMAP
> > +       select BME680_I2C if (I2C)
> > +       select BME680_SPI if (SPI)  
> 
> Don't think you actually need parentheses around any of these, but of
> course then again doesn't hurt

Nice to tidy this one up, though if it is all there is I can do that whilst
applying.  So don't bother sending a v4 for this until other reviews are in.

> 
> > +       help
> > +         Say yes here to build support for Bosch Sensortec BME680 sensor with
> > +         temperature, pressure, humidity and gas sensing capability.
> > +
> > +         This driver can also be built as a module. If so, the module for I2C
> > +         would be called bme680_i2c and bme680_spi for SPI support.
> > +
> > +config BME680_I2C
> > +       tristate
> > +       depends on BME680
> > +       depends on I2C  
> 
> Wouldn't  "depends on I2C && BME680"  be cleaner?  Maybe someone else
> here can tell me if I'm too nit-picky :)

You said it ;)  Can't say I care either way on these.

> 
> > +       select REGMAP_I2C
> > +
> > +config BME680_SPI
> > +       tristate
> > +       depends on BME680
> > +       depends on SPI  
> 
> Same only with SPI
> 
> > +       select REGMAP_SPI
> > +
> >  config CCS811
> >         tristate "AMS CCS811 VOC sensor"
> >         depends on I2C
...

Matt, please give us indication if you don't have anything else to say :)
Saves on a lot of scrolling and wondering if we missed something (which
of course I might have done!)


