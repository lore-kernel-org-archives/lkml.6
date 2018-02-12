Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932803AbeBLWZe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:25:34 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38942 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932608AbeBLWZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:25:32 -0500
X-Google-Smtp-Source: AH8x225/WJEc3EpUs7Yi8CbSmVlKAp5RNJFawBOYZq/RlAAMl4T9YFSOsYB2GSmp/Ck6AlMlgkEf0w==
Date: Mon, 12 Feb 2018 23:25:28 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Masaki Ota <012nexus@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "aaron.ma@canonical.com" <aaron.ma@canonical.com>,
        "jaak@ristioja.ee" <jaak@ristioja.ee>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        richard@hughsie.com
Subject: Re: [PATCH] Support TrackStick of Thinkpad L570
Message-ID: <20180212222528.kphowwblngjgaap2@pali>
References: <20171120075530.4880-1-masaki.ota@jp.alps.com>
 <20171120082942.hgvxguc6vjusi52k@pali>
 <TYXPR01MB0719CB1198852D3B3231DC3EC7220@TYXPR01MB0719.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jq7cnm3aqkkvouws"
Content-Disposition: inline
In-Reply-To: <TYXPR01MB0719CB1198852D3B3231DC3EC7220@TYXPR01MB0719.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq7cnm3aqkkvouws
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Masaki: About firmware update, there is Linux Vendor Firmware Service
project at https://fwupd.org/ exactly for purpose to update firmwares
=66rom Linux distributions. Maintainer of this project, Richard Hughes
(CCed), is more times willing to write support for new devices. So
maybe this can be a solution for future.

On Monday 20 November 2017 08:43:45 Masaki Ota wrote:
> Hi, Pali,
>=20
> 1) Yes, but we don't have FW update plan.
>  And this device works as SMBus in Windows, so this issue happens on only=
 Linux.
>=20
> 2) Yes.
>=20
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]=20
> Sent: Monday, November 20, 2017 5:30 PM
> To: Masaki Ota <012nexus@gmail.com>; dmitry.torokhov@gmail.com
> Cc: benjamin.tissoires@redhat.com; aaron.ma@canonical.com; jaak@ristioja.=
ee; =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps.co=
m>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Support TrackStick of Thinkpad L570
>=20
> On Monday 20 November 2017 16:55:30 Masaki Ota wrote:
> > From: Masaki Ota <masaki.ota@jp.alps.com>
> > - The issue is that Thinkpad L570 TrackStick does not work. Because the=
 main interface of Thinkpad L570 device is SMBus, so ALPS overlooked PS2 in=
terface Firmware setting of TrackStick. The detail is that TrackStick otp b=
it is disabled.
> > - Add the code that checks 0xD7 address value. This value is device num=
ber information, so we can identify the device by checking this value.
> > - If we check 0xD7 value, we need to enable Command mode and after chec=
k the value we need to disable Command mode, then we have to enable the dev=
ice(0xF4 command).
> > - Thinkpad L570 device number is 0x0C or 0x1D. If it is TRUE, enable AL=
PS_DUALPOINT flag.
>=20
> So, the root of this problem is in ALPS firmware which provides wrong inf=
ormation to kernel?
>=20
> Masaki, I have two questions:
>=20
> 1) Can ALPS or Lenovo release a new firmware update for this Thinkpad to
>    fix this issue?
>=20
> 2) Have all Thinkpad L570 machines trackpoint?
>=20
> Dmitry, as a workaround for firmware bug on particular notebook, would no=
t be better to check DMI information and DMI based hook?
>=20
> > Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> > ---
> >  drivers/input/mouse/alps.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c=20
> > index 850b00e3ad8e..cce52104ed5a 100644
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -2541,13 +2541,28 @@ static int=20
> > alps_update_btn_info_ss4_v2(unsigned char otp[][4],  }
> > =20
> >  static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
> > -				       struct alps_data *priv)
> > +				       struct alps_data *priv,
> > +					struct psmouse *psmouse)
> >  {
> >  	bool is_dual =3D false;
> > +	int reg_val =3D 0;
> > +	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> > =20
> > -	if (IS_SS4PLUS_DEV(priv->dev_id))
> > +	if (IS_SS4PLUS_DEV(priv->dev_id)) {
> >  		is_dual =3D (otp[0][0] >> 4) & 0x01;
> > =20
> > +		/* For support TrackStick of Thinkpad L570 device */
> > +		if (alps_exit_command_mode(psmouse) =3D=3D 0 &&
> > +			alps_enter_command_mode(psmouse) =3D=3D 0) {
> > +			reg_val =3D alps_command_mode_read_reg(psmouse, 0xD7);
> > +		}
> > +		alps_exit_command_mode(psmouse);
> > +		ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> > +
> > +		if (reg_val =3D=3D 0x0C || reg_val =3D=3D 0x1D)
> > +			is_dual =3D true;
> > +	}
> > +
> >  	if (is_dual)
> >  		priv->flags |=3D ALPS_DUALPOINT |
> >  					ALPS_DUALPOINT_WITH_PRESSURE;
> > @@ -2570,7 +2585,7 @@ static int alps_set_defaults_ss4_v2(struct=20
> > psmouse *psmouse,
> > =20
> >  	alps_update_btn_info_ss4_v2(otp, priv);
> > =20
> > -	alps_update_dual_info_ss4_v2(otp, priv);
> > +	alps_update_dual_info_ss4_v2(otp, priv, psmouse);
> > =20
> >  	return 0;
> >  }
>=20
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--jq7cnm3aqkkvouws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWoIUVgAKCRCL8Mk9A+RD
UoohAKCCWodFE5Nx/kt9OJvOIHYadUwhlwCfb9Sz/k8o1AcXJAVsvXs3RSDiFqQ=
=gnjm
-----END PGP SIGNATURE-----

--jq7cnm3aqkkvouws--
