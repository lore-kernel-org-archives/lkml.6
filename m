Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeBGSuF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:50:05 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:56619 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754355AbeBGSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:50:02 -0500
Date: Wed, 7 Feb 2018 19:49:59 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 4/6] clk: sunxi-ng: add support for the Allwinner H6
 CCU
Message-ID: <20180207184959.5h233agyhva352s4@flea>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-5-icenowy@aosc.io>
 <20180207090210.jlxleeh32tojvzp5@flea>
 <3AB5A169-5EA5-4A45-95AF-4CA56F13A1CA@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ezess36y6rgitwq2"
Content-Disposition: inline
In-Reply-To: <3AB5A169-5EA5-4A45-95AF-4CA56F13A1CA@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ezess36y6rgitwq2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 05:11:11PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B42=E6=9C=887=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885=
:02:10, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >Hi,
> >
> >On Sat, Feb 03, 2018 at 11:49:40PM +0800, Icenowy Zheng wrote:
> >> +	/* Force the output divider of video PLLs to 0 */
> >> +	for (i =3D 0; i < ARRAY_SIZE(pll_video_regs); i++) {
> >> +		val =3D readl(reg + pll_video_regs[i]);
> >> +		val &=3D ~BIT(0);
> >> +		writel(val, reg + pll_video_regs[i]);
> >> +	}
> >
> >Why?
>=20
> According to the manual the output divider here is
> test only, and for daily use it should be 0.
>=20
> >
> >> +	/* Force OHCI 12M clock sources to 00 (12MHz divided from 48MHz) */
> >> +	for (i =3D 0; i < ARRAY_SIZE(usb2_clk_regs); i++) {
> >> +		val =3D readl(reg + usb2_clk_regs[i]);
> >> +		val &=3D ~GENMASK(25, 24);
> >> +		writel (val, reg + usb2_clk_regs[i]);
> >> +	}
> >
> >Why?
>=20
> Just make them have a sure working parent. Why this
> muxs exist is still mysterious.
>=20
> >
> >> +	/*
> >> +	 * Force the post-divider of pll-video to 8 and the output divider
>=20
> oh here's a typo -- it's audio, not video.
>=20
> >> +	 * of it to 1.
> >> +	 */
> >> +	val =3D readl(reg + SUN50I_H6_PLL_AUDIO_REG);
> >> +	val &=3D ~(GENMASK(21, 16) | BIT(0));
> >> +	writel(val | (7 << 16), reg + SUN50I_H6_PLL_AUDIO_REG);
> >
> >Why?
>=20
> See the comments about pll-audio in the former sources :-)

You should have a comments for all those :)

>=20
> >> diff --git a/include/dt-bindings/clock/sun50i-h6-ccu.h
> >b/include/dt-bindings/clock/sun50i-h6-ccu.h
> >> new file mode 100644
> >> index 000000000000..f7ddb241012c
> >> --- /dev/null
> >> +++ b/include/dt-bindings/clock/sun50i-h6-ccu.h
> >> @@ -0,0 +1,125 @@
> >> +/*
> >> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> >> + *
> >> + * SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >> + */
> >> +
> >> +#ifndef _DT_BINDINGS_CLK_SUN50I_H6_H_
> >> +#define _DT_BINDINGS_CLK_SUN50I_H6_H_
> >> +
> >> +#define CLK_PLL_PERIPH0		3
> >
> >Why is that needed?
>=20
> Parent of AR100 clock in PRCM.

ACK.

> >
> >> +
> >> +#define CLK_CPUX		21
> >> +
> >> +#define CLK_APB1		26
> >
> >Same thing here
>=20
> As discussed in v1, the APB bus clock is used for PIO.

ACK

