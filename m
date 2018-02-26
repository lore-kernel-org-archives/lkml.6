Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeBZNrr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:47:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50520 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeBZNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:47:46 -0500
Date: Mon, 26 Feb 2018 14:47:41 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Message-ID: <20180226134741.neqkpge33zo3pfzt@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lccsnu2jsz373qn3"
Content-Disposition: inline
In-Reply-To: <20180224074543.GF3217@dragon>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lccsnu2jsz373qn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
> On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
> > On i.MX53 it is necessary to set the DBG_EN bit in the
> > platform GPC register to enable access to PMU counters
> > other than the cycle counter.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++++++=
++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-im=
x53.c
> > index 07c2e8dca494..658e28604dca 100644
> > --- a/arch/arm/mach-imx/mach-imx53.c
> > +++ b/arch/arm/mach-imx/mach-imx53.c
> > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
> >  	mxc_set_cpu_type(MXC_CPU_MX53);
> >  }
> > =20
> > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
>=20
> The base address should be retrieved from device tree.

DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "ARM Platf=
orm"
with 8 platform specific 32 bit registers. Do you think it's worth the trou=
ble
adding a new binding? Do you have a suggestion for a compatible value?

-- Sebastian

>=20
> Shawn
>=20
> > +#define GPC_DBG_EN BIT(16)
> > +
> > +/*
> > + * This enables the DBGEN bit in ARM_GPC register, which is
> > + * required for accessing some performance counter features.
> > + * Technically it is only required while perf is used, but to
> > + * keep the source code simple we just enable it all the time
> > + * when the kernel configuration allows using the feature.
> > + */
> > +static void imx53_pmu_init(void)
> > +{
> > +	void __iomem *gpc_reg;
> > +	struct device_node *node;
> > +	u32 gpc;
> > +
> > +	if (!IS_ENABLED(CONFIG_ARM_PMU))
> > +		return;
> > +
> > +	node =3D of_find_compatible_node(NULL, NULL, "arm,cortex-a8-pmu");
> > +	if (!node)
> > +		return;
> > +
> > +	if (!of_property_read_bool(node, "secure-reg-access"))
> > +		return;
> > +
> > +	gpc_reg =3D ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
> > +	if (!gpc_reg) {
> > +		pr_warning("unable to map GPC to enable perf\n");
> > +		return;
> > +	}
> > +
> > +	gpc =3D readl_relaxed(gpc_reg);
> > +	gpc |=3D GPC_DBG_EN;
> > +	writel_relaxed(gpc, gpc_reg);
> > +}
> > +
> >  static void __init imx53_dt_init(void)
> >  {
> >  	imx_src_init();
> > -
> > +	imx53_pmu_init();
> >  	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
> >  }
> > =20
> > --=20
> > 2.15.1
> >=20

--lccsnu2jsz373qn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqUD/oACgkQ2O7X88g7
+poZuQ//UROH93H5dL56QeigAdwkRZWcCGJsrHTraC0xNsr6Qh6bF0OwluFqrmQb
m17Ozdwoy7JFmlPvkaad26Vbwwp4Z7hEyuKJEjtEzVA3km3DDyom5eAFLwYHo9Xf
k56ECq4wkGjC8+aNezlO5GMuTQOCUjSDjAXX+USr9uKOoJEJj+2lRgVKvGdZ338z
Yt51tzDvRVgMgC8t3NBAWw6WWnAxhJ8FWBYgUKGuWdfh1I6JmvWOxS9A1g9SMDNm
luKSr2psJmJsOu3mxJa7mCArboCEypzOdh05wLqgth9HlI/twGbigdDeHbsOuIR5
YRIWm1950h+fsiWojQEGZgG/bdk5RzxpCRmYixhoMYkGmJjpnkzpI0wmVi39aKcl
HvISNF1E9qeankAQWJ44EOwDNSNH1+g5K0Ap1mixkMkFsomZToziyEwieynUEBFb
QHeibjwaZFphpdZdejOqx8Imy9encDld6hdJPBtRJXxZjrESSdE+28TBilKgv9SH
vy3Kw8x/4DYXuUIodwZwHQBw2DAwVIW2/C3yfEPE8dDh/9OCn9oiqSfVCNQwOA5V
zSc8A2MLbZFT9y2tn7XkNbU7lx87po+sS22h/g4OpcOKVh/0mir66qjGHqPCVHav
OQ2McIOwVynVfkBqG2jRlVeRvm36fdD8TagnpGMQpJNPUosJrcI=
=0tXm
-----END PGP SIGNATURE-----

--lccsnu2jsz373qn3--
