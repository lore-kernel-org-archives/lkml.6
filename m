Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeCPAGT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:06:19 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33381 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeCPAGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:06:17 -0400
X-Google-Smtp-Source: AG47ELsWK74EbEukne5JbO31ZE0/zCHCJPp1QKAY1jgl6oZmQrPtl8lWd9J9e1Y19kMJvxXX/AWPuw==
Date: Thu, 15 Mar 2018 17:06:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Dyer <nick@shmanahar.org>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] Input: atmel_mxt_ts - remove platform data support
Message-ID: <20180316000614.GB60361@dtor-ws>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-15-dmitry.torokhov@gmail.com>
 <20180314205938.GD26353@lava.h.shmanahar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314205938.GD26353@lava.h.shmanahar.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 08:59:38PM +0000, Nick Dyer wrote:
> On Mon, Mar 12, 2018 at 12:09:07PM -0700, Dmitry Torokhov wrote:
> > Date: Mon, 12 Mar 2018 12:09:07 -0700
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
> > Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
> >  linux-kernel@vger.kernel.org
> > Subject: [PATCH 14/14] Input: atmel_mxt_ts - remove platform data support
> > 
> > Now that there are no users of custom Atmel platform data, and everyone
> > has switched to the generic device properties, we can remove support for
> > the platform data.
> 
> Thanks, this is a nice tidy up.
> 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  MAINTAINERS                                |   1 -
> >  drivers/input/touchscreen/atmel_mxt_ts.c   | 125 +++++++++------------
> >  include/linux/platform_data/atmel_mxt_ts.h |  31 -----
> >  3 files changed, 50 insertions(+), 107 deletions(-)
> >  delete mode 100644 include/linux/platform_data/atmel_mxt_ts.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4623caf8d72d8..37b70874a4771 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2394,7 +2394,6 @@ T:	git git://github.com/ndyer/linux.git
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> >  F:	drivers/input/touchscreen/atmel_mxt_ts.c
> > -F:	include/linux/platform_data/atmel_mxt_ts.h
> >  
> >  ATMEL SAMA5D2 ADC DRIVER
> >  M:	Ludovic Desroches <ludovic.desroches@microchip.com>
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index cf2aac4e79ae8..642211254acc4 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -23,10 +23,10 @@
> >  #include <linux/delay.h>
> >  #include <linux/firmware.h>
> >  #include <linux/i2c.h>
> > -#include <linux/platform_data/atmel_mxt_ts.h>
> >  #include <linux/input/mt.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/of.h>
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/property.h>
> > @@ -274,7 +274,6 @@ struct mxt_data {
> >  	struct i2c_client *client;
> >  	struct input_dev *input_dev;
> >  	char phys[64];		/* device physical location */
> > -	const struct mxt_platform_data *pdata;
> >  	struct mxt_object *object_table;
> >  	struct mxt_info info;
> >  	unsigned int irq;
> > @@ -325,6 +324,9 @@ struct mxt_data {
> >  
> >  	/* for config update handling */
> >  	struct completion crc_completion;
> > +
> > +	u32 *t19_keymap;
> > +	unsigned int t19_num_keys;
> >  };
> >  
> >  struct mxt_vb2_buffer {
> > @@ -743,15 +745,14 @@ static int mxt_write_object(struct mxt_data *data,
> >  static void mxt_input_button(struct mxt_data *data, u8 *message)
> >  {
> >  	struct input_dev *input = data->input_dev;
> > -	const struct mxt_platform_data *pdata = data->pdata;
> >  	int i;
> >  
> > -	for (i = 0; i < pdata->t19_num_keys; i++) {
> > -		if (pdata->t19_keymap[i] == KEY_RESERVED)
> > +	for (i = 0; i < data->t19_num_keys; i++) {
> > +		if (data->t19_keymap[i] == KEY_RESERVED)
> >  			continue;
> >  
> >  		/* Active-low switch */
> > -		input_report_key(input, pdata->t19_keymap[i],
> > +		input_report_key(input, data->t19_keymap[i],
> >  				 !(message[1] & BIT(i)));
> >  	}
> >  }
> > @@ -759,7 +760,7 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
> >  static void mxt_input_sync(struct mxt_data *data)
> >  {
> >  	input_mt_report_pointer_emulation(data->input_dev,
> > -					  data->pdata->t19_num_keys);
> > +					  data->t19_num_keys);
> >  	input_sync(data->input_dev);
> >  }
> >  
> > @@ -1859,7 +1860,6 @@ static void mxt_input_close(struct input_dev *dev);
> >  static void mxt_set_up_as_touchpad(struct input_dev *input_dev,
> >  				   struct mxt_data *data)
> >  {
> > -	const struct mxt_platform_data *pdata = data->pdata;
> >  	int i;
> >  
> >  	input_dev->name = "Atmel maXTouch Touchpad";
> > @@ -1873,15 +1873,14 @@ static void mxt_set_up_as_touchpad(struct input_dev *input_dev,
> >  	input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
> >  			  MXT_PIXELS_PER_MM);
> >  
> > -	for (i = 0; i < pdata->t19_num_keys; i++)
> > -		if (pdata->t19_keymap[i] != KEY_RESERVED)
> > +	for (i = 0; i < data->t19_num_keys; i++)
> > +		if (data->t19_keymap[i] != KEY_RESERVED)
> >  			input_set_capability(input_dev, EV_KEY,
> > -					     pdata->t19_keymap[i]);
> > +					     data->t19_keymap[i]);
> >  }
> >  
> >  static int mxt_initialize_input_device(struct mxt_data *data)
> >  {
> > -	const struct mxt_platform_data *pdata = data->pdata;
> >  	struct device *dev = &data->client->dev;
> >  	struct input_dev *input_dev;
> >  	int error;
> > @@ -1947,7 +1946,7 @@ static int mxt_initialize_input_device(struct mxt_data *data)
> >  	}
> >  
> >  	/* If device has buttons we assume it is a touchpad */
> > -	if (pdata->t19_num_keys) {
> > +	if (data->t19_num_keys) {
> >  		mxt_set_up_as_touchpad(input_dev, data);
> >  		mt_flags |= INPUT_MT_POINTER;
> >  	} else {
> > @@ -2921,51 +2920,42 @@ static void mxt_input_close(struct input_dev *dev)
> >  	mxt_stop(data);
> >  }
> >  
> > -static const struct mxt_platform_data *
> > -mxt_parse_device_properties(struct i2c_client *client)
> > +static int mxt_parse_device_properties(struct mxt_data *data)
> >  {
> >  	static const char keymap_property[] = "linux,gpio-keymap";
> > -	struct mxt_platform_data *pdata;
> > +	struct device *dev = &data->client->dev;
> >  	u32 *keymap;
> >  	int n_keys;
> >  	int error;
> >  
> > -	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> > -	if (!pdata)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	if (device_property_present(&client->dev, keymap_property)) {
> > -		n_keys = device_property_read_u32_array(&client->dev,
> > -							keymap_property,
> > +	if (device_property_present(dev, keymap_property)) {
> > +		n_keys = device_property_read_u32_array(dev, keymap_property,
> >  							NULL, 0);
> >  		if (n_keys <= 0) {
> >  			error = n_keys < 0 ? n_keys : -EINVAL;
> > -			dev_err(&client->dev,
> > -				"invalid/malformed '%s' property: %d\n",
> > +			dev_err(dev, "invalid/malformed '%s' property: %d\n",
> >  				keymap_property, error);
> > -			return ERR_PTR(error);
> > +			return error;
> >  		}
> >  
> > -		keymap = devm_kmalloc_array(&client->dev, n_keys, sizeof(u32),
> > +		keymap = devm_kmalloc_array(dev, n_keys, sizeof(*keymap),
> >  					    GFP_KERNEL);
> >  		if (!keymap)
> > -			return ERR_PTR(-ENOMEM);
> > +			return -ENOMEM;
> >  
> > -		error = device_property_read_u32_array(&client->dev,
> > -						       keymap_property,
> > +		error = device_property_read_u32_array(dev, keymap_property,
> >  						       keymap, n_keys);
> >  		if (error) {
> > -			dev_err(&client->dev,
> > -				"failed to parse '%s' property: %d\n",
> > +			dev_err(dev, "failed to parse '%s' property: %d\n",
> >  				keymap_property, error);
> > -			return ERR_PTR(error);
> > +			return error;
> >  		}
> >  
> > -		pdata->t19_keymap = keymap;
> > -		pdata->t19_num_keys = n_keys;
> > +		data->t19_keymap = keymap;
> > +		data->t19_num_keys = n_keys;
> >  	}
> >  
> > -	return pdata;
> > +	return 0;
> >  }
> >  
> >  #ifdef CONFIG_ACPI
> > @@ -3048,25 +3038,12 @@ static const struct dmi_system_id mxt_dmi_table[] = {
> >  	{ }
> >  };
> >  
> > -static int mxt_acpi_probe(struct i2c_client *client)
> > +static int mxt_prepare_acpi_properties(struct i2c_client *client)
> >  {
> >  	struct acpi_device *adev;
> >  	const struct dmi_system_id *system_id;
> >  	const struct mxt_acpi_platform_data *acpi_pdata;
> >  
> > -	/*
> > -	 * Ignore ACPI devices representing bootloader mode.
> > -	 *
> > -	 * This is a bit of a hack: Google Chromebook BIOS creates ACPI
> > -	 * devices for both application and bootloader modes, but we are
> > -	 * interested in application mode only (if device is in bootloader
> > -	 * mode we'll end up switching into application anyway). So far
> > -	 * application mode addresses were all above 0x40, so we'll use it
> > -	 * as a threshold.
> > -	 */
> > -	if (client->addr < 0x40)
> > -		return -ENXIO;
> 
> Could you use 0x4a, since that's the lowest application mode address,
> same in the other place.

OK, this is existing code though, so I'll make a separate patch.

> 
> Can I ask if you've checked the behaviour if the device is probed while
> it's already in bootloader mode? Ideally you want to be able to recover
> from a bad firmware flash.

Yes, the device will come up at the bootloader address, but we will
ignore it here. The 2nd ACPI device with application mode address will
be probed, and we'll fail to read anything in mxt_initialize() and will
try to see if it responds at the bootloader address. It did work for me.

Thanks.

-- 
Dmitry
