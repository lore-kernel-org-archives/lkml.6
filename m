Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbeBLJJQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:09:16 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34153 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeBLJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:09:13 -0500
X-Google-Smtp-Source: AH8x224P9WzAhntcnrNRnKQBeRaNw2jIvRnqVmdJhr9Uwz3G62wbQ4Wh58CY5BvvJ7yRYMACPzyhNg==
Date: Mon, 12 Feb 2018 10:09:06 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 08/11] watchdog/hpwdt: Programable Pretimeout NMI
Message-ID: <20180212090906.GB4513@gmail.com>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-9-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20180212052111.12010-9-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

On Sun, Feb 11, 2018 at 10:21:08PM -0700, Jerry Hoemann wrote:
> Make whether or not the hpwdt watchdog delivers a pretimeout NMI
> programable by the user.
>=20
> The underlying iLO hardware is programmable as to whether or not
> a pre-timeout NMI is delivered to the system before the iLO resets
> the system.  However, the iLO does not allow for programming the
> length of time that NMI is delivered before the system is reset.
>=20
> Hence, in hpwdt_set_pretimeout, val =3D=3D 0 disables the NMI. Any
> non-zero value sets the pretimeout length to what the hardware
> supports.
>=20
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 42 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 740d0c633204..e7355f72d883 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -28,12 +28,15 @@
>  #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
>  #define DEFAULT_MARGIN			30
> +#define PRETIMEOUT_SEC			9
> =20
>  static unsigned int soft_margin =3D DEFAULT_MARGIN;	/* in seconds */
> -static unsigned int reload;			/* the computed soft_margin */
>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
>  #ifdef CONFIG_HPWDT_NMI_DECODING
>  static unsigned int allow_kdump =3D 1;
> +static bool pretimeout =3D 1;
> +#else
> +static bool pretimeout;
>  #endif
> =20
>  static void __iomem *pci_mem_addr;		/* the PCI-memory address */
> @@ -55,10 +58,12 @@ static struct watchdog_device hpwdt_dev;
>   */
>  static int hpwdt_start(struct watchdog_device *dev)
>  {
> -	reload =3D SECS_TO_TICKS(dev->timeout);
> +	int control =3D 0x81 | (pretimeout ? 0x4 : 0);
> +	int reload =3D SECS_TO_TICKS(dev->timeout);
> =20
> +	pr_debug("start watchdog 0x%08x:0x%02x\n", reload, control);

dev_dbg()

Even here, I think we should use=20
    dev_emerg()
    dev_crit()
    dev_alert()
    dev_err()
    dev_warn()
    dev_notice()

instead of pr_* functions now when we have a device to use.


>  	iowrite16(reload, hpwdt_timer_reg);
> -	iowrite8(0x85, hpwdt_timer_con);
> +	iowrite8(control, hpwdt_timer_con);
> =20
>  	return 0;
>  }
> @@ -67,6 +72,8 @@ static int hpwdt_stop(struct watchdog_device *dev)
>  {
>  	unsigned long data;
> =20
> +	pr_debug("stop  watchdog\n");
dev_dbg()

> +
>  	data =3D ioread8(hpwdt_timer_con);
>  	data &=3D 0xFE;
>  	iowrite8(data, hpwdt_timer_con);
> @@ -75,8 +82,9 @@ static int hpwdt_stop(struct watchdog_device *dev)
> =20
>  static int hpwdt_ping(struct watchdog_device *dev)
>  {
> -	reload =3D SECS_TO_TICKS(dev->timeout);
> +	int reload =3D SECS_TO_TICKS(dev->timeout);
> =20
> +	pr_debug("ping  watchdog 0x%08x\n", reload);
>  	iowrite16(reload, hpwdt_timer_reg);
> =20
>  	return 0;
> @@ -98,6 +106,16 @@ static int hpwdt_settimeout(struct watchdog_device *d=
ev, unsigned int val)
>  }
> =20
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> +static int hpwdt_set_pretimeout(struct watchdog_device *dev, unsigned in=
t val)
> +{
> +	if (val && (val !=3D PRETIMEOUT_SEC)) {
> +		pr_info("Setting pretimeout to %d\n", PRETIMEOUT_SEC);

dev_info()

> +		val =3D PRETIMEOUT_SEC;
> +	}
> +	dev->pretimeout =3D val;
> +	pretimeout =3D val ? 1 : 0;
> +	return 0;
> +}
> =20
>  static unsigned int hpwdt_my_nmi(void)
>  {
> @@ -108,7 +126,6 @@ static inline int hexdigit(int v)
>  {
>  	return (v > 9) ? (v-9+'A') : (v+'0');
>  }
> -
>  /*
>   *	NMI Handler
>   */
> @@ -128,6 +145,9 @@ static int hpwdt_pretimeout(unsigned int ulReason, st=
ruct pt_regs *regs)
> =20
>  	pr_debug("nmi: ulReason=3D%d, mynmi=3D0x%0x\n", ulReason, mynmi);
> =20
> +	if (!pretimeout)
> +		return NMI_DONE;
> +
>  	if (allow_kdump)
>  		hpwdt_stop(&hpwdt_dev);
> =20
> @@ -144,7 +164,8 @@ static int hpwdt_pretimeout(unsigned int ulReason, st=
ruct pt_regs *regs)
>  static const struct watchdog_info hpwdt_info =3D {
>  	.options	=3D WDIOF_SETTIMEOUT    |
>  			  WDIOF_KEEPALIVEPING |
> -			  WDIOF_MAGICCLOSE,
> +			  WDIOF_MAGICCLOSE    |
> +			  WDIOF_PRETIMEOUT,
>  	.identity	=3D "HPE iLO2+ HW Watchdog Timer",
>  };
> =20
> @@ -296,6 +317,9 @@ static const struct watchdog_ops hpwdt_ops =3D {
>  	.ping		=3D hpwdt_ping,
>  	.set_timeout	=3D hpwdt_settimeout,
>  	.get_timeleft	=3D hpwdt_gettimeleft,
> +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> +	.set_pretimeout	=3D hpwdt_set_pretimeout,
> +#endif					/* } */
>  };
> =20
>  static struct watchdog_device hpwdt_dev =3D {
> @@ -304,6 +328,9 @@ static struct watchdog_device hpwdt_dev =3D {
>  	.min_timeout	=3D 1,
>  	.max_timeout	=3D HPWDT_MAX_TIMER,
>  	.timeout	=3D DEFAULT_MARGIN,
> +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> +	.pretimeout	=3D PRETIMEOUT_SEC,
> +#endif					/* } */
>  };
> =20
> =20
> @@ -322,6 +349,9 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stoppe=
d once started (default=3D"
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
>  module_param(allow_kdump, int, 0444);
>  MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
> +
> +module_param(pretimeout, bool, 0444);
> +MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
>  #endif					/* } */
> =20
>  module_pci_driver(hpwdt_driver);
> --=20
> 2.13.6

Best regards
Marcus Folkesson
>=20

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqBWawACgkQiIBOb1ld
UjIoURAAwhUOe/OqeFlyXbEA1etY5806bo405mJXyszKH/q4XlUrUJgYlHjGhfd9
LAQpOWaxvOJy+H7l6Iv6SeJ6kF8Mm0er44c9NR+ObI/7ZGZvNAtS0SW/VGmKoH+M
2opEoOSCUTGTduXn9YRlECg/Zymco/GtlcgN5ZyKbW5zzYztUXpsW45hvjlgpVWm
aS81/FxCa2gGnSfC5LHhALyuRuCCei1RXBfW0BmZwnWfSoxMKicFIrgiuBwKqGoX
Pmtv7q/SXWxcy233CUpSCJUaLp+Z8jsNZNUqnSitcQmuy917Xu9CUWI/4Wr8ySda
HzXRlATudcyZo12uHRF74DFrn+ZxyZJmIpznwRjgeig8bJnHOcmPVdquAj+4IQfB
TuS3h+w2UoYbItXttEBULlNwbdjz7jDj1SuJKI4YZGy094sYKb7+q4fC4eL8etli
XT8vku2fYEuETWoF7r1Ehrgtg5JimphlC3EJwQ2HMvtB6eFD6innt26QIfn5PLjO
6DfKrAMuXL7mbE/x0pSuavjPdxolyzMvsPJYcoKiZ7BnHxLL08hTdQ14qAg7zVYR
s9nBPsugAXQA6NIKWU9KqTniBP8LnNHXr9DKVN1OMG4+ONBa1AiFy2Cr6GAsww6M
I+TwH6MMo0CFmTeMUEOZm6t8H2S58+FNs7yCPCiawMY0IlxphpQ=
=f+Z/
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
