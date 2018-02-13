Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934182AbeBMKat (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:30:49 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35458 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933849AbeBMKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:30:42 -0500
X-Google-Smtp-Source: AH8x225WzuCRgQMDqEXseQjzr+VaiF4zeJFWgP9k7WW/XCTUUgsc2mk+O2DDKaql2NGq2EJNjLJ+tw==
Date: Tue, 13 Feb 2018 11:30:39 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memory: tegra: Squash tegra20-mc into common
 tegra-mc driver
Message-ID: <20180213103039.GA6764@ulmo>
References: <cover.1518452709.git.digetx@gmail.com>
 <148ce8c56ad764fc8133e0d97e43f9639cae15ff.1518452709.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <148ce8c56ad764fc8133e0d97e43f9639cae15ff.1518452709.git.digetx@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 08:06:30PM +0300, Dmitry Osipenko wrote:
> Tegra30+ has some minor differences in registers / bits layout compared
> to Tegra20. Let's squash Tegra20 driver into the common tegra-mc driver
> to reduce code a tad, this also will be useful for the upcoming Tegra's MC
> reset API.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/Kconfig         |  10 --
>  drivers/memory/Makefile        |   1 -
>  drivers/memory/tegra/Makefile  |   1 +
>  drivers/memory/tegra/mc.c      | 184 +++++++++++++++++++----------
>  drivers/memory/tegra/mc.h      |  10 ++
>  drivers/memory/tegra/tegra20.c |  72 ++++++++++++
>  drivers/memory/tegra20-mc.c    | 254 -----------------------------------=
------
>  include/soc/tegra/mc.h         |   4 +-
>  8 files changed, 211 insertions(+), 325 deletions(-)
>  create mode 100644 drivers/memory/tegra/tegra20.c
>  delete mode 100644 drivers/memory/tegra20-mc.c

I generally like the idea of unifying the drivers, but I think this case
is somewhat borderline because the changes don't come naturally. That is
the parameterizations here seem overly heavy with a lot of special cases
for Tegra20. To me that indicates that Tegra20 is conceptually too much
apart from Tegra30 and later to make unification reasonable.

However, I'd still very much like to see them unified, so let's go
through the remainder in more detail.

> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 19a0e83f260d..8d731d6c3e54 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -104,16 +104,6 @@ config MVEBU_DEVBUS
>  	  Armada 370 and Armada XP. This controller allows to handle flash
>  	  devices such as NOR, NAND, SRAM, and FPGA.
> =20
> -config TEGRA20_MC
> -	bool "Tegra20 Memory Controller(MC) driver"
> -	default y
> -	depends on ARCH_TEGRA_2x_SOC
> -	help
> -	  This driver is for the Memory Controller(MC) module available
> -	  in Tegra20 SoCs, mainly for a address translation fault
> -	  analysis, especially for IOMMU/GART(Graphics Address
> -	  Relocation Table) module.
> -
>  config FSL_CORENET_CF
>  	tristate "Freescale CoreNet Error Reporting"
>  	depends on FSL_SOC_BOOKE
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index 66f55240830e..a01ab3e22f94 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -16,7 +16,6 @@ obj-$(CONFIG_OMAP_GPMC)		+=3D omap-gpmc.o
>  obj-$(CONFIG_FSL_CORENET_CF)	+=3D fsl-corenet-cf.o
>  obj-$(CONFIG_FSL_IFC)		+=3D fsl_ifc.o
>  obj-$(CONFIG_MVEBU_DEVBUS)	+=3D mvebu-devbus.o
> -obj-$(CONFIG_TEGRA20_MC)	+=3D tegra20-mc.o
>  obj-$(CONFIG_JZ4780_NEMC)	+=3D jz4780-nemc.o
>  obj-$(CONFIG_MTK_SMI)		+=3D mtk-smi.o
>  obj-$(CONFIG_DA8XX_DDRCTL)	+=3D da8xx-ddrctl.o
> diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
> index ce87a9470034..94ab16ba075b 100644
> --- a/drivers/memory/tegra/Makefile
> +++ b/drivers/memory/tegra/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  tegra-mc-y :=3D mc.o
> =20
> +tegra-mc-$(CONFIG_ARCH_TEGRA_2x_SOC)  +=3D tegra20.o
>  tegra-mc-$(CONFIG_ARCH_TEGRA_3x_SOC)  +=3D tegra30.o
>  tegra-mc-$(CONFIG_ARCH_TEGRA_114_SOC) +=3D tegra114.o
>  tegra-mc-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D tegra124.o
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index a4803ac192bb..187a9005351b 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -27,6 +27,7 @@
>  #define  MC_INT_INVALID_SMMU_PAGE (1 << 10)
>  #define  MC_INT_ARBITRATION_EMEM (1 << 9)
>  #define  MC_INT_SECURITY_VIOLATION (1 << 8)
> +#define  MC_INT_INVALID_GART_PAGE (1 << 7)
>  #define  MC_INT_DECERR_EMEM (1 << 6)
> =20
>  #define MC_INTMASK 0x004
> @@ -53,7 +54,14 @@
>  #define MC_EMEM_ADR_CFG 0x54
>  #define MC_EMEM_ADR_CFG_EMEM_NUMDEV BIT(0)
> =20
> +#define MC_GART_ERROR_REQ		0x30
> +#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
> +#define MC_SECURITY_VIOLATION_STATUS	0x74
> +
>  static const struct of_device_id tegra_mc_of_match[] =3D {
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +	{ .compatible =3D "nvidia,tegra20-mc", .data =3D &tegra20_mc_soc },
> +#endif
>  #ifdef CONFIG_ARCH_TEGRA_3x_SOC
>  	{ .compatible =3D "nvidia,tegra30-mc", .data =3D &tegra30_mc_soc },
>  #endif
> @@ -79,6 +87,9 @@ static int tegra_mc_setup_latency_allowance(struct tegr=
a_mc *mc)
>  	unsigned int i;
>  	u32 value;
> =20
> +	if (mc->soc->tegra20)
> +		return 0;

Test for feature flags rather than chip generation. This could be
swapped for:

	if (mc->soc->supports_latency_allowance)
		return 0;

> +
>  	/* compute the number of MC clock cycles per tick */
>  	tick =3D mc->tick * clk_get_rate(mc->clk);
>  	do_div(tick, NSEC_PER_SEC);
> @@ -229,6 +240,7 @@ static int tegra_mc_setup_timings(struct tegra_mc *mc)
>  static const char *const status_names[32] =3D {
>  	[ 1] =3D "External interrupt",
>  	[ 6] =3D "EMEM address decode error",
> +	[ 7] =3D "GART page fault",
>  	[ 8] =3D "Security violation",
>  	[ 9] =3D "EMEM arbitration error",
>  	[10] =3D "Page fault",
> @@ -257,78 +269,124 @@ static irqreturn_t tegra_mc_irq(int irq, void *dat=
a)
> =20
>  	for_each_set_bit(bit, &status, 32) {
>  		const char *error =3D status_names[bit] ?: "unknown";
> -		const char *client =3D "unknown", *desc;
> -		const char *direction, *secure;
> +		const char *client =3D "unknown", *desc =3D "";
> +		const char *direction =3D "read", *secure =3D "";
>  		phys_addr_t addr =3D 0;
>  		unsigned int i;
> -		char perm[7];
> +		char perm[7] =3D { 0 };
>  		u8 id, type;
> -		u32 value;
> +		u32 value, reg;
> =20
> -		value =3D mc_readl(mc, MC_ERR_STATUS);
> +		if (mc->soc->tegra20) {
> +			switch (bit) {
> +			case 6:

Can we have symbolic names for this (and other bits)?

> +				reg =3D MC_DECERR_EMEM_OTHERS_STATUS;
> +				value =3D mc_readl(mc, reg);
> =20
> -#ifdef CONFIG_PHYS_ADDR_T_64BIT
> -		if (mc->soc->num_address_bits > 32) {
> -			addr =3D ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
> -				MC_ERR_STATUS_ADR_HI_MASK);
> -			addr <<=3D 32;
> -		}
> -#endif
> +				id =3D value & mc->soc->client_id_mask;
> +				desc =3D error_names[2];
> =20
> -		if (value & MC_ERR_STATUS_RW)
> -			direction =3D "write";
> -		else
> -			direction =3D "read";
> +				if (value & BIT(31))
> +					direction =3D "write";
> +				break;
> =20
> -		if (value & MC_ERR_STATUS_SECURITY)
> -			secure =3D "secure ";
> -		else
> -			secure =3D "";
> +			case 7:
> +				reg =3D MC_GART_ERROR_REQ;
> +				value =3D mc_readl(mc, reg);
> =20
> -		id =3D value & mc->soc->client_id_mask;
> +				id =3D (value >> 1) & mc->soc->client_id_mask;
> +				desc =3D error_names[2];
> =20
> -		for (i =3D 0; i < mc->soc->num_clients; i++) {
> -			if (mc->soc->clients[i].id =3D=3D id) {
> -				client =3D mc->soc->clients[i].name;
> +				if (value & BIT(0))
> +					direction =3D "write";
> +				break;
> +
> +			case 8:
> +				reg =3D MC_SECURITY_VIOLATION_STATUS;
> +				value =3D mc_readl(mc, reg);
> +
> +				id =3D value & mc->soc->client_id_mask;
> +				type =3D (value & BIT(30)) ? 4 : 3;
> +				desc =3D error_names[type];
> +				secure =3D "secure ";
> +
> +				if (value & BIT(31))
> +					direction =3D "write";
> +				break;
> +
> +			default:
> +				reg =3D 0;
> +				direction =3D "";

This makes no sense to me. Why reset direction here if you already
explicitly set direction to "read". Why not just leave it unset until
you know exactly what it's going to be? Why do we even continue in a
case where we know nothing of the error status?

> +				id =3D mc->soc->num_clients;
>  				break;
>  			}
> -		}
> =20
> -		type =3D (value & MC_ERR_STATUS_TYPE_MASK) >>
> -		       MC_ERR_STATUS_TYPE_SHIFT;
> -		desc =3D error_names[type];
> +			if (id < mc->soc->num_clients)
> +				client =3D mc->soc->clients[id].name;
> =20
> -		switch (value & MC_ERR_STATUS_TYPE_MASK) {
> -		case MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE:
> -			perm[0] =3D ' ';
> -			perm[1] =3D '[';
> +			if (reg)
> +				addr =3D mc_readl(mc, reg + sizeof(u32));
> +		} else {
> +			value =3D mc_readl(mc, MC_ERR_STATUS);
> =20
> -			if (value & MC_ERR_STATUS_READABLE)
> -				perm[2] =3D 'R';
> -			else
> -				perm[2] =3D '-';
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> +			if (mc->soc->num_address_bits > 32) {
> +				addr =3D ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
> +					MC_ERR_STATUS_ADR_HI_MASK);
> +				addr <<=3D 32;
> +			}
> +#endif
> +			if (value & MC_ERR_STATUS_RW)
> +				direction =3D "write";
> =20
> -			if (value & MC_ERR_STATUS_WRITABLE)
> -				perm[3] =3D 'W';
> -			else
> -				perm[3] =3D '-';
> +			if (value & MC_ERR_STATUS_SECURITY)
> +				secure =3D "secure ";
> =20
> -			if (value & MC_ERR_STATUS_NONSECURE)
> -				perm[4] =3D '-';
> -			else
> -				perm[4] =3D 'S';
> +			id =3D value & mc->soc->client_id_mask;
> =20
> -			perm[5] =3D ']';
> -			perm[6] =3D '\0';
> -			break;
> +			for (i =3D 0; i < mc->soc->num_clients; i++) {
> +				if (mc->soc->clients[i].id =3D=3D id) {
> +					client =3D mc->soc->clients[i].name;
> +					break;
> +				}
> +			}
> =20
> -		default:
> -			perm[0] =3D '\0';
> -			break;
> -		}
> +			type =3D (value & MC_ERR_STATUS_TYPE_MASK) >>
> +			       MC_ERR_STATUS_TYPE_SHIFT;
> +			desc =3D error_names[type];
> +
> +			switch (value & MC_ERR_STATUS_TYPE_MASK) {
> +			case MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE:
> +				perm[0] =3D ' ';
> +				perm[1] =3D '[';
> +
> +				if (value & MC_ERR_STATUS_READABLE)
> +					perm[2] =3D 'R';
> +				else
> +					perm[2] =3D '-';
> +
> +				if (value & MC_ERR_STATUS_WRITABLE)
> +					perm[3] =3D 'W';
> +				else
> +					perm[3] =3D '-';
> =20
> -		value =3D mc_readl(mc, MC_ERR_ADR);
> -		addr |=3D value;
> +				if (value & MC_ERR_STATUS_NONSECURE)
> +					perm[4] =3D '-';
> +				else
> +					perm[4] =3D 'S';
> +
> +				perm[5] =3D ']';
> +				perm[6] =3D '\0';
> +				break;
> +
> +			default:
> +				perm[0] =3D '\0';
> +				break;
> +			}
> +
> +			value =3D mc_readl(mc, MC_ERR_ADR);
> +			addr |=3D value;
> +		}
> =20
>  		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
>  				    client, secure, direction, &addr, error,

I'd prefer if we completely separated the Tegra20 implementation of this
handler from the Tegra30+ implementation. Both don't end up sharing very
much in the end but this variant is very difficult to read, in my
opinion.

> @@ -369,11 +427,18 @@ static int tegra_mc_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(mc->regs))
>  		return PTR_ERR(mc->regs);
> =20
> -	mc->clk =3D devm_clk_get(&pdev->dev, "mc");
> -	if (IS_ERR(mc->clk)) {
> -		dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
> -			PTR_ERR(mc->clk));
> -		return PTR_ERR(mc->clk);
> +	if (mc->soc->tegra20) {
> +		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		mc->regs2 =3D devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(mc->regs2))
> +			return PTR_ERR(mc->regs2);

Ugh... this is really ugly. In retrospect we really should've left the
memory-controller and iommu in the same device tree node. There's really
no reason for them to be separate, other than perhaps the Linux driver
model, which we could easily workaround by just instancing the IOMMU
device from the memory controller driver. That way we could simply share
the I/O mapping between both and avoid these games with two regions.

> +	} else {
> +		mc->clk =3D devm_clk_get(&pdev->dev, "mc");
> +		if (IS_ERR(mc->clk)) {
> +			dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
> +				PTR_ERR(mc->clk));
> +			return PTR_ERR(mc->clk);
> +		}
>  	}

