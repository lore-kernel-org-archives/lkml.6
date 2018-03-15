Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeCONqx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:46:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49738 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeCONqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:46:50 -0400
Date: Thu, 15 Mar 2018 14:46:45 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180315134645.sp3ru2mk6lpqyrda@earth.universe>
References: <20180314155514.3374-1-thierry.escande@linaro.org>
 <20180314155514.3374-3-thierry.escande@linaro.org>
 <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
 <20180314183043.GX18510@minitux>
 <D999852D-E9A7-41D2-9878-A93CB4D43D0C@holtmann.org>
 <20180314190522.GY18510@minitux>
 <494C4C44-1949-405E-91DA-1B40100ED2E6@holtmann.org>
 <d14007a1-a4dd-bd28-3452-a4d3ad70e5a0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zjvq5bgeh2slxacj"
Content-Disposition: inline
In-Reply-To: <d14007a1-a4dd-bd28-3452-a4d3ad70e5a0@linaro.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjvq5bgeh2slxacj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

On Thu, Mar 15, 2018 at 12:07:44PM +0100, Thierry Escande wrote:
> > > BT_DISABLE_N is the name of this pin in the datasheet of the QCA chip,
> > > not on the board, so this name is the same regardless of what you name
> > > the line or gpio your board connect it to.
> >=20
> > and QCA chip v1 and QCA chip v2 will use the same driver and
> > same firmware loading mechanism. So why do we have to add a new
> > GPIO naming if they decide to change the name in the data sheet.
> > With Bluetooth it is pretty much all the same. Every UART chip
> > has a shutdown/reset GPIO to enable/disable the chip behind the
> > UART.
> >=20
> > > > A new board should not require driver changes, you just ship a new =
DT
> > > > for that board and an existing driver hopefully just does the job. =
No
> > > > matter how someone named a GPIO in a piece of paper.
> > > >=20
> > >=20
> > > I totally agree with the fact that the board should not affect the
> > > naming of the gpio in the driver. But I do enjoy when we refer to pins
> > > by their real name - instead of having to guess which pin in the _chi=
p_
> > > specification the driver actually refer to.
> > >=20
> > >=20
> > > That said, what name would you prefer for this?
> > >=20
> > > Afaict this is not "wakeup" and there are a few extra steps between t=
he
> > > disabled state and "bluetooth is enabled", so "enable" feels slightly
> > > wrong. And it probably should be "bluetooth" and not just "device" as
> > > this refers to a pin on a WiFi/BT combo chip.
> >=20
> > The Broadcom side called it shutdown GPIO, it is essentially the
> > shutdown/reset GPIO or power on/off GPIO. Personally I do not
> > care what it is named, but it will be all the same for all
> > Bluetooth chips. Take a poll from Broadcom, Intel, Realtek and
> > Qualcomm and you can pick a reasonable common name.
>=20
> The Nokia driver has "bluetooth-wakeup" gpio. The Broadcom one has
> "device-wakeup" and "shutdown". The "shutdown" gpio is set to its active
> state to power on the chip which sounds reversed logic. Same for the
> "bt-disable-n" gpio in the Qualcomm driver, configured as ACTIVE_HIGH, and
> which is set to 1 to enable it...
>
> So for consistency, naming it as "shutdown" to stick to the bcm driver but
> it should be configured as ACTIVE_LOW in the dts so we actually do a
> gpiod_set_value(0) to un-shutdown it. Does that sound ok?

FWIW you picked the wrong gpio from the nokia bluetooth binding. The
gpio for shutdown would be "reset". The "bluetooth-wakeup" is
required for normal operation to exit idle mode. The "reset" name
used by the nokia binding is quite common for DT:

Documentation/devicetree/bindings $ git grep reset-gpios | wc -l
212

I guess it only makes sense when the device is actually being
reset, though (i.e. for Nokia the settings are back to defaults
and you need to re-upload the FW).

-- Sebastian

> Regards,
> Thierry
>=20
> > For the wakeup GPIOs, these are different and depend on if there
> > is some low-power mode provided. You would need to check the
> > data sheet to see if they provide more advanced low-power state
> > handling.
> >=20
> > Regards
> >=20
> > Marcel
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--zjvq5bgeh2slxacj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqqeUIACgkQ2O7X88g7
+ppP+A//TUFrGpiRN1Riv54iVFz2yfsf3Aj115/mzBydkicJOXydpDwWIYKvHb8F
m6RoHToUn/f4T27/ZFd1tZDzKeIftQcoJPjboQYcdsFHb4iiiXIA5JMzxThdNgeY
idBG641X5m3LmchkLnHs9T79q6GZTadJlyO3p9KeakZhGGXPhUrAN1AbUNwFh+18
qtvWcS+MUd3x+V61HkhmyuG0YZTuVprVlI5GsylYX6AJ9AsK3Eo+WCkOhJ2zzdEN
E6N8avID/8jlSnPkgYQfZpg2jRrhhVionaQ+3Micg/em2941Ok0fdIysa3j3aILC
+xGgP2v8HgK3d0jQyjdRlh787+aKkeou6jvriXOlr6OxwI6pm8nFdWWbtGAYc7OF
oNpO93uyK3NgLKMvI+AKmbMUgj/5cOMGmL4ChfkZct4gyUeamKYoDYjDn/VZIXKv
SF1O8qZ1iHGmg6rLy4rIlOnIsErXaNMazArT3R8WI8a2HK8y1+rKxky0Qa41h2NO
+jrlpz7maCK8RzYbOWT5B61O9YtsvR0NBb4Ji9WYc4pSVio/mEUgZO9ZwEKO74Uf
/pwnW+47TLZ0DKkKoFNRbw6Di1ruB3v3R4j5s8FTMHs/SoOSZ+odkD4wnEiUz89j
sjdu3OM3HSaRNReVHapYLKYMmX3MAkUb4LOQh1+0Q1RUfmGen6g=
=RBJZ
-----END PGP SIGNATURE-----

--zjvq5bgeh2slxacj--
