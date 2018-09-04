Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75858C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17BE2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ0AH+GI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17BE2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeIDROT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:14:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36971 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIDROT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:14:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so2838689lfb.4;
        Tue, 04 Sep 2018 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D6r0/+tpMLxVYW9JUwh0t/MIXhembdiDSeOxGXmx4HU=;
        b=cQ0AH+GIj0lWXQ/I1eBMfUx5TtxDKGAdpGaW3wasplltzpQFfBR1/mkPF4+IMUNUE+
         BU9flze7Fmkv1sYacX9qfkBdXhbr05oqM7yYoA45GwCnYOlHc5r5vVsl2xO5e9zEBe7l
         ypOtbOeuQuc1s6zRJ2m8xNMlIhXRobqylIxaDncTUP1CbEHpZ71nimcL42t1DshMInf5
         mNmGqXKgrYZKDGp6daxE/pDiiRcXHjDmli+nJ93NJYf/PkFky4H+lsiG4dnKVXUFUQGV
         jip+hVS99kkfNo3Tsnl2loGBuH90Gegdw7P3ZM5a/aK4V0zygs+vQrZRvOOm7aBfnNgi
         sTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D6r0/+tpMLxVYW9JUwh0t/MIXhembdiDSeOxGXmx4HU=;
        b=BvZea3c3E8GuZazXaFJoDUNrtFIfBniX36RPBSx30Z1gG4VWIvFANF5OiXwYuZ1YeR
         6EENL6U+u0zLklOqW+wQqrmrKFOMV+jTAfD/MPPB3rn1u5R/nbeswW/3Dvgn73khUTuX
         iPxX0N4thV1rMPTytGxMex0YXmoyFfSJ2XCsbiwFSMB8DiYz53WBQra7JHU9244En+Lb
         hJYqrJ4B6mSe2IDqJjAQHdGtkkVk7q2mpurTd8TWac3t0IPwLnn1mQawHbPBImzrSJ5c
         NkEH7DovAufQNTnUGQn8E912TaLTgUB0Brd5Q7zFVqw/3M8kGUcRAaMBbD+L3bqwJmrw
         PaKw==
X-Gm-Message-State: APzg51AjqaKE3ZfR5B6qXOCQ3HxewNyE3h3+fjh9NiFt5r2quoYwwNLK
        z5R/W9j6Pn6v/nWhIb18UoQ=
X-Google-Smtp-Source: ANB0VdYlJ/B+TllGHlCBMkIH+A0Vx6XBNT6awm2xq4UNez/jKm7buVL6xTr+FKKmDnohiNdp7Dhk6A==
X-Received: by 2002:a19:4288:: with SMTP id p130-v6mr621449lfa.154.1536065356364;
        Tue, 04 Sep 2018 05:49:16 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f4-v6sm4093010lfa.9.2018.09.04.05.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:49:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxAlo-0001by-9C; Tue, 04 Sep 2018 14:49:24 +0200
Date:   Tue, 4 Sep 2018 14:49:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        andy.shevchenko@gmail.com, ajaykuee@gmail.com,
        daniel.thompson@linaro.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: implement GPIO support for FT230X
Message-ID: <20180904124924.GA7278@localhost>
References: <20180825204744.2307-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180825204744.2307-1-pados@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 10:47:44PM +0200, Karoly Pados wrote:
> This patch uses the CBUS bitbang mode of the device, so there is
> no conflict between the GPIO and VCP functionality.

Please make the commit message self-contained (e.g. don't rely on the
summary, or mail Subject, even if you feel like you're repeating
yourself.)

And you can be a bit more verbose when describing your patch here.

> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
> 
> Tested on an FT230X device. Though there is no copied code from other 
> sources, libftdi was used as a reference.
> 
> I noticed there have been numerous historic attempts by other people at 
> adding GPIO support to ftdi_sio. One tried adding it in some very 
> application-specific way, another one tried to use the mfd framework, the
> tried using a GPIO mode which is mutually exclusive to VCP, another
> one did not implement the review results etc... I hope I learned from those 
> attempts and am planning to respond to reviews. Also, this patch follows 
> the rough structure of the GPIO support for cp210x devices that have 
> already been accepted, in the hope that it is a good starting point.
> 
> This patch uses CBUS bitbanging mode, which works nicely in parallel with
> the VCP function. The other modes do not, and so IMHO it does not make
> sense to try adding them to this same module.
>
> For this device, whenever changing the state of any single pin, all the
> others need to be written too. This means in order to change any pin, we 
> need to know the current state of all the others. So when using GPIO,
> we need to have a known starting state for all pins, but there seems to 
> be no way to retrieve the existing GPIO configuration (directions and
> output register values). The way I handle this in this patch is that when
> requesting a GPIO for the first time, the module initializes all pins to 
> a known default state (to inputs). Input was chosen, because a potentially
> floating pin is better than a potential driver conflict, because the latter
> could result in hardware damage. However, if the user does not request a 
> GPIO, the CBUS pins are not initialized, avoiding unnecessarily changing 
> hardware state. I figured I cannot rely on the default power-on state of
> the device for this as the user might have used libftdi before loading 
> our module. When the module is unloaded, CBUS bitbanging mode is exited 
> if it were us who entered it earlier.

This paragraph seems like it belongs in the commit message in some form.

But your approach seems reasonable, even if it means all pins may change
state when requesting the first.

Actually, after thinking about this some more, it may be better to just
configure all pins during probe. The device is managed by the kernel,
and we can't really consider what user space may have done before, at
least if we can't query the device.  Better to be in a consistent state
while the driver is bound.

> checkpatch.pl emits a bunch of warnings, recommending const for structs. 
> I am unsure if this makes sense, existing code in this same and also
> other modules does not adhere to this rule either. I fixed everything else.

Really? Checkpatch doesn't complain here. Were you using the --strict
option, perhaps? Don't do that...

>  drivers/usb/serial/ftdi_sio.c | 284 +++++++++++++++++++++++++++++++++-
>  drivers/usb/serial/ftdi_sio.h |  25 +++
>  2 files changed, 308 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index b5cef322826f..d1ff4a372b6e 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -40,6 +40,9 @@
>  #include <linux/usb.h>
>  #include <linux/serial.h>
>  #include <linux/usb/serial.h>
> +#ifdef CONFIG_GPIOLIB
> +#include <linux/gpio/driver.h>
> +#endif

No ifdef.

>  #include "ftdi_sio.h"
>  #include "ftdi_sio_ids.h"
>  
> @@ -72,6 +75,14 @@ struct ftdi_private {
>  	unsigned int latency;		/* latency setting in use */
>  	unsigned short max_packet_size;
>  	struct mutex cfg_lock; /* Avoid mess by parallel calls of config ioctl() and change_speed() */
> +#ifdef CONFIG_GPIOLIB
> +	struct gpio_chip gc;
> +	bool	gpio_registered;  /* is the gpiochip in kernel registered */
> +	bool	gpio_used;	  /* true if the user requested a gpio */
> +	u8	gpio_altfunc;	  /* which pins are in gpio mode */
> +	u8	gpio_input;	  /* pin directions cache */
> +	u8	gpio_value;	  /* pin value for outputs */
> +#endif
>  };
>  
>  /* struct ftdi_sio_quirk is used by devices requiring special attention. */
> @@ -1766,6 +1777,268 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
>  
>  }
>  
> +#ifdef CONFIG_GPIOLIB
> +
> +static int ftdi_sio_set_cbus(struct usb_serial_port *port,

Please drop the "_sio" infix from your functions, "ftdi_" as prefix is
enough.

> +			     u8 direction,
> +			     u8 value,
> +			     u8 mode)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);

Since you have port and priv here anyway, you could consider not passing
direction and value in every call. Even mode could go, if you add a
separate helper for that, which would also make this function more
appropriately named.

> +	u16 val;
> +
> +	/* device's direction polarity is different from kernel's */

Why so? You could just replace gpio_input with gpio_output. I think that
may be preferred.

