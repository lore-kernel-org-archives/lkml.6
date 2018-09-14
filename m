Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3EFFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8402C2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgULJAp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8402C2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeINV1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:27:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46938 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:27:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so7951046ljj.13;
        Fri, 14 Sep 2018 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IQmdHxD3CoBeeWnOIi78CA4wBxNbrQghy38GaLKArPE=;
        b=tgULJAp3c3UwTzC8YxOFQaVcS0x5TN6N1B7+7NODdcoFSezhHhzD2ozkknZIaijXSf
         D8cRHVQ8PKl2OIroW3zMRnv7i5yNl6B9/a764SYZmk8zCjQHZYPx9sSFURaV1JhM1NOm
         Z1nQ4RIYsPKetXSV2zutyHZVgPcwkVphKm6KKC9+f+kHc//JFOVBmrt5poSqAT8owG5+
         PnnwuShtKZnyOeEns4UzWPBMs8cKb2mSW8w3KwfuxoVuhB6QoGxuWM6yRQk5PBNgH58g
         WPasG2j++48x1JRzswjIe3aTlPMSDojUYyq8pyayjq3eLwywc6qMGELYf+DJXhzfHjff
         bKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IQmdHxD3CoBeeWnOIi78CA4wBxNbrQghy38GaLKArPE=;
        b=MuclXD4cyGBwMjBCZpBrf4ThPde1be3gGnEDK0fZpIsQUTamJ+UNXZVndFsWLMFA/c
         s+11pCK/mdzPEq7gGs+MRgSBP63WOLECYCtfLrBYN44nnExcG98WKoRn9go/yuEUEYAL
         Bidv+wyrl4nuUpdEApmKZKSZG4Oo22+yxwnoBZeuS9iA7qABrHVpLhf3lBTwOQm49+MF
         Pzt7nb1oPFS9aQZgZ/n+N8vU/0pX+9wqknj+EOZmTgsP9iVDW6JzOVJDc2LEOzEUf36+
         f62Db4qL9GqOhCaVsXI83NtgfQ4mz9WF7EnhO8nChrluJfkBoKlmOSronMKhHeMijWkm
         fSxA==
X-Gm-Message-State: APzg51Ajkzls15RuWcg611lY5XXS7A7Yl+KsJgxJDNt13IsEyRnCQmSD
        K4qrEUZU3wEIn4Y/zgbHIHwhcJUL
X-Google-Smtp-Source: ANB0VdbsA9+wXUIdKhO6r2gz8eovaMLkdNbX4bnUBQXFvHeLfObnn3XCmw+7MVpDSa76eie7hu0xow==
X-Received: by 2002:a2e:8513:: with SMTP id j19-v6mr8290070lji.10.1536941513661;
        Fri, 14 Sep 2018 09:11:53 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v14-v6sm1237959lji.80.2018.09.14.09.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 09:11:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0qhH-0006Ny-Ej; Fri, 14 Sep 2018 18:11:55 +0200
Date:   Fri, 14 Sep 2018 18:11:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v3] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180914161155.GB3443@localhost>
References: <20180910174322.1042-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910174322.1042-1-pados@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 07:43:22PM +0200, Karoly Pados wrote:
> This patch allows using the CBUS pins of FT-X devices as GPIO in CBUS
> bitbanging mode. There is no conflict between the GPIO and VCP
> functionality in this mode. Tested on FT230X and FT231X.
> 
> As there is no way to request the current CBUS register configuration
> from the device, all CBUS pins are set to a known state when the first
> GPIO is requested. This allows using libftdi to set the GPIO pins
> before loading this module for UART functionality, a behavior that
> existing applications might be relying upon (though no specific case
> is known to the authors of this patch).
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
> 
> Changelog:
> - v2: Fix compile error when CONFIG_GPIOLIB is not defined.
> - v3: Incorporate review feedback.

Next time, please be more specific about what you changed here.

> Though there is no code copied, libftdi was used as 
> a reference. ftdi_read_eeprom is based on Loic Poulain's patch.
> 
> I've removed --strict from checkpatch.pl invocation, yet it still gives
> me those warnings it shouldn't. Maybe I have a different version? Now
> in v3 I also get two new I'm not sure how to deal with. Rest of text 
> below same as before.

