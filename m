Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D210607E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeFFHf3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:35:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39101 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbeFFHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:35:27 -0400
Date: Wed, 6 Jun 2018 09:35:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "H. Nikolaus Schaller" <hns@computer.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Subject: Re: [PATCH v7 3/3] gpio: pca953x: fix address calculation for
 pcal6524
Message-ID: <20180606073525.GA18743@amd>
References: <cover.1526533188.git.hns@goldelico.com>
 <e70e83f07aebaf702fef90a9fac61e41d8b558b0.1526533188.git.hns@goldelico.com>
 <20180523140635.GB27215@amd>
 <CAHp75VfxN1RZBFRK6oJ5AzCe_2ej9eYdwt96X+fJZgFy65eaFg@mail.gmail.com>
 <20180605203941.GA28143@amd>
 <A639885E-0E5D-4FB0-BE51-AFF35BF4F76B@computer.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <A639885E-0E5D-4FB0-BE51-AFF35BF4F76B@computer.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-06-06 07:33:32, H. Nikolaus Schaller wrote:
> Hi,
>=20
> > Am 05.06.2018 um 22:39 schrieb Pavel Machek <pavel@ucw.cz>:
> >=20
> > On Tue 2018-06-05 18:37:21, Andy Shevchenko wrote:
> >> On Wed, May 23, 2018 at 5:06 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >>> On Thu 2018-05-17 06:59:49, H. Nikolaus Schaller wrote:
> >>>> The register constants are so far defined in a way that they fit
> >>>> for the pcal9555a when shifted by the number of banks, i.e. are
> >>>> multiplied by 2 in the accessor function.
> >>>>=20
> >>>> Now, the pcal6524 has 3 banks which means the relative offset
> >>>> is multiplied by 4 for the standard registers.
> >>>>=20
> >>>> Simply applying the bit shift to the extended registers gives
> >>>> a wrong result, since the base offset is already included in
> >>>> the offset.
> >>>>=20
> >>>> Therefore, we have to add code to the 24 bit accessor functions
> >>>> that adjusts the register number for these exended registers.
> >>>>=20
> >>>> The formula finally used was developed and proposed by
> >>>> Andy Shevchenko <andy.shevchenko@gmail.com>.
> >>=20
> >>>>      int bank_shift =3D fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
> >>>> +     int addr =3D (reg & PCAL_GPIO_MASK) << bank_shift;
> >>>> +     int pinctrl =3D (reg & PCAL_PINCTRL_MASK) << 1;
> >>=20
> >>> Is this reasonable to do on each register access? Compiler will not be
> >>> able to optimize out fls and shifts, right?
> >>=20
> >> On modern CPUs fls() is one assembly command. OTOH, any proposal to do
> >> this better?
> >>=20
> >> What I can see is that bank_shift is invariant to the function, and
> >> maybe cached.
> >=20
> > Yes, I thought that caching bank_shift might be good idea. I thought
> > it was constant for given chip...
>=20
> Yes, it is an f(chip), but the question that comes to my mind is if
> optimization is worth any effort. This is an accessor method over

It will also be less ugly. Copy&pasted complex exprepsion all over the
driver is not nice.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsXjr0ACgkQMOfwapXb+vIc1wCggj6eiSaPQ5SgwApWF99NsdKs
vqoAoMPTlFh+Gg+YVlfFIoV6TYdftu6l
=1hdR
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
