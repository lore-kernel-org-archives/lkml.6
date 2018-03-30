Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeC3NCU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeC3NCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:02:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D0521770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 14:02:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 00/10]  Add support for SAMA5D2 touchscreen
Message-ID: <20180330140212.57dad66d@archlinux>
In-Reply-To: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 15:32:33 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Hello,
> 
> This patch series is a rework of my previous series named:
> [PATCH 00/14] iio: triggers: add consumer support
> 
> In few words, this is the implementation of splitting the functionality
> of the IP block ADC device in SAMA5D2 SoC from ADC with touchscreen
> support. In order to avoid having a MFD device, two separate
> drivers that would work on same register base and split the IRQ,etc,
> as advised on the mailing list, I created a consumer driver for the
> channels, that will connect to the ADC as described in the device tree.
> 
> I have collected feedback from everyone and here is the result:
> I have added a new generic resistive touchscreen driver, which acts
> as a iio consumer for the given channels and will create an input
> device and report the events. It uses a callback buffer to register
> to the IIO device and waits for data to be pushed.
> Inside the IIO device, I have kept a similar approach with the first version
> of the series, except that now the driver can take multiple buffers, and
> will configure the touchscreen part of the hardware device if the specific
> channels are requested.
> 
> The SAMA5D2 ADC driver registers three new channels: two for the
> position on the X and Y axis, and one for the touch pressure.
> When channels are requested, it will check if the touchscreen channel mask
> includes the requested channels (it is possible that the consumer driver
> will not request pressure for example). If it's the case, it will work
> in touchscreen mode, and will refuse to do usual analog-digital conversion,
> because we have a single trigger and the touchscreen needs it.
> When the scan mask will include only old channels, the driver will function
> in the same way as before. If the scan mask somehow is a mix of the two (the
> masks intersect), the driver will refuse to work whatsoever (cannot have both
> in the same time).
> The driver allows reading raw data for the new channels, if claim direct
> mode works: no touchscreen driver requested anything. The new channels can
> act like the old ones. However, when requesting these channels, the usual
> trigger will not work and will not be enabled. The touchscreen channels
> require special trigger and irq configuration: pen detect, no pen detect
> and a periodic trigger to sample the touchscreen position and pressure.
> If the user attempts to use another trigger while there is a buffer
> that already requested the touchscreen channels (thus the trigger), the
> driver will refuse to comply.
> 
> In order to have defines for the channel numbers, I added a bindings include
> file that goes on a separate commit :
> dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer info
> This should go in the same tree with the following commits :
>   ARM: dts: at91: sama5d2: add channel cells for ADC device
>   ARM: dts: at91: sama5d2: Add resistive touch device
> 
> as build will break because these commits depend on the binding one
> which creates the included header file.
> 
> After the discussions earlier this year on the mailing list, I hope this
> rework of the patches is much better and fulfills all the requirements
> for this implementation.
As I said in one of the later patches, I like this a lot.
It is a good blend of the moderately nasty handling needed in the ADC
driver with a lovely generic input driver.

Very nice!  Hope everyone else agrees ;)

Jonathan

> 
> Eugen Hristev (10):
>   MAINTAINERS: add generic resistive touchscreen adc
>   iio: Add channel for Position Relative
>   dt-bindings: input: touchscreen: touch_adc: create bindings
>   iio: inkern: add module put/get on iio dev module when requesting
>     channels
>   iio: adc: at91-sama5d2_adc: fix channel configuration for differential
>     channels
>   iio: adc: at91-sama5d2_adc: add support for position and pressure
>     channels
>   input: touchscreen: touch_adc: add generic resistive ADC touchscreen
>   dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer
>     info
>   ARM: dts: at91: sama5d2: add channel cells for ADC device
>   ARM: dts: at91: sama5d2: Add resistive touch device
> 
>  Documentation/ABI/testing/sysfs-bus-iio            |  12 +
>  .../bindings/iio/adc/at91-sama5d2_adc.txt          |   9 +
>  .../bindings/input/touchscreen/touch_adc.txt       |  33 ++
>  MAINTAINERS                                        |   6 +
>  arch/arm/boot/dts/sama5d2.dtsi                     |  12 +
>  drivers/iio/adc/at91-sama5d2_adc.c                 | 491 ++++++++++++++++++++-
>  drivers/iio/industrialio-core.c                    |   1 +
>  drivers/iio/inkern.c                               |   8 +-
>  drivers/input/touchscreen/Kconfig                  |  13 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/touch_adc.c              | 199 +++++++++
>  include/dt-bindings/iio/adc/at91-sama5d2_adc.h     |  16 +
>  include/uapi/linux/iio/types.h                     |   1 +
>  tools/iio/iio_event_monitor.c                      |   2 +
>  14 files changed, 791 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
>  create mode 100644 drivers/input/touchscreen/touch_adc.c
>  create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> 