Yeah, the two new ones I get too, and they need to be fixed. More below.

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
> 
> 
>  drivers/usb/serial/ftdi_sio.c | 318 +++++++++++++++++++++++++++++++++-
>  drivers/usb/serial/ftdi_sio.h |  27 ++-
>  2 files changed, 343 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index b5cef322826f..00b6c6abdd09 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -40,6 +40,9 @@
>  #include <linux/usb.h>
>  #include <linux/serial.h>
>  #include <linux/usb/serial.h>
> +#if defined(CONFIG_GPIOLIB)
> +#include <linux/gpio/driver.h>
> +#endif

Hmm. I already commented on this in v1.

>  #include "ftdi_sio.h"
>  #include "ftdi_sio_ids.h"
>  
> @@ -72,6 +75,14 @@ struct ftdi_private {
>  	unsigned int latency;		/* latency setting in use */
>  	unsigned short max_packet_size;
>  	struct mutex cfg_lock; /* Avoid mess by parallel calls of config ioctl() and change_speed() */
> +#if defined(CONFIG_GPIOLIB)
> +	struct gpio_chip gc;
> +	bool	gpio_registered;  /* is the gpiochip in kernel registered */
> +	bool	gpio_used;	  /* true if the user requested a gpio */
> +	u8	gpio_altfunc;	  /* which pins are in gpio mode */
> +	u8	gpio_input;	  /* pin directions cache */

And I asked you to invert this one (i.e. replace with gpio_output).

> +	u8	gpio_value;	  /* pin value for outputs */
> +#endif
>  };
>  
>  /* struct ftdi_sio_quirk is used by devices requiring special attention. */
> @@ -1766,6 +1777,301 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
>  
>  }
>  
> +#if defined(CONFIG_GPIOLIB)
> +
> +static int ftdi_set_bitmode_req(struct usb_serial_port *port, u8 mode)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	int result;
> +	u16 val;
> +
> +	/* device's direction polarity is different from kernel's */
> +	u8 direction = (~priv->gpio_input) & 0x0f;
> +
> +	val = (mode << 8) | (direction << 4) | (priv->gpio_value & 0x0f);
> +	result = usb_control_msg(serial->dev,
> +				 usb_sndctrlpipe(serial->dev, 0),
> +				 FTDI_SIO_SET_BITMODE_REQUEST,
> +				 FTDI_SIO_SET_BITMODE_REQUEST_TYPE, val,
> +				 priv->interface, NULL, 0, WDR_TIMEOUT);
> +

And I asked you to remove such empty lines.

> +	if (result < 0) {
> +		dev_err(&serial->interface->dev,
> +			"bitmode request failed for value: %d\n",

Use hex notation and include the errno:
	
	"bitmode request failed for value 0x%04x: %d\n", val, result

> +	}
> +
> +	return result;
> +}
> +
> +static int ftdi_set_cbus_pins(struct usb_serial_port *port)
> +{
> +	return ftdi_set_bitmode_req(port, FTDI_SIO_BITMODE_CBUS);
> +}
> +
> +static int ftdi_exit_cbus_mode(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	priv->gpio_input = 0;
> +	priv->gpio_value = 0;
> +	return ftdi_set_bitmode_req(port, FTDI_SIO_BITMODE_RESET);
> +}
> +
> +static int ftdi_gpio_request(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	int result;
> +
> +	if (priv->gpio_altfunc & BIT(offset))
> +		return -ENODEV;
> +
> +	if (!priv->gpio_used) {
> +		/* Set default pin states, as we cannot get them from device */
> +		priv->gpio_input = 0xff;
> +		priv->gpio_value = 0x00;
> +		result = ftdi_set_cbus_pins(port);
> +		if (result)
> +			return result;
> +
> +		priv->gpio_used = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ftdi_gpio_get(struct gpio_chip *gc, unsigned int gpio)
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
> +	if (result < 0) {
> +	} else if (result < 1)
> +		result = -EIO;
> +	else
> +		result = !!(rcvbuf[0] & BIT(gpio));

Implement this as

	if (result < 1) {
		if (result >= 0)
			result = -EIO;
	} else {
		result = ...
	}

which follows a common pattern and doesn't violate the coding style.

> +
> +	kfree(rcvbuf);
> +
> +	return result;
> +}
> +
> +static void ftdi_gpio_set(struct gpio_chip *gc,
> +			      unsigned int gpio,
> +			      int value)
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
> +	result = ftdi_set_cbus_pins(port);
> +	if (result < 0) {
> +		dev_err(&port->serial->interface->dev,
> +			"failed to set GPIO value: %d\n",
> +			result);
> +	}

You could now drop the dev_err here if you want.

> +}
> +
> +static int ftdi_gpio_direction_get(struct gpio_chip *gc,
> +				       unsigned int gpio)

