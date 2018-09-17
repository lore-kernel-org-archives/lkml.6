Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E0ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6644E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6644E2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIQNwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:52:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbeIQNwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:52:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BFB36F84D77BA;
        Mon, 17 Sep 2018 16:25:36 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 16:25:35 +0800
Date:   Mon, 17 Sep 2018 09:25:21 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Song Qiang <songqiang1304521@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <andriy.shevchenko@linux.intel.com>,
        <matt.ranostay@konsulko.com>, <tglx@linutronix.de>,
        <ak@it-klinger.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <himanshujha199640@gmail.com>
Subject: Re: [PATCH v5] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180917092521.000044d4@huawei.com>
In-Reply-To: <20180916133651.GA10179@Eros>
References: <20180915095752.8116-1-songqiang.1304521@gmail.com>
        <20180916120149.0c68893f@archlinux>
        <20180916133651.GA10179@Eros>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2018 21:36:51 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Sun, Sep 16, 2018 at 12:01:49PM +0100, Jonathan Cameron wrote:
> > On Sat, 15 Sep 2018 17:57:52 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> >   
> > > This driver was originally written by ST in 2016 as a misc input device
> > > driver, and hasn't been maintained for a long time. I grabbed some code
> > > from it's API and reformed it into an iio proximity device driver.
> > > This version of driver uses i2c bus to talk to the sensor and
> > > polling for measuring completes, so no irq line is needed.
> > > This version of driver supports only one-shot mode, and it can be
> > > tested with reading from
> > > /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > > 
> > > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>  
> > Hi Song,
> > 
> > My first comment was going to be don't use wild cards in a part name
> > in a driver, but a quick sanity check confirmed that ST were actually
> > crazy enough to end a part number with an X.  Ah well ;)
> > 
> > Otherwise a few minor things, mostly around naming.  There is some
> > confusion around endian stuff as well
> > 
> > Looks pretty good for a first go at upstreaming a driver!
> > 
> > Are you planning on adding more features?  Seems like a capable little device
> > and would be good to have fuller support in the long term if you have time
> > to look at it!
> > 
> > Jonathan
> >   
> 
> Hi Jonathan,
> 
> Thanks for spending time with my patch!
> Since I'm now just a student and intrested in embedded linux very much,
> there are plenty of free time for me to work on this, and working with
> the community is not only interesting but helpful to my knowledge.
> People reviewed my patch gave me a lot helpful suggestions, espacially
> Himanshu. :)
Cool.

> 
> When I was writing this patch, I thought maybe I should go one step
> each time, so this driver may seems like a little simple, but I believe
> it's just for now.
Agreed. It makes complete sense to start simple and build up.  I was
just being curious on how far you were planning on going ;)

> 
> Actually there is a question, ST released a new version of this device
> called VL53L1X in June, which still has no support for linux drivers,
> but compitable with VL53L0X. Do you have any suggestions for my
> driver's name? The first one came to my mind would be VL53LxX, which is
> a little crazy I think. ;)
Yes. Wild cards are almost always a bad idea. Just go with the name
of the first part you support.

If you want example of this see the max1363 ADC driver.  That supports
lots of seemingly unconnected part numbers so a wild card approach would
have caused all sorts of mess.

> 
>
...

> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Support for ST VL53L0X FlightSense ToF Ranging Sensor on a i2c bus.
> > > + *
> > > + * Copyright (C) 2016 STMicroelectronics Imaging Division.
> > > + * Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>
> > > + *
> > > + * Datasheet available at
> > > + * <https://www.st.com/resource/en/datasheet/vl53l0x.pdf>
> > > + *
> > > + * Default 7-bit i2c slave address 0x29.
> > > + *
> > > + * TODO: FIFO buffer, continuous mode, interrupts, range selection,
> > > + * sensor ID check.
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/delay.h>
> > > +
> > > +#include <linux/iio/iio.h>
> > > +
> > > +#define VL53L0X_DRV_NAME				"vl53l0x-i2c"  
> > 
> > A quick google suggests this only has an i2c interface.  Hence I'd argue
> > there is no point in having -i2c in the driver name.  Lots of other
> > i2c only parts don't on the basis it doesn't add anything.  In fact
> > the only time we tend to do this is if we have a driver that splits
> > into a shared core and two or more bus specific drivers.
> >   
> 
> Actually this device do has a CCI(Camera Control Interface) for
> communication and it's original API has two kinds of ways for accessing
> this device. 
Hmm. That one is a bit of a surprise.

OK.  Fine to do the driver name as *-i2c but don't have it in the
iio_dev.name field as it's not really useful to pass on.  That
usually just contains the part number. Userspace doesn't care about the
interface.

