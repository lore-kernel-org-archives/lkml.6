Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73045ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEEB20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVTRWxcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEEB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeGTLck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:32:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41500 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeGTLcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:32:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id v22-v6so1481365lfe.8;
        Fri, 20 Jul 2018 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U+Apa7wET5EWT8KQIL90gFcvmhItnMKavJu3l3sEzt0=;
        b=RVTRWxcU62By9Tgx2NuPOilaPf18Mv55e/5TphQG7Suf8Cs62KR2sM/3x4yaOHd7cP
         WPfNOWROSfF2ibVbDU8aY+EsWVVGuorQNG3c1Hunkv3Rfnug/GtL3i9lLm4HI2x9j0Ai
         IfIGwuHEz+u5iropDy5cSGbz21Rx2HftygAt1Ji6OuclKal6ACVI8+KPTEqksdyMDGoJ
         ArBtSDfqkBH+7zt6fK8xITNaM/jVaVxmU7ms6MhjqNncA/BcIPmzq93TPwZT1L7rnzcO
         U0EPbcOsoPt1Ezxvjdp5HB5GnXpxifvsNH8RmjMq1pS5++SoUQuJEV0ks+F8LG8vAe6d
         s0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U+Apa7wET5EWT8KQIL90gFcvmhItnMKavJu3l3sEzt0=;
        b=o09wNEjhVmrDS1BKAZGAlqGzXkq6JJ4doMUMNK33hLe6+znnASQGTCzheOF1wK3pdE
         ehuW8+jYS7wlMreNGU2w0pb5omlkegMRCN0ozI43L0EkXAfFld0O0lB2A28elAw/3XML
         GohbQ6AD50fHrSDp5jbSg1LnSMiM1O5a0UBM4lcIwW4wZGPmmKIgX5+VBRimxo5F5GHp
         Oj2P7KrFW4iE4XmVpdiVFGjhzkLeomNyKm8XUdGVfyAiFt0DIO1DWhbY/InHzHXgKRxu
         wAYxLNuSB1ZJlNs2IdGQ/gnHdNv4at1K9t9zTpOygbF8uw0gMFxo9xCb2S4qkwcXthDJ
         159w==
X-Gm-Message-State: AOUpUlEASodFgoNA0j/fvKtTYuoQ9BleqxbgWLdkAa8cus+iHf++blcq
        dYBpJxdTMGi2yUgunCsa0FE=
X-Google-Smtp-Source: AAOMgpdLxPtgu80fj9gvi7N29SPlr4VnSTpeZOhCSKnY2H/+MmB8LEw4vK91o9iOe1ANVVNdS/LCPg==
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr1154208lfe.148.1532083497917;
        Fri, 20 Jul 2018 03:44:57 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id q4-v6sm300101ljh.36.2018.07.20.03.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 03:44:56 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fgStu-0005Ln-TO; Fri, 20 Jul 2018 12:44:42 +0200
Date:   Fri, 20 Jul 2018 12:44:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: cp210x: Implement GPIO support for
 CP2102N
Message-ID: <20180720104442.GC19245@localhost>
References: <20180718212004.11852-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718212004.11852-1-pados@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:20:04PM +0200, Karoly Pados wrote:
> This is v2 of the patch and addresses all feedback previously
> received from the maintainer. New input/output support stayed
> as discussed on the e-mail lists separately. CP2105 is also
> using the new code structure, but due to missing way to get
> default pin states after reset from the device, support
> for this device is basically still output-only as before, at
> least in name. But CP2105 and CP2102N paths are unified.

This reads like a patch changelog rather than a commit message. Please
try to rephrase this so that it's self-contained and not relying on
having read the mail thread for v1.

In the future you should include a changelog from what changed from one
revision to another below the cut-off line (---) instead.

> This patch is based on the latest patch series by Johan just
> submitted today.

Should also go below the cut-off line.

> Signed-off-by: Karoly Pados <pados@pados.hu>

Oh, and you should have included Martyn who contributed to the
discussion about how to handle input mode on CC.

