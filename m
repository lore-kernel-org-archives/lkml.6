Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeEWOGk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:06:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43295 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933093AbeEWOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:06:37 -0400
Date: Wed, 23 May 2018 16:06:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v7 3/3] gpio: pca953x: fix address calculation for
 pcal6524
Message-ID: <20180523140635.GB27215@amd>
References: <cover.1526533188.git.hns@goldelico.com>
 <e70e83f07aebaf702fef90a9fac61e41d8b558b0.1526533188.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <e70e83f07aebaf702fef90a9fac61e41d8b558b0.1526533188.git.hns@goldelico.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-05-17 06:59:49, H. Nikolaus Schaller wrote:
> The register constants are so far defined in a way that they fit
> for the pcal9555a when shifted by the number of banks, i.e. are
> multiplied by 2 in the accessor function.
>=20
> Now, the pcal6524 has 3 banks which means the relative offset
> is multiplied by 4 for the standard registers.
>=20
> Simply applying the bit shift to the extended registers gives
> a wrong result, since the base offset is already included in
> the offset.
>=20
> Therefore, we have to add code to the 24 bit accessor functions
> that=A0adjusts the register number for these exended registers.
>=20
> The formula finally used was developed and proposed by
> Andy Shevchenko <andy.shevchenko@gmail.com>.
>=20
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index c682921d7019..4ad553f4e41f 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -222,9 +222,11 @@ static int pca957x_write_regs_16(struct pca953x_chip=
 *chip, int reg, u8 *val)
>  static int pca953x_write_regs_24(struct pca953x_chip *chip, int reg, u8 =
*val)
>  {
>  	int bank_shift =3D fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
> +	int addr =3D (reg & PCAL_GPIO_MASK) << bank_shift;
> +	int pinctrl =3D (reg & PCAL_PINCTRL_MASK) << 1;

Is this reasonable to do on each register access? Compiler will not be
able to optimize out fls and shifts, right?

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsFdWsACgkQMOfwapXb+vITrwCcDj//GiI8j4gSWTwrTovWV1af
B5QAniiu4Ct5Fy1mqITZSjntXGb4B+4F
=uPYg
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
