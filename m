Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbeE2Lrs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:47:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58430 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933288AbeE2Lrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:47:45 -0400
Date: Tue, 29 May 2018 12:47:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v3 6/6] regulator: bd71837: BD71837 PMIC regulator driver
Message-ID: <20180529114740.GG23509@sirena.org.uk>
References: <cover.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
 <68b0cf2c7ab5578eef2f71a33315bc8ab9a68a39.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <68b0cf2c7ab5578eef2f71a33315bc8ab9a68a39.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Variables don't
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 01:02:15PM +0300, Matti Vaittinen wrote:

> @@ -0,0 +1,677 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018 ROHM Semiconductors */
> +/*
> + * bd71837-regulator.c ROHM BD71837MWV regulator driver
> + */

The SPDX header (and the rest of the block) need to be C++ comments.

> +static int bd71837_regulator_set_regmap(struct regulator_dev *rdev, int set)
> +{
> +	int ret = -EINVAL;
> +	struct bd71837_pmic *pmic = rdev->reg_data;
> +
> +	/* According to the data sheet we must not change regulator voltage
> +	 * when it is enabled. Thus we need to check if regulator is enabled
> +	 * before changing the voltage. This mutex is used to avoid race where
> +	 * we might enable regulator after it's state has been checked but
> +	 * before the voltage is changed
> +	 */
> +	mutex_lock(&pmic->mtx);
> +	if (!set)
> +		ret = regulator_disable_regmap(rdev);
> +	else
> +		ret = regulator_enable_regmap(rdev);
> +	mutex_unlock(&pmic->mtx);
> +

This still has the weird locking/wrapper thing going on.  The regulator
core will ensure that only one operation is called on a given regulator
at once.

> +static const struct regulator_desc bd71837_regulators[] = {
> +	{
> +	 .name = "buck1",

The indentation style here is weird, please follow CodingStyle.  Looks
like the second level is just indented by a space for some reason, and
there's similar problems elsewhere.

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsNPdsACgkQJNaLcl1U
h9DIMwf9Gko/cLaIOR7E6jd5feuDxB3vTjXfFNZPaTspdh0DO16BEpXHpqfVKEfU
J8h+FlYeXeaiGA6PGN8hqVSR/VV4duOTRzstjYYeTNpBeYTDeL8KBP2JyqTd5rcO
r+Wup8DMwGXZi7DbPcCYWef3KBe01tRvijThMkouhfu+6SUpc8jgaeNAQlcAw4O/
cbNIseTZs82gJAeAp3QJq4qvPNn7LpUjrZh85A0Xp9lVi0h4H/x60LDVPB+EmsII
gzwDVmIopWv2U+75lkYXSVA0q+fYgzUpT6Cv5eaa19xL1E5KDquvp6CqTNwrjbhX
s/D6TS6ufJyFzVUuAp59DT2LhrZXwQ==
=Zutn
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