> ---
>  drivers/usb/serial/cp210x.c | 274 ++++++++++++++++++++++++++++++------
>  1 file changed, 232 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 4a118eb13590..81f9d3e183c6 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -224,9 +224,19 @@ MODULE_DEVICE_TABLE(usb, id_table);
>  struct cp210x_serial_private {
>  #ifdef CONFIG_GPIOLIB
>  	struct gpio_chip	gc;
> -	u8			config;
> -	u8			gpio_mode;
>  	bool			gpio_registered;
> +
> +	/*
> +	 * The following three fields are for devices that
> +	 * emulate input/output pins using open-drain/pushpull
> +	 * drive modes.
> +	 */
> +	/* One bit for each GPIO, 1 if pin is pushpull */
> +	u8			gpio_pushpull;
> +	/* One bit for each GPIO, 1 if pin is not in GPIO mode */
> +	u8			gpio_altfunc;
> +	/* One bit for each GPIO, 1 if pin direction is input */
> +	u8			gpio_input;

Your code is clean, but you're relying a bit too much on comments in my
opinion. The code should be self-explanatory and not rely on in-function
comments, unless you want to highlight something particularly important
or clever.

I've dropped some examples of this in my reworked version of the patch.

>  #endif
>  	u8			partnum;
>  	speed_t			max_speed;
> @@ -343,6 +353,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  #define CONTROL_WRITE_RTS	0x0200
>  
>  /* CP210X_VENDOR_SPECIFIC values */
> +#define CP210X_READ_2NCONFIG	0x000E
>  #define CP210X_READ_LATCH	0x00C2
>  #define CP210X_GET_PARTNUM	0x370B
>  #define CP210X_GET_PORTCONFIG	0x370C
> @@ -452,6 +463,12 @@ struct cp210x_config {
>  #define CP2105_GPIO1_RXLED_MODE		BIT(1)
>  #define CP2105_GPIO1_RS485_MODE		BIT(2)
>  
> +/* CP2102N configuration array indices */
> +#define CP210X_2NCONFIG_CONFIG_VERSION_IDX	2
> +#define CP210X_2NCONFIG_GPIO_MODE_IDX		581
> +#define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
> +#define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
> +
>  /* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2 bytes. */
>  struct cp210x_gpio_write {
>  	u8	mask;
> @@ -1308,21 +1325,29 @@ static void cp210x_break_ctl(struct tty_struct *tty, int break_state)
>  }
>  
>  #ifdef CONFIG_GPIOLIB
> +
> +/*
> + * Helper to determine if a specific serial device belongs to the cp2102n
> + * family of devices.
> + */
> +static bool cp210x_is_cp2102n(struct usb_serial *serial)
> +{
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +
> +	return  (priv->partnum == CP210X_PARTNUM_CP2102N_QFN28) ||
> +		(priv->partnum == CP210X_PARTNUM_CP2102N_QFN24) ||
> +		(priv->partnum == CP210X_PARTNUM_CP2102N_QFN20);
> +}

I also did away with this one (again). The cp2102n way of dealing with
gpios appear to be the standard way; while cp2105 and cp2108 are the odd
birds.

> +
>  static int cp210x_gpio_request(struct gpio_chip *gc, unsigned int offset)
>  {
>  	struct usb_serial *serial = gpiochip_get_data(gc);
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
>  
> -	switch (offset) {
> -	case 0:
> -		if (priv->config & CP2105_GPIO0_TXLED_MODE)
> -			return -ENODEV;
> -		break;
> -	case 1:
> -		if (priv->config & (CP2105_GPIO1_RXLED_MODE |
> -				    CP2105_GPIO1_RS485_MODE))
> -			return -ENODEV;
> -		break;
> +	if (priv->gpio_altfunc & BIT(offset)) {
> +		dev_warn(&serial->interface->dev,
> +			 "Cannot control GPIO with active alternate function.\n");

I dropped the warning, you're already returning an errno as before.

> +		return -ENODEV;
>  	}
>  
>  	return 0;
> @@ -1331,10 +1356,15 @@ static int cp210x_gpio_request(struct gpio_chip *gc, unsigned int offset)
>  static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  {
>  	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +	u8 req_type = REQTYPE_DEVICE_TO_HOST;
>  	int result;
>  	u8 buf;
>  
> -	result = cp210x_read_vendor_block(serial, REQTYPE_INTERFACE_TO_HOST,
> +	if (priv->partnum == CP210X_PARTNUM_CP2105)
> +		req_type = REQTYPE_INTERFACE_TO_HOST;
> +
> +	result = cp210x_read_vendor_block(serial, req_type,
>  					  CP210X_READ_LATCH, &buf, sizeof(buf));
>  	if (result < 0)
>  		return result;
> @@ -1345,34 +1375,82 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
>  {
>  	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
>  	struct cp210x_gpio_write buf;
> +	int result = 0;
>  
> -	if (value == 1)
> -		buf.state = BIT(gpio);
> -	else
> -		buf.state = 0;
> -
> +	buf.state = (value == 1) ? BIT(gpio) : 0;

No need to change this, and generally try to avoid the ternary
operator which often just makes code harder to read.

>  	buf.mask = BIT(gpio);
>  
> -	cp210x_write_vendor_block(serial, REQTYPE_HOST_TO_INTERFACE,
> -				  CP210X_WRITE_LATCH, &buf, sizeof(buf));
> +	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +		result = cp210x_write_vendor_block(serial,
> +						   REQTYPE_HOST_TO_INTERFACE,
> +						   CP210X_WRITE_LATCH, &buf,
> +						   sizeof(buf));
> +	} else if (cp210x_is_cp2102n(serial)) {

So I just made this the default implementation by dropping the
conditional.

> +		u16 wIndex = buf.state << 8 | buf.mask;
> +
> +		result = usb_control_msg(serial->dev,
> +					 usb_sndctrlpipe(serial->dev, 0),
> +					 CP210X_VENDOR_SPECIFIC,
> +					 REQTYPE_HOST_TO_DEVICE,
> +					 CP210X_WRITE_LATCH,
> +					 wIndex,
> +					 NULL, 0, USB_CTRL_SET_TIMEOUT);
> +	}
> +
> +	if (result < 0)
> +		dev_err(&serial->interface->dev, "Failed to set GPIO value.\n");

This could include the errno.

>  }
>  
>  static int cp210x_gpio_direction_get(struct gpio_chip *gc, unsigned int gpio)
>  {
> -	/* Hardware does not support an input mode */
> -	return 0;
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +
> +	return priv->gpio_input & BIT(gpio);
>  }
>  
>  static int cp210x_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio)
>  {
> -	/* Hardware does not support an input mode */
> -	return -ENOTSUPP;
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +
> +	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +		/* Hardware does not support an input mode */
> +		return -ENOTSUPP;
> +	} else if (cp210x_is_cp2102n(serial)) {

This should be the default implementation.

> +		/* Push-pull pins cannot be changed to be inputs */
> +		if (priv->gpio_pushpull & BIT(gpio)) {
> +			dev_warn(&serial->interface->dev,
> +				 "Cannot change direction of a push-pull GPIO to input.\n");

No need to warn, as you're returning an error.

> +			return -EPERM;

And this isn't really a permission issue; -EINVAL is more appropriate.


> +		}
> +
> +		/* Make sure to release pin if it is being driven low */
> +		cp210x_gpio_set(gc, gpio, 1);
> +
> +		/* Note pin direction to ourselves */
> +		priv->gpio_input |= BIT(gpio);
> +
> +		return 0;
> +	}
> +
> +	return -EPERM;
>  }
>  
>  static int cp210x_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
>  					int value)
>  {
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +
> +	/* Note pin direction to ourselves */
> +	priv->gpio_input &= ~BIT(gpio);
> +
> +	/* Set requested initial output value */

I'd drop these comments for example.

> +	cp210x_gpio_set(gc, gpio, value);
> +
>  	return 0;
>  }
>  
> @@ -1385,11 +1463,11 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
>  
>  	/* Succeed only if in correct mode (this can't be set at runtime) */
>  	if ((param == PIN_CONFIG_DRIVE_PUSH_PULL) &&
> -	    (priv->gpio_mode & BIT(gpio)))
> +	    (priv->gpio_pushpull & BIT(gpio)))
>  		return 0;
>  
>  	if ((param == PIN_CONFIG_DRIVE_OPEN_DRAIN) &&
> -	    !(priv->gpio_mode & BIT(gpio)))
> +	    !(priv->gpio_pushpull & BIT(gpio)))
>  		return 0;
>  
>  	return -ENOTSUPP;
> @@ -1402,13 +1480,14 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
>   * this driver that provide GPIO do so in a way that does not impact other
>   * signals and are thus expected to have very different initialisation.
>   */
> -static int cp2105_shared_gpio_init(struct usb_serial *serial)
> +static int cp2105_gpioconf_init(struct usb_serial *serial)
>  {
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
>  	struct cp210x_pin_mode mode;
>  	struct cp210x_config config;
>  	u8 intf_num = cp210x_interface_num(serial);
>  	int result;
> +	u8 iface_config;
>  
>  	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
>  					  CP210X_GET_DEVICEMODE, &mode,
> @@ -1424,20 +1503,25 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)
>  
>  	/*  2 banks of GPIO - One for the pins taken from each serial port */
>  	if (intf_num == 0) {
> -		if (mode.eci == CP210X_PIN_MODE_MODEM)
> +		if (mode.eci == CP210X_PIN_MODE_MODEM) {
> +			/* Mark all GPIOs of this interface as reserved */
> +			priv->gpio_altfunc = 0xFF;
>  			return 0;
> +		}
>  
> -		priv->config = config.eci_cfg;
> -		priv->gpio_mode = (u8)((le16_to_cpu(config.gpio_mode) &
> +		iface_config = config.eci_cfg;
> +		priv->gpio_pushpull = (u8)((le16_to_cpu(config.gpio_mode) &
>  						CP210X_ECI_GPIO_MODE_MASK) >>
>  						CP210X_ECI_GPIO_MODE_OFFSET);
>  		priv->gc.ngpio = 2;
>  	} else if (intf_num == 1) {
> -		if (mode.sci == CP210X_PIN_MODE_MODEM)
> -			return 0;
> +		if (mode.sci == CP210X_PIN_MODE_MODEM) {
> +			/* Mark all GPIOs of this interface as reserved */
> +			priv->gpio_altfunc = 0xFF;

Here the return 0 fell out, which could lead to the pins being
considered available.

> +		}
>  
> -		priv->config = config.sci_cfg;
> -		priv->gpio_mode = (u8)((le16_to_cpu(config.gpio_mode) &
> +		iface_config = config.sci_cfg;
> +		priv->gpio_pushpull = (u8)((le16_to_cpu(config.gpio_mode) &
>  						CP210X_SCI_GPIO_MODE_MASK) >>
>  						CP210X_SCI_GPIO_MODE_OFFSET);
>  		priv->gc.ngpio = 3;
> @@ -1445,6 +1529,118 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)
>  		return -ENODEV;
>  	}
>  
> +	/* Mark all pins which are not in GPIO mode */
> +	priv->gpio_altfunc = 0;
> +	if (iface_config & CP2105_GPIO0_TXLED_MODE)	/* GPIO 0 */
> +		priv->gpio_altfunc |= BIT(0);
> +	if (iface_config & (CP2105_GPIO1_RXLED_MODE |	/* GPIO 1 */
> +			CP2105_GPIO1_RS485_MODE))
> +		priv->gpio_altfunc |= BIT(1);
> +
> +	/* Driver implementation for CP2105 only supports outputs */
> +	priv->gpio_input = 0;
> +
> +	return 0;
> +}
> +
> +static int cp2102n_gpioconf_init(struct usb_serial *serial)
> +{
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +	const u16 CONFIG_SIZE = 0x02A6;

Lower case variable names, and I'd use lower-case for hex constants as
well.

> +	u8 gpio_rst_latch;
> +	u8 config_version;
> +	u8 gpio_pushpull;
> +	u8 *config_buf;
> +	u8 gpio_latch;
> +	u8 gpio_ctrl;
> +	int result;
> +	u8 i;
> +
> +	/* Retrieve device configuration from the device.
> +	 * The array received contains all customization settings
> +	 * done at the factory/manufacturer.
> +	 * Format of the array is documented at the time of writing at
> +	 * https://www.silabs.com/community/interface/knowledge-base.entry.html/2017/03/31/cp2102n_setconfig-xsfa
> +	 */

Multi-line comment style is

	/*
	 * blah...
	 */

as I already mentioned in comments to v1.

> +	config_buf = kmalloc(CONFIG_SIZE, GFP_KERNEL);
> +	if (!config_buf)
> +		return -ENOMEM;
> +
> +	result = cp210x_read_vendor_block(serial,
> +					  REQTYPE_DEVICE_TO_HOST,
> +					  CP210X_READ_2NCONFIG,
> +					  config_buf,
> +					  CONFIG_SIZE);
> +	if (result < 0) {
> +		kfree(config_buf);
> +		return -EIO;

Return result.

> +	}
> +
> +	config_version = config_buf[CP210X_2NCONFIG_CONFIG_VERSION_IDX];
> +	gpio_pushpull = config_buf[CP210X_2NCONFIG_GPIO_MODE_IDX];
> +	gpio_ctrl = config_buf[CP210X_2NCONFIG_GPIO_CONTROL_IDX];
> +	gpio_rst_latch = config_buf[CP210X_2NCONFIG_GPIO_RSTLATCH_IDX];
> +
> +	kfree(config_buf);
> +
> +	/* Make sure this is a config format we understand */
> +	if (config_version != 0x01)
> +		return -ENOTSUPP;
> +
> +	/* We only support 4 GPIOs even on the QFN28 package, because
> +	 * config locations of GPIOs 4-6 determined using reverse
> +	 * engineering revealed conflicting offsets with other
> +	 * documented functions. So we'll just play it safe for now.
> +	 */
> +	priv->gc.ngpio = 4;
> +
> +	/* Get default pin states after reset. Needed so we can determine
> +	 * the direction of an open-drain pin.
> +	 */
> +	gpio_latch = (gpio_rst_latch >> 3) & 0x0F;
> +
> +	/* 0 indicates open-drain mode, 1 is push-pull */
> +	priv->gpio_pushpull = (gpio_pushpull >> 3) & 0x0F;
> +
> +	/* 0 indicates GPIO mode, 1 is alternate function */
> +	priv->gpio_altfunc = (gpio_ctrl >> 2) & 0x0F;
> +
> +	/* The CP2102N does not strictly has input and output pin modes,
> +	 * it only knows open-drain and push-pull modes which is set at
> +	 * factory. An open-drain pin can function both as an
> +	 * input or an output. We emulate input mode for open-drain pins
> +	 * by making sure they are not driven low, and we do not allow
> +	 * push-pull pins to be set as an input.
> +	 */
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		/* Set direction to "input" iff
> +		 * pin is open-drain and reset value is 1
> +		 */
> +		if (!(priv->gpio_pushpull & BIT(i)) && (gpio_latch & BIT(i)))
> +			priv->gpio_input |= BIT(i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cp210x_gpio_init(struct usb_serial *serial)
> +{
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +	int result = 0;
> +
> +	if (cp210x_is_cp2102n(serial))
> +		result = cp2102n_gpioconf_init(serial);
> +	else if (priv->partnum == CP210X_PARTNUM_CP2105)
> +		result = cp2105_gpioconf_init(serial);
> +	else
> +		return 0;

This could be a switch-statement.

> +
> +	if (result < 0) {
> +		dev_err(&serial->interface->dev,
> +			"GPIO initialisation failed, continuing without GPIO support\n");
> +		return result;
> +	}

By moving the error message into cp210x_gpio_init, we'd no longer log
any registration errors below.

> +
>  	priv->gc.label = "cp210x";
>  	priv->gc.request = cp210x_gpio_request;
>  	priv->gc.get_direction = cp210x_gpio_direction_get;
> @@ -1477,7 +1673,7 @@ static void cp210x_gpio_remove(struct usb_serial *serial)
>  
>  #else
>  
> -static int cp2105_shared_gpio_init(struct usb_serial *serial)
> +static int cp210x_gpio_init(struct usb_serial *serial)
>  {
>  	return 0;
>  }
> @@ -1588,13 +1784,7 @@ static int cp210x_attach(struct usb_serial *serial)
>  
>  	cp210x_init_max_speed(serial);
>  
> -	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> -		result = cp2105_shared_gpio_init(serial);
> -		if (result < 0) {
> -			dev_err(&serial->interface->dev,
> -				"GPIO initialisation failed, continuing without GPIO support\n");
> -		}
> -	}
> +	cp210x_gpio_init(serial);
>  
>  	return 0;
>  }

So, mostly minor things that I've now fixed up.

Nice and clean job overall.

Post a new commit message, and we'll get this included in 4.19.

Thanks,
Johan