> +	direction = (~direction) & 0x0f;
> +
> +	val = (mode << 8) | (direction << 4) | (value & 0x0f);
> +	return usb_control_msg(port->serial->dev,
> +				 usb_sndctrlpipe(port->serial->dev, 0),
> +				 FTDI_SIO_SET_BITMODE_REQUEST,
> +				 FTDI_SIO_SET_BITMODE_REQUEST_TYPE, val,
> +				 priv->interface, NULL, 0, WDR_TIMEOUT);

I think you should log any errors here (even if that means two error
messages for failed set()).

> +}
> +
> +static int ftdi_sio_gpio_request(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	int result = 0;

No need to initialise.

> +
> +	if (priv->gpio_altfunc & BIT(offset))
> +		return -ENODEV;
> +
> +	if (!priv->gpio_used) {
> +		/* Set default pin states, as we cannot get them from device */
> +		priv->gpio_input = 0xff;
> +		priv->gpio_value = 0x00;
> +		result = ftdi_sio_set_cbus(port,
> +					   priv->gpio_input,
> +					   priv->gpio_value,
> +					   FTDI_SIO_GPIO_MODE_CBUS);
> +		if (result)
> +			return result;
> +
> +		priv->gpio_used = true;
> +	}

So I think this initialisation should be done at probe instead.

> +
> +	return 0;
> +}
> +
> +static int ftdi_sio_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	unsigned char *rcvbuf;
> +	int result;
> +
> +	rcvbuf = kmalloc(1, GFP_KERNEL);
> +	if (!rcvbuf)
> +		return -ENOMEM;
> +
> +	result = usb_control_msg(serial->dev,
> +				 usb_rcvctrlpipe(serial->dev, 0),
> +				 FTDI_SIO_READ_PINS_REQUEST,
> +				 FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
> +				 priv->interface, rcvbuf, 1, WDR_TIMEOUT);
> +

No newline.

> +	if (result < 1)
> +		result = -EIO;
> +	else
> +		result = !!(rcvbuf[0] & BIT(gpio));
> +
> +	kfree(rcvbuf);
> +
> +	return result;
> +}
> +
> +static void ftdi_sio_gpio_set(struct gpio_chip *gc,
> +			      unsigned int gpio,
> +			      int value
> +)

Closing parentheses goes after value.

> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	int result;
> +
> +	if (value)
> +		priv->gpio_value |= BIT(gpio);
> +	else
> +		priv->gpio_value &= ~BIT(gpio);
> +
> +	result = ftdi_sio_set_cbus(port,
> +				   priv->gpio_input,
> +				   priv->gpio_value,
> +				   FTDI_SIO_GPIO_MODE_CBUS);
> +

No newline.

