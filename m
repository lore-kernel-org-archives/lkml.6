Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeENL7j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:59:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40177 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeENL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:59:36 -0400
X-Google-Smtp-Source: AB8JxZoV4RiUEE+sfKQUeJSnXSZeChbkdDNI3tAYGfjaXd+PvE7I55iIkWdGS3Ni2aq0Kp89vjNTaA==
Date: Mon, 14 May 2018 13:59:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
Message-ID: <20180514115933.GH18312@ulmo>
References: <20180513211347.7187-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <20180513211347.7187-1-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 12:13:47AM +0300, Dmitry Osipenko wrote:
> Nothing prevents I2C clients to access I2C while Tegra's driver is being
> suspended, this results in -EBUSY error returned to the clients and that
> may have unfortunate consequences. In particular this causes problems
> for the TPS6586x MFD driver which emits hundreds of "failed to read
> interrupt status" error messages on resume from suspend. This happens if
> TPS6586X is used to wake system from suspend by the expired RTC alarm
> timer because TPS6586X is an I2C device driver and its IRQ handler reads
> the status register while Tegra's I2C driver is suspended, i.e. just after
> kernel enabled IRQ's during of resume-from-suspend process.
>=20
> Note that the removed tegra_i2c_resume() invoked tegra_i2c_init() which
> performs HW reset. That seems was also not entirely correct because moving
> tegra_i2c_resume to an earlier stage of resume-from-suspend process causes
> I2C transfer to fail in the case of TPS6586X. It is fine to remove the
> HW-reinitialization for now because it should be only needed in a case of
> using lowest power-mode during suspend, which upstream kernel doesn't
> support.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)

Shardar, Laxman, any thoughts on this? The is_suspended thing looks to
me like a workaround of some sort that may not be needed if clients have
proper suspend/resume implementations. Even without suspend/resume
support in client drivers, the driver core should resume devices in the
right order (I2C adapter before any of the clients), so I don't see any
cases where the is_suspended logic would be useful.

Thierry

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr5eiUACgkQ3SOs138+
s6HmcQ//aSgYhfohzOMno/sNXEmFWOsKYdWsSSlz7cjbGxeVb6Hmp1I+sxfVof+b
XmMdH/Yq033hCIuUMU/zgRVTUhayDSngElbzGvZngCErYLe8mFn4uL5JSLElSH/j
xSKmHG6UcYC/P6LMQ961jr5si9Fm23MXFBEEXVOdJ/3Cz4h3bbGft6k46fT3mlvG
HdgYi0qEwGt/ujuHLqC/V8VYEiDJ0efkrOwuDaEquMjKYLVwJKiYYydT5LjQ4o7D
NqVANSY0AnuiqgoPyq0qKHaVQMDom5cejB7o9LloschUtynQCWUQt+gxnZLSb/SH
KwplDi4clocEwS0kwjUraiO9RLSF88+dwuJQE/cnNUsKAzBmiO523/UW0bcpwUGA
ZW+5CFwx7/q5HexlaiTdtPwpsVqS4+7kBNBv5RiT8vh2lICJr4iaj9OnLveJGaJ6
AxF+WPNbJbm9DLr5+nHCmMLWxkFhxSH/ydYQ8+SuvZ5jNn+Bm65aX8l9mH018MVt
tChed0UY1YUMN+cOkJQrlFlKMWGChEPgV5MM1dmKTX1mLtyZO4CGVjQnU/HCfvOs
3+uVJQ7GklqB4mOo0c8js/YaqGGhqQnLRZ04tRhIVI/lk3jhVQIkioaR0HNICmCr
4kut2rs+HFy8KU+/GUH4nhtSJDrYYQ3tMGT11lmJfFeB7gZ7sis=
=euGK
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
