Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3FFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0295F2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0295F2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbeGLOz1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:55:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732338AbeGLOz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:55:26 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35EFA7151F10;
        Thu, 12 Jul 2018 22:45:26 +0800 (CST)
Received: from localhost (10.202.226.43) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Thu, 12 Jul 2018
 22:45:19 +0800
Date:   Thu, 12 Jul 2018 15:45:05 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Brian Masney <masneyb@onstation.org>
CC:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
        "jonathan@marek.ca" <jonathan@marek.ca>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mkelly@xevo.com" <mkelly@xevo.com>,
        "fischerdouglasc@gmail.com" <fischerdouglasc@gmail.com>,
        "bshah@kde.org" <bshah@kde.org>,
        "ctatlor97@gmail.com" <ctatlor97@gmail.com>
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180712154505.00000f4a@huawei.com>
In-Reply-To: <20180711130007.jwnie5pr3zaxwsca@d08157822050>
References: <20180711010932.20313-1-masneyb@onstation.org>
        <20180711010932.20313-3-masneyb@onstation.org>
        <SN1PR12MB2525E8A460DA734A7C6A2692C45A0@SN1PR12MB2525.namprd12.prod.outlook.com>
        <20180711130007.jwnie5pr3zaxwsca@d08157822050>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 09:00:07 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Wed, Jul 11, 2018 at 12:29:33PM +0000, Jean-Baptiste Maneyrol wrote:
> > Hello,
> >
 
> > I really don't like the idea to have regulator handled inside the
> > driver. I know this was done like that before for Nexus 5, but I
> > think now this is something that can be done using dts only. Does
> > anyone know if there is a way with dts to handle regulator
> > automatically and prevent the use in the driver? That would be a
> > good idea to search how this handled for other drivers.
> > 
> > Anyway, you are enforcing regulator use in your code. It doesn't
> > seem the code will work when there is no regulator declared in the
> > dts, which is the case for the majority of configurations. We
> > should at least make it optional.
> > 
> > Thanks for the contribution.  
> 

> My understanding of devm_regulator_get_optional() is that a stub
> regulator will be returned if one is not configured. See the comment
> above regulator_get_optional() for where I got this information.
> 
> https://elixir.bootlin.com/linux/v4.17/source/drivers/regulator/core.c#L1750

Quite the opposite (though the text is perhaps less than crystal clear)
 - reread that comment really carefully. 

 * This is intended for use by consumers for devices which can have
 * some supplies unconnected in normal use, such as some MMC devices.
 * It can allow the regulator core to provide stub supplies for other
 * supplies requested using normal regulator_get() calls without
 * disrupting the operation of drivers that can handle absent
 * supplies.

So in it allows normal path (non "optional") one to return stubs, but when
optional versions are used, it will return an error if they aren't there
- thus letting the driver decide what to do about it.


> 
> I agree that it would be better if this could be handled exclusively in
> dts if possible, although I'm not sure how. I looked at other drivers
> and commits from the last year or so and this appears to be the current
> recommended approach. I'm open to other approaches to doing this.

In the general case it is very hard to do. Many devices have fairly complex
regulator setups and need to enable them in particular orders and can
power down subsets etc.

The case here of just providing a power supply is very simplistic and
it may well be that down the line we want to do finer grained control
in the driver.  Only a driver can know what the effect of turning
a particular power supply to a device off actually is.

Jonathan
 
