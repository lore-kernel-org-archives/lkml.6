Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeDPX62 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 19:58:28 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37673 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeDPX60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 19:58:26 -0400
X-Google-Smtp-Source: AIpwx4/cZ4ZY9s84KYfntPM0VNOdkyY+3ajlMEMAG8SaPQ11hPkLSDLw/y+96FIcZEhq/7OlQ2zasg==
Date: Mon, 16 Apr 2018 16:58:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, nicolas.ferre@microchip.com,
        robh@kernel.org
Subject: Re: [PATCH v3 06/11] iio: inkern: add module put/get on iio dev
 module when requesting channels
Message-ID: <20180416235821.GF77055@dtor-ws>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
 <1523350677-27106-7-git-send-email-eugen.hristev@microchip.com>
 <20180415203321.1aaaf91e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415203321.1aaaf91e@archlinux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 08:33:21PM +0100, Jonathan Cameron wrote:
> On Tue, 10 Apr 2018 11:57:52 +0300
> Eugen Hristev <eugen.hristev@microchip.com> wrote:
> 
> > When requesting channels for a particular consumer device,
> > besides requesting the device (incrementing the reference counter), also
> > do it for the driver module of the iio dev. This will avoid the situation
> > where the producer IIO device can be removed and the consumer is still
> > present in the kernel.
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > ---
> >  drivers/iio/inkern.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index ec98790..68d9b87 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/mutex.h>
> >  #include <linux/of.h>
> > +#include <linux/module.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include "iio_core.h"
> > @@ -152,6 +153,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
> >  	if (index < 0)
> >  		goto err_put;
> >  	channel->channel = &indio_dev->channels[index];
> > +	try_module_get(channel->indio_dev->driver_module);
> 
> And if it fails? (the module we are trying to get is going away...)
> 
> We should try and handle it I think. Be it by just erroring out of here.

Even more, this has nothing to do with modules. A device can go away for
any number of reasons (we unbind it manually via sysfs, we pull the USB
plug from the host in case it is USB-connected device, we unload I2C
adapter for the bus device resides on, we kick underlying PCI device)
and we should be able to handle this in some fashion. Handling errors
from reads and ignoring garbage is one of methods.

FWIW this is a NACK from me.

Thanks.

-- 
Dmitry
