Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F57AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17561217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfACXea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:34:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56836 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfACXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:34:29 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 73223808E3; Fri,  4 Jan 2019 00:34:21 +0100 (CET)
Date:   Fri, 4 Jan 2019 00:34:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <dachaac@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20190103233425.GA10071@amd>
References: <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Regarding led_scale_color_elements() - I checked it in GIMP and
> >the results are not satisfactory when increasing brightness.
> >Even if we managed to fix it, the result would not be guaranteed
> >to be the same across all devices.
>=20
> No and they will never be the same. I was told by our hardware expert that
> it is rather impossible to get linearly behaving LED control without spec=
ial
> curve fitting trimmed for particular hardware and LED component in use. A=
nd
> if you go and change LED component/vendor it would need to be "calibrated"
> again if such accuracy would be required. Also LEDs age and that has also
> effect on this.

Well, it is not possible to "perfectly" calibrate LCD monitors,
either. Yet, color tables make sense for them.

And we should aim for the same thing.

And yes, it may mean re-doing calibration when vendor changes. And it
will mean some math and some understanding of colors.

And... LEDs are linear-enough as it is. That is not a problem. But RGB
does _not_ expect linear response. That's why colors are _way_ off currentl=
y.

> >I have another proposal, being a mix of what has been discussed so far:
> >
> > =A0=A0 RGB LED class will expose following files:
> > =A0=A0 a) available by default:
> > =A0=A0=A0=A0 - red, green, blue
> > =A0=A0=A0=A0=A0=A0 Writing any of these file will result in writing cor=
responding
> > =A0=A0=A0=A0=A0=A0 device register.
>=20
> Problem with this is that we are basically back at square one and one can=
not
> do "atomic" color change with this.
>=20
> In order to set or activate new values one would need "load values" file =
or
> such that when writing to it would activate new values. However it becomes
> quite clumsy interface at that point as you need to handle multiple writes
> to multiple files and makes those operations rather slow.

If you don't like the interface, create an shared library. It may be
neccessary, anyway, for the color operations.

You say it is "rather slow" to change all 3 colors. How long does it
take, and how long do you need it to take?

> Then we have color presets left that could kinda solve the issue on setti=
ng
> the color to fixed values atomically.

Lets not design crazy interface "because sysfs writing is too
slow". Hint: it is not.=20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwunAEACgkQMOfwapXb+vLRIQCguTxCUuv5V7XSTdfCv8d8jXOB
ragAmgJsbRIsDrQtdqSdsH6lkkdK0vK8
=2YYv
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