> 
> > > +
> > > +#define VL_REG_SYSRANGE_START				0x00
> > > +
> > > +#define VL_REG_SYSRANGE_MODE_MASK			GENMASK(3, 0)
> > > +#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
> > > +#define VL_REG_SYSRANGE_MODE_START_STOP			BIT(0)
> > > +#define VL_REG_SYSRANGE_MODE_BACKTOBACK			BIT(1)
> > > +#define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
> > > +#define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
> > > +
> > > +#define VL_REG_SYS_SEQUENCE_CFG				BIT(0)
> > > +#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		BIT(2)
> > > +#define VL_REG_SYS_RANGE_CFG				0x09
> > > +#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
> > > +#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			BIT(0)
> > > +#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			BIT(1)
> > > +#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
> > > +#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY		BIT(2)
> > > +#define VL_REG_SYS_INT_CFG_GPIO				0x0A
> > > +#define VL_REG_SYS_INT_CLEAR				0x0B
> > > +#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x84
> > > +
> > > +#define VL_REG_RESULT_INT_STATUS			0x13
> > > +#define VL_REG_RESULT_RANGE_STATUS			0x14
> > > +#define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
> > > +
> > > +/* Check contents of these registers to verify the device. */
> > > +#define VL_REG_IDENTIFICATION_MODEL_ID			0xC0
> > > +#define VL_REG_IDENTIFICATION_REVISION_ID		0xC2
> > > +
> > > +struct vl53l0x_data {
> > > +	struct i2c_client *client;
> > > +};
> > > +
> > > +static int vl53l0x_read_proximity(struct vl53l0x_data *data,
> > > +				  const struct iio_chan_spec *chan,
> > > +				  int *val)
> > > +{
> > > +	struct i2c_client *client = data->client;
> > > +	unsigned int tries = 20;
> > > +	u8 buffer[12];
> > > +	int ret;
> > > +
> > > +	ret = i2c_smbus_write_byte_data(client,
> > > +		VL_REG_SYSRANGE_START, 1);  
> > 
> > Looks like the above would fit on one line.  Please do a quick check
> > through the driver for other cases of this.
> >   
> 
> Oops, I'll change that. 
> 
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	do {
> > > +		ret = i2c_smbus_read_byte_data(client,
> > > +			VL_REG_RESULT_RANGE_STATUS);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
> > > +			break;
> > > +
> > > +		usleep_range(1000, 5000);
> > > +	} while (--tries);
> > > +	if (!tries)
> > > +		return -ETIMEDOUT;
> > > +
> > > +	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
> > > +		12, buffer);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	else if (ret != 12)
> > > +		return -EREMOTEIO;
> > > +
> > > +	/* Values should be between 30~1200. */
> > > +	*val = le16_to_cpu((buffer[10] << 8) + buffer[11]);  
> > This worries me as a conversion.  The shift and addition is
> > unwinding the endianness already. You then do it again with le16_to_cpu
> > 
> > As it's aligned you could have done
> > *val = le16_to_cpu(*(le16 *)(&buffer[10]));  That's obviously
> > a bit ugly though, mainly because we are handling the buffer as
> > a u8.  Is there a reason to not directly handle it as an le16 array?
> > 
> > I'm having trouble finding the relevant section of the manual to actually
> > figure out what is in the first 10 bytes!
> > 
> > 
> >   
> 
> Sorry for this insanity, actually, I was writing this driver without a
> full memory layout. I tried to look for one, but then I found the poor ST
> support seems like doesn't want to release one at all! Have a look at
> this thread on Soren Karlsen's reply:
> <https://community.st.com/s/question/0D50X00009XkYTtSAN/request-of-vl53l0x>
> All those documents on ST's support websites mentioned only several
> registers for connection check.
> 
> I can't say this is a very big deal because at least ST released a full
> API source with documentation. I analyzed their API source and also
> looked up some usage examples on google to get this device working.
> The protocal in the datasheet P19-20 shows that this device has to read
> consecutive bytes stream to get all data. I tried to access these
> registers one by one but it's not working. 
> Datasheet:
> <https://www.st.com/resource/en/datasheet/vl53l0x.pdf> P19-20
> 
> Something I know from arduino's example code is that the 11th and 12th
> bytes hold distance, the 9th and 10th bytes hold signal countdown
> value and 7th and 8th bytes hold ambient countdown value. 

Hmm. One of 'those' parts.  They give almost but not quite enough information
to use it in a sane fashion...  Oh well, we work with what we have and good
there is at least some example code to get things going!

> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct iio_chan_spec vl53l0x_channels[] = {
> > > +	{
> > > +		.type = IIO_DISTANCE,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),  
> > 
> > This is a time of flight sensor?  As such I would kind of assume it is possible
> > to get to a real world distance?  Adding scale and offset to do this can
> > of course be a follow up patch,  but it would be good to have!
> >   
> 
> That's right, there was a scale channel, but since this device returns
> value in millimeters I thought there isn't a need for that channel, so
> I just return raw value.

If it's already in mm then you should use _PROCESSED not _RAW
to indicate that to userspace.  Right now userspace would think that there
was no known scaling.

> Usually in our production, we do some linear calibration for it's return
> values, but I think this may should be left with userspace to do.

That's normal.  We give as much information as possible, but if you want any 
really precise values off a sensor then it's up to you to calibrate it offline.

> 
> > > +	},
> > > +};
> > > +
...

Jonathan


