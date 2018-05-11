Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeEKMgG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeEKMgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:36:04 -0400
Date: Fri, 11 May 2018 14:35:53 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] serdev: add controller runtime PM support
Message-ID: <20180511123553.gmtpc5gelps5j3vj@earth.universe>
References: <20180509094419.13470-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rj6nkibnjsz4q422"
Content-Disposition: inline
In-Reply-To: <20180509094419.13470-1-johan@kernel.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rj6nkibnjsz4q422
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Wed, May 09, 2018 at 11:44:18AM +0200, Johan Hovold wrote:
> Add support for controller runtime power management to serdev core. This
> is needed to allow slave drivers to manage the runtime PM state of the
> underlying serial controller when its driver, in turn, implements more
> aggressive runtime power management (e.g. using autosuspend).
>=20
> For some applications, for example, where loss off initial data after a
> remote-wakeup event is acceptable or where rx is not used at all,
> aggressive serial controller runtime PM may be used without further
> involvement of the slave driver. But when this is not the case, the
> slave driver must be able to indicate when incoming data is expected in
> order to avoid data loss.
>=20
> To facilitate the common case, where the serial controller power state
> is active whenever the port is open (which is the case with just about
> every serial driver), and where data loss is not acceptable and cannot
> even be prevented by explicit controller runtime power management, an
> RPM reference is taken in serdev open and put again at close. This
> reference can later be balanced by any serdev driver which wants and/or
> can handle aggressive controller runtime PM.
>=20
> Note that the .ignore_children flag is set for the serdev controller to
> allow the underlying hardware to idle when no I/O is expected, regardless
> of the slave device RPM state.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Looks good to me.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/tty/serdev/core.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index df93b727e984..e5e84303faca 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/serdev.h>
>  #include <linux/slab.h>
> =20
> @@ -143,11 +144,28 @@ EXPORT_SYMBOL_GPL(serdev_device_remove);
>  int serdev_device_open(struct serdev_device *serdev)
>  {
>  	struct serdev_controller *ctrl =3D serdev->ctrl;
> +	int ret;
> =20
>  	if (!ctrl || !ctrl->ops->open)
>  		return -EINVAL;
> =20
> -	return ctrl->ops->open(ctrl);
> +	ret =3D ctrl->ops->open(ctrl);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pm_runtime_get_sync(&ctrl->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(&ctrl->dev);
> +		goto err_close;
> +	}
> +
> +	return 0;
> +
> +err_close:
> +	if (ctrl->ops->close)
> +		ctrl->ops->close(ctrl);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_open);
> =20
> @@ -158,6 +176,8 @@ void serdev_device_close(struct serdev_device *serdev)
>  	if (!ctrl || !ctrl->ops->close)
>  		return;
> =20
> +	pm_runtime_put(&ctrl->dev);
> +
>  	ctrl->ops->close(ctrl);
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_close);
> @@ -416,6 +436,9 @@ struct serdev_controller *serdev_controller_alloc(str=
uct device *parent,
> =20
>  	dev_set_name(&ctrl->dev, "serial%d", id);
> =20
> +	pm_runtime_no_callbacks(&ctrl->dev);
> +	pm_suspend_ignore_children(&ctrl->dev, true);
> +
>  	dev_dbg(&ctrl->dev, "allocated controller 0x%p id %d\n", ctrl, id);
>  	return ctrl;
> =20
> @@ -547,20 +570,23 @@ int serdev_controller_add(struct serdev_controller =
*ctrl)
>  	if (ret)
>  		return ret;
> =20
> +	pm_runtime_enable(&ctrl->dev);
> +
>  	ret_of =3D of_serdev_register_devices(ctrl);
>  	ret_acpi =3D acpi_serdev_register_devices(ctrl);
>  	if (ret_of && ret_acpi) {
>  		dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
>  			ret_of, ret_acpi);
>  		ret =3D -ENODEV;
> -		goto out_dev_del;
> +		goto err_rpm_disable;
>  	}
> =20
>  	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
>  		ctrl->nr, &ctrl->dev);
>  	return 0;
> =20
> -out_dev_del:
> +err_rpm_disable:
> +	pm_runtime_disable(&ctrl->dev);
>  	device_del(&ctrl->dev);
>  	return ret;
>  };
> @@ -591,6 +617,7 @@ void serdev_controller_remove(struct serdev_controlle=
r *ctrl)
> =20
>  	dummy =3D device_for_each_child(&ctrl->dev, NULL,
>  				      serdev_remove_device);
> +	pm_runtime_disable(&ctrl->dev);
>  	device_del(&ctrl->dev);
>  }
>  EXPORT_SYMBOL_GPL(serdev_controller_remove);
> --=20
> 2.17.0
>=20

--rj6nkibnjsz4q422
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlr1jiYACgkQ2O7X88g7
+po57w/9Fr2uQ1qCrElanPCpNKB1uB0HjCkU+jDpMXzEpoX/TI+6L57SJbZ0qfzL
vMKzMhpOVogiF2Kd8kVxz4ZliJFngCNDd7tPccH1AHdt4kr00VIC70UGBvG57GOt
iQMF1Sd25x9sXv3t/qLNpOwqv3VcmFp8zm7ewp43XCHSOXhBgykcBCtldiSYw72b
oA8DUfOTdzm1M7Rpiy1fo6/XUQX62Mexlj40cp6m2afnEKxJiBATpYG9ftK11kT2
jsVq2GqYnp+M4BAgsS7+Ev269T+1q8YLkk+0evyKlAXThjZTArhfPxQENpIONN8R
r51MIhzGZ45g2ghTnREybaf2jboDVP6v1dFLTtCVC2tOAnVNodX//c8L89IWENss
Bpx+PNJIS4G58ZUPPNSjYq2wRVtS3BdRHVsbmYO42SEBFvklKwAMQ4AqUnOsAYec
Dg8v/Sl7hfyS+jCrSUg8DA9CEeFY+6nwNwrmzdZT204VOP1MrGLMQQgMYK72FI84
KytM0Etf9PhohYcXz9G4FWJ/QM5XA63AsW3msSk2OHqL3JcOUfqSyV4JIJWi8VwZ
mQTm4KqvsPOrNDvmJh4XfM+AUWt/Xk9ZA43pBSXnF8Wo5/1BAJc3pBdNrykK3R/u
UBN665HIWlch7dviHqwm2oGr8T08i1QKgitnKWVDx+BhootW548=
=NEH3
-----END PGP SIGNATURE-----

--rj6nkibnjsz4q422--
