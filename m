Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935592AbeCCAZg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935578AbeCCAZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:25:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458472178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Sat, 3 Mar 2018 00:25:29 +0000
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 5/6] MIPS: generic: Add support for Microsemi Ocelot
Message-ID: <20180303002528.GE4197@saruman>
References: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
 <20180302224811.26840-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20180302224811.26840-6-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 11:48:10PM +0100, Alexandre Belloni wrote:
> Introduce support for the MIPS based Microsemi Ocelot SoCs.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/mips/Makefile                            |  4 ++
>  arch/mips/configs/generic/board-ocelot.config | 40 +++++++++++++
>  arch/mips/generic/Kconfig                     | 17 ++++++
>  arch/mips/generic/Makefile                    |  1 +
>  arch/mips/generic/board-ocelot.c              | 83 +++++++++++++++++++++=
++++++
>  5 files changed, 145 insertions(+)
>  create mode 100644 arch/mips/configs/generic/board-ocelot.config
>  create mode 100644 arch/mips/generic/board-ocelot.c

very nice :-)

> diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/co=
nfigs/generic/board-ocelot.config
> new file mode 100644
> index 000000000000..7f9e1eaccc34
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-ocelot.config
> @@ -0,0 +1,40 @@
> +# require CONFIG_32BIT=3Dy

If this has a 24KEc, does it make sense to use:
# require CONFIG_CPU_MIPS32_R2=3Dy
like ni169445 and xilfpga do. There doesn't seem to be any point
enabling support in 32r6 generic kernels for example.

Similarly if the platform is little endian only, you could also add:
# require CONFIG_CPU_LITTLE_ENDIAN=3Dy

> +
> +CONFIG_LEGACY_BOARD_OCELOT=3Dy
> +
> +CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=3Dy

Hmm, can this break any other generic platforms that already make the
DTB command line override the arcs_cmdline? Paul?

I.e. In arch_mem_init() the condition of copying arcs_cmdline to
boot_command_line would switch from !boot_command_line[0] to
arcs_cmdline[0]. I suppose arcs_cmdline[] may not have been written in
those cases. If its safe then it should probably be a standard thing
selected by MIPS_GENERIC instead of a board specific thing.

> +CONFIG_MAGIC_SYSRQ=3Dy

Perhaps its worth adding this to the base generic_defconfig if its
useful to have.

> +CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1

That is already the default, though I wonder if we should set it to 0
for safety, which still retains the functionality, but just may require
writing to /proc/sys/kernel/sysrq or passing sysrq_always_enabled as a
kernel parameter to use sysrq from keyboard / uart.

> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index 2ff3b17bfab1..04b8d2262f9d 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -27,6 +27,23 @@ config LEGACY_BOARD_SEAD3
>  	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
>  	  development boards, which boot using a legacy boot protocol.
> =20
> +comment "MSCC Ocelot doesn't work with SEAD3 enabled"
> +       depends on LEGACY_BOARD_SEAD3

broken indentation. Tab please.

> +
> +config LEGACY_BOARD_OCELOT
> +	bool "Support MSCC Ocelot boards"
> +	depends on LEGACY_BOARD_SEAD3=3Dn
> +	select LEGACY_BOARDS
> +	select MSCC_OCELOT
> +
> +config MSCC_OCELOT
> +	bool
> +	select DMA_NONCOHERENT

MIPS_GENERIC already selects DMA_PERFDEV_COHERENT, which should already
treat devices as non-coherent unless they have the dma-coherent DT
property.

