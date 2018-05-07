Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeEGCVj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 22:21:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35441 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeEGCVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 22:21:36 -0400
X-Google-Smtp-Source: AB8JxZoDnioFFyT/nCrvlLSuHQRBCWO6+ZMRfSX5jgoomwlDAwuwKD+3CqTwGk9gE51gwJ1bQNNktw==
Message-ID: <1525659688.4030.5.camel@canonical.com>
Subject: Re: [PATCH] iio: humidity: hts221: Fix sensor reads after resume
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 07 May 2018 10:21:28 +0800
In-Reply-To: <20180506171942.0a4802d7@archlinux>
References: <20180430042546.8801-1-shrirang.bagul@canonical.com>
         <20180506171942.0a4802d7@archlinux>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zMGSogCQuESQWws1m/lw"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zMGSogCQuESQWws1m/lw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-05-06 at 17:19 +0100, Jonathan Cameron wrote:
> On Mon, 30 Apr 2018 12:25:46 +0800
> Shrirang Bagul <shrirang.bagul@canonical.com> wrote:
>=20
> > CTRL1 register (ODR & BDU settings) gets reset after system comes back
> > from suspend, causing subsequent reads from the sensor to fail.
> >=20
> > This patch restores the CTRL1 register after resume.
> >=20
> > Based on:
> > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-fixes-f=
or-4.14b
> >=20
> > Since 4.17.rc1, this driver uses REGMAP; I'll send a separate patch to
> > address this issue.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfigu=
ration)
>=20
> Looks like part of the problem was introduced in that patch, part well pr=
edated
> it (BDU).
>=20
> > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
>=20
> As you way, this needs to be a bit different to take into account
> the change to regmap.  We'll need to have that upstream before we look
> at a back port.  One element inline surprises me and needs further
> explanation.
I have sent a patch based on iio-for-4.17b [1], Lorenzo and I are still=20
discussing our findings. It's not just the CTRL1 reg, but also the AV_CONF(=
0x10) reg.
which loses it's contents coming out of suspend.

[1] https://marc.info/?l=3Dlinux-iio&m=3D152534455701742&w=3D2
>=20
>=20
> > ---
> >  drivers/iio/humidity/hts221_core.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/=
hts221_core.c
> > index 32524a8dc66f..fed2da64fa3b 100644
> > --- a/drivers/iio/humidity/hts221_core.c
> > +++ b/drivers/iio/humidity/hts221_core.c
> > @@ -674,11 +674,15 @@ static int __maybe_unused hts221_resume(struct de=
vice *dev)
> >  	struct hts221_hw *hw =3D iio_priv(iio_dev);
> >  	int err =3D 0;
> > =20
> > -	if (hw->enabled)
> > -		err =3D hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> > -					     HTS221_ENABLE_MASK, true);
>=20
> Why drop the enable setting?  Seems that we want to do this 'as well',
> if the device was previous enabled.
Yes, will cover this in v2.
>=20
> > +	err =3D hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> > +				     HTS221_BDU_MASK, 1);
> > +	if (err < 0)
> > +		goto fail_err;
> > =20
> > -	return err;
> > +	err =3D hts221_update_odr(hw, hw->odr);
> > +
> > +fail_err:
> > +	return err < 0 ? err : 0;
> >  }
> > =20
> >  const struct dev_pm_ops hts221_pm_ops =3D {
>=20
>=20
--=-zMGSogCQuESQWws1m/lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa77goAAoJELlj3b/+u+hk4XwP/0SHH/Cv407g+WHxOBSGbVBO
bLtWtBUE0/aJKEglo6BANFA5RmtRaFslm95UlkdnB5yX0qG/2HpY8rgflBxOv8yj
WW+6PhMgRBwNX/uf5576DtCK97VId+z18aSwQoPt6g/CjasaFQN0CLAuqYls5o9S
Rx4MbRGFek6qElZ2NH4aGyjEVxmlLCLaO+QS9C3+6KKWa85iaYpUiccpBW5R08Pp
WuqbXJlsLXvPsFQxF8DUpQ8iz4VgucZJopkdbC32cRyumQGcAcP5mFEyu6swIMBT
Ju87+rXLXkrgqTM8b4FLNaiJEFurwXLvhvcV2ehSq+u/XH/VveGMyTU6akjnBNa1
Q63V2VCS3wQiQA+wf3gcTNsBMERnABkJ3QMVt7ZTxkwEt+1mbujaZ7DOOtJnxKTW
QCjaHBilrEYT+lE96fvqLdBAbqp3DhF8NE334YbGwQcFL+jZP9M1jg34J8sRG4IT
528Kniqsxj5jmLeyNCzViWXK6eYrkTkHACOf90/78cD62Hn5P18dlxela91/ac2/
fzhLyd939/yiDTAyHAX5akIeUABPCb84AIyAbnRuUiQ5+DS8IG2+SYg2/IEGroYM
mUEVoJ/T5PMpq6mLTeH4MbEwi/iRRu1qJY+Br3V1Lrvqu3k39CjpJaZV9oo6+T+e
Jmk0HNYqlvczgXaCMMgo
=ZGkH
-----END PGP SIGNATURE-----

--=-zMGSogCQuESQWws1m/lw--