> +	if (result < 0) {
> +		dev_err(&port->serial->interface->dev,
> +			"failed to set GPIO value: %d\n",
> +			result);
> +	}
> +}
> +
> +static int ftdi_sio_gpio_direction_get(struct gpio_chip *gc,
> +				       unsigned int gpio)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	return priv->gpio_input & BIT(gpio);
> +}
> +
> +static int ftdi_sio_gpio_direction_input(struct gpio_chip *gc,
> +					 unsigned int gpio)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	priv->gpio_input |= BIT(gpio);
> +
> +	return ftdi_sio_set_cbus(port,
> +			  priv->gpio_input,
> +			  priv->gpio_value,
> +			  FTDI_SIO_GPIO_MODE_CBUS);
> +}
> +
> +static int ftdi_sio_gpio_direction_output(struct gpio_chip *gc,
> +					  unsigned int gpio,
> +					  int value)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	priv->gpio_input &= ~BIT(gpio);
> +	if (value)
> +		priv->gpio_value |= BIT(gpio);
> +	else
> +		priv->gpio_value &= ~BIT(gpio);
> +
> +	return ftdi_sio_set_cbus(port,
> +			  priv->gpio_input,
> +			  priv->gpio_value,
> +			  FTDI_SIO_GPIO_MODE_CBUS);
> +}
> +
> +static int ftx_gpioconf_init(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	const u16 config_size = 0x24;
> +	u8 *config_buf;
> +	int result;
> +	u8 i;
> +
> +	/* Read part of device EEPROM */
> +	config_buf = kmalloc(config_size, GFP_KERNEL);
> +	if (!config_buf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < config_size / 2; i++) {
> +		result = usb_control_msg(serial->dev,
> +					 usb_rcvctrlpipe(serial->dev, 0),
> +					 FTDI_SIO_READ_EEPROM_REQUEST,
> +					 FTDI_SIO_READ_EEPROM_REQUEST_TYPE, 0,
> +					 i, config_buf + (i * 2),

2 * i, parenthesis not needed

> +					 2, WDR_TIMEOUT);
> +		if (result < 2) {
> +			result = -EIO;

Return -EIO for short transfers, but just return result otherwise.

> +			break;
> +		}
> +	}
> +
> +	if (result < 0) {
> +		kfree(config_buf);
> +		return result;
> +	}

Factor this out to an eeprom helper that can be reused by other chip
types.

> +
> +	/*
> +	 * All FT-X devices have at least 1 GPIO, some have more.
> +	 * Chip-type guessing logic based on libftdi.
> +	 */
> +	priv->gc.ngpio = 1;
> +	if (serial->dev->descriptor.bcdDevice == 0x1000)  /* FT230X */

Missing le16_to_cpu().

> +		priv->gc.ngpio = 4;

Shouldn't this be handled the other way round? IIRC there are two FTX
device types with four pins, and one type where only one pin is
accessible.

> +
> +	/* Determine which pins are configured for CBUS bitbanging */
> +	priv->gpio_altfunc = 0xff;
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		if (config_buf[0x1A + i] == FTDI_SIO_CBUS_MUX_GPIO)

0x1a warrants a define; but you shouldn't be reading 0x24 bytes from
offset 0 above when the pinconfig is stored in just a couple of words.

> +			priv->gpio_altfunc &= ~BIT(i);
> +	}
> +
> +	kfree(config_buf);
> +
> +	return 0;
> +}
> +
> +static int ftdi_sio_gpio_init(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	int result;
> +
> +	/* Device-specific initializations */
> +	switch (priv->chip_type) {
> +	case FTX:
> +		result = ftx_gpioconf_init(port);
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (result < 0)
> +		return result;
> +
> +	/* Register GPIO chip to kernel */
> +	priv->gc.label = "ftdi_sio";

Maybe we shouldn't use the legacy sio suffix here; "ftdi" or "ftdi-cbus"
should do.

> +	priv->gc.request = ftdi_sio_gpio_request;
> +	priv->gc.get_direction = ftdi_sio_gpio_direction_get;
> +	priv->gc.direction_input = ftdi_sio_gpio_direction_input;
> +	priv->gc.direction_output = ftdi_sio_gpio_direction_output;
> +	priv->gc.get = ftdi_sio_gpio_get;
> +	priv->gc.set = ftdi_sio_gpio_set;
> +	priv->gc.owner = THIS_MODULE;
> +	priv->gc.parent = &serial->interface->dev;
> +	priv->gc.base = -1;
> +	priv->gc.can_sleep = true;
> +
> +	result = gpiochip_add_data(&priv->gc, port);
> +	if (!result)
> +		priv->gpio_registered = true;
> +
> +	return result;
> +}
> +
> +static void ftdi_sio_gpio_remove(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	if (priv->gpio_used) {
> +		ftdi_sio_set_cbus(port, 0, 0, FTDI_SIO_GPIO_MODE_RESET);

IIRC this leaves the pins in the state that we set them, which is fine,
but could be highlighted here.

> +		priv->gpio_used = false;
> +	}
> +
> +	if (priv->gpio_registered) {
> +		gpiochip_remove(&priv->gc);
> +		priv->gpio_registered = false;
> +	}
> +}
> +
> +#else
> +
> +static int ftdi_sio_gpio_init(struct usb_serial *serial)

As the test robot reported, these should take a port as their argument.

> +{
> +	return 0;
> +}
> +
> +static void ftdi_sio_gpio_remove(struct usb_serial *serial)
> +{
> +	/* Nothing to do */

Comment not really needed; you can even put the brackets after the
closing parentheses

	...* serial) { }

as we sometimes do in headers, if you want.

> +}
> +
> +#endif
> +
>  /*
>   * ***************************************************************************
>   * FTDI driver specific functions
> @@ -1794,7 +2067,7 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
>  {
>  	struct ftdi_private *priv;
>  	const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
> -
> +	int result;
>  
>  	priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
>  	if (!priv)
> @@ -1813,6 +2086,13 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
>  		priv->latency = 16;
>  	write_latency_timer(port);
>  	create_sysfs_attrs(port);
> +
> +	result = ftdi_sio_gpio_init(port);
> +	if (result < 0)
> +		dev_err(&port->serial->interface->dev,
> +			"GPIO initialisation failed: %d\n",
> +			result);

Please use brackets for conditionals with multi-line statements.

> +
>  	return 0;
>  }
>  
> @@ -1930,6 +2210,8 @@ static int ftdi_sio_port_remove(struct usb_serial_port *port)
>  {
>  	struct ftdi_private *priv = usb_get_serial_port_data(port);
>  
> +	ftdi_sio_gpio_remove(port);
> +
>  	remove_sysfs_attrs(port);
>  
>  	kfree(priv);
> diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
> index dcd0b6e05baf..5046d02fe3ac 100644
> --- a/drivers/usb/serial/ftdi_sio.h
> +++ b/drivers/usb/serial/ftdi_sio.h
> @@ -36,6 +36,10 @@
>  #define FTDI_SIO_SET_ERROR_CHAR		7 /* Set the error character */
>  #define FTDI_SIO_SET_LATENCY_TIMER	9 /* Set the latency timer */
>  #define FTDI_SIO_GET_LATENCY_TIMER	10 /* Get the latency timer */
> +#define FTDI_SIO_SET_BITMODE		11 /* Set CBUS GPIO pin mode */
> +#define FTDI_SIO_READ_PINS		12 /* Read immediate value of pins */
> +#define FTDI_SIO_READ_EEPROM		144 /* Read EEPROM */

