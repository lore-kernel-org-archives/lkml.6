Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeDZCdr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:33:47 -0400
Received: from bert.emutex.com ([91.103.1.109]:54909 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeDZCdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:33:43 -0400
Date: Thu, 26 Apr 2018 03:33:37 +0100
From: Javier Arteaga <javier@emutex.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, "Dan O'Donovan" <dan@emutex.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 1/3] mfd: upboard: Add UP2 platform controller
 driver
Message-ID: <20180426023337.u2d6azqcjmjsur5c@localhost>
References: <20180421085009.28773-1-javier@emutex.com>
 <20180421085009.28773-2-javier@emutex.com>
 <1524671850.21176.585.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524671850.21176.585.camel@linux.intel.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi Andy, First off, many thanks for your thorough review!
   Replies inline. On Wed, Apr 25, 2018 at 06:57:30PM +0300, Andy Shevchenko
   wrote: > > +config MFD_UPBOARD > > + tristate "UP Squared" > > + depends on
    ACPI > > + depends on GPIOLIB > > + select MFD_CORE > > + select REGMAP >
    > + help > > + If you say yes here you get support for the platform > > controller
    > > + of the UP Squared single-board computer. > > + > > + This driver provides
    common support for accessing the > > device, > > + additional drivers must
    be enabled in order to use the > > + functionality of the device. > > + >
    > + This driver can also be built as a module. If so, the > > module > >
   + will be called upboard. > > "upboard" [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

First off, many thanks for your thorough review! Replies inline.

On Wed, Apr 25, 2018 at 06:57:30PM +0300, Andy Shevchenko wrote:
> > +config MFD_UPBOARD
> > +	tristate "UP Squared"
> > +	depends on ACPI
> > +	depends on GPIOLIB
> > +	select MFD_CORE
> > +	select REGMAP
> > +	help
> > +	  If you say yes here you get support for the platform
> > controller
> > +	  of the UP Squared single-board computer.
> > +
> > +	  This driver provides common support for accessing the
> > device,
> > +	  additional drivers must be enabled in order to use the
> > +	  functionality of the device.
> > +
> > +	  This driver can also be built as a module. If so, the
> > module
> > +	  will be called upboard.
> 
> "upboard"

The module name in quotes reads better to me too, but the majority of
Kconfig entries do it this way, looks like:

linux $ rg 'module will be called [^"]' | wc -l
1275
linux $ rg 'module will be called "' | wc -l
5

> > +static int upboard_read(void *context, unsigned int reg, unsigned int
> > *val)
> Can't you rewrite this like
> 
> for (addr) {
>  strobe(0)
>  data(x)
>  strobe(1)
> }
> 
> for (register) {
>  strobe(0)
>  val = data(x)
>  strobe(1)
> }
> 
> val &= BIT(register_size);
> strobe(0)
> 
> ?

> > +static int upboard_write(void *context, unsigned int reg, unsigned
> > int val)
> Similar here:
> 
> for (addr) {
>  strobe(0)
>  data(x)
>  strobe(1)
> }
> 
> for (register) {
>  strobe(0)
>  data(x)
>  strobe(1)
> }
> 
> strobe(0)
> strobe(1)
> 
> ?

> Moreover these two functions have duplications, i.e.
> 
> static ... upboard_clear()
> {
>  clear(0)
>  clear(1)
> }
> 
> static ... upboard_set_address()
> {
>  for (addr) {
>   ...
>  }
> }

I'll look into making these R/W functions more compact.

> Additional question is about spi-bitbang and i2c-gpio. Can one of them
> be utilized here? Why not?

i2c-gpio would be closest, but unfortunately this isn't quite I2C:

- two in/out GPIOs instead of a single SDA line,
- R/W sequence start is signaled from yet _another_ line,
- ACK implicit in last rising edge of the address instead of an ACK pulse,
- etc...

Probably should explain this in a comment too.

> > +static int upboard_init_gpio(struct upboard *upboard)
> > +{
> > +	struct gpio_desc *enable_gpio;
> > +
> > +	enable_gpio = devm_gpiod_get(upboard->dev, "enable",
> > GPIOD_OUT_LOW);
> > +	if (IS_ERR(enable_gpio))
> > +		return PTR_ERR(enable_gpio);
> 
> > +	gpiod_set_value(enable_gpio, 1);
> 
> When do you disable it? Why not?

enable = 0/1 sets all FPGA pins for FPGA-routed lines Hi-Z/active. It's
probably safer to set enable = 0 on unload.

I'll go over this again (and add comments in any case).

> > +static int upboard_check_supported(struct upboard *upboard)
> > +{
> 
> > +	const unsigned int AAEON_MANUFACTURER_ID = 0x01;
> > +	const unsigned int SUPPORTED_FW_MAJOR = 0x0;
> 
> Why to hide here instead of putting at the top of file as defined
> constants?

No strong reason. I'll move them to the top.

> > +	build = (firmware_id >> 12) & 0xf;
> > +	major = (firmware_id >> 8) & 0xf;
> > +	minor = (firmware_id >> 4) & 0xf;
> 
> > +	patch = firmware_id & 0xf;
> 
> For style purposes you can use
> (firmware >> 0) & 0xf here

Sure, why not.

> > +static int upboard_probe(struct platform_device *pdev)
> > +{
> > +	struct upboard *upboard;
> > +	const struct acpi_device_id *id;
> > +	const struct upboard_data *upboard_data;
> > +	int ret;
> 
> > +	id = acpi_match_device(upboard_acpi_match, &pdev->dev);
> > +	if (!id)
> > +		return -ENODEV;
> > +
> > +	upboard_data = (const struct upboard_data *) id->driver_data;
> 
> Use new API for that.

Will do.

> > +MODULE_LICENSE("GPL");
> 
> License mismatch.

True, it should read "GPL v2". I'll update these.

> > +#define UPBOARD_ADDRESS_SIZE  7
> > +#define UPBOARD_REGISTER_SIZE 16
> 
> > +#define UPBOARD_READ_FLAG     BIT(UPBOARD_ADDRESS_SIZE)
> 
> It's not clear why this one is defined in this way.
> Comment is needed.

It means that the RW flag comes after the last bit of the address, like
in I2C. I'll likely drop this #define and make this clearer next
iteration.
