Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeBZKM4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:12:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44278 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbeBZKMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:12:54 -0500
Date: Mon, 26 Feb 2018 11:12:52 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
Message-ID: <20180226101252.ozdsxjvawgkemz2c@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-11-mylene.josserand@bootlin.com>
 <CAGb2v67SuK9Xr7_dVb7RVGXUJwYRKnTiJwDrOJ-Su5CXmm7HXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mbneedr2uplq73p2"
Content-Disposition: inline
In-Reply-To: <CAGb2v67SuK9Xr7_dVb7RVGXUJwYRKnTiJwDrOJ-Su5CXmm7HXA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mbneedr2uplq73p2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 12:17:13AM +0800, Chen-Yu Tsai wrote:
> On Fri, Feb 23, 2018 at 9:37 PM, Myl=E8ne Josserand
> <mylene.josserand@bootlin.com> wrote:
> > On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.
> > It should be done by the bootloader but it is currently not the case,
> > even for boot CPU because this SoC is booting in secure mode.
> > It leads to an random offset value meaning that each CPU will have a
> > different time, which isn't working very well.
> >
> > Add assembly code used for boot CPU and secondary CPU cores to make
> > sure that the CNTVOFF register is initialized.
> >
> > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/headsmp.S | 21 +++++++++++++++++++++
> >  arch/arm/mach-sunxi/sunxi.c   |  4 ++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsm=
p.S
> > index d5c97e945e69..605896251927 100644
> > --- a/arch/arm/mach-sunxi/headsmp.S
> > +++ b/arch/arm/mach-sunxi/headsmp.S
> > @@ -65,9 +65,30 @@ ENTRY(sunxi_mc_smp_cluster_cache_enable)
> >         first: .word sunxi_mc_smp_first_comer - .
> >  ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> >
> > +ENTRY(sunxi_init_cntvoff)
> > +       /*
> > +        * CNTVOFF has to be initialized either from non-secure Hypervi=
sor
> > +        * mode or secure Monitor mode with SCR.NS=3D=3D1. If TrustZone=
 is enabled
> > +        * then it should be handled by the secure code
> > +        */
> > +       cps     #MON_MODE
> > +       mrc     p15, 0, r1, c1, c1, 0           /* Get Secure Config */
> > +       orr     r0, r1, #1
> > +       mcr     p15, 0, r0, c1, c1, 0           /* Set Non Secure bit */
> > +       instr_sync
> > +       mov     r0, #0
> > +       mcrr    p15, 4, r0, r0, c14             /* CNTVOFF =3D 0 */
> > +       instr_sync
> > +       mcr     p15, 0, r1, c1, c1, 0           /* Set Secure bit */
> > +       instr_sync
> > +       cps     #SVC_MODE
> > +       ret     lr
> > +ENDPROC(sunxi_init_cntvoff)
>=20
> There is no need to move all the assembly into a separate file, just
> to add this function. Everything can be inlined as a naked function.
> The "instr_sync" macro can be replaced with "isb", which is what it
> expands to anyway.
>=20
> I really want to keep everything self-contained without global symbols,
> and in C files if possible.

What is the rationale for keeping it in C files (beside the global
symbols)? Because the syntax is quite ugly, and it's much easier to
read, review and amend using a separate file.

> >  #ifdef CONFIG_SMP
> >  ENTRY(sunxi_boot)
> >         bl      sunxi_mc_smp_cluster_cache_enable
> > +       bl      sunxi_init_cntvoff
> >         b       secondary_startup
> >  ENDPROC(sunxi_boot)
> >
> > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > index 5e9602ce1573..4bb041492b54 100644
> > --- a/arch/arm/mach-sunxi/sunxi.c
> > +++ b/arch/arm/mach-sunxi/sunxi.c
> > @@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] =
=3D {
> >  };
> >
> >  extern void __init sun6i_reset_init(void);
> > +extern void sunxi_init_cntvoff(void);
> > +
> >  static void __init sun6i_timer_init(void)
> >  {
> > +       sunxi_init_cntvoff();
>=20
> You should check the enable-method to see if PSCI is set or not,
> as an indicator whether the kernel is booted secure or non-secure.

It's an indicator, but it's not really a perfect one. You could very
well have your kernel booted in non-secure, without PSCI. Or even with
PSCI, but without the SMP ops.

We have a quite big number of these cases already, where, depending on
the configuration, we might not have access to the device we write to,
the number of hacks to just enable that device for non-secure is a
good example of that.

> AFAIK trying to set CNTVOFF under non-secure would be very bad.

Just like any other access we do :/

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--mbneedr2uplq73p2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqT3aMACgkQ0rTAlCFN
r3Qmqw//WGnAKBTv6UvydDeyCIB9E8IQO19puDonvS5tDNbJCXX2sPNqlvZi5eYH
gudBP8QUQsSpCdRR8YHOKrh2XLyTdjkRFuMa1bochbSAIk+jsA1IA3hW+V8i9N6B
STw8FG/0araXLAMapBOc5/0JSzSEdc7o+X4XEUMG6WGlmlHxk2i0zxfSe3EhhF/Q
hSHUUbkcwAlJhE4xW98ZmsgqgSH5zt3z03/MiQhNpo+DLZpR25xkRytz72Z1dhyZ
VcRPtunBLlmXM0h/Q98G8LPVXsKmgdJITTYyt5SNfbuFRHOlkfkRD/D8u5GX2nGp
xiefs8IqW9PywLjrsVd0tSX6V+zcEvbM02LN/8KSVKY6StkRaEH1ZthOR1QJmRty
mHBRZhMgQWcpkjGzeIKp3dsrcH4fYISLvavqNNjgO3GDwtXeF8yMqsT1hbmd3daT
d6R5AeDk8msU7CUFBSlKzgWyJ/BOaHIn0XR4YCu8sHyJVEUXEEtU2KnWtf5gc4QW
3g9ROxL1NT9bALnnibi/sWELqTA1iiUeIbh0lGU4d+jAtIy8ZOJZa8hSWZUo7AOu
s8FzovMl/3+1ZqGRTZbu18y2IPfhG9kDVUe8UaYyu1RpWAfhc4z+YemcKsa+5nm5
O7ew3QimPym+PvAH/KNy4TfstyhrKXloi8pbVBCY035LudK1bC4=
=86xh
-----END PGP SIGNATURE-----

--mbneedr2uplq73p2--
