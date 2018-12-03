Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E11C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED8420878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED8420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbeLCNHU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:07:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbeLCNHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:07:20 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7ADE6D1509F96;
        Mon,  3 Dec 2018 21:06:18 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 21:06:18 +0800
Date:   Mon, 3 Dec 2018 13:06:06 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-usp@googlegroups.com>
Subject: Re: [PATCH] staging: iio: ad5933: replaced kfifo by
 triggered_buffer
Message-ID: <20181203130606.00002854@huawei.com>
In-Reply-To: <20181202181045.vkdnus4ow3chdlu6@smtp.gmail.com>
References: <20181122125347.sn2oqrw7fyb4corf@smtp.gmail.com>
        <20181125105926.4730a798@archlinux>
        <20181202181045.vkdnus4ow3chdlu6@smtp.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2018 16:10:45 -0200
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 11/25, Jonathan Cameron wrote:
> > On Thu, 22 Nov 2018 10:53:47 -0200
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >   
> > > Previously, there was an implicit creation of a kfifo which was replaced
> > > by a call to triggered_buffer_setup, which is already implemented in iio
> > > infrastructure.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>  
> > 
> > I'm a little surprised that this would work without screaming a lot as 
> > it will register an interrupt with no handlers. Do you have this
> > device to test?  It's rapidly heading in the direction of too complex
> > a driver to fix without test hardware.  Also, semantically this change
> > is not sensible as it implies an operating mode which the driver
> > is not using.
> >   
> 
> Thanks for reviewing the patch. I'm not expert at electronics so I'm
> still studying the datasheet to understand how the ad5933 works.
> 
> > There are fundamental questions about how we handle an autotriggered
> > sweep that need answering before this driver can move forwards.
> > It needs some concept of a higher level trigger rather than a per
> > sample one like we typically use in IIO.
> >   
> 
> From what I've read so far it seems that we would need to have two
> operation modes: one for the frequency sweep (that need to be
> discussed yet) and another for the receive stage (in which ad5933 would
> be continuously requested for data through I2C). So my first approach
> would be to build up an abstract trigger that would allow switching
> between these two operation modes. What do you think about that?

Hmm.  I haven't looked at it in much depth yet but based largely on the intro
to the datasheet and what you say here...

Mode 1 : Sweep.
* Controls for peak-to-peak, start, resolution, number of points.

Two ways we could treat this.
* A single buffer with no meta data and rely on start and stop signals
  and careful sync.  This is similar to what we have previously talked
  about doing for impact sensors.

* We could present the current frequency as a channel.  At which point
  this is a simple triple of drive frequency, real and imaginary responses.
  It would need a start control though to get a sweep going. Also potentially
  a control to force a waiting period for the start frequency to sweep
  transition.  There is also the repeat option to deal with.

Mode 2 : Read without changing anything?  This is just hitting the repeat
constantly I guess as I can't immediately see another control for it.
This could also be implemented within the above as a one step sweep with
an indefinite repeat count (magic number such as -1).

Anyhow, just some initial thoughts. I'll think more on this one as
the best answer isn't obvious!

