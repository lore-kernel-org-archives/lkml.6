Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeDJNr1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:47:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54186 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752810AbeDJNrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:47:25 -0400
Date: Tue, 10 Apr 2018 14:47:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Quentin Schulz <quentin.schulz@bootlin.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        <devicetree@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-iio@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-input@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/10]  Add support for SAMA5D2 touchscreen
Message-ID: <20180410144706.00007600@huawei.com>
In-Reply-To: <20180410073812.xbt3n6oegr23nlff@qschulz>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
        <20180330140212.57dad66d@archlinux>
        <20180410073812.xbt3n6oegr23nlff@qschulz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 09:38:12 +0200
Quentin Schulz <quentin.schulz@bootlin.com> wrote:

> Hi Jonathan and Eugen,
> 
> On Fri, Mar 30, 2018 at 02:02:12PM +0100, Jonathan Cameron wrote:
> > On Tue, 27 Mar 2018 15:32:33 +0300
> > Eugen Hristev <eugen.hristev@microchip.com> wrote:
> >   
> > > Hello,
> > > 
> > > This patch series is a rework of my previous series named:
> > > [PATCH 00/14] iio: triggers: add consumer support
> > > 
> > > In few words, this is the implementation of splitting the functionality
> > > of the IP block ADC device in SAMA5D2 SoC from ADC with touchscreen
> > > support. In order to avoid having a MFD device, two separate
> > > drivers that would work on same register base and split the IRQ,etc,
> > > as advised on the mailing list, I created a consumer driver for the
> > > channels, that will connect to the ADC as described in the device tree.
> > > 
> > > I have collected feedback from everyone and here is the result:
> > > I have added a new generic resistive touchscreen driver, which acts
> > > as a iio consumer for the given channels and will create an input
> > > device and report the events. It uses a callback buffer to register
> > > to the IIO device and waits for data to be pushed.
> > > Inside the IIO device, I have kept a similar approach with the first version
> > > of the series, except that now the driver can take multiple buffers, and
> > > will configure the touchscreen part of the hardware device if the specific
> > > channels are requested.
> > > 
> > > The SAMA5D2 ADC driver registers three new channels: two for the
> > > position on the X and Y axis, and one for the touch pressure.
> > > When channels are requested, it will check if the touchscreen channel mask
> > > includes the requested channels (it is possible that the consumer driver
> > > will not request pressure for example). If it's the case, it will work
> > > in touchscreen mode, and will refuse to do usual analog-digital conversion,
> > > because we have a single trigger and the touchscreen needs it.
> > > When the scan mask will include only old channels, the driver will function
> > > in the same way as before. If the scan mask somehow is a mix of the two (the
> > > masks intersect), the driver will refuse to work whatsoever (cannot have both
> > > in the same time).
> > > The driver allows reading raw data for the new channels, if claim direct
> > > mode works: no touchscreen driver requested anything. The new channels can
> > > act like the old ones. However, when requesting these channels, the usual
> > > trigger will not work and will not be enabled. The touchscreen channels
> > > require special trigger and irq configuration: pen detect, no pen detect
> > > and a periodic trigger to sample the touchscreen position and pressure.
> > > If the user attempts to use another trigger while there is a buffer
> > > that already requested the touchscreen channels (thus the trigger), the
> > > driver will refuse to comply.
> > > 
> > > In order to have defines for the channel numbers, I added a bindings include
> > > file that goes on a separate commit :
> > > dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer info
> > > This should go in the same tree with the following commits :
> > >   ARM: dts: at91: sama5d2: add channel cells for ADC device
> > >   ARM: dts: at91: sama5d2: Add resistive touch device
> > > 
> > > as build will break because these commits depend on the binding one
> > > which creates the included header file.
> > > 
> > > After the discussions earlier this year on the mailing list, I hope this
> > > rework of the patches is much better and fulfills all the requirements
> > > for this implementation.  
> > As I said in one of the later patches, I like this a lot.
> > It is a good blend of the moderately nasty handling needed in the ADC
> > driver with a lovely generic input driver.
> > 
> > Very nice!  Hope everyone else agrees ;)
> >   
> 
> I'd love to see a generic touchscreen driver being an iio consumer!
> 
> However, I've already a case that can't be handled unfortunately.
> 
> I posted ~2 years ago a patch series[1] for touchscreen support for
> Allwinner SoCs that are using their ADC (also) for touchscreen purpose.
> 
> It's been a very long time, I'm trying the hardest I can with my
> "IIRC-skills".
> 
> There are several problems:
>   - Data is stored in one register as a queue following this scheme:
>     X @t=0 coord, Y @t=0 coord, X @t=1 coord, Y @t=1 coord, X @t=2
>     coord, Y @t=2 coord, etc...
> 
>     Thus, I suppose I've only one channel and not two for coordinates.

