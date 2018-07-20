Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5529ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91194204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91194204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbeGTQLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:11:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43216 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbeGTQLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:11:09 -0400
Received: from broadband.bt.com (unknown [IPv6:2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 05895265A44;
        Fri, 20 Jul 2018 16:22:20 +0100 (BST)
Message-ID: <1532100137.6926.10.camel@collabora.co.uk>
Subject: Re: [PATCH v4] USB: serial: cp210x: Implement GPIO support for
 CP2102N
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Karoly Pados <pados@pados.hu>, Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Jul 2018 16:22:17 +0100
In-Reply-To: <444431dd30f45f753644e2ea80dbe0c0@pados.hu>
References: <20180720105240.24680-1-johan@kernel.org>
         <444431dd30f45f753644e2ea80dbe0c0@pados.hu>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 12:35 +0000, Karoly Pados wrote:
> This patch adds GPIO support for CP2102N devices.
> 
> It introduces new generic code to support emulating separate
> input and outputs directions even though these devices
> only know output modes (open-drain and pushpull). Existing
> GPIO support for CP2105 has been migrated over to the new
> code structure.
> 
> Only limitation is that for the QFN28 variant, only 4 out of
> 7 GPIOs are supported. This is because the config array
> locations of the last 3 pins are not documented, and reverse
> engineering revealed offsets that conflicted with other
> documented functions. Hence we'll play it safe instead
> until somebody clears this up further.
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>

As Johan made some changes, I think his Signed-off-by should be here
as is in v3.

Other than that:

Acked-by: Martyn Welch <martyn.welch@collabora.co.uk>

> ---
> 
> Patch changelog:
> v1: Initial implementation.
> v2: Incorporate Johan's feedback, most importantly generalize
>     new code and unify with CP2105.
> v3 (by Johan): Apply stylistic and minor bug fixes.
> v4: Corrected commit message. No code changes.
> 
> 
>  drivers/usb/serial/cp210x.c | 245 ++++++++++++++++++++++++++++++--
> ----
>  1 file changed, 209 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c
> b/drivers/usb/serial/cp210x.c
> index 4a118eb13590..b9bc80700be7 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -224,9 +224,10 @@ MODULE_DEVICE_TABLE(usb, id_table);
>  struct cp210x_serial_private {
>  #ifdef CONFIG_GPIOLIB
>  	struct gpio_chip	gc;
> -	u8			config;
> -	u8			gpio_mode;
>  	bool			gpio_registered;
> +	u8			gpio_pushpull;
> +	u8			gpio_altfunc;
> +	u8			gpio_input;
>  #endif
>  	u8			partnum;
>  	speed_t			max_speed;
> @@ -343,6 +344,7 @@ static struct usb_serial_driver * const
> serial_drivers[] = {
>  #define CONTROL_WRITE_RTS	0x0200
>  
>  /* CP210X_VENDOR_SPECIFIC values */
> +#define CP210X_READ_2NCONFIG	0x000E
>  #define CP210X_READ_LATCH	0x00C2
>  #define CP210X_GET_PARTNUM	0x370B
>  #define CP210X_GET_PORTCONFIG	0x370C
> @@ -452,6 +454,12 @@ struct cp210x_config {
>  #define CP2105_GPIO1_RXLED_MODE		BIT(1)
>  #define CP2105_GPIO1_RS485_MODE		BIT(2)
>  
> +/* CP2102N configuration array indices */
> +#define CP210X_2NCONFIG_CONFIG_VERSION_IDX	2
> +#define CP210X_2NCONFIG_GPIO_MODE_IDX		581
> +#define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
> +#define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
> +
>  /* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2
> bytes. */
>  struct cp210x_gpio_write {
>  	u8	mask;
> @@ -1313,17 +1321,8 @@ static int cp210x_gpio_request(struct
> gpio_chip *gc, unsigned int offset)
>  	struct usb_serial *serial = gpiochip_get_data(gc);
>  	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
>  
> -	switch (offset) {
> -	case 0:
> -		if (priv->config & CP2105_GPIO0_TXLED_MODE)
> -			return -ENODEV;
> -		break;
> -	case 1:
> -		if (priv->config & (CP2105_GPIO1_RXLED_MODE |
> -				    CP2105_GPIO1_RS485_MODE))
> -			return -ENODEV;
> -		break;
> -	}
> +	if (priv->gpio_altfunc & BIT(offset))
> +		return -ENODEV;
>  
>  	return 0;
>  }
> @@ -1331,10 +1330,15 @@ static int cp210x_gpio_request(struct
> gpio_chip *gc, unsigned int offset)
>  static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  {
>  	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
> +	u8 req_type = REQTYPE_DEVICE_TO_HOST;
>  	int result;
>  	u8 buf;
>  
> -	result = cp210x_read_vendor_block(serial,
> REQTYPE_INTERFACE_TO_HOST,
> +	if (priv->partnum == CP210X_PARTNUM_CP2105)
> +		req_type = REQTYPE_INTERFACE_TO_HOST;
> +
> +	result = cp210x_read_vendor_block(serial, req_type,
>  					  CP210X_READ_LATCH, &buf,
> sizeof(buf));
>  	if (result < 0)
>  		return result;
> @@ -1345,7 +1349,9 @@ static int cp210x_gpio_get(struct gpio_chip
> *gc, unsigned int gpio)
>  static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio,
> int value)
>  {
>  	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
>  	struct cp210x_gpio_write buf;
> +	int result;
>  
>  	if (value == 1)
>  		buf.state = BIT(gpio);
> @@ -1354,25 +1360,68 @@ static void cp210x_gpio_set(struct gpio_chip
> *gc, unsigned int gpio, int value)
>  
>  	buf.mask = BIT(gpio);
>  
> -	cp210x_write_vendor_block(serial, REQTYPE_HOST_TO_INTERFACE,
> -				  CP210X_WRITE_LATCH, &buf,
> sizeof(buf));
> +	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +		result = cp210x_write_vendor_block(serial,
> +						   REQTYPE_HOST_TO_I
> NTERFACE,
> +						   CP210X_WRITE_LATC
> H, &buf,
> +						   sizeof(buf));
> +	} else {
> +		u16 wIndex = buf.state << 8 | buf.mask;
> +
> +		result = usb_control_msg(serial->dev,
> +					 usb_sndctrlpipe(serial-
> >dev, 0),
> +					 CP210X_VENDOR_SPECIFIC,
> +					 REQTYPE_HOST_TO_DEVICE,
> +					 CP210X_WRITE_LATCH,
> +					 wIndex,
> +					 NULL, 0,
> USB_CTRL_SET_TIMEOUT);
> +	}
> +
> +	if (result < 0) {
> +		dev_err(&serial->interface->dev, "failed to set GPIO
> value: %d\n",
> +				result);
> +	}
>  }
>  
>  static int cp210x_gpio_direction_get(struct gpio_chip *gc, unsigned
> int gpio)
>  {
> -	/* Hardware does not support an input mode */
> -	return 0;
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
> +
> +	return priv->gpio_input & BIT(gpio);
>  }
>  
>  static int cp210x_gpio_direction_input(struct gpio_chip *gc,
> unsigned int gpio)
>  {
> -	/* Hardware does not support an input mode */
> -	return -ENOTSUPP;
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
> +
> +	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +		/* hardware does not support an input mode */
> +		return -ENOTSUPP;
> +	}
> +
> +	/* push-pull pins cannot be changed to be inputs */
> +	if (priv->gpio_pushpull & BIT(gpio))
> +		return -EINVAL;
> +
> +	/* make sure to release pin if it is being driven low */
> +	cp210x_gpio_set(gc, gpio, 1);
> +
> +	priv->gpio_input |= BIT(gpio);
> +
> +	return 0;
>  }
>  
>  static int cp210x_gpio_direction_output(struct gpio_chip *gc,
> unsigned int gpio,
>  					int value)
>  {
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
> +
> +	priv->gpio_input &= ~BIT(gpio);
> +	cp210x_gpio_set(gc, gpio, value);
> +
>  	return 0;
>  }
>  
> @@ -1385,11 +1434,11 @@ static int cp210x_gpio_set_config(struct
> gpio_chip *gc, unsigned int gpio,
>  
>  	/* Succeed only if in correct mode (this can't be set at
> runtime) */
>  	if ((param == PIN_CONFIG_DRIVE_PUSH_PULL) &&
> -	    (priv->gpio_mode & BIT(gpio)))
> +	    (priv->gpio_pushpull & BIT(gpio)))
>  		return 0;
>  
>  	if ((param == PIN_CONFIG_DRIVE_OPEN_DRAIN) &&
> -	    !(priv->gpio_mode & BIT(gpio)))
> +	    !(priv->gpio_pushpull & BIT(gpio)))
>  		return 0;
>  
>  	return -ENOTSUPP;
> @@ -1402,12 +1451,13 @@ static int cp210x_gpio_set_config(struct
> gpio_chip *gc, unsigned int gpio,
>   * this driver that provide GPIO do so in a way that does not impact
> other
>   * signals and are thus expected to have very different
> initialisation.
>   */
> -static int cp2105_shared_gpio_init(struct usb_serial *serial)
> +static int cp2105_gpioconf_init(struct usb_serial *serial)
>  {
>  	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
>  	struct cp210x_pin_mode mode;
>  	struct cp210x_config config;
>  	u8 intf_num = cp210x_interface_num(serial);
> +	u8 iface_config;
>  	int result;
>  
>  	result = cp210x_read_vendor_block(serial,
> REQTYPE_DEVICE_TO_HOST,
> @@ -1424,20 +1474,26 @@ static int cp2105_shared_gpio_init(struct
> usb_serial *serial)
>  
>  	/*  2 banks of GPIO - One for the pins taken from each
> serial port */
>  	if (intf_num == 0) {
> -		if (mode.eci == CP210X_PIN_MODE_MODEM)
> +		if (mode.eci == CP210X_PIN_MODE_MODEM) {
> +			/* mark all GPIOs of this interface as
> reserved */
> +			priv->gpio_altfunc = 0xff;
>  			return 0;
> +		}
>  
> -		priv->config = config.eci_cfg;
> -		priv->gpio_mode =
> (u8)((le16_to_cpu(config.gpio_mode) &
> +		iface_config = config.eci_cfg;
> +		priv->gpio_pushpull =
> (u8)((le16_to_cpu(config.gpio_mode) &
>  						CP210X_ECI_GPIO_MODE
> _MASK) >>
>  						CP210X_ECI_GPIO_MODE
> _OFFSET);
>  		priv->gc.ngpio = 2;
>  	} else if (intf_num == 1) {
> -		if (mode.sci == CP210X_PIN_MODE_MODEM)
> +		if (mode.sci == CP210X_PIN_MODE_MODEM) {
> +			/* mark all GPIOs of this interface as
> reserved */
> +			priv->gpio_altfunc = 0xff;
>  			return 0;
> +		}
>  
> -		priv->config = config.sci_cfg;
> -		priv->gpio_mode =
> (u8)((le16_to_cpu(config.gpio_mode) &
> +		iface_config = config.sci_cfg;
> +		priv->gpio_pushpull =
> (u8)((le16_to_cpu(config.gpio_mode) &
>  						CP210X_SCI_GPIO_MODE
> _MASK) >>
>  						CP210X_SCI_GPIO_MODE
> _OFFSET);
>  		priv->gc.ngpio = 3;
> @@ -1445,6 +1501,125 @@ static int cp2105_shared_gpio_init(struct
> usb_serial *serial)
>  		return -ENODEV;
>  	}
>  
> +	/* mark all pins which are not in GPIO mode */
> +	if (iface_config & CP2105_GPIO0_TXLED_MODE)	/* GPIO 0
> */
> +		priv->gpio_altfunc |= BIT(0);
> +	if (iface_config & (CP2105_GPIO1_RXLED_MODE |	/* GPIO
> 1 */
> +			CP2105_GPIO1_RS485_MODE))
> +		priv->gpio_altfunc |= BIT(1);
> +
> +	/* driver implementation for CP2105 only supports outputs */
> +	priv->gpio_input = 0;
> +
> +	return 0;
> +}
> +
> +static int cp2102n_gpioconf_init(struct usb_serial *serial)
> +{
> +	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
> +	const u16 config_size = 0x02a6;
> +	u8 gpio_rst_latch;
> +	u8 config_version;
> +	u8 gpio_pushpull;
> +	u8 *config_buf;
> +	u8 gpio_latch;
> +	u8 gpio_ctrl;
> +	int result;
> +	u8 i;
> +
> +	/*
> +	 * Retrieve device configuration from the device.
> +	 * The array received contains all customization settings
> done at the
> +	 * factory/manufacturer. Format of the array is documented
> at the
> +	 * time of writing at:
> +	 * https://www.silabs.com/community/interface/knowledge-base
> .entry.html/2017/03/31/cp2102n_setconfig-xsfa
> +	 */
> +	config_buf = kmalloc(config_size, GFP_KERNEL);
> +	if (!config_buf)
> +		return -ENOMEM;
> +
> +	result = cp210x_read_vendor_block(serial,
> +					  REQTYPE_DEVICE_TO_HOST,
> +					  CP210X_READ_2NCONFIG,
> +					  config_buf,
> +					  config_size);
> +	if (result < 0) {
> +		kfree(config_buf);
> +		return result;
> +	}
> +
> +	config_version =
> config_buf[CP210X_2NCONFIG_CONFIG_VERSION_IDX];
> +	gpio_pushpull = config_buf[CP210X_2NCONFIG_GPIO_MODE_IDX];
> +	gpio_ctrl = config_buf[CP210X_2NCONFIG_GPIO_CONTROL_IDX];
> +	gpio_rst_latch =
> config_buf[CP210X_2NCONFIG_GPIO_RSTLATCH_IDX];
> +
> +	kfree(config_buf);
> +
> +	/* Make sure this is a config format we understand. */
> +	if (config_version != 0x01)
> +		return -ENOTSUPP;
> +
> +	/*
> +	 * We only support 4 GPIOs even on the QFN28 package,
> because
> +	 * config locations of GPIOs 4-6 determined using reverse
> +	 * engineering revealed conflicting offsets with other
> +	 * documented functions. So we'll just play it safe for now.
> +	 */
> +	priv->gc.ngpio = 4;
> +
> +	/*
> +	 * Get default pin states after reset. Needed so we can
> determine
> +	 * the direction of an open-drain pin.
> +	 */
> +	gpio_latch = (gpio_rst_latch >> 3) & 0x0f;
> +
> +	/* 0 indicates open-drain mode, 1 is push-pull */
> +	priv->gpio_pushpull = (gpio_pushpull >> 3) & 0x0f;
> +
> +	/* 0 indicates GPIO mode, 1 is alternate function */
> +	priv->gpio_altfunc = (gpio_ctrl >> 2) & 0x0f;
> +
> +	/*
> +	 * The CP2102N does not strictly has input and output pin
> modes,
> +	 * it only knows open-drain and push-pull modes which is set
> at
> +	 * factory. An open-drain pin can function both as an
> +	 * input or an output. We emulate input mode for open-drain
> pins
> +	 * by making sure they are not driven low, and we do not
> allow
> +	 * push-pull pins to be set as an input.
> +	 */
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		/*
> +		 * Set direction to "input" iff pin is open-drain
> and reset
> +		 * value is 1.
> +		 */
> +		if (!(priv->gpio_pushpull & BIT(i)) && (gpio_latch &
> BIT(i)))
> +			priv->gpio_input |= BIT(i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cp210x_gpio_init(struct usb_serial *serial)
> +{
> +	struct cp210x_serial_private *priv =
> usb_get_serial_data(serial);
> +	int result;
> +
> +	switch (priv->partnum) {
> +	case CP210X_PARTNUM_CP2105:
> +		result = cp2105_gpioconf_init(serial);
> +		break;
> +	case CP210X_PARTNUM_CP2102N_QFN28:
> +	case CP210X_PARTNUM_CP2102N_QFN24:
> +	case CP210X_PARTNUM_CP2102N_QFN20:
> +		result = cp2102n_gpioconf_init(serial);
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (result < 0)
> +		return result;
> +
>  	priv->gc.label = "cp210x";
>  	priv->gc.request = cp210x_gpio_request;
>  	priv->gc.get_direction = cp210x_gpio_direction_get;
> @@ -1477,7 +1652,7 @@ static void cp210x_gpio_remove(struct
> usb_serial *serial)
>  
>  #else
>  
> -static int cp2105_shared_gpio_init(struct usb_serial *serial)
> +static int cp210x_gpio_init(struct usb_serial *serial)
>  {
>  	return 0;
>  }
> @@ -1588,12 +1763,10 @@ static int cp210x_attach(struct usb_serial
> *serial)
>  
>  	cp210x_init_max_speed(serial);
>  
> -	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> -		result = cp2105_shared_gpio_init(serial);
> -		if (result < 0) {
> -			dev_err(&serial->interface->dev,
> -				"GPIO initialisation failed,
> continuing without GPIO support\n");
> -		}
> +	result = cp210x_gpio_init(serial);
> +	if (result < 0) {
> +		dev_err(&serial->interface->dev, "GPIO
> initialisation failed: %d\n",
> +				result);
>  	}
>  
>  	return 0;