> 
> > The main focus in the short term should be around defining that ABI
> > as it may fundamentally change the structure of the driver.
> > If you want to take this on (and it'll be a big job I think!) then
> > it may be possible to source some hardware to support that effort.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> As a member of the FLOSS group at Universidade de São Paulo I have the
> hardware to test the driver though I didn't figure out all the steps to
> do it yet. I intend to continue development on this driver so I'm really
> thankful for all advise given.

Great!

Jonathan

> 
> Thanks,
> 
> Marcelo
> 
> > > ---
> > >  .../staging/iio/impedance-analyzer/Kconfig    |  2 +-
> > >  .../staging/iio/impedance-analyzer/ad5933.c   | 25 ++++---------------
> > >  2 files changed, 6 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
> > > index dd97b6bb3fd0..d0af5aa55dc0 100644
> > > --- a/drivers/staging/iio/impedance-analyzer/Kconfig
> > > +++ b/drivers/staging/iio/impedance-analyzer/Kconfig
> > > @@ -7,7 +7,7 @@ config AD5933
> > >  	tristate "Analog Devices AD5933, AD5934 driver"
> > >  	depends on I2C
> > >  	select IIO_BUFFER
> > > -	select IIO_KFIFO_BUF
> > > +	select IIO_TRIGGERED_BUFFER
> > >  	help
> > >  	  Say yes here to build support for Analog Devices Impedance Converter,
> > >  	  Network Analyzer, AD5933/4, provides direct access via sysfs.
> > > diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > > index f9bcb8310e21..edb8b540bbf1 100644
> > > --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> > > +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > > @@ -20,7 +20,7 @@
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > >  #include <linux/iio/buffer.h>
> > > -#include <linux/iio/kfifo_buf.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > >  
> > >  /* AD5933/AD5934 Registers */
> > >  #define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
> > > @@ -615,22 +615,6 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
> > >  	.postdisable = ad5933_ring_postdisable,
> > >  };
> > >  
> > > -static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> > > -{
> > > -	struct iio_buffer *buffer;
> > > -
> > > -	buffer = iio_kfifo_allocate();
> > > -	if (!buffer)
> > > -		return -ENOMEM;
> > > -
> > > -	iio_device_attach_buffer(indio_dev, buffer);
> > > -
> > > -	/* Ring buffer functions - here trigger setup related */
> > > -	indio_dev->setup_ops = &ad5933_ring_setup_ops;
> > > -
> > > -	return 0;
> > > -}
> > > -
> > >  static void ad5933_work(struct work_struct *work)
> > >  {
> > >  	struct ad5933_state *st = container_of(work,
> > > @@ -744,7 +728,8 @@ static int ad5933_probe(struct i2c_client *client,
> > >  	indio_dev->channels = ad5933_channels;
> > >  	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
> > >  
> > > -	ret = ad5933_register_ring_funcs_and_init(indio_dev);
> > > +	ret = iio_triggered_buffer_setup(indio_dev, NULL, NULL,
> > > +					 &ad5933_ring_setup_ops);  
> > 
> > The absence of either of the interrupt related callbacks made me
> > wonder what is going on here.  The upshot is that this device
> > isn't operating in a triggered buffer style at all so we really
> > shouldn't be using that infrastructure - even if it's convenient.
> > 
> > It'll allocate an interrupt with neither a top half nor a thread
> > function. I'm not sure what the core will do about that but it
> > seems unlikely to be happy about it!
> >   
> 
> The reason for not using triggered_buffer would be because I2C of
> communication is always started by the master device so the ad5933 would
> only wait for being requested for data. It wouldn't be capable of using
> I2C to call for master device nor it has any interrupt pin to do that.
> Is that right?
> 
> >   
> > >  	if (ret)
> > >  		goto error_disable_reg;
> > >  
> > > @@ -759,7 +744,7 @@ static int ad5933_probe(struct i2c_client *client,
> > >  	return 0;
> > >  
> > >  error_unreg_ring:
> > > -	iio_kfifo_free(indio_dev->buffer);
> > > +	iio_triggered_buffer_cleanup(indio_dev);
> > >  error_disable_reg:
> > >  	regulator_disable(st->reg);
> > >  
> > > @@ -772,7 +757,7 @@ static int ad5933_remove(struct i2c_client *client)
> > >  	struct ad5933_state *st = iio_priv(indio_dev);
> > >  
> > >  	iio_device_unregister(indio_dev);
> > > -	iio_kfifo_free(indio_dev->buffer);
> > > +	iio_triggered_buffer_cleanup(indio_dev);
> > >  	regulator_disable(st->reg);
> > >  
> > >  	return 0;  
> >   


