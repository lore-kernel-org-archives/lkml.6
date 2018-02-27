Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeB0KRR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:17:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56198 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeB0KRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:17:15 -0500
Date: Tue, 27 Feb 2018 11:17:12 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Message-ID: <20180227101712.3zwobvs4ox4jchcj@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bhxrs7heoy7nzc2m"
Content-Disposition: inline
In-Reply-To: <20180227011033.GV3217@dragon>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bhxrs7heoy7nzc2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2018 at 09:10:34AM +0800, Shawn Guo wrote:
> On Mon, Feb 26, 2018 at 02:47:41PM +0100, Sebastian Reichel wrote:
> > On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
> > > On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
> > > > On i.MX53 it is necessary to set the DBG_EN bit in the
> > > > platform GPC register to enable access to PMU counters
> > > > other than the cycle counter.
> > > >=20
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > > ---
> > > >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++=
++++++++-
> > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mac=
h-imx53.c
> > > > index 07c2e8dca494..658e28604dca 100644
> > > > --- a/arch/arm/mach-imx/mach-imx53.c
> > > > +++ b/arch/arm/mach-imx/mach-imx53.c
> > > > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
> > > >  	mxc_set_cpu_type(MXC_CPU_MX53);
> > > >  }
> > > > =20
> > > > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
> > >=20
> > > The base address should be retrieved from device tree.
> >=20
> > DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "ARM P=
latform"
> > with 8 platform specific 32 bit registers. Do you think it's worth the =
trouble
> > adding a new binding? Do you have a suggestion for a compatible value?
>=20
> Looking at it more closely, I feel that patching every single platform
> which needs to set up additional register for secure-reg-access support
> doesn't really scale.  Can we have pmu driver do it with a phandle in
> DT pointing to the register and bit that need to be configured?

The PMU driver used to have a feature for initialising platform
specific bits, but it is currently being removed to make the PMU
code more maintainable. My understanding is, that it's very uncommon
to require platform specific setup to get secure-reg-access working.
I.e. it is not needed for newer iMX platforms.

-- Sebastian

>=20
> Shawn
>=20
> > > > +#define GPC_DBG_EN BIT(16)
> > > > +
> > > > +/*
> > > > + * This enables the DBGEN bit in ARM_GPC register, which is
> > > > + * required for accessing some performance counter features.
> > > > + * Technically it is only required while perf is used, but to
> > > > + * keep the source code simple we just enable it all the time
> > > > + * when the kernel configuration allows using the feature.
> > > > + */
> > > > +static void imx53_pmu_init(void)
> > > > +{
> > > > +	void __iomem *gpc_reg;
> > > > +	struct device_node *node;
> > > > +	u32 gpc;
> > > > +
> > > > +	if (!IS_ENABLED(CONFIG_ARM_PMU))
> > > > +		return;
> > > > +
> > > > +	node =3D of_find_compatible_node(NULL, NULL, "arm,cortex-a8-pmu");
> > > > +	if (!node)
> > > > +		return;
> > > > +
> > > > +	if (!of_property_read_bool(node, "secure-reg-access"))
> > > > +		return;
> > > > +
> > > > +	gpc_reg =3D ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
> > > > +	if (!gpc_reg) {
> > > > +		pr_warning("unable to map GPC to enable perf\n");
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	gpc =3D readl_relaxed(gpc_reg);
> > > > +	gpc |=3D GPC_DBG_EN;
> > > > +	writel_relaxed(gpc, gpc_reg);
> > > > +}
> > > > +
> > > >  static void __init imx53_dt_init(void)
> > > >  {
> > > >  	imx_src_init();
> > > > -
> > > > +	imx53_pmu_init();
> > > >  	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
> > > >  }
> > > > =20
> > > > --=20
> > > > 2.15.1
> > > >=20
>=20
>=20

--bhxrs7heoy7nzc2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqVMCUACgkQ2O7X88g7
+ppW2w/9G+Xub1WmJrS8ff/D1ZrpOQjVNpz0DHJqBC+TY+jutSE2WKuS/7slPDBd
HTwptXe7OOl/GZ2vdJP2fCwnbMjVu8+4u0CBYutJlAbz6xlSL0oEN3ERZ+2y8f9y
KTWgGepbAIyKCE6chMAaXRz8bZfHXpRKcdySiMpl677ZRI+lA4IbykDGJhnnSxH9
VD6felDZmQJAEqWLcC2TRe+I/Fk2gp9eNQ2JrgHbix+KgLcgwrUt2k4zMTWThbwb
OpqU/HmpvH1i0Imjz28TxpQ2JWqb8Bg0djrOuS/7rFvuPVXz0D9sd6bndfoDLeUy
IReUacfNyVLjdmLZOYXrHulgOWOc8JpXQurscKZRN7e45tL2PRWZwBhgDWDPdlsn
Jw6r3IPXI3VHnO0gE36VpS6Fz8lWXMX9YX3uEFYgHyTL8ugmh0CAPKXMtaOB5ez3
nnzYjhrUHku2yK4qvRVK5fwNjnKfUA7AZ6oWA2qU3xohmtC3A3AyTrqiDY/UpEYW
bxWpCUOe5cvUbcQpNpApdxtFSU92S4v2XnLSXmpVbAkRCQatNr/xCEP1KlVWQBc4
VQ+KjX0Ka+L2yu5ivM/NgYvSEdK3WAk75eAMjrOyo4mKKreZ/X6tWo1calcO3bBH
Drk7DUyd4zr91IRnV9biCyOcnW8X8xcX8ZbbVjVXpaFrhdTKCAU=
=v90N
-----END PGP SIGNATURE-----

--bhxrs7heoy7nzc2m--