As I read this, no you don't.  You have two channels going through a
very short on chip hw fifo.  They need to be reported as two channels
with data appropriate reformatted to reflect that before being pushed
to the IIO buffer interfaces.

> 
>   - The first data stored after an up event is absolutely unreliable so
>   I have to flush it, thus I need to use another API call to have the
>   touchscreen driver do some logic with a whole queue only when it's
>   after an up event (it doesn't really make sense to do so in the IIO
>   driver, does it?).

If it is garbage data I don't see any real problem with doing it in
the IIO driver.  But obviously I don't have details to hand so there
may be some complexity in this - I'm not sure the IIO driver knows
enough about what is going on to distinguish that this data is bad.

> 
>   - This up event is an interrupt.. that is configurable from the same
>   set of registers than for the ADC, so I need an mfd,
Hmm.  So there are various options here other than using an mfd.

1. Could use the event to 'filter' the trigger being used to drive the
data flow to the touch screen driver. So, as far as the touch screen
driver is concerned it gets good data only when a touch is in progress.
We present it as a 'magic' trigger that can be associated with the
device that happens to have this property.

2. Could actually write the (long missing) in kernel API for IIO events and
support the touch as a threshold falling event and add support for
handling to the touchscreen driver.
> 
> What are your thoughts (and maybe workarounds?) on those issues?
> 
Not trivial and at some point we'll be different enough from the generic
driver that it makes sense to perhaps have a couple of 'classes' of generic
touch screen to cover common options without making thing too complex.
That might be in one driver, and it might not.

> Thanks,
> Quentin
> 
> [1] https://lkml.org/lkml/2016/7/20/156
> 
> > Jonathan
> >   
> > > 
> > > Eugen Hristev (10):
> > >   MAINTAINERS: add generic resistive touchscreen adc
> > >   iio: Add channel for Position Relative
> > >   dt-bindings: input: touchscreen: touch_adc: create bindings
> > >   iio: inkern: add module put/get on iio dev module when requesting
> > >     channels
> > >   iio: adc: at91-sama5d2_adc: fix channel configuration for differential
> > >     channels
> > >   iio: adc: at91-sama5d2_adc: add support for position and pressure
> > >     channels
> > >   input: touchscreen: touch_adc: add generic resistive ADC touchscreen
> > >   dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer
> > >     info
> > >   ARM: dts: at91: sama5d2: add channel cells for ADC device
> > >   ARM: dts: at91: sama5d2: Add resistive touch device
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-iio            |  12 +
> > >  .../bindings/iio/adc/at91-sama5d2_adc.txt          |   9 +
> > >  .../bindings/input/touchscreen/touch_adc.txt       |  33 ++
> > >  MAINTAINERS                                        |   6 +
> > >  arch/arm/boot/dts/sama5d2.dtsi                     |  12 +
> > >  drivers/iio/adc/at91-sama5d2_adc.c                 | 491 ++++++++++++++++++++-
> > >  drivers/iio/industrialio-core.c                    |   1 +
> > >  drivers/iio/inkern.c                               |   8 +-
> > >  drivers/input/touchscreen/Kconfig                  |  13 +
> > >  drivers/input/touchscreen/Makefile                 |   1 +
> > >  drivers/input/touchscreen/touch_adc.c              | 199 +++++++++
> > >  include/dt-bindings/iio/adc/at91-sama5d2_adc.h     |  16 +
> > >  include/uapi/linux/iio/types.h                     |   1 +
> > >  tools/iio/iio_event_monitor.c                      |   2 +
> > >  14 files changed, 791 insertions(+), 13 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
> > >  create mode 100644 drivers/input/touchscreen/touch_adc.c
> > >  create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> > >   
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel  
> 
