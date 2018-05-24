Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031372AbeEXOOe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:14:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33168 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966100AbeEXOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:14:32 -0400
Date: Thu, 24 May 2018 15:14:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH 8/9] regulator: bd71837: BD71837 PMIC regulator driver
Message-ID: <20180524141427.GU4828@sirena.org.uk>
References: <20180524060036.GI4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LtN0I0gXzHUftVCi"
Content-Disposition: inline
In-Reply-To: <20180524060036.GI4249@localhost.localdomain>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LtN0I0gXzHUftVCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2018 at 09:00:36AM +0300, Matti Vaittinen wrote:

> @@ -0,0 +1,683 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018 ROHM Semiconductors */
> +/*
> + * bd71837-regulator.c ROHM BD71837MWV regulator driver
> + */
> +#include <linux/kernel.h>

Make the entire comment block a C++ comment so it looks more intentional
and add a blank line before the headers for legibility.

> +static int bd71837_regulator_set_regmap(struct regulator_dev *rdev, int set)
> +{
> +	int ret = -EINVAL;
> +	struct bd71837_pmic *pmic = rdev->reg_data;
> +
> +	if (pmic) {
> +		mutex_lock(&pmic->mtx);
> +		if (!set)
> +			ret = regulator_disable_regmap(rdev);
> +		else
> +			ret = regulator_enable_regmap(rdev);
> +		mutex_unlock(&pmic->mtx);
> +	}

This looks very weird - why might we not have a parent PMIC, what is the
lock doing and what is this wrapper function intended to do?  Similar
issues apply to the voltage functions, if there's any need for this it
needs to be better documented but it really doesn't look like a good
idea.

> +	err =
> +	    regmap_update_bits(pmic->mfd->regmap, BD71837_REG_REGLOCK,
> +			       (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
> +	if (err) {
> +		dev_err(&pmic->pdev->dev, "Failed to unlock PMIC (%d)\n", err);
> +		goto err;
> +	} else
> +		dev_dbg(&pmic->pdev->dev, "%s: Unlocked lock register 0x%x\n",
> +			__func__, BD71837_REG_REGLOCK);

There's loads of coding style problems with this code, please refer to
the coding style - indentation is weird and if there's { } on one side
of an else it should be on both.

> +		rdev = regulator_register(desc, &config);
> +		if (IS_ERR(rdev)) {

devm_regulator_regster()

--LtN0I0gXzHUftVCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsGyMIACgkQJNaLcl1U
h9BVuQf/cxnvFEfK8b/tJjG1FFbjWQlAQDE04Ti6c9LSrNP5jc7u1pzkBpmbqYH7
lk+4NUzecWbgrqSNvKBQbERCeE1U+CXC/jAP+9kRiAOZBz2tHptA5wfUZT0nhhFn
YU2J/99hDSDYfpt7rTfjXBG5ljXUrymJ/eWrzRGnrbRVSvnav3ViST7TJBdG23mt
6nnhcAo9CrEjYgKCfOJPFXXmiukU0+aWSpwQA2+ygOBXZKk5dG+FSLpbgTHpEzWt
ucQTwHEFPkQaEr/NubKHEeIetZ8nOoow7bd22gCswE+Thrtu2H9WLLYDldGmWXvc
DxS/F8D740F4NXZfRhv3HN0YEKHPIQ==
=upsr
-----END PGP SIGNATURE-----

--LtN0I0gXzHUftVCi--