> 
> Brian
> 
> 
> >
> > 
> > From: Brian Masney <masneyb@onstation.org>
> > Sent: Wednesday, July 11, 2018 03:09
> > To: jic23@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; andy.gross@linaro.org; david.brown@linaro.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-soc@vger.kernel.org
> > Cc: jonathan@marek.ca; Jean-Baptiste Maneyrol; knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; mkelly@xevo.com; fischerdouglasc@gmail.com; bshah@kde.org; ctatlor97@gmail.com; masneyb@onstation.org
> > Subject: [PATCH 2/3] iio: imu: mpu6050: add support for regulator framework
> >   
> > 
> > CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > 
> > This patch adds support for the regulator framework to the mpu6050
> > driver.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > ---
> > This is a variation of Jonathan Marek's patch from postmarketOS
> > https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcbce94944b3f4dd68f8f9fc37
> > with the following changes:
> > 
> > - Stripped out 6515 variant code. (See my previous patch in this series)
> > - Add the regulator to the mpu core instead of only the i2c variant.
> > - Add error handling.
> > - Release the regulator on suspend, device remove, etc.
> > - Device tree documentation.
> > 
> >  .../bindings/iio/imu/inv_mpu6050.txt          |  1 +
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 57 +++++++++++++++++--
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  2 +-
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  3 +
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  9 +++
> >  5 files changed, 66 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > index b7def51c8ad9..d39907b12a46 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > @@ -21,6 +21,7 @@ Required properties:
> >    bindings.
> > 
> >  Optional properties:
> > + - vddio-supply: regulator phandle for VDDIO supply
> >   - mount-matrix: an optional 3x3 mounting rotation matrix
> >   - i2c-gate node.  These devices also support an auxiliary i2c bus.  This is
> >     simple enough to be described using the i2c-gate binding. See
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index 12c1b9507007..ec276b7bcc69 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/acpi.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> >  #include "inv_mpu_iio.h"
> > 
> >  /*
> > @@ -926,6 +927,19 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
> >         return result;
> >  }
> > 
> > +static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
> > +{
> > +       int result;
> > +
> > +       result = regulator_enable(st->vddio_supply);
> > +       if (result == 0) {
> > +               /* Give the device a little bit of time to start up. */
> > +               usleep_range(35000, 70000);
> > +       }
> > +
> > +       return result;
> > +}
> > +
> >  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> >                 int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
> >  {
> > @@ -990,15 +1004,28 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> >                 return -EINVAL;
> >         }
> > 
> > +       st->vddio_supply = devm_regulator_get_optional(dev, "vddio");
> > +       if (IS_ERR(st->vddio_supply)) {
> > +               if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
> > +                       dev_err(dev, "Failed to get vddio regulator %d\n",
> > +                               (int)PTR_ERR(st->vddio_supply));
> > +
> > +               return PTR_ERR(st->vddio_supply);
> > +       }
> > +
> > +       result = inv_mpu_core_enable_regulator(st);
> > +       if (result)
> > +               return result;
> > +
> >         /* power is turned on inside check chip type*/
> >         result = inv_check_and_setup_chip(st);
> >         if (result)
> > -               return result;
> > +               goto out_disable_regulator;
> > 
> >         result = inv_mpu6050_init_config(indio_dev);
> >         if (result) {
> >                 dev_err(dev, "Could not initialize device.\n");
> > -               return result;
> > +               goto out_disable_regulator;
> >         }
> > 
> >         if (inv_mpu_bus_setup)
> > @@ -1023,24 +1050,34 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> >                                                  NULL);
> >         if (result) {
> >                 dev_err(dev, "configure buffer fail %d\n", result);
> > -               return result;
> > +               goto out_disable_regulator;
> >         }
> >         result = inv_mpu6050_probe_trigger(indio_dev, irq_type);
> >         if (result) {
> >                 dev_err(dev, "trigger probe fail %d\n", result);
> > -               return result;
> > +               goto out_disable_regulator;
> >         }
> > 
> >         result = devm_iio_device_register(dev, indio_dev);
> >         if (result) {
> >                 dev_err(dev, "IIO register fail %d\n", result);
> > -               return result;
> > +               goto out_disable_regulator;
> >         }
> > 
> >         return 0;
> > +
> > +out_disable_regulator:
> > +       regulator_disable(st->vddio_supply);
> > +       return result;
> > +
> >  }
> >  EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
> > 
> > +int inv_mpu_core_remove(struct inv_mpu6050_state *st)
> > +{
> > +       return regulator_disable(st->vddio_supply);
> > +}
> > +
> >  #ifdef CONFIG_PM_SLEEP
> > 
> >  static int inv_mpu_resume(struct device *dev)
> > @@ -1050,6 +1087,11 @@ static int inv_mpu_resume(struct device *dev)
> > 
> >         mutex_lock(&st->lock);
> >         result = inv_mpu6050_set_power_itg(st, true);
> > +       if (result)
> > +               goto out_unlock;
> > +
> > +       result = inv_mpu_core_enable_regulator(st);
> > +out_unlock:
> >         mutex_unlock(&st->lock);
> > 
> >         return result;
> > @@ -1062,6 +1104,11 @@ static int inv_mpu_suspend(struct device *dev)
> > 
> >         mutex_lock(&st->lock);
> >         result = inv_mpu6050_set_power_itg(st, false);
> > +       if (result)
> > +               goto out_unlock;
> > +
> > +       result = regulator_disable(st->vddio_supply);
> > +out_unlock:
> >         mutex_unlock(&st->lock);
> > 
> >         return result;
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> > index dd758e3d403d..ce227038c61c 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> > @@ -164,7 +164,7 @@ static int inv_mpu_remove(struct i2c_client *client)
> >                 i2c_mux_del_adapters(st->muxc);
> >         }
> > 
> > -       return 0;
> > +       return inv_mpu_core_remove(st);
> >  }
> > 
> >  /*
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > index e69a59659dbc..0289615a6135 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > @@ -129,6 +129,7 @@ struct inv_mpu6050_hw {
> >   *  @chip_period:      chip internal period estimation (~1kHz).
> >   *  @it_timestamp:     timestamp from previous interrupt.
> >   *  @data_timestamp:   timestamp for next data sample.
> > + *  @vddio_supply      voltage regulator for the chip.
> >   */
> >  struct inv_mpu6050_state {
> >         struct mutex lock;
> > @@ -149,6 +150,7 @@ struct inv_mpu6050_state {
> >         s64 chip_period;
> >         s64 it_timestamp;
> >         s64 data_timestamp;
> > +       struct regulator *vddio_supply;
> >  };
> > 
> >  /*register and associated bit definition*/
> > @@ -321,4 +323,5 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
> >  void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
> >  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> >                 int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
> > +int inv_mpu_core_remove(struct inv_mpu6050_state *st);
> >  extern const struct dev_pm_ops inv_mpu_pmops;
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> > index 227f50afff22..fce935f8f1e4 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> > @@ -70,6 +70,14 @@ static int inv_mpu_probe(struct spi_device *spi)
> >                                   inv_mpu_i2c_disable, chip_type);
> >  }
> > 
> > +static int inv_mpu_remove(struct spi_device *spi)
> > +{
> > +       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +       struct inv_mpu6050_state *st = iio_priv(indio_dev);
> > +
> > +       return inv_mpu_core_remove(st);
> > +}
> > +
> >  /*
> >   * device id table is used to identify what device can be
> >   * supported by this driver
> > @@ -94,6 +102,7 @@ MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
> > 
> >  static struct spi_driver inv_mpu_driver = {
> >         .probe          =       inv_mpu_probe,
> > +       .remove         =       inv_mpu_remove,
> >         .id_table       =       inv_mpu_id,
> >         .driver = {
> >                 .acpi_match_table = ACPI_PTR(inv_acpi_match),
> > --
> > 2.17.1
> > 
> >       
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


