Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeCZWjC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:39:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37801 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeCZWjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:39:00 -0400
X-Google-Smtp-Source: AG47ELtCp3Ptag8ghbh2fNov5YXY9ubaRvOf5FdT5D222I78TcxE+Rz8G3duuPf4Ednji7NQldRsdQ==
Date: Tue, 27 Mar 2018 00:38:56 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: alps - Report pressure of v3 and v7 trackstick
Message-ID: <20180326223856.asna4arlwwwbaq7p@pali>
References: <20180321200736.32406-1-pali.rohar@gmail.com>
 <20180326223732.GB204225@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="smjhgk36fpaznjjj"
Content-Disposition: inline
In-Reply-To: <20180326223732.GB204225@dtor-ws>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--smjhgk36fpaznjjj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 26 March 2018 15:37:32 Dmitry Torokhov wrote:
> Hi Pali,
>=20
> On Wed, Mar 21, 2018 at 09:07:36PM +0100, Pali Roh=C3=A1r wrote:
> > ALPS v3 and v7 packet formats reports trackstick pressure. This informa=
tion
> > is already parsed in unused "z" variable.
> >=20
> > ALPS SS4 S2 devices already reports trackstick pressure as ABS_PRESSURE
> > attribute, therefore reports pressure in the same way also for v3 and v=
7.
> >=20
> > This patch also updates parsing v3 pressure information, it is also sto=
red
> > in 7 bits.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > ---
> >  drivers/input/mouse/alps.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > index 010c1bcdb06d..0a9e6a3a2f9f 100644
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -139,11 +139,11 @@ static const struct alps_model_info alps_model_da=
ta[] =3D {
> >  };
> > =20
> >  static const struct alps_protocol_info alps_v3_protocol_data =3D {
> > -	ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
> > +	ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESS=
URE
>=20
> It seems that with these changes we no longer have trackpoints that do
> not report pressure in ALPS. Should we get rid of

Nope, we still have. See them in the alps_model_data table.

> ALPS_DUALPOINT_WITH_PRESSURE and clean up the code a bit?
>=20
> Thanks.
>=20
> >  };
> > =20
> >  static const struct alps_protocol_info alps_v3_rushmore_data =3D {
> > -	ALPS_PROTO_V3_RUSHMORE, 0x8f, 0x8f, ALPS_DUALPOINT
> > +	ALPS_PROTO_V3_RUSHMORE, 0x8f, 0x8f, ALPS_DUALPOINT | ALPS_DUALPOINT_W=
ITH_PRESSURE
> >  };
> > =20
> >  static const struct alps_protocol_info alps_v4_protocol_data =3D {
> > @@ -155,7 +155,7 @@ static const struct alps_protocol_info alps_v5_prot=
ocol_data =3D {
> >  };
> > =20
> >  static const struct alps_protocol_info alps_v7_protocol_data =3D {
> > -	ALPS_PROTO_V7, 0x48, 0x48, ALPS_DUALPOINT
> > +	ALPS_PROTO_V7, 0x48, 0x48, ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESS=
URE
> >  };
> > =20
> >  static const struct alps_protocol_info alps_v8_protocol_data =3D {
> > @@ -583,7 +583,7 @@ static void alps_process_trackstick_packet_v3(struc=
t psmouse *psmouse)
> > =20
> >  	x =3D (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
> >  	y =3D (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
> > -	z =3D (packet[4] & 0x7c) >> 2;
> > +	z =3D packet[4] & 0x7c;
> > =20
> >  	/*
> >  	 * The x and y values tend to be quite large, and when used
> > @@ -595,6 +595,7 @@ static void alps_process_trackstick_packet_v3(struc=
t psmouse *psmouse)
> > =20
> >  	input_report_rel(dev, REL_X, x);
> >  	input_report_rel(dev, REL_Y, -y);
> > +	input_report_abs(dev, ABS_PRESSURE, z);
> > =20
> >  	/*
> >  	 * Most ALPS models report the trackstick buttons in the touchpad
> > @@ -1118,6 +1119,7 @@ static void alps_process_trackstick_packet_v7(str=
uct psmouse *psmouse)
> > =20
> >  	input_report_rel(dev2, REL_X, (char)x);
> >  	input_report_rel(dev2, REL_Y, -((char)y));
> > +	input_report_abs(dev2, ABS_PRESSURE, z);
> > =20
> >  	input_report_key(dev2, BTN_LEFT, left);
> >  	input_report_key(dev2, BTN_RIGHT, right);
> > --=20
> > 2.11.0
> >=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--smjhgk36fpaznjjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWrl2fgAKCRCL8Mk9A+RD
UhJyAJ42dmTEkUoq4EJXrXWmrIhIauHAHgCcCJD5R/JIS+/93h/uZpEHKd8qjgE=
=34fP
-----END PGP SIGNATURE-----

--smjhgk36fpaznjjj--