Looks like there's no longer any need for a line break above (and
elsewhere?).

> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	return priv->gpio_input & BIT(gpio);

Return 0 or 1 here as most (all?) drivers do.

> +}
> +
> +static int ftdi_gpio_direction_input(struct gpio_chip *gc,
> +					 unsigned int gpio)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	priv->gpio_input |= BIT(gpio);
> +
> +	return ftdi_set_cbus_pins(port);
> +}
> +
> +static int ftdi_gpio_direction_output(struct gpio_chip *gc,
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
> +	return ftdi_set_cbus_pins(port);
> +}
> +
> +/* Returns the number of bytes read */
> +static int ftdi_read_eeprom(struct usb_serial *serial,
> +			    void *dst,	/* must be kmalloc'd using GFP_KERNEL*/

Whether GFP_KERNEL was used is not really relevant, but highlighting
that the buffer needs to be DMA-able is good.

> +			    u16 addr,	/* must be aligned to 16 bits */
> +			    u16 nbytes)	/* must be a multiple of 16 bits */

I think checkpatch gets confused by you odd argument comments here. Use
a kernel doc comment, if you want to be this specific instead.

> +{
> +	int read = 0;
> +
> +	/* Argument checks */

Comment not needed.

> +	if (addr % 2 != 0)
> +		return -EINVAL;
> +	if (nbytes % 2 != 0)
> +		return -EINVAL;
> +
> +	/* Read EEPROM two bytes at a time */
> +	while (read < nbytes) {
> +		int rv;
> +
> +		rv = usb_control_msg(serial->dev,
> +				     usb_rcvctrlpipe(serial->dev, 0),
> +				     FTDI_SIO_READ_EEPROM_REQUEST,
> +				     FTDI_SIO_READ_EEPROM_REQUEST_TYPE,
> +				     0, (addr + read) / 2, dst + read, 2,
> +				     WDR_TIMEOUT);
> +		if (rv < 0)
> +			return rv;
> +
> +		read += rv;
> +
> +		if (rv < 2)
> +			break;

Treat any short read as an error.

> +	}
> +
> +	return read;

Just return 0 on success and always return as many bytes as was
requested.

> +}
> +
> +static int ftx_gpioconf_init(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	const u16 cbus_cfg_addr = 0x1a;
> +	const u16 cbus_cfg_size = 8;
> +	u8 *cbus_cfg_buf;
> +	int result;
> +	u8 i;
> +
> +	/* Read a part of device EEPROM */
> +	cbus_cfg_buf = kmalloc(cbus_cfg_size, GFP_KERNEL);
> +	if (!cbus_cfg_buf)
> +		return -ENOMEM;
> +
> +	result = ftdi_read_eeprom(serial, cbus_cfg_buf,
> +				  cbus_cfg_addr, cbus_cfg_size);
> +

No empty line.

> +	if (result < 0)
> +		goto out_free;
> +	else if (result < 8) {
> +		result = -EIO;

Just handle this case in the helper.

> +		goto out_free;
> +	} else
> +		result = 0;

Note that you need brackets on all branches as per the coding style.

> +
> +	/* Chip-type guessing logic based on libftdi. */
> +	priv->gc.ngpio = 4;  /* FT230X, FT231X */
> +	if (le16_to_cpu(serial->dev->descriptor.bcdDevice) != 0x1000)
> +		priv->gc.ngpio = 1;  /* FT234XD */

No known way to identify FT234XD here?

After taking a quick peek at libftdi, it seems we really have no clue
how to detect these device types and 0x1000 could be for all FTX
devices. Heck, the current kernel driver just assumes anything we don't
recognise to be an FTX, something which would now hit this code path...

What devices did you and Loic have? Could you post the lsusb -v output
for these? Perhaps someone with an FT234XD can chime in as well.

> +
> +	/* Determine which pins are configured for CBUS bitbanging */
> +	priv->gpio_altfunc = 0xff;
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		if (cbus_cfg_buf[i] == FTDI_SIO_CBUS_MUX_GPIO)
> +			priv->gpio_altfunc &= ~BIT(i);
> +	}
> +
> +out_free:
> +	kfree(cbus_cfg_buf);
> +
> +	return result;
> +}
> +
> +static int ftdi_gpio_init(struct usb_serial_port *port)
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
> +	priv->gc.label = "ftdi-cbus";
> +	priv->gc.request = ftdi_gpio_request;
> +	priv->gc.get_direction = ftdi_gpio_direction_get;
> +	priv->gc.direction_input = ftdi_gpio_direction_input;
> +	priv->gc.direction_output = ftdi_gpio_direction_output;
> +	priv->gc.get = ftdi_gpio_get;
> +	priv->gc.set = ftdi_gpio_set;
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
> +static void ftdi_gpio_remove(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	if (priv->gpio_used) {
> +		/* Remark: Exiting CBUS-mode does not reset pin states too */
> +		ftdi_exit_cbus_mode(port);
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
> +static int ftdi_gpio_init(struct usb_serial_port *port)
> +{
> +	return 0;
> +}
> +
> +static void ftdi_gpio_remove(struct usb_serial_port *port) { }
> +
> +#endif
> +
>  /*
>   * ***************************************************************************
>   * FTDI driver specific functions
> @@ -1794,7 +2100,7 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
>  {
>  	struct ftdi_private *priv;
>  	const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
> -
> +	int result;
>  
>  	priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
>  	if (!priv)
> @@ -1813,6 +2119,14 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
>  		priv->latency = 16;
>  	write_latency_timer(port);
>  	create_sysfs_attrs(port);
> +
> +	result = ftdi_gpio_init(port);
> +	if (result < 0) {
> +		dev_err(&port->serial->interface->dev,
> +			"GPIO initialisation failed: %d\n",
> +			result);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1930,6 +2244,8 @@ static int ftdi_sio_port_remove(struct usb_serial_port *port)
>  {
>  	struct ftdi_private *priv = usb_get_serial_port_data(port);
>  
> +	ftdi_gpio_remove(port);
> +
>  	remove_sysfs_attrs(port);
>  
>  	kfree(priv);
> diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
> index dcd0b6e05baf..5a296e9e87a2 100644
> --- a/drivers/usb/serial/ftdi_sio.h
> +++ b/drivers/usb/serial/ftdi_sio.h
> @@ -35,7 +35,10 @@
>  #define FTDI_SIO_SET_EVENT_CHAR		6 /* Set the event character */
>  #define FTDI_SIO_SET_ERROR_CHAR		7 /* Set the error character */
>  #define FTDI_SIO_SET_LATENCY_TIMER	9 /* Set the latency timer */
> -#define FTDI_SIO_GET_LATENCY_TIMER	10 /* Get the latency timer */
> +#define FTDI_SIO_GET_LATENCY_TIMER	0x0a /* Get the latency timer */
> +#define FTDI_SIO_SET_BITMODE		0x0b /* Set CBUS GPIO pin mode */

That comment is too specific. It's just used to set *a* bitbang mode,
right?

> +#define FTDI_SIO_READ_PINS		0x0c /* Read immediate value of pins */
> +#define FTDI_SIO_READ_EEPROM		0x90 /* Read EEPROM */
>  
>  /* Interface indices for FT2232, FT2232H and FT4232H devices */
>  #define INTERFACE_A		1
> @@ -433,6 +436,28 @@ enum ftdi_sio_baudrate {
>   *         1 = active
>   */
>  
> +/* FTDI_SIO_SET_BITMODE */
> +#define FTDI_SIO_SET_BITMODE_REQUEST_TYPE 0x40
> +#define FTDI_SIO_SET_BITMODE_REQUEST FTDI_SIO_SET_BITMODE
> +
> +/* Possible bitmodes for FTDI_SIO_SET_BITMODE_REQUEST */
> +#define FTDI_SIO_BITMODE_RESET		0x00
> +#define FTDI_SIO_BITMODE_CBUS		0x20
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
> +#define FTDI_SIO_CBUS_MUX_GPIO		8

Again, this one is FTX specific and warrants an FTX infix (instead of
SIO).

Johan
