Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeCURs4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:48:56 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:52102 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeCURsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:48:53 -0400
X-Google-Smtp-Source: AG47ELt8iJIm75WrGYAEjvjL782rxqgQoh+Q2QRijbapHfzrqq4wWq4WcfXmV+rtGLczS5d4zLGK/g==
Date: Wed, 21 Mar 2018 18:48:49 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALPS Trackpoint & pressure
Message-ID: <20180321174849.sjxdcme36fghmexx@pali>
References: <20180204150839.b5qm4wb26vic35st@pali>
 <20180205224955.GB46524@dtor-ws>
 <20180206002947.GB27776@jelly>
 <20180208232141.2jxjd2xzkfua42mr@pali>
 <20180208235703.GA4300@jelly>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lugo43uavryf2i27"
Content-Disposition: inline
In-Reply-To: <20180208235703.GA4300@jelly>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lugo43uavryf2i27
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 09 February 2018 09:57:03 Peter Hutterer wrote:
> On Fri, Feb 09, 2018 at 12:21:41AM +0100, Pali Roh=C3=A1r wrote:
> > On Tuesday 06 February 2018 10:29:47 Peter Hutterer wrote:
> > > On Mon, Feb 05, 2018 at 02:49:55PM -0800, Dmitry Torokhov wrote:
> > > > On Sun, Feb 04, 2018 at 04:08:39PM +0100, Pali Roh=C3=A1r wrote:
> > > > > Hi! Now playing again with trackpoint connected to ALPS rushmore
> > > > > touchpad and I'm seeking a nice feature. Via ALPS PS/2 protocol it
> > > > > reports pressure of trackpoint. Parser for it is already implemen=
ted in
> > > > > alps.c and value is assigned to variable "z". When I just move
> > > > > trackpoint z is zero, when I push trackpoint while moving, then z=
 is
> > > > > number higher, maximally 32. Variable "z" is set, but unused.
> > > > >=20
> > > > > Do we have some input interface which can be used to report this
> > > > > pressure of trackpoint to userspace? I can use this feature e.g. =
as
> > > > > additional button...
> > > >=20
> > > > We could either do the conversion in kernel and emit BTN_LEFT, or
> > > > report ABS_PRESSURE and see if userspace will be able to handle
> > > > REL_X/REL_Y/ABS_PRESSURE device.
> > > >=20
> > > > Adding Peter.
> > >=20
> > > judging by trackpoint history, I'd leave the pressure->click conversi=
on to
> > > userspace because every trackpoint may need a different threshold set=
ting.
> > > "easier" to have this in userspace with dmi matches etc. plus, conver=
ting to
> > > BTN_LEFT in the kernel means we cannot use it as a separate interacti=
on
> > > anymore.
> >=20
> > Also BTN_LEFT is already reported when left button under trackpoint is
> > pressed. Therefore it would not be possible to distinguish between
> > trackpoint "press" and real left button press.
>=20
> yep, that's what I meant with "we cannot use it as separate interaction",
> we'd have no way to know how the click was generated.
>=20
> >=20
> > > That aside, I think exporting ABS_PRESSURE is fine, that's what it's =
there
> > > for. Nothing will use it for now though, tbh not sure yet how that wo=
uld be
> > > exported from libinput. but worth filing a bug for, please assign it =
to me.
> >=20
> > Ok, so ABS_PRESSURE? Also then question is, how to report minimal and
> > maximal (possible) value? If we are going to "standardize" API for it,
> > we should also define min/max values, so userspace would be able to
> > normalize this pressure event. I can imagine that some devices can
> > report 8bit value, but ALPS rushmore reports only 5bit value.
>=20
> tbh, I'm not putting my hopes on this being an accurate range ever. So
> what's likely going to happen is that you pick a best-guess min/max for t=
he
> kernel and then we have dmi-based overrides for every single trackpoint in
> userspace to tell us what a realistic threshold value for a click is and
> what the actual min/max ranges is.
>=20
> This is relatively easy to measure in userspace, we can pop it into
> 60-evdev.hwdb to override the min/max and ship the threshold values as
> libinput-specific files. It's awful, but most likely the best we can do.
>=20
> But hey, at least a min of 0 will be accurate ;)
>=20
> Cheers,
>    Peter

Now I see that alps.c already has following initialization code for
tracksticks:

		if (priv->flags & ALPS_DUALPOINT_WITH_PRESSURE) {
			input_set_capability(dev2, EV_ABS, ABS_PRESSURE);
			input_set_abs_params(dev2, ABS_PRESSURE, 0, 127, 0, 0);
		}

And for ALPS SS4 S2 devices alps.c sets that flag. And in function
alps_process_packet_ss4_v2() for SS4_PACKET_ID_STICK it calls:

		input_report_rel(dev2, REL_X, SS4_TS_X_V2(packet));
		input_report_rel(dev2, REL_Y, SS4_TS_Y_V2(packet));
		input_report_abs(dev2, ABS_PRESSURE, SS4_TS_Z_V2(packet));

Therefore ABS_PRESSURE is already used for one trackstick device.

I will prepare patch to export "z" axes also for other ALPS trackpoints
via that ABS_PRESSURE attribute.

Above input_set_abs_params() call already sets minimal and maximal
value, therefore this problem is solved too.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--lugo43uavryf2i27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWrKa/QAKCRCL8Mk9A+RD
Uny+AJ9DtUthbylgRXTeMnDMEi/kFtPKjQCgnlEFOtcV9xCS+33hZWfGYU3S+d0=
=iAWQ
-----END PGP SIGNATURE-----

--lugo43uavryf2i27--
