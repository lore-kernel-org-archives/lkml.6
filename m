Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeCPNjs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:39:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34242 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:39:45 -0400
X-Google-Smtp-Source: AG47ELuuIhQCEbHbufDegRJLts9VrnMf0InVqQ2R6gzk136lavNcSqAUHTgMT+nW/c6lTUmHyTht9A==
Date: Fri, 16 Mar 2018 14:39:38 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v5] input: pxrc: new driver for PhoenixRC Flight
 Controller Adapter
Message-ID: <20180316133938.GB31029@gmail.com>
References: <20180218161747.21110-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20180218161747.21110-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ping.

I do not want to nag, but would someone please have a look at this?

Thanks,
Marcus Folkesson

On Sun, Feb 18, 2018 at 05:17:46PM +0100, Marcus Folkesson wrote:
> This driver let you plug in your RC controller to the adapter and
> use it as input device in various RC simulators.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>=20
> v5:
> 	- Drop autosuspend support
> 	- Use pm_mutex instead of input_dev->mutex
> 	- Use pxrc->is_open instead of input_dev->users
> v4:
> 	- Add call to usb_mark_last_busy() in irq
> 	- Move code from pxrc_resume() to pxrc_reset_resume()
> v3:
> 	- Use RUDDER and MISC instead of TILT_X and TILT_Y
> 	- Drop kref and anchor
> 	- Rework URB handling
> 	- Add PM support
> v2:
> 	- Change module license to GPLv2 to match SPDX tag
>=20
>=20
>  Documentation/input/devices/pxrc.rst |  57 +++++++
>  drivers/input/joystick/Kconfig       |   9 ++
>  drivers/input/joystick/Makefile      |   1 +
>  drivers/input/joystick/pxrc.c        | 303 +++++++++++++++++++++++++++++=
++++++
>  4 files changed, 370 insertions(+)
>  create mode 100644 Documentation/input/devices/pxrc.rst
>  create mode 100644 drivers/input/joystick/pxrc.c
>=20
> diff --git a/Documentation/input/devices/pxrc.rst b/Documentation/input/d=
evices/pxrc.rst
> new file mode 100644
> index 000000000000..ca11f646bae8
> --- /dev/null
> +++ b/Documentation/input/devices/pxrc.rst
> @@ -0,0 +1,57 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +pxrc - PhoenixRC Flight Controller Adapter
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> +
> +This driver let you use your own RC controller plugged into the
> +adapter that comes with PhoenixRC [1]_ or other compatible adapters.
> +
> +The adapter supports 7 analog channels and 1 digital input switch.
> +
> +Notes
> +=3D=3D=3D=3D=3D
> +
> +Many RC controllers is able to configure which stick goes to which chann=
el.
> +This is also configurable in most simulators, so a matching is not neces=
sary.
> +
> +The driver is generating the following input event for analog channels:
> +
> ++---------+----------------+
> +| Channel |      Event     |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> +|     1   |  ABS_X         |
> ++---------+----------------+
> +|     2   |  ABS_Y         |
> ++---------+----------------+
> +|     3   |  ABS_RX        |
> ++---------+----------------+
> +|     4   |  ABS_RY        |
> ++---------+----------------+
> +|     5   |  ABS_RUDDER    |
> ++---------+----------------+
> +|     6   |  ABS_THROTTLE  |
> ++---------+----------------+
> +|     7   |  ABS_MISC      |
> ++---------+----------------+
> +
> +The digital input switch is generated as an `BTN_A` event.
> +
> +Manual Testing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To test this driver's functionality you may use `input-event` which is p=
art of
> +the `input layer utilities` suite [2]_.
> +
> +For example::
> +
> +    > modprobe pxrc
> +    > input-events <devnr>
> +
> +To print all input events from input `devnr`.
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. [1] http://www.phoenix-sim.com/
> +.. [2] https://www.kraxel.org/cgit/input/
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kcon=
fig
> index f3c2f6ea8b44..332c0cc1b2ab 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -351,4 +351,13 @@ config JOYSTICK_PSXPAD_SPI_FF
> =20
>  	  To drive rumble motor a dedicated power supply is required.
> =20
> +config JOYSTICK_PXRC
> +	tristate "PhoenixRC Flight Controller Adapter"
> +	depends on USB_ARCH_HAS_HCD
> +	depends on USB
> +	help
> +	  Say Y here if you want to use the PhoenixRC Flight Controller Adapter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called pxrc.
>  endif
> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Mak=
efile
> index 67651efda2e1..dd0492ebbed7 100644
> --- a/drivers/input/joystick/Makefile
> +++ b/drivers/input/joystick/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_JOYSTICK_JOYDUMP)		+=3D joydump.o
>  obj-$(CONFIG_JOYSTICK_MAGELLAN)		+=3D magellan.o
>  obj-$(CONFIG_JOYSTICK_MAPLE)		+=3D maplecontrol.o
>  obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+=3D psxpad-spi.o
> +obj-$(CONFIG_JOYSTICK_PXRC)			+=3D pxrc.o
>  obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+=3D sidewinder.o
>  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+=3D spaceball.o
>  obj-$(CONFIG_JOYSTICK_SPACEORB)		+=3D spaceorb.o
> diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> new file mode 100644
> index 000000000000..07a0dbd3ced2
> --- /dev/null
> +++ b/drivers/input/joystick/pxrc.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Phoenix RC Flight Controller Adapter
> + *
> + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/usb.h>
> +#include <linux/usb/input.h>
> +#include <linux/mutex.h>
> +#include <linux/input.h>
> +
> +#define PXRC_VENDOR_ID	(0x1781)
> +#define PXRC_PRODUCT_ID	(0x0898)
> +
> +static const struct usb_device_id pxrc_table[] =3D {
> +	{ USB_DEVICE(PXRC_VENDOR_ID, PXRC_PRODUCT_ID) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(usb, pxrc_table);
> +
> +struct pxrc {
> +	struct input_dev	*input;
> +	struct usb_device	*udev;
> +	struct usb_interface	*intf;
> +	struct urb		*urb;
> +	struct mutex		pm_mutex;
> +	bool			is_open;
> +	__u8			epaddr;
> +	char			phys[64];
> +	unsigned char           *data;
> +	size_t			bsize;
> +};
> +
> +static void pxrc_usb_irq(struct urb *urb)
> +{
> +	struct pxrc *pxrc =3D urb->context;
> +	int error;
> +
> +	switch (urb->status) {
> +	case 0:
> +		/* success */
> +		break;
> +	case -ETIME:
> +		/* this urb is timing out */
> +		dev_dbg(&pxrc->intf->dev,
> +			"%s - urb timed out - was the device unplugged?\n",
> +			__func__);
> +		return;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +	case -EPIPE:
> +		/* this urb is terminated, clean up */
> +		dev_dbg(&pxrc->intf->dev, "%s - urb shutting down with status: %d\n",
> +			__func__, urb->status);
> +		return;
> +	default:
> +		dev_dbg(&pxrc->intf->dev, "%s - nonzero urb status received: %d\n",
> +			__func__, urb->status);
> +		goto exit;
> +	}
> +
> +	if (urb->actual_length =3D=3D 8) {
> +		input_report_abs(pxrc->input, ABS_X, pxrc->data[0]);
> +		input_report_abs(pxrc->input, ABS_Y, pxrc->data[2]);
> +		input_report_abs(pxrc->input, ABS_RX, pxrc->data[3]);
> +		input_report_abs(pxrc->input, ABS_RY, pxrc->data[4]);
> +		input_report_abs(pxrc->input, ABS_RUDDER, pxrc->data[5]);
> +		input_report_abs(pxrc->input, ABS_THROTTLE, pxrc->data[6]);
> +		input_report_abs(pxrc->input, ABS_MISC, pxrc->data[7]);
> +
> +		input_report_key(pxrc->input, BTN_A, pxrc->data[1]);
> +	}
> +
> +exit:
> +	/* Resubmit to fetch new fresh URBs */
> +	error =3D usb_submit_urb(urb, GFP_ATOMIC);
> +	if (error && error !=3D -EPERM)
> +		dev_err(&pxrc->intf->dev,
> +			"%s - usb_submit_urb failed with result: %d",
> +			__func__, error);
> +}
> +
> +static int pxrc_open(struct input_dev *input)
> +{
> +	struct pxrc *pxrc =3D input_get_drvdata(input);
> +	int retval;
> +
> +	mutex_lock(&pxrc->pm_mutex);
> +	retval =3D usb_submit_urb(pxrc->urb, GFP_KERNEL);
> +	if (retval) {
> +		dev_err(&pxrc->intf->dev,
> +			"%s - usb_submit_urb failed, error: %d\n",
> +			__func__, retval);
> +		retval =3D -EIO;
> +		goto out;
> +	}
> +
> +	pxrc->is_open =3D true;
> +
> +out:
> +	mutex_unlock(&pxrc->pm_mutex);
> +	return retval;
> +}
> +
> +static void pxrc_close(struct input_dev *input)
> +{
> +	struct pxrc *pxrc =3D input_get_drvdata(input);
> +
> +	mutex_lock(&pxrc->pm_mutex);
> +	usb_kill_urb(pxrc->urb);
> +	pxrc->is_open =3D false;
> +	mutex_unlock(&pxrc->pm_mutex);
> +}
> +
> +static int pxrc_usb_init(struct pxrc *pxrc)
> +{
> +	struct usb_endpoint_descriptor *epirq;
> +	unsigned int pipe;
> +	int retval;
> +
> +	/* Set up the endpoint information */
> +	/* This device only has an interrupt endpoint */
> +	retval =3D usb_find_common_endpoints(pxrc->intf->cur_altsetting,
> +			NULL, NULL, &epirq, NULL);
> +	if (retval) {
> +		dev_err(&pxrc->intf->dev,
> +			"Could not find endpoint\n");
> +		goto error;
> +	}
> +
> +	pxrc->bsize =3D usb_endpoint_maxp(epirq);
> +	pxrc->epaddr =3D epirq->bEndpointAddress;
> +	pxrc->data =3D devm_kmalloc(&pxrc->intf->dev, pxrc->bsize, GFP_KERNEL);
> +	if (!pxrc->data) {
> +		retval =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	usb_set_intfdata(pxrc->intf, pxrc);
> +	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
> +	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> +
> +	pxrc->urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +	if (!pxrc->urb) {
> +		retval =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	pipe =3D usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
> +	usb_fill_int_urb(pxrc->urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
> +						pxrc_usb_irq, pxrc, 1);
> +
> +error:
> +	return retval;
> +
> +
> +}
> +
> +static int pxrc_input_init(struct pxrc *pxrc)
> +{
> +	pxrc->input =3D devm_input_allocate_device(&pxrc->intf->dev);
> +	if (pxrc->input =3D=3D NULL) {
> +		dev_err(&pxrc->intf->dev, "couldn't allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	pxrc->input->name =3D "PXRC Flight Controller Adapter";
> +	pxrc->input->phys =3D pxrc->phys;
> +	usb_to_input_id(pxrc->udev, &pxrc->input->id);
> +
> +	pxrc->input->open =3D pxrc_open;
> +	pxrc->input->close =3D pxrc_close;
> +
> +	input_set_capability(pxrc->input, EV_KEY, BTN_A);
> +	input_set_abs_params(pxrc->input, ABS_X, 0, 255, 0, 0);
> +	input_set_abs_params(pxrc->input, ABS_Y, 0, 255, 0, 0);
> +	input_set_abs_params(pxrc->input, ABS_RX, 0, 255, 0, 0);
> +	input_set_abs_params(pxrc->input, ABS_RY, 0, 255, 0, 0);
> +	input_set_abs_params(pxrc->input, ABS_RUDDER, 0, 255, 0, 0);
> +	input_set_abs_params(pxrc->input, ABS_THROTTLE, 0, 255, 0, 0);
> +	input_set_abs_params(pxrc->input, ABS_MISC, 0, 255, 0, 0);
> +
> +	input_set_drvdata(pxrc->input, pxrc);
> +
> +	return input_register_device(pxrc->input);
> +}
> +
> +static int pxrc_probe(struct usb_interface *intf,
> +		      const struct usb_device_id *id)
> +{
> +	struct pxrc *pxrc;
> +	int retval;
> +
> +	pxrc =3D devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
> +	if (!pxrc)
> +		return -ENOMEM;
> +
> +	mutex_init(&pxrc->pm_mutex);
> +	pxrc->udev =3D usb_get_dev(interface_to_usbdev(intf));
> +	pxrc->intf =3D intf;
> +
> +	retval =3D pxrc_usb_init(pxrc);
> +	if (retval)
> +		goto error;
> +
> +	retval =3D pxrc_input_init(pxrc);
> +	if (retval)
> +		goto err_free_urb;
> +
> +	return 0;
> +
> +err_free_urb:
> +	usb_free_urb(pxrc->urb);
> +
> +error:
> +	return retval;
> +}
> +
> +static void pxrc_disconnect(struct usb_interface *intf)
> +{
> +	struct pxrc *pxrc =3D usb_get_intfdata(intf);
> +
> +	usb_free_urb(pxrc->urb);
> +	usb_set_intfdata(intf, NULL);
> +}
> +
> +static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct pxrc *pxrc =3D usb_get_intfdata(intf);
> +
> +	mutex_lock(&pxrc->pm_mutex);
> +	if (pxrc->is_open)
> +		usb_kill_urb(pxrc->urb);
> +	mutex_unlock(&pxrc->pm_mutex);
> +
> +	return 0;
> +}
> +
> +static int pxrc_resume(struct usb_interface *intf)
> +{
> +	struct pxrc *pxrc =3D usb_get_intfdata(intf);
> +	int retval =3D 0;
> +
> +	mutex_lock(&pxrc->pm_mutex);
> +	if (pxrc->is_open && usb_submit_urb(pxrc->urb, GFP_KERNEL) < 0)
> +		retval =3D -EIO;
> +
> +	mutex_unlock(&pxrc->pm_mutex);
> +	return retval;
> +}
> +
> +static int pxrc_pre_reset(struct usb_interface *intf)
> +{
> +	struct pxrc *pxrc =3D usb_get_intfdata(intf);
> +
> +	mutex_lock(&pxrc->pm_mutex);
> +	usb_kill_urb(pxrc->urb);
> +	return 0;
> +}
> +
> +static int pxrc_post_reset(struct usb_interface *intf)
> +{
> +	struct pxrc *pxrc =3D usb_get_intfdata(intf);
> +	int retval =3D 0;
> +
> +	if (pxrc->is_open && usb_submit_urb(pxrc->urb, GFP_KERNEL) < 0)
> +		retval =3D -EIO;
> +
> +	mutex_unlock(&pxrc->pm_mutex);
> +
> +	return retval;
> +}
> +
> +static int pxrc_reset_resume(struct usb_interface *intf)
> +{
> +	return pxrc_resume(intf);
> +}
> +
> +static struct usb_driver pxrc_driver =3D {
> +	.name =3D		"pxrc",
> +	.probe =3D	pxrc_probe,
> +	.disconnect =3D	pxrc_disconnect,
> +	.id_table =3D	pxrc_table,
> +	.suspend	=3D pxrc_suspend,
> +	.resume		=3D pxrc_resume,
> +	.pre_reset	=3D pxrc_pre_reset,
> +	.post_reset	=3D pxrc_post_reset,
> +	.reset_resume	=3D pxrc_reset_resume,
> +};
> +
> +module_usb_driver(pxrc_driver);
> +
> +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> +MODULE_DESCRIPTION("PhoenixRC Flight Controller Adapter");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.15.1
>=20

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqryRQACgkQiIBOb1ld
UjLtHxAArdzfUQFHR4ppo09ayayq7AwHuQSb+j2Jv7fJFInN3jHiRlFPgua+v03z
IXKmArh8QhhJ38WXz+6zPhUBMGk5i9TiIe1pmMgpnxNwsRabKRMLz/7lR1mkANYW
XISmXAZB4z0Sc2nA+JVkoiuvnoVwITAsM3bKFUoyTrnvlZ2mOPMPKOjoyG6Kf+m3
hx7ZPA6KOnDlawchlDAb2t+3o9iIUck0TFxri4Li4QDnzieWlWIslOJeafPFYgOW
sm1Y+vQog96CBtcWbJHxGqIR7YpUR0vUxVKrSI+tK9r8LU8DPgvCChGHDW0RW00E
FZJ6f/JcntEGz+/scZBT+JKvMEoi5BmuhntxRXs6ko8uyOa2t7H39eZ4OCA30Wxa
TOxdguRrZYbnp0+8z47MlKy7aJEVxuv7FKaFejNR1Uu9gD/l3d9gq0sKmeoISpwU
rtuJALuJaAHjVpoo6A1kc1kgGG9FiWhRxXtpS5QCCFGa5vDqwi4Q6pmSQO8k+fOj
cjU565vpm+dB6yQNIEuESxL7Gcz4VOoZ/hkfhyA0BzSmnB6u7pQLrl2issBFnlJJ
E70Qgh7A+v0xEPCiVvh5yQeLH4P37groYBBygJHfWkiG6XXUPhPc8FxOH7TcVgCp
0awvpNd5n64DpKWStCuBedt6mch0+4go6yF/lZHoVYjdx6B7cdA=
=LSi/
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
