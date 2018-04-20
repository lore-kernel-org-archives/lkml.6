Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeDTTmO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:42:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48476 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDTTmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:42:12 -0400
Date: Fri, 20 Apr 2018 21:42:07 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix reset-gpio for level based irqs
Message-ID: <20180420194207.i2zo235duknjsjjd@earth.universe>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
 <7b4976b0a8a642767bd4e0a5e9d7fb6c9dc86ec9.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwcilrccnbfghvbz"
Content-Disposition: inline
In-Reply-To: <7b4976b0a8a642767bd4e0a5e9d7fb6c9dc86ec9.camel@collabora.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pwcilrccnbfghvbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 02:44:02PM -0300, Ezequiel Garcia wrote:
> Hi Sebastian,
>=20
> On Fri, 2018-04-20 at 19:24 +0200, Sebastian Reichel wrote:
> > The current reset-gpio support triggers an interrupt storm on platforms
> > using the maxtouch with level based interrupt. The Motorola Droid 4,
> > which I used for some of the tests is not affected, since it uses a lev=
el
> > based interrupt.
> >=20
>=20
> I found this confusing. Interrupt storm happen with level-based interrupt=
s,
> but the Droid4 is not affected?

This is a typo. Droid 4 has an edge based interrupt defined, PPD has
an level based interrupt defined. PPD got an interrupt storm, Droid 4
did not.

> > This change avoids the interrupt storm by enabling the device while
> > its interrupt is disabled. The following mxt_initialize() requires,
> > that the device is responsive (at least mxt224E is unresponsive for
> > ~22ms), so we wait some time. We don't wait for leaving bootloader
> > mode anymore, since mxt_initialize() checks for it anyways.
> >=20
>=20
> IMHO, having some more or less arbritrary sleeps is almost
> always a problem. This value might be enough for some platform,
> might be too short for some other, and then it might get too large
> for someone else.

The 22ms chip-being-unresponsive are not newly introduced. The
same 22ms are also required for soft-reset. I did introduce a
new time (MXT_RESET_GPIO_TIME) for the "chip being reset" state,
since my randomly chosen 200ms from before were exaggerated
considering all mxt datasheets I checked stated only a few nano
seconds.

> > This fixes a boot problem on GE PPD (watchdog kills device) and also
> > has been tested on the Droid 4.
> >=20
> > Fixes: f657b00df22e ("Input: atmel_mxt_ts - add support for reset line")
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/t=
ouchscreen/atmel_mxt_ts.c
> > index 5d9699fe1b55..f8a9f2a47e78 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -194,6 +194,7 @@ enum t100_type {
> > =20
> >  /* Delay times */
> >  #define MXT_BACKUP_TIME		50	/* msec */
> > +#define MXT_RESET_GPIO_TIME	20	/* msec */
> >  #define MXT_RESET_TIME		200	/* msec */
> >  #define MXT_RESET_TIMEOUT	3000	/* msec */
> >  #define MXT_CRC_TIMEOUT		1000	/* msec */
> > @@ -3167,20 +3168,14 @@ static int mxt_probe(struct i2c_client *client,=
 const struct i2c_device_id *id)
> >  		return error;
> >  	}
> > =20
> > +	disable_irq(client->irq);
> > +
> >  	if (data->reset_gpio) {
> > -		data->in_bootloader =3D true;
> > -		msleep(MXT_RESET_TIME);
> > -		reinit_completion(&data->bl_completion);
> > +		msleep(MXT_RESET_GPIO_TIME);
> >  		gpiod_set_value(data->reset_gpio, 1);
>=20
> Can't we enable the IRQ here, just before the wait...
>=20
> > -		error =3D mxt_wait_for_completion(data, &data->bl_completion,
> > -						MXT_RESET_TIMEOUT);
>=20
> ... and then disable it back afterwards?

Yes and no. We need the wait, since the interrupt pin does random
stuff for 100ms after reset. We can do the wait-for-completion
after that time (see mxt_soft_reset function). I kept it simple,
since the following init does another soft reset anyways.

> > -		if (error)
> > -			return error;
> > -		data->in_bootloader =3D false;
> > +		msleep(MXT_RESET_TIME);
>=20
> >  	}
> > =20
> > -	disable_irq(client->irq);
> > -
> >  	error =3D mxt_initialize(data);
> >  	if (error)
> >  		return error;

-- Sebastian

--pwcilrccnbfghvbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlraQo0ACgkQ2O7X88g7
+pq5jA/+PU2yx/iPDNogwItkdzztCsygZax8acn3WE56dl90iLoTTBlUzdIfyljR
YUpz1qb0EW5k4iVk4jg/1VhflS1gEL6oxN76IwkdWxGXSQWn4APdMJ0MN+OY5k7w
HuiT0PfWuKDaMjr0c1cXappVXh1gsB4MARwDvEm9brbJ6wjBbtYS1gk0jUNbdeFd
6NqB3ph7Ymdaf27m0VeGAxc0FHOviMyBiri/SQJe0qnTS8cPKbp3Nvk0rNoskUiW
/PS9XJ11NaZeSq+ZZmOY58DFfTeS0GOxYE+hZm6fqHM0QeAguMCMWmtx4ZojS/1Y
KmVQpGaFcLdMgj3+o/GMv6s6QGWQTgldcKvM4ze0HI7rmkhCcLoe3SuaqIR+6Glz
7ZuNpKHv+xS8bUYHR3K/rHb7sOihk3FBkYSK0n7QK/a8HYoxMUb6VgZkeEsv8SoI
Ii1ptMe6+h3RD+JmqDg6N79YRvCWd9Qk6H93KT6+Hv1An1CDG2A3G4+ZTm7hJjf5
WuHqATd6ouW33avywia2PzPTjfmiwSYQWBm0xcx3Dg73DMAeBgTYCUWD1DzBYgNd
IcRWD6ANPfOmQq6boJGscpq0VnNd2veSN2ru5IJ4ScCVeqNrHW2WsGoUubXw/e3g
bVGoZf9cEVzXMMkRDLofoLC2e0ny2TsA3Uh1LpTTBsFYaRxE94Q=
=I+n2
-----END PGP SIGNATURE-----

--pwcilrccnbfghvbz--