> >
> >> +
> >> +#define CLK_DE			29
> >> +#define CLK_BUS_DE		30
> >> +#define CLK_DEINTERLACE		31
> >> +#define CLK_BUS_DEINTERLACE	32
> >> +#define CLK_GPU			33
> >> +#define CLK_BUS_GPU		34
> >> +#define CLK_CE			35
> >> +#define CLK_BUS_CE		36
> >> +#define CLK_VE			37
> >> +#define CLK_BUS_VE		38
> >> +#define CLK_EMCE		39
> >> +#define CLK_BUS_EMCE		40
> >> +#define CLK_VP9			41
> >> +#define CLK_BUS_VP9		42
> >> +#define CLK_BUS_DMA		43
> >> +#define CLK_BUS_MSGBOX		44
> >> +#define CLK_BUS_SPINLOCK	45
> >> +#define CLK_BUS_HSTIMER		46
> >> +#define CLK_AVS			47
> >> +#define CLK_BUS_DBG		48
> >> +#define CLK_BUS_PSI		49
> >> +#define CLK_BUS_PWM		50
> >> +#define CLK_BUS_IOMMU		51
> >> +
> >> +#define CLK_MBUS_DMA		53
> >> +#define CLK_MBUS_VE		54
> >> +#define CLK_MBUS_CE		55
> >> +#define CLK_MBUS_TS		56
> >> +#define CLK_MBUS_NAND		57
> >> +#define CLK_MBUS_CSI		58
> >> +#define CLK_MBUS_DEINTERLACE	59
> >> +
> >> +#define CLK_NAND0		61
> >> +#define CLK_NAND1		62
> >> +#define CLK_BUS_NAND		63
> >> +#define CLK_MMC0		64
> >> +#define CLK_MMC1		65
> >> +#define CLK_MMC2		66
> >> +#define CLK_BUS_MMC0		67
> >> +#define CLK_BUS_MMC1		68
> >> +#define CLK_BUS_MMC2		69
> >> +#define CLK_BUS_UART0		70
> >> +#define CLK_BUS_UART1		71
> >> +#define CLK_BUS_UART2		72
> >> +#define CLK_BUS_UART3		73
> >> +#define CLK_BUS_I2C0		74
> >> +#define CLK_BUS_I2C1		75
> >> +#define CLK_BUS_I2C2		76
> >> +#define CLK_BUS_I2C3		77
> >> +#define CLK_BUS_SCR0		78
> >> +#define CLK_BUS_SCR1		79
> >> +#define CLK_SPI0		80
> >> +#define CLK_SPI1		81
> >> +#define CLK_BUS_SPI0		82
> >> +#define CLK_BUS_SPI1		83
> >> +#define CLK_BUS_EMAC		84
> >> +#define CLK_TS			85
> >> +#define CLK_BUS_TS		86
> >> +#define CLK_IR_TX		87
> >> +#define CLK_BUS_IR_TX		88
> >> +#define CLK_BUS_THS		89
> >> +#define CLK_I2S3		90
> >> +#define CLK_I2S0		91
> >> +#define CLK_I2S1		92
> >> +#define CLK_I2S2		93
> >> +#define CLK_BUS_I2S0		94
> >> +#define CLK_BUS_I2S1		95
> >> +#define CLK_BUS_I2S2		96
> >> +#define CLK_BUS_I2S3		97
> >> +#define CLK_SPDIF		98
> >> +#define CLK_BUS_SPDIF		99
> >> +#define CLK_DMIC		100
> >> +#define CLK_BUS_DMIC		101
> >> +#define CLK_AUDIO_HUB		102
> >> +#define CLK_BUS_AUDIO_HUB	103
> >> +#define CLK_USB_OHCI0		104
> >> +#define CLK_USB_PHY0		105
> >> +#define CLK_USB_PHY1		106
> >> +#define CLK_USB_OHCI3		107
> >> +#define CLK_USB_PHY3		108
> >> +#define CLK_USB_HSIC_12M	109
> >> +#define CLK_USB_HSIC		110
> >> +#define CLK_BUS_OHCI0		111
> >> +#define CLK_BUS_OHCI3		112
> >> +#define CLK_BUS_EHCI0		113
> >> +#define CLK_BUS_XHCI		114
> >> +#define CLK_BUS_EHCI3		115
> >> +#define CLK_BUS_OTG		116
> >> +#define CLK_PCIE_REF_100M	117
> >> +#define CLK_PCIE_REF		118
> >> +#define CLK_PCIE_REF_OUT	119
> >> +#define CLK_PCIE_MAXI		120
> >> +#define CLK_PCIE_AUX		121
> >
> >Dito.
>=20
> I think AUX clock is used in PCIe code.
>=20
> BTW the REF_100M clock is intermediate, and
> does't need to be exported. Will fix it in the next version.
>=20
> >
> >> +#define CLK_BUS_PCIE		122
> >> +#define CLK_HDMI		123
> >> +#define CLK_HDMI_CEC		124
> >> +#define CLK_BUS_HDMI		125
> >> +#define CLK_BUS_TCON_TOP	126
> >
> >Ditto.
>=20
> TCON_TOP is not a clock parent -- it's a dedicated hw
> part which controlls the connection between
> DE2/3 mixers and TCONs.

Ok, great, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--ezess36y6rgitwq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp7SlYACgkQ0rTAlCFN
r3TrMg//QcmsHRC1PFMt3DUBC3NPwNUuBDBP741PNoVCDWXCyOU6NbgkWUoaqOFZ
cslmtPLAFzmqAwtsvcAAu9/pdUKDc8F1Y6510+JvRuvj+6ulnNmRodsVpRPcgsfV
9ycdrEzgPRX3tcaRzuh0ByYDnRuRtBwY7aTMZTjY2/HORSHwIrfLVDe7k0ytllIZ
3QABWdFNe1XNM1UoAOSypFbwnDsnpz+g8Yod14SiuGgVoEZQ4OUOT1kfJL8SUJFf
VgNzg7VCYjQmpOcvgeiuI767ZnnRjCZEyJBhTC5zap09yyzmAVP/9Qiu6jXt1Zd9
vCPfXy/6AOqgFbiluy3iGWitGcV9ykfZorFyBbDLL4Ub8+WRdQVg1rh6nWl0ozf0
tDRLs9cjnEmm+odO/wHN8rFF0FXWLZAgwvLBnmOp7RkLxVmBjxhqMW4TmgK+CYxS
tN76Harvdod7AZFGNGnsOyTP0KL4CA2z527yLg+Dr20NV4IecgPRSyAVBWmPLZPp
QiFpnfQ6B3tcC6qCi77kUkeNZjRyFZ2KenUGKnmZaM7oLFwmp6wpEwtXMH0SjmtB
K4Ik3feqfBWWgja3GQz0fUeM7UkcD8MdLZdmolfEL6BDm2Y0g9VRTCp/u4dAjtUk
HifqpnHMhxElgfSD0MP4ZN7OQcGEDC3aGaHx3SRy/tf3PWdferk=
=oJSi
-----END PGP SIGNATURE-----

--ezess36y6rgitwq2--