> +	select GPIOLIB
> +	select MSCC_OCELOT_IRQ
> +	select SYS_HAS_EARLY_PRINTK
> +	select USE_GENERIC_EARLY_PRINTK_8250
> +
>  comment "FIT/UHI Boards"
> =20
>  config FIT_IMAGE_FDT_BOSTON
> diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
> index 5c31e0c4697d..d03a36f869a4 100644
> --- a/arch/mips/generic/Makefile
> +++ b/arch/mips/generic/Makefile
> @@ -14,5 +14,6 @@ obj-y +=3D proc.o
> =20
>  obj-$(CONFIG_YAMON_DT_SHIM)		+=3D yamon-dt.o
>  obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+=3D board-sead3.o
> +obj-$(CONFIG_LEGACY_BOARD_OCELOT)	+=3D board-ocelot.o
>  obj-$(CONFIG_KEXEC)			+=3D kexec.o
>  obj-$(CONFIG_VIRT_BOARD_RANCHU)		+=3D board-ranchu.o
> diff --git a/arch/mips/generic/board-ocelot.c b/arch/mips/generic/board-o=
celot.c
> new file mode 100644
> index 000000000000..752c6edbe1d5
> --- /dev/null
> +++ b/arch/mips/generic/board-ocelot.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Microsemi MIPS SoC support
> + *
> + * Copyright (c) 2017 Microsemi Corporation
> + */
> +#include <asm/machine.h>
> +#include <asm/prom.h>
> +
> +#define DEVCPU_GCB_CHIP_REGS_CHIP_ID	0x71070000
> +#define CHIP_ID_PART_ID			GENMASK(27, 12)
> +
> +#define OCELOT_PART_ID			(0x7514 << 12)
> +
> +#define UART_UART			0x70100000
> +
> +static __init bool ocelot_detect(void)
> +{
> +	u32 rev;
> +
> +	rev =3D __raw_readl((void *)DEVCPU_GCB_CHIP_REGS_CHIP_ID);

Isn't that an address in the user segment, i.e. TLB mapped virtual
memory? Does the bootloader set up a wired mapping for it or something?

The address looks similar to UART_UART which is given to ioremap so must
be a physical address. Perhaps the mapping you're using is 1:1
virtual:physical address?

If its using a TLB mapping, then:
1) That isn't safe this early to run on other platforms, as it'll give a
   TLB refill exception. It should be quite possible to detect such a
   mapping to make it safer though.
2) If yamon initialises the TLB to a known state, then that may well be
   a hacky but workable way to distinguish yamon (sead3) from redboot
   (mscc) in future.

> +
> +	if ((rev & CHIP_ID_PART_ID) !=3D OCELOT_PART_ID)
> +		return 0;
> +
> +	/* Copy command line from bootloader early for Initrd detection */
> +	if (fw_arg0 < 10 && (fw_arg1 & 0xFFF00000) =3D=3D 0x80000000) {
> +		unsigned int prom_argc =3D fw_arg0;
> +		const char **prom_argv =3D (const char **)fw_arg1;
> +
> +		if (prom_argc > 1 && strlen(prom_argv[1]) > 0)
> +			/* ignore all built-in args if any f/w args given */
> +			strcpy(arcs_cmdline, prom_argv[1]);
> +	}
> +
> +	return 1;
> +}
> +
> +static __init unsigned int ocelot_measure_hpt_freq(void)
> +{
> +	struct device_node *np;
> +	u32 freq;
> +
> +	np =3D of_find_node_by_name(NULL, "cpus");
> +	if (!np)
> +		panic("missing 'cpus' DT node");
> +	if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
> +		panic("missing 'mips-hpt-frequency' property");
> +	of_node_put(np);
> +
> +	return freq;
> +}

Is it too late to change this to use the generic mips_hpt_frequency
calculation in plat_time_init()? The DT would have to provide e.g. a
fixed-clock and link to it from the CPU node.

See arch/mips/boot/dts/ni/169445.dts for an example of how it could
look.

That would allow you to eliminate this machine callback altogether, as
well as being more flexible if you ever needed the frequency to be
calculated more dynamically based on platform registers.

Thanks!
James

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqZ63IACgkQbAtpk944
dnrNOxAAi/QwkOPfsfwnFj3PDGHzLSezb0GYCBeXND/DkV9g8xAXlM1AZ4Lr8wIn
zH+zI3uNhPVbez3luyEXnAV1y690LOvx8FoeZ0K4qw+OK/dF3VUiFCffKj/yEGP5
tvqE7GDK5zygCMs+gH8nIuWYii4c2pf03yw700JdJk6+iocPX1/E4DN10Yts55Iu
wwZSHBHnTbizDRjQjX8pjI8ls0jT3pMO1eiHAWg7m6/w7ZeBmI9w6yV74crf2cAN
/6JCW49lcLaIhU9uX4FPDZeagzEY8Jwns4E36DMJA9zy3Y2eF4eOOgSOZD6w82cs
bGF7N90PL4rXSH+fq1ztaqZcGPiAAQYzCjQrCD+FBjfIB43hJ91W+T0E1hcjYd1j
mG4Vztlh5wmT7amiForWEL+sdg1XbSFaOH+D95KTWF3mgo0U5yvCX4ZeJM30+Rgc
7gReJgx7+rkwHHZ9j/WvN9vWQV8djWBqx06QZA5fn+TOdNMUFn1TelYgCDD/5acU
csbQ1ByLr0SP1YghgMNvu/QkRYWHT5B21Yzcr6/am0bN8dyFzKZWgjhT4ptkd9S/
uNO06KjBT2iXa59nf54WxKQdFoy4eszdB8jkDal95I17kRMsWqwCMsh6rkG4qcqz
Qjqu+1Yyqfb1eZoWMuQ5Nmkx1XY1MWL4mEnCAPHOdYbDhXrSK3Y=
=6/0u
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