Please use hex notation.

> +
>  
>  /* Interface indices for FT2232, FT2232H and FT4232H devices */
>  #define INTERFACE_A		1
> @@ -433,6 +437,27 @@ enum ftdi_sio_baudrate {
>   *         1 = active
>   */
>  
> +/* FTDI_SIO_SET_BITMODE */
> +#define FTDI_SIO_SET_BITMODE_REQUEST_TYPE 0x40
> +#define FTDI_SIO_SET_BITMODE_REQUEST FTDI_SIO_SET_BITMODE

This looks awfully redundant, but I realise you're just sticking to the
current pattern (as you should).

> +
> +/* FTDI_SIO_READ_PINS */
> +#define FTDI_SIO_READ_PINS_REQUEST_TYPE 0xc0
> +#define FTDI_SIO_READ_PINS_REQUEST FTDI_SIO_READ_PINS
> +
> +/*
> + * FTDI_SIO_READ_EEPROM
> + *
> + * EEPROM format found in FTDI AN_201, "FT-X MTP memory Configuration",
> + * http://www.ftdichip.com/Support/Documents/AppNotes/AN_201_FT-X%20MTP%20Memory%20Configuration.pdf
> + */
> +#define FTDI_SIO_READ_EEPROM_REQUEST_TYPE 0xc0
> +#define FTDI_SIO_READ_EEPROM_REQUEST FTDI_SIO_READ_EEPROM
> +
> +#define FTDI_SIO_GPIO_MODE_CBUS		0x20
> +#define FTDI_SIO_GPIO_MODE_RESET	0x00

Sort the mode defines by value here.

And these belong with FTDI_SET_BITMODE above and should be renamed to
reflect that.

> +
> +#define FTDI_SIO_CBUS_MUX_GPIO		8
>  
>  
>  /* Descriptors returned by the device

Thanks,
Johan
