Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeENMr3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:47:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36713 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeENMr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:47:26 -0400
X-Google-Smtp-Source: AB8JxZpr9K+Npawv0osAQst3BWH+qxkdXcHag7sqN/n5MkjpuDKttQIi9/bOQi2XwX/qtVSSmn6xOg==
Date: Mon, 14 May 2018 14:47:23 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Dmitry Osipenko <digetx@gmail.com>, Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
Message-ID: <20180514124723.GJ18312@ulmo>
References: <20180513211347.7187-1-digetx@gmail.com>
 <20180514115933.GH18312@ulmo>
 <d83fc1f7-d5e5-4211-1cd8-babcabdd9c4b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <d83fc1f7-d5e5-4211-1cd8-babcabdd9c4b@nvidia.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 05:51:58PM +0530, Laxman Dewangan wrote:
>=20
>=20
> On Monday 14 May 2018 05:29 PM, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Mon, May 14, 2018 at 12:13:47AM +0300, Dmitry Osipenko wrote:
> > > Nothing prevents I2C clients to access I2C while Tegra's driver is be=
ing
> > > suspended, this results in -EBUSY error returned to the clients and t=
hat
> > > may have unfortunate consequences. In particular this causes problems
> > > for the TPS6586x MFD driver which emits hundreds of "failed to read
> > > interrupt status" error messages on resume from suspend. This happens=
 if
> > > TPS6586X is used to wake system from suspend by the expired RTC alarm
> > > timer because TPS6586X is an I2C device driver and its IRQ handler re=
ads
> > > the status register while Tegra's I2C driver is suspended, i.e. just =
after
> > > kernel enabled IRQ's during of resume-from-suspend process.
> > >=20
> > > Note that the removed tegra_i2c_resume() invoked tegra_i2c_init() whi=
ch
> > > performs HW reset. That seems was also not entirely correct because m=
oving
> > > tegra_i2c_resume to an earlier stage of resume-from-suspend process c=
auses
> > > I2C transfer to fail in the case of TPS6586X. It is fine to remove the
> > > HW-reinitialization for now because it should be only needed in a cas=
e of
> > > using lowest power-mode during suspend, which upstream kernel doesn't
> > > support.
> > >=20
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > Cc: <stable@vger.kernel.org>
> > > ---
> > >   drivers/i2c/busses/i2c-tegra.c | 33 -------------------------------=
--
> > >   1 file changed, 33 deletions(-)
> > Shardar, Laxman, any thoughts on this? The is_suspended thing looks to
> > me like a workaround of some sort that may not be needed if clients have
> > proper suspend/resume implementations. Even without suspend/resume
> > support in client drivers, the driver core should resume devices in the
> > right order (I2C adapter before any of the clients), so I don't see any
> > cases where the is_suspended logic would be useful.
> >=20
>=20
> Our I2C driver is based on the interrupt. So we have converted the
> suspend/resume to suspend_noirq and reseume_noirq so that we will not all=
ow
> the transfer when system interrupt disabled in downstream.
>           SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resu=
me)

That seems to me like it shouldn't be necessary. If all clients are
properly suspended, then when the I2C controller gets suspended there
should be no pending transfers. That's provided that the driver model
properly orders suspend of clients vs. their controller. I think it
didn't use to do that (especially when deferred probing was involved)
but I remember that getting fixed sometime in the last couple of years.

> In shutdown path, where interrupt disabled and still need i2c, we use the
> bit-bang method via GPIO for i2c transfer.

Do we really need to bit-bang the GPIOs? Couldn't the I2C controller
operate in a polling mode where only the interrupt was disabled but we
still polled the status register to know when a transfer was finished?

Thierry

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr5hVsACgkQ3SOs138+
s6GL5Q/8Cl1aMjNKGqcGrhayr5QbjG5arrOLj90/fmCnVgZrX2XkCny8MkbXvPcz
q/HNi2TRBwvaBOfGGODKM3NtTsxmMWmpSmDS1AChaVtyI0YLLbcof20dJylv4WAY
RqSp3aDJs6254RjN3TUg5E2MlHA/f+sNeOyaL91j1XfN77dCGiqI4i7AflFfWJp+
0s5r+hwGOGvt+BBXc6NZQlGM4M8TKwWDYSM+ae+nccKJSBcQo7Mjns/49vnOUD4G
6Sd6zk5gceNokgK6YEWzGU/YmK06kDwkJU3HMFJ2XP6wzNgj+ayL10YJTv9Tjep1
sO3vLYv9H62uoaFsNWXBXDpkwiMv+wgJGjderVeO4q/aF5SNm7K3iZdssoxQ3buH
9zVFWWLR+ZkVPmnLRVnWlqmijaA0C1ISAVat5fG8SuQZdz43/ilBjlCO11EIDfcL
a5wqYlsHpDrd5Aw7g/1fX0WxYiHRggV77+5eCTPPOceQEtweY+S1T9flBYeMGzOm
KF53+gvwZ2x8HS3cOlb6GlU68RHDa0fk+pHkOimzyPs7+xdVucyzsTfynLuNAqXG
2VQ/tkUgDq1+AHfkAy1FedpQc9/rEbzNT2UL0ZFLjMBaaxFt6+NBPFAjmNKLsyTu
NrNV7eopWVtIkjtIafV1/zyRHjFq8mlfqCttcu2pj2//zIcw8CY=
=cpLT
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
