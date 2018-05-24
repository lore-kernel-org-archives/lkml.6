Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032187AbeEXR4Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:56:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40855 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030366AbeEXR4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:56:23 -0400
Date: Thu, 24 May 2018 19:56:20 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Message-ID: <20180524175620.GB12093@piout.net>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
 <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
 <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
 <20180517045437.GE20254@sirena.org.uk>
 <0e6e71e2-f8ac-7889-0d81-8d8a4c15223d@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6e71e2-f8ac-7889-0d81-8d8a4c15223d@microchip.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/05/2018 19:04:11+0300, Radu Pirea wrote:
> 
> 
> On 05/17/2018 07:54 AM, Mark Brown wrote:
> > On Tue, May 15, 2018 at 12:22:24PM +0300, Radu Pirea wrote:
> > > On Mon, 2018-05-14 at 20:38 +0300, Andy Shevchenko wrote:
> > 
> > > > So, what is not going as expected in "SPI core takes care of CSs"
> > > > case?
> > > > Did you use oscilloscope for that?
> > 
> > > Yes, I used and CSs was not asserted. Anyway, I will will try again.
> > 
> > If the core chip select handling is not working properly for some reason
> > then the core chip select handling should be fixed rather than just open
> > coding in your driver - probably it's also broken for other users.
> > 
> 
> Hi Mark,
> 
> I found the fix for cs-gpios. If I change spi_add_device function like
> this(see below) everything is ok.
> 
> int spi_add_device(struct spi_device *spi)
> 
> ...
> 
>     if (ctlr->cs_gpios){
>         spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
>         if(gpio_is_valid(spi->cs_gpio))
>             gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> 
>     }
> 
> ...
> 
>     return status;
> }
> 
> In the subsystem gpio direction of pins is never set and gpio_set_value()
> don't set the direction.
> In my opinion gpio_direction_output() set direction should be called in
> spi_add_device. What do you think? Is ok?

Back in 2014, I was suggesting using devm_gpio_request_one() in
of_spi_register_master(). That would take care of setting the direction
of the GPIO:

https://www.spinics.net/lists/arm-kernel/msg351251.html

I never took the time to create the patch and test though.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