It's odd that we don't have an MC clock on Tegra2. I wonder if perhaps
we just never implemented one, or it uses one which is always on by
default. Cc Peter to see if he knows.

> =20
>  	err =3D tegra_mc_setup_latency_allowance(mc);
> @@ -416,7 +481,8 @@ static int tegra_mc_probe(struct platform_device *pde=
v)
> =20
>  	value =3D MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
>  		MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
> -		MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM;
> +		MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM |
> +		MC_INT_INVALID_GART_PAGE;

This should be conditionalized on a feature flag such as "has_gart". For
most generations of Tegra this would probably work, but newer versions
have become quite picky about these kinds of things, so in some cases an
access to a reserved register or field can cause an exception.

> =20
>  	mc_writel(mc, value, MC_INTMASK);
> =20
> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
> index ddb16676c3af..1642fbea5ce3 100644
> --- a/drivers/memory/tegra/mc.h
> +++ b/drivers/memory/tegra/mc.h
> @@ -16,15 +16,25 @@
> =20
>  static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
>  {
> +	if (mc->soc->tegra20 && offset >=3D 0x24)
> +		return readl(mc->regs2 + offset - 0x3c);

Erm... this is weird. Shouldn't the check be offset >=3D 0x3c? Otherwise
you could turn the offset into a very large number and access memory
outside of the mapping. At least technically.

Again, it'd be so much easier if MC and IOMMU were a single device as
they are in actual hardware. I'm sure we could argue the case that the
current DTS is buggy and that it's reasonable to break backwards-
compatibility.

> +
>  	return readl(mc->regs + offset);
>  }
> =20
>  static inline void mc_writel(struct tegra_mc *mc, u32 value,
>  			     unsigned long offset)
>  {
> +	if (mc->soc->tegra20 && offset >=3D 0x24)
> +		return writel(value, mc->regs2 + offset - 0x3c);
> +
>  	writel(value, mc->regs + offset);
>  }
> =20
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +extern const struct tegra_mc_soc tegra20_mc_soc;
> +#endif
> +
>  #ifdef CONFIG_ARCH_TEGRA_3x_SOC
>  extern const struct tegra_mc_soc tegra30_mc_soc;
>  #endif
> diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra2=
0.c
> new file mode 100644
> index 000000000000..81a082bdba19
> --- /dev/null
> +++ b/drivers/memory/tegra/tegra20.c
> @@ -0,0 +1,72 @@
> +/*
> + * Copyright (C) 2012 NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "mc.h"
> +
> +static const struct tegra_mc_client tegra20_mc_clients[] =3D {
> +	{ .name =3D "display0a" },
> +	{ .name =3D "display0ab" },
> +	{ .name =3D "display0b" },
> +	{ .name =3D "display0bb" },
> +	{ .name =3D "display0c" },
> +	{ .name =3D "display0cb" },
> +	{ .name =3D "display1b" },
> +	{ .name =3D "display1bb" },
> +	{ .name =3D "eppup" },
> +	{ .name =3D "g2pr" },
> +	{ .name =3D "g2sr" },
> +	{ .name =3D "mpeunifbr" },
> +	{ .name =3D "viruv" },
> +	{ .name =3D "avpcarm7r" },
> +	{ .name =3D "displayhc" },
> +	{ .name =3D "displayhcb" },
> +	{ .name =3D "fdcdrd" },
> +	{ .name =3D "g2dr" },
> +	{ .name =3D "host1xdmar" },
> +	{ .name =3D "host1xr" },
> +	{ .name =3D "idxsrd" },
> +	{ .name =3D "mpcorer" },
> +	{ .name =3D "mpe_ipred" },
> +	{ .name =3D "mpeamemrd" },
> +	{ .name =3D "mpecsrd" },
> +	{ .name =3D "ppcsahbdmar" },
> +	{ .name =3D "ppcsahbslvr" },
> +	{ .name =3D "texsrd" },
> +	{ .name =3D "vdebsevr" },
> +	{ .name =3D "vdember" },
> +	{ .name =3D "vdemcer" },
> +	{ .name =3D "vdetper" },
> +	{ .name =3D "eppu" },
> +	{ .name =3D "eppv" },
> +	{ .name =3D "eppy" },
> +	{ .name =3D "mpeunifbw" },
> +	{ .name =3D "viwsb" },
> +	{ .name =3D "viwu" },
> +	{ .name =3D "viwv" },
> +	{ .name =3D "viwy" },
> +	{ .name =3D "g2dw" },
> +	{ .name =3D "avpcarm7w" },
> +	{ .name =3D "fdcdwr" },
> +	{ .name =3D "host1xw" },
> +	{ .name =3D "ispw" },
> +	{ .name =3D "mpcorew" },
> +	{ .name =3D "mpecswr" },
> +	{ .name =3D "ppcsahbdmaw" },
> +	{ .name =3D "ppcsahbslvw" },
> +	{ .name =3D "vdebsevw" },
> +	{ .name =3D "vdembew" },
> +	{ .name =3D "vdetpmw" },
> +};

Can you please initialize the .id field for these? I know they aren't
technically necessary because the Tegra20 code doesn't actually look up
the client by ID (because the ID happens to match the array index), but
I'd like this to be consistent across all generations.

Thierry

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqCvkwACgkQ3SOs138+
s6HulA/+KwjPApikyCMDRY0PuqnyHRH8K6l78W0C7b9I0EbQTH1myKpfeRrFNNlN
G4tl90USMUOnTuqWibR9/hzntsQywfauxcIFbpoh8WmlfmTfJox3Qwp9ehIB12wG
lQ2WVGq7aOkLHn8l6PyGpof2MG/SxmCH/bkCPADmJNX8G6c6zmmqbH0/roMJ0Nvf
K0gLnxujy9hAhAkzZlG9exIh237qjcEdM9lPlhhs+sv2LfNkBomKqppbO+Wnsz9i
Pw+LbtE8E4+U0p0d9MSiHE+avynxpd2F3ySRXSXToUCp8naNxK6uQTig6UvIGsQT
jL5jc33OVvJ/ijEeI4gXYAu1ByR4OGfeCs7T/US+cTQBxnyBksonGXYGnKIm/Z1i
CVu0LWEK1MkHkLncuVxArHJ5ukKhQk6nS0iXdyUNohTX43S9bNibKY/IiLrr7ozJ
xU6D9zNaPfxVdSshNVunhkQx877ld9x/6iZ00C1G+cNoQyutDRnCwWds2wVDjTz0
vzVG5EoSDkmmym3mHVQtlRkqi9YThps+WYC38+MNNqC8mqDNyAlsNMJLjIwqqwjW
KX0wFPli2EcnHuvdugY3+OqeKE42VIMH1gpBFvwO84qGq6BB840P7Q3cqHbsR7FN
LzgexK7CS31IwktT7jprAa1HN8eWY0VYow9pw0wK7VGULu1jWIk=
=9Ci0
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
